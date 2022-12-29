use std::cmp::Ordering;
use std::env::temp_dir;
use std::error::Error;
use std::fs::File;
use std::io::{BufReader, BufRead, ErrorKind, Error as IoError};
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
fn has_name(event_content: &BytesStart, name: &str) -> bool {
    event_content.name().into_inner().cmp(name.as_bytes()).is_eq()
}

fn contains_att_pair(event: &BytesStart, key: &str, value: &str) -> Result<bool, XmlError>{
    let mut event_atts = event.attributes();
    while let Some(Ok(att)) = event_atts.next(){
        println!("{:?}", att);
        let att_key = str::from_utf8(att.key.into_inner())?;
        let att_value = str::from_utf8(att.value.as_ref())?;
        if att_key.cmp(key).is_eq() && att_value.cmp(value).is_eq() {
            return Ok(true);
        }
    }
    Ok(false)
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

// Other exercises in coupling include: 
    // after reading in the "resource" event, read in  the <doc> and </doc>
    // by calling .read_event_into 2 times to get to the method tag
    // we can make this assumption because the sep_wadl.xml
    // file we are using and coupling to this code has only
    // this format. However, this does very tightly couple the two

fn main() {
    let path = "/home/neel/projects/learningRUST_repo/xml_practice/sep_wadl.xml";
    let mut reader = Reader::from_file(path).expect("couldn't read from file");
    let mut buf = Vec::new();
    let wx = "wx:samplePath";
    let path_arg = "/sdev";
    let method_arg = "GET";
    let method_tag_name = "method";
    let resource = "resource";

    // find the resource with the wx:samplePath="path_arg"
    loop{
        buf.clear();
        match reader.read_event_into(&mut buf).expect("could not read event from file"){
            Event::Start(e) => {
                if has_name(&e, resource) && 
                contains_att_pair(&e, wx, path_arg)
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
    'outer: loop{
        buf.clear();
        match reader.read_event_into(&mut buf).expect("could not read event from file"){
            Event::Start(e) => {
                if has_name(&e, method_tag_name) && 
                contains_att_pair(&e, "name", method_arg)
                .expect("method search: unexpected error occurred") {
                    println!("found the tag!: {:?}", e);
                    let mut event_atts = e.attributes();
                    while let Some(Ok(att)) = event_atts.next(){
                        let att_key = str::from_utf8(att.key.into_inner()).unwrap();
                        let att_value = str::from_utf8(att.value.as_ref()).unwrap();
                        if att_key.cmp("wx:mode").is_eq(){
                            println!("{att_value}");
                            break 'outer;
                        }
                    }
                }
            },
            Event::Eof => { panic!("{}", ErrorKind::NotFound) }
            _ => {},
        }
    }
}
/*
getting string from attribute iterator
for att in event.attributes()
    if let Ok(att) = att{
        let key = str::from_utf8(att.key.into_inner()).expect("could not read key as ascii");
        let value = str::from_utf8(att.value.as_ref()).expect("could not read value as ascii");
                    
 */
