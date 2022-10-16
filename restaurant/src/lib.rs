pub mod front_of_house;

pub use front_of_house::hosting;

#[allow(dead_code)]
// this is all practice for strings and other things.
pub fn eat_at_restaurant() {
    hosting::add_to_waitlist();
    let pi: f32 = 3.1415926535897934384626433832795028841971693993;
    println!("pi<float>: {pi}");
    let pi_str = "3.1415926535897934384626433832795028841971693993";
    println!("{pi_str}");
    let acc_pi_str = String::from(pi_str) + "75105820974944";
    println!("{acc_pi_str}");
    let mut v = vec![100, 32, 57];
    // for i in &mut v {
    //     println!("{:#?}", i);
    //     println!("{}", i);
    //     if *i == 32 { v.push(42)}
    // }
    for j in 0..v.len()+5 {
        let imref = v.get(j);
        match imref {
            Some(a) => {
                println!("{a:#?}");
                if *a == 32 { v.push(42) }
            },
            None => println!(" None "),
        }
    }
}

