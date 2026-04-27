use std::io::{self, BufRead};

fn main() {
    let stdin = io::stdin();
    for result in stdin.lock().lines() {
        let line = result.unwrap().trim().to_string();
        if line.len() == 0 {
            continue;
        }

        println!("{}", line);
    }
}
