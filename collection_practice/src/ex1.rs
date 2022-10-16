use std::collections::HashMap;

// returns tuple with (median: i32, mode: i32)
pub fn exercise1(list: &mut Vec<i32>)-> (i32, i32){
    list.sort();
    let median_index = list.len()/2;
    let median = list.get(median_index);
    
    let mut list_map = HashMap::new();
    let mut mode_values: (i32, i32) = (0, 0);
    for i in list {
        let count = list_map.entry(i).or_insert(0);
        *count +=1;
        let (mode_num, mode_count) = &mut mode_values;
        if *count > *mode_count {
            match list_map.get(i){
                Some(a) => {
                    *mode_num = *a;
                    *mode_count = *count;
                },
                None => continue,
            }
        }
    }
    if let Some(a) = median {
        return (*a, mode_values.0);
    }
    return (0, mode_values.0);
}
