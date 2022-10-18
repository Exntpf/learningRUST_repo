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
    let http_request = buf_reader
        .lines()
        .map(|result| result.unwrap()) //unwrap here means that we are not handling the None that .lines() could return.
        .take_while(|line| !line.is_empty())
        .collect();

    let status_line = "HTTP/1.1 200 OK";
    let content = fs::read_to_string("hello.html").unwrap(); //this may not work if the file doesn't exist.
    // for the server, could use the error here as a way to check if the file/resource exists
    // but it still feels better to have a whitelist of the services offered by the server, compare 
    // the request against that,
    // and then have a function encapsulate the getting of the resource from the file.
    let content_length = content.len();

    let response = format!("{status_line}\r\nContent-Length: {content_length}\r\n\r\n{content}");
    stream.write_all(response.as_bytes()).unwrap(); // error handling not done here either. write_all might return Err

}
