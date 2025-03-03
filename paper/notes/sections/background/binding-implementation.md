## Rough Draft

binding / blue code implementations
- binding
    - wrappers that allow you to use something in a target language
- binding construction (metadata phase)
    - since we need some representation of the types in both languages
    - so the question is how do we generate these bindings
    - automatically
        - we parse the headers
            - frontend compiler tools (clang AST parser)
            - alot more difficult to work with as we only need a very restricted portion of the ast, that is we just need the header information
            => manually implemented header parsers (crubit I think)
            - easier to implement and apply in our binding generation tool but also means we have to basically reimplement existing frontend tooling
        - we use code reflection
            - languages which implement strong reflection systems (AKA python)
            - reflect on the types and extract runtime type metadata to generat bindings for target language
            - **issues**:
                - reflection is not supported in many languages
                - many languages arent even designed to ever really accomodate it properly,
                - additionaly reflections systems can potentially not provide enough or just not the right information needed
                - examples: Python, Java, C#
    - manual specification
        - we can manually specificy the bindings
	- example: Boost.python (pybind11, CxxWrap) use manual specifications and then code generation from the specifications
        - issue: obvious fact that it requires manual specification
        - benefit: we dont need to work with parsers at all, i mean idfk im not gonna enmerate on everything
        
## Refined Draft
binding / blue code implementations
- binding
    - wrappers that allow you to use something in a target language
- binding construction (metadata phase)
    - since we need some representation of the types in both languages
    - so the question is how do we generate these bindings
    - automatically
        - we parse the headers
            - frontend compiler tools (clang AST parser)
            - alot more difficult to work with as we only need a very restricted portion of the ast, that is we just need the header information
            => manually implemented header parsers (crubit I think)
            - easier to implement and apply in our binding generation tool but also means we have to basically reimplement existing frontend tooling

Having established a baseline for the low-level dynamics we can move onto some of the more high-level question when it comes to the design of binding generators. As is the case when we talk about most kinds of software we can broadly distinguish two important categories, the low-level and high-level aspects of our implementation. A very popular field in which this division is most commonly mentioned is the field of web development where we have a back-end usually running server sided code such as one which handles API requests and a front-end which deals with client actions such as making requests and rendering information. The division of back-end naturally extends to various other implementations of software systems, in the case of binding generators our back-end comes in the form of the low-level platform based considerations we have to make i.e. reconciling different memory layouts and execution models, the high-level or "front-end" is then what we actually expose to the programmer. A more apt descriptor of a binding generator front-end would be the API it exposes. An important distinction here is that when we talk about glue code generators there are two relevant API's:
1. The one of the generator itself, so the collection of methods and classes it exposes as features.
2. The collection of types this generator is capable of bridging into a different languages which itself often relates to bridging an API for a library or framework written in another language. 
In the following I will focus primarily on (1) as its difficult to asses (2) in any meaningful fashion within the scope of this paper. It would make sense to establish some semantic clarity before we move on. When I talk about an interoperability layer this refers to the broadest possible descriptor of any software system which enables interoperability between languages which encompasses glue code, binding generators, foreign function interfaces, etc. The concrete piece of code which actually enables interop is usually a conjunction of a languages foreign function interface standard on which there are generally libraries which form abstraction proxies to enable easier and more flexible usage over having to deal with the more low level constructs. Binding generators as the name implies are pieces of software which generate a language binding, which is to say they are code generators for automating the creation of glue code. Having established the terminology now we can move on to the key question of how do these generators tend to actually produces the desired glue code ? 

Abstraction once again becomes a very central aspect to how different implementations tackle the problem of generating the desired glue code. Naturally it might become clear that if we want to generate bindings for an API across a language boundary we need some mechanism to actually understand both what this API expects as inputs and gives back as outputs. Expressing this expectation more formally there are 4 important stages we can define 
1. Parsing : We need some means of turning the API (i.e. our collections of types) into a malleable format   
2. Semantic analysis : Once we have our format we need some way of understanding it to ensure we create a safe bridge 
3. Transformation : Once we have developed an understanding of the API we need to define constraints to not expose functionality which would be unsafe 
4. (Glue) code generation  : Finally once we have defined the necessary constraints we need to actually generate the necessary bindings to use the language bindings in our bridged language
As these are dependent processes one of the most important implementation considerations becomes the choice of how we parse the API we wish to expose to the other language. An observation people familiar with compilers might have already made would be the similarity here to compilation processes of programming languages. The similarity to standard compilation leads into the first approach various glue code generators use for parsing, namely standard lexical and syntactic analysis based on a languages defined tokens and grammar. Despite superficially similar approaches being employed to front-end compiler design; as one approach of parsing; there is a common design paradigm of creating domain specific restricted parsers that naturally focus predominantly on parsing headers / type signatures as its ultimately not the entire language itself we aim to bridge, simply the interfaces this would make working with language parsers rather unwieldy as we would essentially have to extract only a minimal subset of the high level IR which actually refers to the information necessary for the glue code generation. Despite this the swift compiler team did implement the header parsing process utilizing the clang AST parser, though looking at some of the most popular glue code generators this approach appears to be an outlier. 

- we use code reflection
	- languages which implement strong reflection systems (AKA python)
	- reflect on the types and extract runtime type metadata to generate bindings for target language
	- **issues**:
		- reflection is not supported in many languages
		- many languages arent even designed to ever really accomodate it properly,
		- additionaly reflections systems can potentially not provide enough or just not the right information needed
                - examples: Python, Java, C#
    - manual specification
        - we can manually specificy the bindings
	- example: Boost.python (pybind11, CxxWrap) use manual specifications and then code generation from the specifications
        - issue: obvious fact that it requires manual specification
        - benefit: we dont need to work with parsers at all, i mean idfk im not gonna enmerate on everything
        
 The other approach we can observe for gathering the necessary information about the types we aim to bridge is to utilize code reflection. I want to clarify that, as with most design considerations discussed in this paper, the wide variety of implementations means that the approaches analyzed here are not mutually exclusive. While I discuss them separately, real-world implementations may combine multiple approaches. My goal is simply to assess different attributes of these implementations in a way that made the most sense given the constraints of the ones I examined. Code reflection, as opposed to parsing through lexing and syntactic analysis, is a much more language specific implementation choice as the glue code generator is now integrated with the languages runtime as opposed to existing aside it as an addition build step for example. As reflection is a primarily runtime based process it allows for certain unique approaches for generating glue code as we can utilize runtime information though comes with its fare share of drawbacks. Unlike the more traditional compiler based parsing code reflection is naturally only present in a subset of languages as its not an intrinsic property of a language rather a deliberate runtime implementation feature of the languages design. Furthermore, as reflection, more concretely type metadata, implies overhead in conjunction with its predominantly runtime based nature we have the fact that many languages arent even designed to accomodate reflection. Finally we have the fact that reflection systems can potentially provide not enough or just not the right information necessary, abstractly speaking we run into a similar issue of using a language AST in that we first need to parse the format into our domain specific usage as opposed to just developing a domain specific parsing solution from the get-go. Nonetheless as I will elaborate in the binding generation section there are some very interesting results that we get from the dynaism that comes with applying code reflection in this situation.

Manual specification is the final approach for how to generate bindings. Complete manual specification, by which I mean using very low level FFI libraries is a largely outdated approach for most languages as by now even for the case of manual specification there exist means by which extreme low level specifications are abstracted by utilizing different code generation processes, a simple example being the use of macros to expand binding specifications into the more low level format which we can pass across the language boundary. One area in which we see manual specification often occur even with binding generator tools is in making certain more nuanced modifications to the generated code or the generation process in instances where the generator tools yield certain undesirable formats in the cross language setting. 
## Final Draft