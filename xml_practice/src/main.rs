use std::io::{BufRead, ErrorKind};
use std::ops::Deref;
use std::path::Path;
// use std::collections::HashMap;
use std::str;

use quick_xml::Error as XmlError;
use quick_xml::events::{Event, BytesStart};
// use quick_xml::events::{attributes};
use quick_xml::reader::Reader;

// Basic sep_xml search and retrieve api.
// This could probably be done far more succinctly and clearly, but 
// I am not fluent enough with iterators and closures yet to do a 
// neater implementation.

// return true if the empty tag or start tag passed in has name="name"
// ignores all other types of events apart from Start and Empty tags
//  as sep_wadl doesn't contain them and text doesn't have an id/name
fn event_has_name(event_content: &BytesStart, name: &str) -> bool {
    event_content.name().into_inner().cmp(name.as_bytes()).is_eq()
}

/// returns Ok(true) if start/empty tag bytes has attribute "key"="value"
/// else Ok(false)
/// returns any error that quick_xml returns, including EOF
fn contains_att_value(event: &BytesStart, key: &str, value: &str) -> Result<bool, XmlError>{
    let mut event_atts = event.attributes();
    while let Some(Ok(att)) = event_atts.next(){
        let att_key = str::from_utf8(att.key.into_inner())?;
        let att_value = str::from_utf8(att.value.as_ref())?;
        if att_key.cmp(key).is_eq() && att_value.cmp(value).is_eq() {
            return Ok(true);
        }
    }
    Ok(false)
}

/// wadl.rs
#[derive(Debug)]
pub enum Mode{
    Mandatory,
    Optional,
    Discouraged,
    Error,
}

/// wadl.rs 
/// as it is sep_wadl.xml specific
fn get_mode(path_arg: &str, method_arg: &str) -> Option<Mode>{
    let path = "sep_wadl.xml";
    let mut reader = Reader::from_file(path).expect("couldn't read from file");
    let mut buf = Vec::new();
    let wx = "wx:samplePath";
    let method_tag_name = "method";
    let resource = "resource";
    // find the resource with the wx:samplePath="path_arg"
    loop{
        buf.clear();
        match reader.read_event_into(&mut buf).expect("could not read event from file"){
            Event::Start(e) => {
                if event_has_name(&e, resource) && 
                contains_att_value(&e, wx, path_arg)
                .expect("resource search: unexpected error occurred") {
                    break;
                }                
            },
            Event::Eof => { panic!("{}", ErrorKind::NotFound) }
            _ => {},
        }
    }

    // loop to find method tag with attribute name="method_arg"
    // tried to extract this loop into a function - it is a nightmare
    loop{
        buf.clear();
        match reader.read_event_into(&mut buf).expect("could not read event from file"){
            Event::Start(e) => {
                if !event_has_name(&e, method_tag_name) || 
                !contains_att_value(&e, "name", method_arg)
                .expect("method search: unexpected error occurred") {
                    continue;
                }

                // we've found the <method> tag with attribute name="method"
                let mut event_atts = e.attributes();
                // loop to find wx:mode="Mode" and return
                while let Some(Ok(att)) = event_atts.next(){
                    let att_key = str::from_utf8(att.key.into_inner()).unwrap();
                    let att_value = str::from_utf8(att.value.as_ref()).unwrap();
                    if att_key.cmp("wx:mode").is_ne(){
                        continue;
                    }
                    println!("{att_value}");
                    match att_value {
                        "M" => return Some(Mode::Mandatory),
                        "O" => return Some(Mode::Optional),
                        "D" => return Some(Mode::Discouraged),
                        "E" => return Some(Mode::Error),
                        // this means the wadl has a bad entry
                        _ => panic!("Unexpected error while retrieveing mode"),
                    }
                }
            },
            Event::Eof => { return None }
            _ => {},
        }
    }
}

/* 
 * fn seek_till<'a, R: BufRead, T: AsRef<Path>>(name: &'a str, file_path: &'a T) -> Result<(Reader<BufReader<File>>, Vec<u8>, Event<'a>), Error>;
 * finds first occurence of of either Start or Empty tag with name="name"
 * returns Reader at that position, else Err - which would be a useful function
 * and after trying to figure this out for way too long, I am officially 
 * out of patience and am not not bothering with lifetimes, event returning,
 * function definitions or any of that stuff. I am writing this the dumb
 * block of code spaghetti way and that's that. If you can figure this
 * out please do so and I will be more than happy to see how someone
 * not a newbie solves this problem
 */ 
fn seek_till<'a, R: BufRead>(reader: &mut Reader<R>, name: &str, att_key: Option<&str>, att_value: Option<&str>) -> Result<Event<'static>, XmlError>{
    let mut buf = Vec::new();
    
    // locate the tag in question
    loop{
        let event = reader.read_event_into(&mut buf)?;
        match event {
            Event::Start(ref e) => {
                if !event_has_name(e, name){
                    continue;
                }
                if let (Some(att_key), Some(att_value)) = (att_key, att_value){
                    if contains_att_value(&e, att_key, att_value)?{
                        return Ok(event.into_owned());
                    }
                } else {
                    return Ok(event.into_owned());
                }
            },
            Event::Empty(ref e) => {
                if !event_has_name(e, name){
                    continue;
                }
                if let (Some(att_key), Some(att_value)) = (att_key, att_value){
                    if contains_att_value(&e, att_key, att_value)?{
                        return Ok(event.into_owned());
                    }
                } else {
                    return Ok(event.into_owned());
                }
            },
            Event::Eof => { return Err(XmlError::TextNotFound) }
            _ => {},
        }
        buf.clear();
    };
}

// Other potential exercises in coupling include: 
    // after reading in the "resource" event, read in  the <doc> and </doc>
    // by calling .read_event_into 2 times to get to the method tag
    // we can make this assumption because the sep_wadl.xml
    // file we are using and coupling to this code has only
    // this format. However, this does very tightly couple the two

/// Input: file name, name of the tag, an attribute key-value pair
/// returns: byte array with the content that appears after the '>' 
/// of the tag found, trimmed of leading and trailing whitespace, each
/// tag ending in a newline '\n' character
pub fn get_first_content<P: AsRef<Path>>(file_path: P, name: &str, att_key: Option<&str>, att_value: Option<&str>) -> Result<Vec<u8>, XmlError>{
    let mut reader = Reader::from_file(file_path)?;
    reader.trim_text(true);
    let mut buf = Vec::new();
    let mut output: Vec<u8> = Vec::new();

    let found_event = seek_till(&mut reader, name, att_key, att_value)?;
    // found_event is either Empty or Start. If Empty, we return
    match found_event {
        Event::Empty(e) =>{
            let mut output = Vec::from( e
                .deref()
                .to_owned()
                );
            output.push(b'\n');
            return Ok(output);
        },
        Event::Start(found_event_content) =>{
            loop{
                let event = reader.read_event_into(&mut buf)?;
                match event {
                    Event::End(e) => {
                        if e.name().cmp(&found_event_content.name()).is_eq(){
                            break;
                        } else {
                            output.append(
                                &mut Event::End(e)
                                .into_owned()
                                .deref()
                                .to_owned()
                                );
                            output.push(b'\n');
                        }
                    },
                    Event::Eof => return Err(XmlError::UnexpectedEof(
                        "reach end of file without finding closing tag".to_owned()
                    )),
                    _ => {
                        output.append(&mut event
                                        .into_owned()
                                        .deref()
                                        .to_owned()
                                        );
                        output.push(b'\n');
                    },
                }
                buf.clear();
            };
        },
        _ => { return Err(XmlError::TextNotFound) }    
    }
    Ok(output)
}

/// retrieves first instance of a Start or Empty tag with "name" and Some("att_key")=Some("att_value")
/// if att_key and/or att_value are None, ignores tag attributes.
/// returns the found tag
fn get_tag_bytes<P: AsRef<Path>>(file_path: P, name: &str, att_key: Option<&str>, att_value: Option<&str>) -> Result<Vec<u8>, XmlError>{
    let mut reader = Reader::from_file(file_path)?;
    reader.trim_text(true);
    let found_tag = seek_till(&mut reader, name, att_key, att_value)?;
    println!("get_tag_bytes output: {found_tag:?}");
    return Ok(found_tag.deref().to_vec());
}



const WADL_PATH: &str = "sep_wadl.xml";

pub fn validate_method(path: &str, method: &str) -> Option<Mode>{
    let resource_tag = get_tag_bytes(
                        WADL_PATH, 
                        "resource",
                        Some("wx:samplePath"),
                        Some(path));
    match resource_tag {
        Ok(bytes) =>{
            let resource_str = str::from_utf8(&bytes).unwrap();
            println!("resource_str: {resource_str}");
            if let Some(id) = resource_str
            .split_whitespace()
            .filter(|a| a.starts_with("id"))
            .next(){
                println!("{id}");
                Some(Mode::Mandatory)
            } else {
                panic!("sep_wadl contained incorrect whitespace: {resource_str}");
            }
        },
        Err(e) => {
            match e {
                quick_xml::Error::Io(_) => panic!("sep_wadl.xml file not found"),
                quick_xml::Error::NonDecodable(_) => panic!("sep_wadl.xml file decoding error"),
                quick_xml::Error::UnexpectedEof(_) => None,
                quick_xml::Error::InvalidAttr(_) => None,
                XmlError::TextNotFound => return None,
                _ => panic!("Unexpected error occurred"),
            }
        },
    }
}

fn main() {
    let path_arg = "/dcap";
    let method_arg = "GET";
    let path = "sep_wadl.xml";
    let tag_name = "method";
    let att_key = "id";
    let att_value = "POSTDeviceCapability";

    println!("{:?}", validate_method(path_arg, method_arg));
}



/*
getting string from attribute iterator
for att in event.attributes()
    if let Ok(att) = att{
        let key = str::from_utf8(att.key.into_inner()).expect("could not read key as ascii");
        let value = str::from_utf8(att.value.as_ref()).expect("could not read value as ascii");
                    
 */