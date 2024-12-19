use std::ops::Add;

pub fn add<T>(a: T) -> T
where
    T: Add<Output = T> {
    a + a
}
