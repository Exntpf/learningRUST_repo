#[no_mangle]
pub extern "C" fn square(x: i32) -> i32 {
    println!("lib.rs");
    x * x
}

#[no_mangle]
pub extern "C" fn hello_from_rust() {
    println!("Hello from Rust!");
}