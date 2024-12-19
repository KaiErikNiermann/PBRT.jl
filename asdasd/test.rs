fn out_string(a: String, b: String) -> String {
    b
}

fn main() {
    let s1 = String::from("hello");
    let s2 = String::from("world");
    out_string(s1, s2);
}
