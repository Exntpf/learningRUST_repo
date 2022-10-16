mod ex1;
mod ex2;
mod ex3;

pub fn run_exercises(){
    let mut list = vec![1, 4, 2, 4, 1, 3, 2, 1, 2, 1, 9, 34, 76];
    println!("(median, mode): {:#?}", ex1::exercise1(&mut list));
    ex2::exercise2();
    ex3::exercise3();
}