# Notes on C->RUST
Helpful nuances of Rust to note if you come from C:

## General

expressions (that evaluate to a value) don't need ';' at the end.
expressions at the end of functions are the return value. so fn myFunction() -> bool { true } is perfectly valid.
0 != false & 1 != true. No `if(myFn()) { do_something() }`
variable assignment is not an expression. No `if(i=myFn()) {do_something()}` or `x = y = 1` (which needs `y=1` to return `1`)


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
