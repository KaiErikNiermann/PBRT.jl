#include <experimental/reflect>
#include <iostream>
#include <utility>
#include <array>

namespace reflect = std::experimental::reflect;

template<template<typename> typename Trait_t, reflect::ObjectSequence Sequence_t, size_t... ints>
consteval auto make_object_sequence_array(std::index_sequence<ints...>)
{
    return std::array { Trait_t<reflect::get_element_t<ints, Sequence_t>>::value... };
}

template<typename T>
consteval auto enum_names() requires std::is_enum_v<T>
{
    using reflected_enum = reflexpr(T);
    using enum_enumerators = reflect::get_enumerators_t<reflected_enum>;
    constexpr size_t T_size = reflect::get_size_v<enum_enumerators>;
    using sequence = std::make_index_sequence<T_size>;
    return make_object_sequence_array<reflect::get_name, enum_enumerators>(sequence{});
}

//example

enum class DaysOfTheWeek : char
{
    Monday,
    Tuesday,
    Wednesday,
    Thursday,
    Friday,
    Saturday,
    Sunday
};

int main()
{
    constexpr auto names = enum_names<DaysOfTheWeek>();
    for(auto& s : names)
    {
        std::cout << s << '\n';
    }
    return names.size(); 
}