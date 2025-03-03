# Introduction 
So I think a good first thing to establish here is a baseline for some terminology. 
When we talk about a rewrite in software development what we mean is writing new code; in the same or a new language; which implements an existing feature set. The key differentating factor here being `new code`, unlike in refactoring where we generally just rearrange or minmize existing code. 
Rewrites can happen for a vast variety of reasons, on an individual level alot of developers might be familiar with the second system effect whereby an initial implementation might be more restrained and careful due to things being new territory but as comfort grows so do the ideas for what to implement the second time around. 
Now this can have some obvious benefits and drawbacks, Fred Brooks who coined this term used it to express a critical drawback of this as being the tendency to overimplement a second system due to the intial restraint. Though there are also some key benefits that come from not only gaining a better understanding of what you are implementing but also new developments in libraries and programming languages which could be effectively applied. 
Additionally there is the aspect that certain intial choices made in an implementation could be somewhat restrictive as the application scales make the codebase harder and harder to maintain as time goes on. 
So in general rewrites have been and are a key component of software development, and with my thesis I wanted to explore some approaches for how we can effectively rewrite systems utilizing some interesting technologies.

# Motivation 
The primary type of rewrite I was interested was a cross-language rewrite. That is to say a rewrite where you apply a different language than the existing language of the source code. Cross-language can generally have the same benefits of regular rewrites but on-top of that also have the potential to address more fundamental limitations regarding the implementation language. 

So while languages can and have obviously evolved over time, they still generally have fundamental properties which remain static, so if these fundamental properties in any way conflict which your system requirements then a rewrite in the same language can only do so much.

The question then becomes, how can you effectively approach rewriting something in another language, especially in larger systems. The most obvious answer is simply rewriting everything. But that comes with some very problematic issues 
- What if it turns out the choice of language is simply ineffective for the system ? 
- What if the system is extremely large and it would take considerable time ? 
- What if unforseen incompatibilities arise with the choice of language ? 

So lets constrain this problem to something more specific, lets say we wanted to first test a critical component of our hypothetical system in another language? Since you could reason that if the most important part of a system doesnt effectively function for the choice of language then there is little benefit in rewriting anything else. So then how do we do this? Some examples for approaches we can take are 
- We could write the minimum required code to wrap the rewritten component in some testing framework to examine how well it functions 
- We could as before rewriting everything to accurately test this component (but again this is problematic)

Ok, now there are some issues that arise from the above choices, so lets maybe refrain our problem here in terms of what we want, we want to test the most important component in an environment which would accurately reflect its real world usage, with the minimal amount of additional code needed since this would achieve the core objective of answering the question of 
- Does this component work better in another language ? 

One way we can get this is through the use of language interop APIs, which depending on the choice of language can require very little to no additional code needed while allowing us to perfectly slot in a component in a different language into the existing implementation.

This provided the basis for the motivation, I wanted to test how effectively we could use these APIs and by extension the system which allows these APIs to function, to effectively solate and test compontents in other languages while still being able to use all other aspects of the existing implementation.

# Research questions 
First, the main question we want to address is:

How can we effectively test the performance of a specific component of a system rewritten in another programming language?

Aim: Our aim is to establish a basic framework for evaluating how effective a particular programming language might be at solving a specific task within a system, without the need to rewrite the entire system in that language.

Next, we need to consider the role of language APIs:

How do language APIs differ in their approaches to mapping objects and types, and how can we minimize the overhead? Additionally, we need to determine whether these rewritten components can be used as actual parts of the system or only for performance testing in isolation.

Aim: Here, we aim to explore the current approaches taken for mapping types and efficiently creating bindings between Julia and other languages. Specifically, we'll compare high-level dynamically typed languages with low-level statically typed ones.

Another critical aspect is understanding the impact of language APIs on optimization techniques:

How do language APIs affect the types of optimization techniques we can apply to the components?

Aim: Our goal is to explore how a language API impacts optimizations. For example, can we still use the full set of optimization techniques, or do APIs limit the types of optimizations we can employ in our component?

# System Design 
To evaluate these research questions we need to create an actual concrete implementation of a system so we can see if these language APIs really do effectively work on a larger scale. 

So for this project I chose to use a simple ray tracer implemented in julia for various different reasons. Including 
- complexity: While this is a quite minimal implementation of a ray tracer system its still complex enough to demonstrate the idea in an applied setting as opposed to for example some more abstract minimal implementation which wouldn't necessary be as easily transferrable to a real world scenario. 

- distinct components: a nice benefit of this ray tracing system is tht it has relatively defined components as we saw in the overview we can broadly describe the image generation code, hit code and scatter code, which in turn means we can also isolate some of the most performance dependent sections to reimplement in our different languages 

- high performance: ray tracers especially real time ray tracing is pretty well known for being a very performance heavy task, which gives us the added insight of how well the overall implementation functions when we attached components in different layers by using the various embedding APIs

# Approach 
So now that we established some motivation behind why we want to test this and we have an implementation we can test this with, next comes how we actually test this in practice. We can kinda elaborate on our approach using a Q&A format 
- How do we isolate the most performance impacting component ?
> We profile our application, looking at both runtime and memory profiling and then making some judgment based of this information. 

- What languages do we choose for rewriting ? 
> While we are constrained in a sense to languages which have embedding APIs for julia there are still a few to choose from. From these I would reason that it makes sense to choose 2 languages which differing fundamental properties to evaluate the language APIs applied to two very different scenarios, in our case Python and C++. For both of which we have established interface libraries, and the languages fundamentally differ a fair amount which gives us a nice broad collection of insights we could transfer to languages in various similar domains.

- How do we test the effectiveness of the component ?
> We can use benchmarking tools to test the component in isolation and we can use julia sided tools to benchmark the component + overhead, which allows us to evaluate the performance of the julia sided code, the interface code, and the performance of the component itself.

# Rewriting 

Doing some basic profiling, somewhat unexpectedly the most performance impacting aspect where the hit functions, since most of the time spent in a ray tracer is the check of if the ray actually hit something, this is going to naturally be the most performance heavy code. 

So in this instance we could reason that if our target languages have a worse efficiency at executing this component that it would not make much sense to rewrite the entire ray tracer in the choice of language.

Actually then rewriting these components is a somewhat trivial tasks, since all choice of languages have a mostly similar syntax we can with relative ease reimplement the ray-intersection algorithms in Python and C++.

To just kinda show off the function signatures for one of the hit functions
```c++
bool hit_aabb(const aabb& box, const ray& r, const interval& ray_t)
```

```py
def hit_aabb(bbox: aabb, r: ray, ray_t: interval[float]) -> bool: 
```

```julia
function hit!(bbox::aabb, r::ray, ray_t::interval)::Bool
```

So you can see that code wise at least the implementations map fairly nicely.

# Choice of APIs 
Just having the components written doesnt really accomplish much if we cant execute them as a part of the larger system, so the next move was to figure out which embedding API we choose to actually attach our hit functions to the ray tracer implementation. 

## Python 
Now for python this is was a somewhat simple choice, there is the Python/JuliaCall API which builds on an earlier implementation to support a wider range of conversions between the two languages. 

## C++ 
This becomes more interesting, since Python has trivial reflection mechanisms for objects, that is its quite easy to figure out information from objects conversion mechanisms are pretty simple to implement. The same cannot be said for C++. Here you have more or less 2 main options.
- CxxWrap which has a good featureset but is not very userfriendly 
- Jluna, which is newer and very userfriendly but is missing some mapping mechanisms 

I ended up choosing Jluna for a few reasons, what I wanted to examine here was how can we write the least amount of additional code and expend the least amount of effort to create usable components in another language. Through the use of newer and more extensible C++ techniques Jluna was both more futureproof and userfriendly.

Which broadly speaking is something important to consider, when you do write a component in another language, assuming you do see positive results, preferably you would want to do the least amount of refactoring to integrate the component into the larger rewritten system. Which translates to choosing an API which 
1. leads to a minimal amount of additional code having to be written 
2. leads to a minimal amount of code having to be attached to your components 

Another observation I learned from this process, and some foreshadowing for what is to come, generally languages which support reflection are the ones where you have to write the least amount of additional code and can just rewrite and test your components.

# Testing setup 
With all this in mind we can create out testing setup which is seen as below

*just describe the diagram or something*


# Dynamic mapping 

TODO: 

# Static mapping 

For mapping objects from julia to statically typed languages the approach in most instances is to have the user describe an interface for any defined type (e.g. class/struct) and then have the API utilize this type to map the low level representation of the mirrored Julia type onto this type.

So more broadly speaking we have a user defined reflection system, and them some mapping algorithm which can parse the low level type and from this data give us back the corresponding C++ type before handing it off to the function.

More formally we define a function $\text{get}(x)$ and a function $\text{put}(x)$ for all intents and purposes these can be thought of as getters and setters. So we first define a property $x$, a simple approach here would be to use a string representation, and we then define our getter setter pair as 
$$
\text{get}: S\rightarrow V = \text{object property }x
$$
$$
\text{set}: S, V\rightarrow S = \text{modified propert }x 
$$
For people who are familiar with functional programming you might realize that this is mroe or less the same thing as a lens.

# No reflect trivial 

Now the issue with this model of using these getter/setter pairs is that is a key limitation. To demonstrate lets introduce some additional notation, we will express $S$ and $V$ with corresponding types $T$ as $[S: T]$ and $[V: T]$, which yields us. 
$$
\text{set}: [S: T], [V: T]\rightarrow S
$$
Now the problem comes when our source $S$ takes on an abstract type, lets denote $T_B$ as some abstract base type and $T_{di}$ as the $i$th derived type. We then have the function 
$$
\text{set}: [S: T_B], [V: T_{bi}]\rightarrow S
$$
So now you might be asking why is this an issue ? We have our base type for the source object, and we have the derived type being expressed by the view $V$. So we can now instantiate our object using the derived type. 

But unfortunately things arent so simple in practice. In the case of Julia the metadata contained in the low level type representation uses strings to express the type, so the above function is actually 
$$
\text{set}: [S: T_B], [V: \text{str}(T_{bi})]\rightarrow S
$$
So the question then becomes how can we instantiate the derived type $T_{bi}$ corresponding to $\text{str}(T_{bi})$. For any approach the first thing we must do is create some mapping of strings to some type information which can be used in C++. Formally we define a function $st$ 
$$
st: \text{str}(T_i)\rightarrow \text{typeinf}(T_i)
$$

As a reminder we need to figure out $T_{bi}$ that is, we must find some transformation which gives us the C++ sided type such that we can call the correct instantiation method for this type. 

While it might be feasable to create a direct runtime mapping of strings to C++ types a simple way of achieving an indirect mapping is through the use of some basic compile time code generation constructs. We define a variadic template pack which takes the derived types a setter might need to know about, and then at compile time we use a fold expression to in a sense "iterate" over the template pack and discern the type with the matching type info. That is to say we define a function 
$$
f: st, \text{typeinf}(T_p)\rightarrow \text{bool}
$$

With this function we can take in the string representation of our Julia type and match it to the corresponding C++ type and from this instantiate the correct object.

So in other words a trivial way of creating this correspondence is by utilizing fold expression generate a compile time list of checks that instantiate the right object for a type with a matching type info.

# no reflect better 

An issue with the above approach is that it requires that we provide all derived types to each getter/setter pair, which would lead to a considerable amount of overhead and would likely also be error prone while there are methods of mitigating that. 

So what we would preferably want is a system where; for the setters that need it; we can provide them with all the user defined derived types and we would preferably not want to provide this individually to all setters it would be nice to define the set of derived types once and give all setters for attributes of a particular class access to this information. 

# no reflect better 2
We can improve upon this design by creating a function which uses varadic templates not only for the types but for the getters and setters for a coresponding object itself. This can be used to generate a compile time mapping for object attribute names to getter and setter pairs, each of which have access to all derived types. We can define this as 

```py
def initialize_type[T, properties..., derived...]() -> void: 
    fold(
        mapping.insert(property::name, 
            {
                [instance: T]() { 
                    instance[T](property::get(instance)) 
                }, 
                [instance: T, jl_val: jlval, jl_type_string: str] {
                    fold(
                        if (f(st(jl_type_string), typeinfo(derived))): 
                            property::set(instance, instance[derived](jl_val))
                            matched = true
                    )
                    if (!matched): 
                        property::set(instance, instance[T](jl_val))
                }
            }
        )
    )

...
def instance[T](jl_val): 
    out = T()

    for name, (setter, getter) in mapping: 
        setter(out, jlfield(name, jl_val))

    return out
```

# no reflect better 3 

The way this system is then defined on the user end is through the use of template metafunctions, these are generic objects with static members that can be treated as types and hence passed in a variadic template pack. 

We can declare our object properties as such 
```cpp
template <typename Ot, typename Ft, const char* name>
struct Property {
    using obj_t = const Ot;
    using field_t = Ft;
    static constexpr const char* get_name() { return name; }
    static std::function<Ft(Ot&)> getter;
    static std::function<void(Ot&, Ft)> setter;
};
``` 
We would define a property as follows 
```cpp
Property<bvh_node, Hittable*, "left">
```
After we defined all properties we can then pass this off to your `intialize_type` function. 
```cpp 
Usertype<bvh_node>::initalize_type(
    tl<
        bvh_node_left,
        bvh_node_right,
        bvh_node_bbox
    >(),
    tl<Triangle, sphere, bvh_node>()
);
```
`Usertype<bvh_node>` in this case is simply an abstraction for a collection of defined `Property` types, all of which are utilized to self-instantiate a class based on some incoming jl representation.

# Limitations 
The assumption here is that the person using this API is trying to mirror the types, that is to say from Julia they will not attempt to call an object with no  ++ mirrored version 
this is not too problematic though as library already errors if no mirrored type exists as it heavily uses type predicates to find a matching interface and if none is found it errors
this approach still requires the user to specify a fair bit information about the class properties via lambdas, and you still have to pass all derived types to any object with a base type attributes
i tried having just the base type interface get its derived types but with the current system it seems somewhat hard to get the correct type back from the base type interface as this can generally only ever either construct itself or unbox a derived type but not give the unboxed type back to the callee

# benefits
this system allows for pretty easy deduction of the correct object to generate, whereas more traditional methods often required quite convoluted implementations to make the type hierarchy visible to the API 
in this case since we are no longer relying on all interfaces by default stack allocating their own instances when unboxing, we should be able to map purely abstract functions that arent default construcable between languages
in line with the principle the library was designed with this extension uses somewhat modern c++ principles which make it potentially more futureproof and imo more maintainable
this approach in general is alot more terse then previously implementations and also through its generality probably more easily extensible 

# Impact 
So, to relate all of this back to some of the research questions we wanted to answer. We've seen now that even thought C++ has rather poor support for introspection on objects we can indeed use modern approaches to implement a basic system that allows simple user defined specification for mapping poylmorphic objects.

Thus putting it on par with the abilities of the juliacall API while offering the speed of C++. It still does differentiate itself from the Juliacall implementation by being forced to copy over the Julia sided data though this is more of a fundamental restriction related to the Julia C API. And through the use of some performance benchmarks we will see that this doesn't have too much impact on the overhead of these interop layers. 

With the above described system I aimed to demonstrate that even if there is a lacking availability in interop libraries these are not necessarily too complex to work with and extend given the modern feature set of a language. So even if there are certain unique attributes of an implementation which might not be as trivially mapped, if we can implement a basic form of reflection or if a language already has this available, then we can generally utilize this effectively as a means of mapping low level object representations between languages.

Furthermore since many existing statically typed languages do have some means of object introspection, either through direct support or via similar metaprogramming techniques, it gives ground to the simplicity in the application of these interop libraries as a means of at least testing components in an existing implementation.

# Baseline performance 

So, to look a bit into the performance side of things, I added timing points to two main sections, I timed the call to the bvh hit from julia and i timed the internal time it took for the call to execute in the target language, so c++ and python. This yielded the following results.

These 3 graphs display the runtimes of all calls made to the bvh hit function. We can notice that for Julia most calls alternate betwen a runtime close to 0 which is generally the case where we immediately return because the ray doesn't hit anything and we have a bunch of calls with a longer runtime around 0.0010ms which can be described by the calls where we do actually have a ray intersection with an object and preform the computations

With Python and C++ it becomes a little less clear initially. We can notice that the distribution in call times again measured from julia is within a similar range this can be explained by the overhead incurred which will become a bit clearer when we actually graph out the overhead exclusively. 

# Isolated performance 

Now while its not necessarily the most unexpected thing that using language embedding APIs incurs overhead in this instance I felt it made sense to dig a bit deeper and try to understand the actual source of this. Firstly I wanted to separate out the component runtime from the overhead runtime caused by making the calls to the target languages. 

Doing this we can notice that the actual component runtimes accurately reflect the speed we would expect from the languages with C++ outperforming Julia and Python. 

To look into why we have such a substantial overhead we can use `perf` to actually see which functions are yielding the most amount of overhead. The result revealed that for both Python and C++ the Julia API functions related to dynamic dispatch and type inference where the most heavily visited. While Julia when written trivially generally preforms not much better than something like Python in can preform incredibly well when written in a Type stable manner, that is to say when we don't force the JIT compiler to look for a function to execute and when it can use a cached compiled version. This is a behavior which is likely inhibited as in this case the JIT compiler cant just triviall run a cached precompiled version of the function but instead needs to preform various operations before it can utilize the C API to make the external calls. 

This is one of the major downsides if you want to have high performance interop between languages which are alot more fundamentally different. On a smaller scale this might be effective but it does inhibit the viability of using interop between languages that are too different.  

# Results

So in the end there are a few key things I learned from this. Firstly, while different language APIs do utilize different approaches in the way they allow for the integration of foriegn programming languages into your program, the adaptation of these APIs to a specific use case does not pose a significant challenge. In addition metaprogramming techniques are an effect tool to implement these libraries in a generic and extensible manner. Nonetheless its an important consideration what API you use to rewrite a component since the ways in which they function can drastically impact the developer experience. 

In terms of the performance there is indeed a considerable overhead but this is primarily caused by language incompatitibilites and can be potentially mitigated when doing interop with languages that function of similar execution methods. Thus while the use of these APIs for testing components works well enough based on this application using them in performance dependent production code is something that should be carefully tested beforehand and could be potentially looked into further.