use std::cmp::Ordering;
use std::str;

use quick_xml::events::{Event};
// use quick_xml::events::{attributes};
use quick_xml::reader::Reader;

fn main() {
    let mut reader = Reader::from_file("/home/neel/projects/learningRUST_repo/xml_practice/sep_wadl.xml").expect("Could not read from file");
    let mut buf = Vec::new();
    loop {
        if let Event::Start(e) = reader.read_event_into(&mut buf).expect("could not read event from file"){
            // disregard all non - "resource" tags
            if e.name().into_inner().cmp(b"resource")  != Ordering::Equal {
                continue;
            };
            println!("id: {}", str::from_utf8(e.name().into_inner()).unwrap());
            for att in e.attributes() {
                print!("{:?}, ", att.unwrap());
            }
            print!("\n");
            break;
        }
        buf.clear();
    }
    println!("We should have by now printed the first \"resource\"");
}
