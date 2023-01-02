use quick_xml::events::{BytesStart, Event};
use quick_xml::reader::Reader;
use quick_xml::name::{QName};
use quick_xml::name;
use std::str;

fn main() {
    let mut reader = Reader::from_str(r#"
        <method id="GETsomething" name="GET" wx:mode="M">
            <response>
                <representation mediaType="application/sep+xml" element="sep:DeviceCapability"/>
                <representation mediaType="application/sep-exi" element="sep:DeviceCapability"/>
            </response>
        </method>
    "#);
    reader.trim_text(true);
    let mut reader_buf = Vec::new();
    let mut into_end_buf = Vec::new();
    
    loop {
        match reader.read_event_into(&mut reader_buf).unwrap(){
            Event::Start(e) => {
                if e.name().into_inner().cmp(b"representation").is_eq(){
                    if let Ok(span) = reader.read_to_end_into(e.name(), &mut into_end_buf){
                        let into_end_string = str::from_utf8(&into_end_buf);
                        println!("span: {:?}", span);
                        println!("{into_end_string:?}");
                        
                    }
                }
            },
            Event::Empty(e)=>{
                if e.name().into_inner().cmp(b"representation").is_eq(){
                    println!("found empty tag: {e:?}");
                    if let Ok(span) = reader.read_to_end_into(e.name(), &mut into_end_buf){
                        let into_end_string = str::from_utf8(&into_end_buf);
                        println!("span: {:?}", span);
                        println!("{into_end_string:?}");

                    } else {
                        println!("read_to_end_into returned error");
                    }
                }
            }
            Event::Eof => break,
            _=>{},
        }
    }
}
