use std::collections::HashMap;

//returns an immutable reference to the median element.
fn calc_median(list: &Vec<i32>) -> &i32{
    let median_index = list.len()/2;
    return &list[median_index];
}

// returns tuple with (median: i32, mode: i32)

pub fn exercise1(mut list: Vec<i32>)-> (i32, i32){
    list.sort();
    // median is now an immutable reference to the middle value of the list.
    let median = calc_median(&list);

    let mut list_map = HashMap::new();
    for i in &list {
        // increment count of list value
        let count = list_map.entry(i).or_insert(0);
        *count +=1;
    }
    println!("{:?}", list_map);

    let mut mode_values: (i32, i32) = (0, 0);
    for (key, value) in list_map{
        let (mode_num, mode_count) = &mut mode_values;
        if value > *mode_count {
            *mode_num = *key;
            *mode_count = value;
        }
    }
    return (*median, mode_values.0);
}
