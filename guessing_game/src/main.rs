use std::io;
use std::cmp::Ordering;
use rand::Rng;

fn gen_random_int(lower: &i32, upper: &i32) -> i32{
    rand::thread_rng().gen_range(*lower..=*upper)
}

fn get_number_stdin() -> i32{
    loop {
        let mut input_string = String::new();
        io::stdin()
            .read_line(&mut input_string)
            .expect("Could not read in number");

        match input_string.trim().parse() {
            Ok(a) => break a,
            Err(_) => {
                println!("You didn't enter a number!");
                continue;
            }
        };
    }
}

// checks guess against rand_int, prints appropriate messages for Greater, Less and Equal cases.
// returns True if not equal, else False.
fn check_guess(guess: &i32, rand_int: &i32) -> bool {
    match (*guess).cmp(rand_int) {
        Ordering::Greater => {
            println!("Too high!");
            true
        },
        Ordering::Less => {
            println!("Too low!");
            true
        },
        Ordering::Equal => {
            println!("Just right!");
            false
        }
    }
}

fn main() {


    println!("Enter lower bound: ");
    let lower = get_number_stdin();
    println!("Enter upper bound: ");
    let upper = get_number_stdin();

    let rand_int = gen_random_int(&lower, &upper);
    
    println!("Enter your guess!");
    while check_guess(&get_number_stdin(), &rand_int){}

    println!("Congratulations! You win!");

    // let secret_number = rand::thread_rng().gen_range(1..=100);

    // loop {
    //     println!("Please input your guess.");

    //     let mut guess = String::new();

    //     io::stdin()
    //     .read_line(&mut guess)
    //     .expect("Failed to read line");
        
    //     let guess: u32 = match guess.trim().parse() {
    //         Ok(a) => a,
    //         Err(_) => {
    //             println!("Please type an integer!");
    //             continue;
    //         }
    //     };
        
    //     println!("You guessed: {guess}");
        
    //     match guess.cmp(&secret_number) {
    //         Ordering::Greater => 
    //         println!("Guess is too big!"),
    //         Ordering::Equal => {
    //             println!("Correct! You win!");
    //             break;
    //         }
    //         Ordering::Less => 
    //         println!("Guess is too small!"),
    //     }
    // }
    
    // well that was simple and informative! Already getting a taste of the helpfullness
    // of not-ancient languages that unlike C have vuild-in functions to make life easier.
}
