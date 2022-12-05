pub mod hosting;

pub mod serving {
    use crate::{hosting::add_to_waitlist, eat_at_restaurant};

    pub fn take_order() {add_to_waitlist(); serve_order();}

    pub fn serve_order() {eat_at_restaurant()}

    pub fn take_payment() {}
}