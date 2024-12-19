package main

import (
    "fmt"
)

// Define a type constraint for numeric types.
type Number interface {
    int | int32 | int64 | float32 | float64
}

// Generic add function that takes two parameters of type Number.
func myadd[T Number](a, b T) T {
    return a + b
}

func main() {
    // Using the myadd function with different numeric types
    intResult := myadd(5, 10)
    fmt.Printf("Integer result: %d\n", intResult)

    floatResult := myadd(5.5, 10.5)
    fmt.Printf("Float result: %.2f\n", floatResult)

    int64Result := myadd(int64(1000000000), int64(2000000000))
    fmt.Printf("Int64 result: %d\n", int64Result)
}
