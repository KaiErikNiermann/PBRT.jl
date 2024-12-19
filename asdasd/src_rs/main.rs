mod test;
mod test2;

fn main() {
    test2::foo();
    println!("add test: {}", test::add(10.5));
}