use my_traits::Resource;

use my_macros::Resource;

#[derive(Resource)]
struct my_resource{
    href: String,
}

// impl Resource for my_resource{
//     fn get_href(&self) -> String{
//         self.href.to_owned()
//     }
// }

fn main() {
    let a = my_resource{href: String::from("/xxx")};
    println!("{}", a.get_href());
}
