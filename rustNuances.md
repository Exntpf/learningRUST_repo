# Notes on C->RUST

Helpful nuances of Rust to note if you come from C:

## General

expressions (that evaluate to a value) don't need ';' at the end.

expressions at the end of functions are the return value. so `fn myFunction() -> bool { true }` is perfectly valid.

`0` is not `false` and `1` is not `true`. No `if(myFn()) { do_something() }` where `fn myFn()->int`

variable assignment is not an expression. No `if(i=myFn()) {do_something()}` or `x = y = 1` (which needs `y=1` to return `1` in C)

A data type implementing the `Copy` trait (ints, char, floats, bool, str) means `x = 1; y = x` will copy `x`'s data into `y`. If the type doesn't implement `Copy`, `x`'s value would be moved to `y`, and `x` can no longer be used.
    More rigorously, all data types that have a known size at compile time are stored on the Stack, where copy data is easy - hence the `Copy` trait. All other data is stored in the heap. Strings are a variable size, so doesn’t implement `Copy`.

You can print the value of a variable, it's location, and line number to stderr using `dbg!(&var)`, as long as the variable type implements the `Debug` trait. The macro takes ownership of `var` if you let it and returns it back, so can do `let var1 = dbg!(var);`.
output: `[src/main.rs:14] dbg_input = value in pretty debug format`

Null doesn't exist: there is only enum Option<T>{ Some<T>, None}, which you can return whenever your code could return Null. To assign a value `None`: `let variable_name: Option<some_type> = None;`. This enum forces you to always consider the case when output could be None to keep code safe.

Literals (values that are literally written out and you can see them in the code) can be made static in the code if the code requires it to exist. This means a function can return a reference to a literate, 

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
```rust
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

## Pointers vs References

### Similarities:

- References refer to an address in memory. You can print them out using the `format(“{:p}”, ptrVar);`. 

- References are a different variable type, and can’t be assigned something that’s not a reference of that type.

    ```rust
    let mut var = &10 \\ &int
    var = &20 \\ allowed
    var = 20 \\ not allowed
    ```

- To edit the value the reference points to, you de-reference it first using the `*` operator. 

    ```rust
    let mut value1 = 10;
    let mut ref1 = &mut value1;
    println!("{ref1:p}"); // address of value1
    *ref1 = *ref1 + 10;
    println!("{ref1:p}"); // **also** address of value1
    assert_eq(value1, 20); // this succeeds
    ```
    
- 

### Differences

- You can perform numeric operations on ints and int references without needing to de-reference. However, you can’t *compare* int and int references without de-referencing. (the former returns an int, but the latter is an expression that would normally result a boolean and rust doesn’t like that)
- You *cannot* perform numeric operations on mutable references without de-referencing first.

## Running RUST functions from C

This can be done by generating a shared library `.so` file. Steps are as follows:

- Rust side:

    - include following lines in `Cargo.toml`:

        ```rust
        [lib]
        crate-type=["cdylib"]
        ```

    - after running `cargo build`,  the `.so` file will be generated in `/target/debug/` in the crate root directory.

    - shared library file name will be in the format: `lib`+`crate_name`+`.so`

- C side (assuming that the C file calling the rust code is in the crate root directory):

    - Linking the library and the executable is done at run time, so compile the project first using `gcc example.c -o example -L./target/debug -lcrate_name`
        - The `-L` flag has the location.
        - The `-l` flag has the file name. gcc adds the `lib` start and `.so` end on it’s own.
    - set the `LD_LIBRARY_PATH` environment variable by running either:
        -  `export LD_LIBRARY_PATH=LD_LIBRARY_PATH:abs/crate/addr/target/debug`
        - `LD_LIBRARY_PATH=abs/crate/addr/target/debug`
        - You may use relative addressing as well, just be careful of which directory the terminal is in
    - the `example` executable should now include the `.so` as if it were a regular library.

- When doing this, be careful of types. the `libc` crate gives you C types in RUST.

# Notes on OOP lang -> RUST

Rust doesn’t have inheritance, and separates data and logic more than other languages by having structs and impl blocks for them.

If you have a trait that needs a struct to have certain data, you can have a trait that has getter functions for that data, and have your struct implement that trait. Dunno is this is a hack or the way that language was supposed to be used for this purpose.

RUST also prioritises composition over inheritance. Primarily because it doesn’t have inheritance. But it still follows a common saying that the former is better than the latter as it makes for more flexible code.



# General Notes and Observations

- If you edit a value, you can’t touch any immutable reference to that value used before the edit. Pretend it doesn’t exist, because you can’t read it, work with it, refer to it, think about it, nothing.
- If you have a mutable reference to a value, that can be the only way you manipulate that value till you’re done with the reference. If you reference or edit the value after using a mutable reference, you can’t use that `&mut` again.
- You can compare (`==, <, >, >=, <=` ) 2 types that implement the `PartialEq` trait, and 2 *references* of those types as well.
- `&str` is the only exception as `&str == str` is allowed
