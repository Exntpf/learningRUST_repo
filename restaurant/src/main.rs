use restaurant;
use restaurant::front_of_house;
use restaurant::front_of_house::serving;

fn main() {
    restaurant::eat_at_restaurant();
    serving::take_order();
    front_of_house::hosting::add_to_waitlist();
}