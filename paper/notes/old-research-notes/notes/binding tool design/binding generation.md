- binding generation
    - once we have the type metadata how do we generate bindings
    - depends on language compatability
        - similar languages
        - bindings form minimal interfaces, we might only need to apply slight transformations to the source type so its representable in the target language
            - sometimes even no transformations at all but I think rarely
            - sometimes we have cases where compilers are like kinda designed with multiple languages in mind
                - Cython compiler can generate C code

        - disimilar languages
        -  bindings are generally more complex in nature, here to my knowledge there are kinda two ways to implement things
            - connected glue code layers
            => this is what most implementations do, in that the generated bindings often dont really appear as idiomatically mirrored types but instead as clear wrappers which expose certain functionality that can be bridged

            - disconnected glue code layers
            => this seems to be alot less common, here the glue code layer is essentially hidden in that you have idiomatically mirrored types, naturally things are still restricted by what the library can mirror but for all types which can be bridged for the user end everything is completely exposed
            - in this case the glue code layer instead of consiting of wrappers which hold memory it instantates those mirrored types which its capable of briding