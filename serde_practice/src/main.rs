use serde::{Serialize, Serializer, Deserialize, Deserializer};
use serde::de::{self, Visitor};
use arrayvec::ArrayString;
use std::fmt;
use std::error::Error;
use std::io::ErrorKind;

// #[derive(Serialize, Deserialize, Debug)]
#[derive(Debug)]
struct String6(ArrayString<6>);
impl String6{
    const MAX_LEN:usize = 6;
    fn new(input: &str) -> Result<Self, ErrorKind>{
        if input.len() > Self::MAX_LEN {
            // would like to use generic errors here, but that will be done during the 
            // Great Error Refactor (GER)
            Err(ErrorKind::InvalidInput)
        } else {
            Ok(String6(ArrayString::from(input).unwrap()))
        }
    }
}


struct String6Visitor;

impl Serialize for String6{
    fn serialize<S: Serializer>(&self, serializer: S) -> Result<S::Ok, S::Error> {
        serializer.serialize_str(self.0.as_str())
    }
}

// can't make this generic as Value must be concrete. 
impl<'de> Visitor<'de> for String6Visitor {
    type Value = String6;

    fn expecting(&self, formatter: &mut fmt::Formatter) -> fmt::Result {
        formatter.write_str("expected string with maximum length of 6 characters")
    }

    fn visit_string<E >(self, v: String) -> Result<Self::Value, E>
        where
            E: de::Error, {
        if v.len() > Self::Value::MAX_LEN {
            Err(E::invalid_length(Self::Value::MAX_LEN, &self))
        } else {
            Ok(String6(ArrayString::<{Self::Value::MAX_LEN}>::from(&v).unwrap()))
        }
    }
    
    // This is the function Deserialize runs. All other functions are not required/flavour
    // visit_string can be written triviall by using exactly the same body as bellow,
    // but borrowing "v" and using the appropriate function signature.
    fn visit_str<E >(self, v: &str) -> Result<Self::Value, E>
        where
            E: de::Error, {
        if v.len() > Self::Value::MAX_LEN {
            Err(E::invalid_length(Self::Value::MAX_LEN, &self))
        } else {
            Ok(String6(ArrayString::<{Self::Value::MAX_LEN}>::from(v).unwrap()))
        }
    }
    
}

// In keeping with KISS, trying other tomfoolery to work around the innevitable 
// boilerplate is not worth the trouble at this point.
// We will need to get used to macro's and use them to derive all this stuff.
impl<'de> Deserialize<'de> for String6 {
    fn deserialize<D>(deserializer: D) -> Result<String6, D::Error>
    where
        D: Deserializer<'de>,
    {
        deserializer.deserialize_string(String6Visitor)
    }
}

fn main() {

    let mut v = vec![1, 2, 4];
    v.push(3);
    v.remove(3);
    v.pop();
    let my = String6::new("blab").unwrap();
    dbg!(&my);
    println!("my: {my:?}");
    let ser_my = serde_json::to_string(&my).unwrap();
    println!("ser_my: {ser_my}");
    let de_my: String6 = serde_json::from_str(&ser_my).unwrap();
    dbg!(&de_my);
    // let obj = ResourceData::new("edev");
    // dbg!(&obj);
    // println!("obj: {obj:?}");
    // let ser_obj = serde_json::to_string(&obj).unwrap();
    // dbg!(&ser_obj);
    // println!("ser_obj: {ser_obj}");
    // let de_obj: ResourceData = serde_json::from_str(&ser_obj).unwrap();
    // dbg!(&de_obj);
}