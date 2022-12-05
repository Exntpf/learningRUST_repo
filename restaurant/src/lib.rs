pub mod front_of_house;

pub use front_of_house::hosting;

#[allow(dead_code)]
// this is all practice for strings and other things.
pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    let pi: f32 = 3.1415926535897934384626433832795028841971693993;
    println!("pi<float>: {pi}");
    let pi_str = "3.1415926535897934384626433832795028841971693993";
    println!("pi<&str>: {pi_str}");
    println!("pi<String>: {}", String::from(pi_str) + "75105820974944");
}

