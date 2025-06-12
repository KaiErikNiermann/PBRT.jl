Having established a baseline for the low-level dynamics we can move onto some of the more high-level question when it comes to the design of binding generators. As is the case when we talk about most kinds of software we can broadly distinguish two important categories, the low-level and high-level aspects of our implementation. A very popular field in which this division is most commonly mentioned is the field of web development where we have a back-end usually running server sided code such as one which handles API requests and a front-end which deals with client actions such as making requests and rendering information. The division of back-end naturally extends to various other implementations of software systems, in the case of binding generators our back-end comes in the form of the low-level platform based considerations we have to make i.e. reconciling different memory layouts and execution models, the high-level or "front-end" is then what we actually expose to the programmer. A more apt descriptor of a binding generator front-end would be the API it exposes. An important distinction here is that when we talk about glue code generators there are two relevant API's:

\begin{enumerate}
  \item \textit{Generator API}: The generator itself, which includes the collection of methods and classes it exposes as features.
  \item \textit{Bridging API}: The collection of types this generator is capable of bridging into different languages, often related to bridging an API for a library or framework written in another language.
\end{enumerate}

In the following I will focus primarily on (1) as its difficult to asses (2) in any meaningful fashion within the scope of this paper. It would make sense to establish some semantic clarity before we move on. When I talk about an interoperability layer this refers to the broadest possible descriptor of any software system which enables interoperability between languages which encompasses glue code, binding generators, foreign function interfaces, etc. The concrete piece of code which actually enables interop is usually a conjunction of a languages foreign function interface standard on which there are generally libraries which form abstraction proxies to enable easier and more flexible usage over having to deal with the more low level constructs. Binding generators as the name implies are pieces of software which generate a language binding, which is to say they are code generators for automating the creation of glue code. Having established the terminology now we can move on to the key question of how do these generators tend to actually produces the desired glue code ?

Abstraction once again becomes a very central aspect to how different implementations tackle the problem of generating the desired glue code. Naturally it might become clear that if we want to generate bindings for an API across a language boundary we need some mechanism to actually understand both what this API expects as inputs and gives back as outputs. Expressing this expectation more formally there are 4 important stages we can define
\begin{figure}[ht!]
  \centering
  \include{tex_figures/binding_generator_stages}
  \caption{A high-level overview of the stages in a binding generator.}
  \label{fig:binding_generator_stages}
\end{figure}

\begin{enumerate}
  \item \textit{Parsing}: We need some means of turning the API (i.e. our collections of types) into a malleable format.
  \item \textit{Semantic analysis}: Once we have our format, we need some way of understanding it to ensure we create a safe bridge.
  \item \textit{Transformation}: Once we have developed an understanding of the API, we need to define constraints to not expose functionality which would be unsafe.
  \item \textit{(Glue) code generation}: Finally, once we have defined the necessary constraints, we need to actually generate the necessary bindings to use the language bindings in our bridged language.
\end{enumerate}