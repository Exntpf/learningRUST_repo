# Notes on C->RUST
Helpful nuances of Rust to note if you come from C:

## General

expressions (that evaluate to a value) don't need ';' at the end.
expressions at the end of functions are the return value. so fn myFunction() -> bool { true } is perfectly valid.
0 != false & 1 != true. No `if(myFn()) { do_something() }`
variable assignment is not an expression. No `if(i=myFn()) {do_something()}` or `x = y = 1` (which needs `y=1` to return `1`)
A data type implementing the `Copy` trait (ints, char, floats, bool, str) means `x = 1; y = x` will copy `x`'s data into `y`. If the type doesn't implement `Copy`, `x`'s value would be moved to `y`, and `x` can no longer be used.
    More rigorously, all data types that have a known size at compile time are stored on the Stack, where copy data is easy - hence the `Copy` trait. All other data is stored in the heap. Strings are a variable size, so can't do `Copy`.

You can print the value of a variable, it's location, and line number to stderr using `dbg!(&var)`, as long as the variable type implements the `Debug` trait. The macro takes ownership of `var` if you let it and returns it back, so can do `let var1 = dbg!(var);`.
output: [src/main.rs:14] var = type 


## If & else:
if{} & else{} are expressions that evaluate to the last expression inside the conditional that executes. 
Because of this i = i<10 ? i+1 : i; in C -> i = if i<10 {i+1} else {i}; in RUST. 
all if{}, if else{} and else{} statements chained together must return the same type. char = if char.

## Loops
loops are expressions that can evaluate to `x` using `break x` 
label loops using `'labelname: loop {`
you can break out of specific loops using `break 'loopname;` even when inside a nested loop
`for i in array {` loops through each element of `array`, is more flexible, faster, and easier to read than using indices. Use it.
specify ranges using `startNumber..endNumber`, and the compiler will try and figure it out for you.
reverse range/list

## Tuples
Immutable collections of any data type defined within `()`
Index tuple values using `.`, like struct fields, but with tuple index numbers
Can name tuples to create new data types by doing: `struct TupleName(data_type1, data_type2);` (though I don't know where you would use this instead of a struct).

## Structs
All fields in a struct instance is either mutable or not - you can't choose some struct fields to be mutable but keep the rest constant, including in the struct definition.

Structs are instantiated `field: value,`, **not** `field = value,`.
if field name and value variable name are the same, then just do: `variable,`, not `variable: variable,`

If updating select fields in a struct, make a new variable with those field changes and end with `..instance_name }`.
Move and Copy rules apply - you're updating a field with the `Copy` trait, then the new variable will be a copy of the old one and both exist. Else, only the new variable exists.

E.g.
```
struct Person {
    email: String,
    name: String,
}

fn main() {
    let email = String::new("example@example.com");
    let name = String::new("John Doe");

    let p = Person {
        email,      // instead of email: email,
        name,
    };

    let p2 = Person {
        email: String::new("example2@example.com"),
        ..p
    }
}
```
