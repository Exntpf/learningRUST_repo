#[no_mangle]
pub extern fn square(x: i32) -> i32 {
    println!("lib.rs");
    x * x
}