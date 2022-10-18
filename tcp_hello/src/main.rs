use std::{
    fs,
    io::{prelude::*, BufReader},
    net::{TcpListener, TcpStream},
};

fn main() {
    let listener = TcpListener::bind("127.0.0.1:7878").unwrap();

    for stream in listener.incoming(){
        let stream = stream.unwrap();
        handle_connection(stream);
    }
}

fn handle_connection(mut stream: TcpStream){
    let buf_reader = BufReader::new(&mut stream);
    let http_request_line = buf_reader.lines().next().unwrap().unwrap();
    // first unwrap is for Option because lines() might return None
    // second unwrap is to return the actual str that gets assigned.
    // unwrap() in the above line for commit 8610b4aef42b51dbe13231b84d2a6dba5fb94bb2 
    // means that we are not handling the None that .lines() could return.

    let (status_line, http_file) = match http_request_line.as_str() {
        "GET / HTTP/1.1" => ("HTTP/1.1 200 OK", "hello.html"),
        _ => ("HTTP/1.1 404 NOT FOUND", "404.html"),
    };

    let content = fs::read_to_string(http_file).unwrap(); // this might return Err if file not found.
    // for the server, could use the error here as a way to check if the file/resource exists
    // but it still feels better to have a whitelist of the services offered by the server, compare 
    // the request against that,
    // and then have a function encapsulate the getting of the resource from the file.
    let content_length = content.len();
    let response = format!("{status_line}\r\nContent-Length: {content_length}\r\n\r\n{content}");
    stream.write_all(response.as_bytes()).unwrap(); // error handling not done here either. write_all might return Err
}
