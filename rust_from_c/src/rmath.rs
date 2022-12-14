// we want a .so file
#![crate_type = "dylib"]

// no_mangle lets us find the name in the symbol table
// extern makes the function externally visible
#[no_mangle]
pub extern fn square(x: i32) -> i32 {
    println!("rmath.rs");
    x * x
}
