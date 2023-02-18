pub trait Resource{
    fn get_href(&self) -> String{
        String::from("/edev")
    }
}