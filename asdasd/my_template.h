#ifndef MY_TEMPLATE_H
#define MY_TEMPLATE_H

template <typename T>
class MyTemplate {
public:
    MyTemplate(T value) : value(value) {}
    T getValue() const { return value; }
private:
    T value;
};

extern template class MyTemplate<int>;
extern template class MyTemplate<double>;

#endif // MY_TEMPLATE_H
