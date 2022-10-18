use std::io;
use std::collections::HashMap;

enum Command {
    add,
    list_all,
    list_department,
    quit,
}


// Error codes:
// -1 = no input;
// -2 = invalid command;

// command format
// "Add <person: String> to <department: String>"
// "List <department: String>"
// "List everyone"

// data organisation:
// HashMap<department: String, people: Vec<String>>

fn get_command(s: &String) -> Result<Command, i32>{
//     if s.is_empty() { return Err(-1) };
    let mut command_words = s.split_whitespace();
    return match command_words.next() {
        // check string not empty
        Some(value) => {
            // check first argument
            match value {
                "Add" => Ok(Command::add),
                "Quit" => Ok(Command::quit),
                "List" => {
                    if let Some(next_arg) = command_words.next(){
                        if next_arg == "everyone" { return Ok(Command::list_all);}
                        else { return Ok(Command::list_department); }
                    } else {
                        return Err(-2);
                    }
                },
                _ => Err(-2),
            }
        },
        None => Err(-1),
    }
}

fn get_input() -> String{
    let mut input = String::new();
    io::stdin()
        .read_line(&mut input)
        .expect("Could not read in command.");
    input
}

fn 

pub fn exercise3(){
    let mut department_hash = HashMap::new();
    loop {
        let input_string = get_input();
        match get_command(&input_string) {
            Ok(command) =>{
                let mut input_iter = input_string.split_whitespace().next();
                match command =>{
                    Command::add => {
                        if input_iter.nth(2) != "to" {
                            println!("Incorrect command given. Please enter a valid command.");
                            continue;
                        }
                        let mut dep_people = department_hash
                            .entry(input_iter.nth(3))
                            .or_insert(vec![input_iter.nth(1)]);
                        if dep_people.len() != 1 {
                            dep_people.push(input_iter.nth(1));
                        }
                    },
                    Command::list_all => {
                        
                    },
                    Command::list_department => {
                        
                    },
                    Command::quit => {
                        return;
                    },
                }
            }
            Err(err_code) => {
                match err_code {
                    -1 => {
                        println!("No command found. Please enter a valid command.");
                        continue;
                    },
                    -2 => {
                        println!("Incorrect command given. Please enter a valid command.");
                        continue;
                    },
                    _ =>  {
                        println!("Error occurred. Please enter a valid command.");
                        continue;
                    },
                }
            },

        }

    }
    println!("Exercise 3 result: ");
}