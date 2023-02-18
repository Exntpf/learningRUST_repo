use my_traits::Resource;

use my_macros::Resource;

pub struct ResourceB{
    s: String,
}

impl Resource for ResourceB{
    fn get_href(&self) -> String {
        self.s.clone()
    }
}

#[derive(Resource)]
pub struct MyResource{
    a: String,
    super_class: ResourceB,
}
// impl Resource for my_resource{
//     fn get_href(&self) -> String{
//         self.href.to_owned()
//     }
// }

fn main() {
    let a = MyResource{a: String::from("dummy"), super_class: ResourceB { s: String::from("derive works!") }};
    println!("{}", a.get_href());
}
