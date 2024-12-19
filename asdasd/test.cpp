#include <string>
#include <concepts>

auto out_string(std::string a, std::string b) -> std::string {
    return a;
}

template <typename T>
struct Box {
    using value_type = T;  
    T value;
};

// The issue was here - the requires expression needed to match how value_type is used
template<typename T>
concept is_box = requires(T t) {
    { t.value } -> std::convertible_to<typename T::value_type>;
};

template<is_box T>
auto out_type(T a, T b) -> T {
    return a;
}

int main() {
    Box<int> a{.value = 1};
    Box<int> b{.value = 2};
    out_type(a, b);
    return 0;
}