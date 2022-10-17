const VOWELS: &str = "aeiou";

pub fn exercise2(s: &String) -> String{
    let mut output_str = String::from("");
    for word in s.split_whitespace() {
        let mut word_chars = word.chars();
        if let Some(first_letter) = word_chars.next(){
            if VOWELS.contains(first_letter){
                output_str.push_str(&format!("{}{}-hay ", first_letter, word_chars.as_str()));
            } else {
                output_str.push_str(&format!("{1}-{0}ay ", first_letter, word_chars.as_str()));
            }
        }
    }
    return String::from(output_str.trim());
}
