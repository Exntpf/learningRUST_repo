use std::{
    env,
    fs,
    io::{ prelude::*, BufReader},
    net::{TcpListener, TcpStream},
};

// starts up either a client or server instance.
// client given IP address: 127.0.0.1:1111
// server given IP address: 127.0.0.1:7878, which is hardcoded into client. 

fn main(){
    let args: Vec<String> = env::args().collect();
    dbg!(args.len());
    if !args.len() == 2 {
        println!("Invalid arguments provided. Usage: -- \"client\"||\"server\"");
        return;
    }
    match args[1].as_str() {
        "client" => run_client(),
        "server" => run_server(),
        _ => {
            println!("Invalid arguments provided. Usage: -- \"client\"||\"server\"");
            return;
        },
    };   
}

fn run_client() -> i32{
    return connect_to_server();
}



fn connect_to_server() -> i32{

    match TcpStream::connect("127.0.0.1:7878") {
        Ok(mut stream) => {
            
            println!("Client: Connection to server established.");

            let get_msg_str= "GET /dcap HTTP/1.1\r\n";

            stream.write(get_msg_str.as_bytes()).unwrap();

            println!("Client: Get message sent successfully.");

            let buf_reader = BufReader::new(&mut stream);

            match buf_reader.lines().next().unwrap() {
                Ok(server_response) => {
                    println!("Client: Received server response.");
                    match fs::write("client_output.txt", server_response.as_bytes()){
                        Ok(_) => {
                            println!("Client: Server response successfully saved to client_output.txt.");
                            return 0;
                        },
                        Err(err_code) => {
                            println!("Client: Could not save server response to file -> {}", err_code);
                            return -1;

                        },
                    };
                },
                Err(err_code) => {
                    println!("Client: Server response error -> {}", err_code);
                    return -1;
                },
            }
        },
        Err(err_code) => {
            println!("Client: Could not connect to server -> {}", err_code);
            return -1;
        }
    }
}


fn run_server() -> i32{
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();
    println!("server running on: 127.0.0.1:7878");
    
    for stream in listener.incoming(){
        let stream = stream.unwrap();
        server_handle_connection(stream);
    }
    return 0;
}

fn server_handle_connection(mut stream: TcpStream){
    let buf_reader = BufReader::new(&mut stream);
    let http_request_line = buf_reader
        .lines()
        .next()
        .unwrap()
        .unwrap();


    // first unwrap is for Option because lines() might return None
    // second unwrap is to return the actual str that gets assigned.
    // unwrap() in the above line for commit 8610b4aef42b51dbe13231b84d2a6dba5fb94bb2 
    // means that we are not handling the None that .lines() could return.
    println!("received request: {:#?}", http_request_line);
    let (status_line, http_file) = match http_request_line.as_str() {
        "GET /dcap HTTP/1.1" => ("HTTP/1.1 200 OK", "devCapMsg.html"),
        _ => ("HTTP/1.1 404 NOT FOUND", "404.html"),
    };

    let content = fs::read_to_string(http_file).unwrap(); // this might return Err if file not found.
    // for the server, could use the error here as a way to check if the file/resource exists
    // but it still feels better to have a whitelist of the services offered by the server, compare 
    // the request against that,
    // and then have a function encapsulate the getting of the resource from the file.
    let content_length = content.len();
    let response = format!("{status_line}\r\nContent-Type: application/sep+xml\r\nContent-Length: {content_length}\r\n\r\n{content}");
    stream.write_all(response.as_bytes()).unwrap(); // error handling not done here either. write_all might return Err
}
