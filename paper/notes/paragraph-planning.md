# Table of contents

- Introduction (**done**)

- Background & Related work
  - Part 1 - FFI and low level interop

    - Foreign Function Interface (FFI) (**done**)
      - Definition and explanation of FFI
      - Example code snippets in C, Julia, Rust, and Python
      - Discussion on memory layout and limitations of FFI boundary methods

    - Application Binary Interface (ABI) (**done**)
      - Explanation of ABI stability and its importance
      - Discussion on ABI stability in different languages

    - C-ABI and Interop in practice (**done**)
      - Explanation of interop using the C ABI
      - Discussion on marshalling and boxing through the FFI boundary
      - Examples of language features and libraries for interop

    - WebAssembly (WASM) (**done**)
      - Overview of WASM and its development
      - Major WASM compiler toolchains and their descriptions
      - Discussion on WASI and its canonical ABI
      - Explanation of the component model and WIT

  - Part 2 - Meta- approaches to interop

    - Generic types and metaprogramming models (**Notes**)

    - Metaprogramming in the wild (**Notes**)

    - Partial Evaluation and Super Compliation (**Notes**)

    - Unified execution models (**Notes**)

    - Interop in APIs (**Notes**)

    - Domain Specific Languages in Interoperability (**Notes**)

  - Part 3 - Binding generators

    - Binding generator designs (**done**)
      - Explanation of parameter-passing strategies
      - Discussion on memory management and variable lifetimes
      - Overview of binding construction and generation methods
      - Explanation of when binding generation occurs

    - Memory management strategies (**done**)
      - How different languages deal with dropping memory
      - Approaches to reconciling different memory management strategies
      - Lifetimes of objects in programing languages
      - Attempts at unifying lifetime models

    - Binding generator implementations (**ROUGH DRAFT**)
      - Bindings enable cross-language functionality via wrappers.  
      - Binding construction represents types in both languages.  
      - Automatic methods parse headers (e.g., Clang AST, Crubit).  
      - Reflection to extract type metadata and its limitations (languages which support reflection/introspection)
      - Manual methods (e.g., pybind11) avoid parsers but require effort.  

    - Binding generation process (**ROUGH DRAFT**)
      - Binding generation depends on language compatibility: similar languages require minimal transformations, dissimilar ones need complex glue code.  
      - Glue code layers can be **connected** (clear wrappers) or **disconnected** (idiomatic mirrored types).  
      - Preprocessor-based generation occurs as a separate build step, often relying on libraries.  
      - Static compiler-based generation (e.g., Swift's `swiftc`) integrates interoperability directly.  
      - Runtime-based generation, used in dynamic languages (e.g., javacpp, cppyy), leverages runtime information for flexible bindings.  

- (**potential**) A formalization of interop systems and meta-frameworks

  - An overview of type systems (**Notes**)

  - Type systems as categories (**Idea**)

  - Interop systems as Functors ?? (**Idea**)

  - Formal Verification with Coq ?? (**Idea**)

  - Bridging Formality and Practicality ?? (**Idea**)

  - Limitations and future work ?? v

- Practical case study: an applied system
  - Initial prcatical idea: Rewrite a part of a program in different programming languages and integrate it back into the original program.
  - Motivation: Curiosity about executing a program written in two different languages.
  - Refining the idea:
    - Importance of having a reason for rewriting code, such as performance improvement.
    - Differences in performance due to language design and execution methods.
    - Selected a simple Ray Tracer in Julia based on Peter Shirley's guide and C++ implementation.
    - Initial goal: Learn Julia for its performance characteristics close to C and simplicity of Python.
    - Benchmarking results were less than desirable.

  - Explanation of Julia's performance:
    - Julia is a JIT-compiled language with online partial evaluation (OPE) related to its type system.
    - Specializes methods for concrete types it can infer, known as type stable methods.
    - Julia's JIT compiler lacks profile-guided optimization (PGO).
    - Strong dependence on idiomatic code for performance.
    - Written in a non-idiomatic and inefficient manner.
    - Different execution method compared to AOT and other JIT-compiled languages.

  - Alternative approach:
    - Rewrite the most performance-critical segment in a language with less reliance on idiomatic style.
    - Potential to explore interesting questions about interoperability and code execution methods:
    - Designing a system of communication between languages with fundamental differences.
    - Reconciling different type systems in language interoperability.
    - Performance characteristics of language interoperability systems.

  - Summary of practical implementation

  - Part 1 : We want to do something (**mostly done**)

  - Part 2 : We have a problem (**mostly done**)

  - Part 3 : We have a solution (**mostly done**)

  - Part 4 : How well does it work (**Needs Revision**)

  - Limitations and future practical work (**Needs Revision**)

- Discussion (**TODO**)

- Conclusion (**TODO**)
