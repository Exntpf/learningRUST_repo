#[derive(Debug)]
struct Rectangle {
    width: u32,
    height: u32,
}

impl Rectangle {
    fn area(&self) -> u32 {
        self.width * self.height
    }

    pub fn calc_area(height: &u32, width: &u32) -> u32{
        height * width
    }

    fn is_larger(&self, r: &Rectangle) -> bool {
        self.width > r.width && self.width > r.height && self.height > r.width && self.height > r.height
    }

    fn destroy(self){}
}

#[allow(dead_code)]
fn main() {
    let rect1 = Rectangle {
        width: 58,
        height: 32,
    };
    let rect2 = Rectangle {
        width: 12,
        height: 23,
    };

    println!("The area of the rectangle rect1 is {} square pixels.", rect1.area());
    println!("rect1.is_larger(rect2): {}\nrect2.is_larger(rect1): {}", 
    rect1.is_larger(&rect2),  rect2.is_larger(&rect1));
    let x = 4;
    let y = x;
    println!("{}", Rectangle::calc_area(&x, &y));
    rect1.destroy();

}
