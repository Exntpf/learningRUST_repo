use core::panic;
use std::io;
use std::collections::HashMap;

// command format
// "Add <person: String> to <department: String>"
// "List <department: String>"
// "List everyone"

// data organisation:
// HashMap< department: String, people: Vec<String> >

enum Command{
    Add(String, String),
    ListDept(String),
    ListAll,
    Quit,
    None,
}

fn get_command() -> Command{
    let mut input = String::new();
    io::stdin()
        .read_line(&mut input)
        .expect("Could not read in command.");
    let command_vec: Vec<String> = input.split_whitespace().map(|a| a.to_string()).collect();
    match command_vec[0].as_str(){
        "Add" => {
            if command_vec.len() != 4 { return Command::None }
            else if command_vec[2].to_string() != "to".to_string() { return Command::None }
            else { Command::Add(command_vec[1].to_string(), command_vec[3].to_string()) }
        },
        "List" => {
            if command_vec.len() != 2{
                return Command::None
            }
            if command_vec[1].to_string() == "everyone".to_string(){
                return Command::ListAll
            }
            Command::ListDept(command_vec[1].to_string())
        },
        "Quit" => {
            if command_vec.len() != 1 { Command::None } else { Command::Quit }
        },
        _ => Command::None,
    }
}


pub fn exercise3(){
    let mut data = HashMap::new();
    loop{
        match get_command(){
            Command::Add(person, dept) => {
                println!("{person} added to {dept} department!");
                let employees = &mut data.entry(dept).or_insert(vec![]);
                employees.push(person);
            },
            Command::ListDept(dept) => {
                if data.contains_key(&dept){
                    let employees = &data[&dept];
                    println!("Department {dept} has employees: {0:?}", *employees);
                } else {
                    println!("Department {dept} does not have any employees");
                }
                continue;
            },
            Command::ListAll => {
                if data.is_empty() { println!("Nobody works here!"); continue; }
                for dept in data.keys(){
                    println!("Department {dept} has employees: {0:?}", data[dept]);
                }
            },
            Command::Quit => {
                println!("Adios!");
                break;
            }
            Command::None => {
                println!("Command not valid!");
            }
        } 
    }
}