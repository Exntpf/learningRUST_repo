mod ex1;
mod ex2;
mod ex3;

pub fn run_exercises(){
    let mut list = vec![1, 4, 2, 4, 1, 3, 2, 1, 2, 1, 9, 34, 76];
    println!("list: {:?}", list);
    list.sort();
    println!("sorted list: {:?}", list);
    println!("(median, mode): {:?}", ex1::exercise1(list));
    
    let input_string = String::from("detective rabbit apple, a");
    println!("{}", ex2::exercise2(&input_string));
    
    ex3::exercise3();
}