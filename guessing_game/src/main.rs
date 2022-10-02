use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn main() {

    println!("Guess a number!");

    let secret_number = rand::thread_rng().gen_range(1..=100);

    loop {
        println!("Please input your guess.");

        let mut guess = String::new();

        io::stdin()
        .read_line(&mut guess)
        .expect("Failed to read line");
        
        let guess: u32 = match guess.trim().parse() {
            Ok(a) => a,
            Err(_) => {
                println!("Please type an integer!");
                continue;
            }
        };
        
        println!("You guessed: {guess}");
        
        match guess.cmp(&secret_number) {
            Ordering::Greater => 
            println!("Guess is too big!"),
            Ordering::Equal => {
                println!("Correct! You win!");
                break;
            }
            Ordering::Less => 
            println!("Guess is too small!"),
        }
    }
    
    // well that was simple and informative! Already getting a taste of the helpfullness
    // of not-ancient languages that unlike C have vuild-in functions to make life easier.
}
