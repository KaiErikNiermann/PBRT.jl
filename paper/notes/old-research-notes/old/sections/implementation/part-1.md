# Versions 
Idea : We want to do something
## Draft
- system design overview 
	- motivate why a ray tracer is the right choice
- approach 
	- briefly mention the rewriting process 
- choices of APIs 
	- maybe go over the architectures for both ? 
	- u can also give like maybe a table to show the features or smth idk 
- testing setup
	- explain the diagram more or less

## Refined Draft

- *System design overview* 
To evaluate these research questions we need to create an actual concrete implementation of a system so we can see if these language APIs really do effectively work on a larger scale. So for this project I chose to use a simple ray tracer implemented in julia for various different reasons. Including 
complexity: While this is a quite minimal implementation of a ray tracer system its still complex enough to demonstrate the idea in an applied setting as opposed to for example some more abstract minimal implementation which wouldn't necessary be as easily transferable to a real world scenario. 

distinct components: a nice benefit of this ray tracing system is that it has relatively defined components as we saw in the overview we can broadly describe the image generation code, hit code and scatter code, which in turn means we can also isolate some of the most performance dependent sections to re-implement in our different languages 

high performance: Ray tracers especially real time ray tracing is pretty well known for being a very performance heavy task, which gives us the added insight of how well the overall implementation functions when we attached components in different layers by using the various embedding APIs.

- *Approach*
So now that we established some motivation behind why we want to test this and we have an implementation we can test this with, next comes how we actually test this in practice. We can kinda elaborate on our approach using a Q&A format 

How do we isolate the most performance impacting component ?
We profile our application, looking at both runtime and memory profiling and then making some judgment based of this information. 

What languages do we choose for rewriting ? 
While we are constrained in a sense to languages which have embedding APIs for julia there are still a few to choose from. From these I would reason that it makes sense to choose 2 languages which differing fundamental properties to evaluate the language APIs applied to two very different scenarios, in our case Python and C++. For both of which we have established interface libraries, and the languages fundamentally differ a fair amount which gives us a nice broad collection of insights we could transfer to languages in various similar domains.

How do we test the effectiveness of the component ?
We can use benchmarking tools to test the component in isolation and we can use julia sided tools to benchmark the component + overhead, which allows us to evaluate the performance of the julia sided code, the interface code, and the performance of the component itself.

- *Choice of APIs*
Just having the components written doesnt really accomplish much if we cant execute them as a part of the larger system, so the next move was to figure out which embedding API we choose to actually attach our hit functions to the ray tracer implementation. 

Python 
Now for python this is was a somewhat simple choice, there is the Python/JuliaCall API which builds on an earlier implementation to support a wider range of conversions between the two languages. 

C++ 
This becomes more interesting, since Python has trivial reflection mechanisms for objects, that is its quite easy to figure out information from objects conversion mechanisms are pretty simple to implement. The same cannot be said for C++. Here you have more or less 2 main options.
- CxxWrap which has a good featureset but is not very userfriendly 
- Jluna, which is newer and very userfriendly but is missing some mapping mechanisms 

I ended up choosing Jluna for a few reasons, what I wanted to examine here was how can we write the least amount of additional code and expend the least amount of effort to create usable components in another language. Through the use of newer and more extensible C++ techniques Jluna was both more futureproof and userfriendly.

Which broadly speaking is something important to consider, when you do write a component in another language, assuming you do see positive results, preferably you would want to do the least amount of refactoring to integrate the component into the larger rewritten system. Which translates to choosing an API which 
1. leads to a minimal amount of additional code having to be written 
2. leads to a minimal amount of code having to be attached to your components 

Another observation I learned from this process, and some foreshadowing for what is to come, generally languages which support reflection are the ones where you have to write the least amount of additional code and can just rewrite and test your components.

- *Testing setup*

## Final Draft

As one of the objectives of this paper is not only to research the theoretical underpinnings of interoperability but also asses their viability in practice we can move on to describing how a lot of the topics previously discussed have relevance in practice. In the preamble the decision was made to use a ray-tracer implementation written in Julia as the main subject for this exploration. Before delving into the implementation of the actual cross language aspects it would make sense to give some motivation as to why a ray-tracer serves as a good subject. The decision; despite being initially somewhat ad-hoc; does present some potentially insightful attributes. Ray-tracers, especially more developed legacy implementations, are somewhat well-known for being complex pieces of software, not only due to their foundation in mathematical modelling but also their interconnectedness of various different systems to enable the actual image generation. The complexity of even somewhat minimal ray-tracer implementations; as in the case of the one im using; nicely presents a situation analogous enough to more complex systems giving potentially some broader insights into the effects of interop as opposed to some domain specific minimal example. Performance is another key aspect of ray-tracers, while they had their roots in drawing simple images nowadays ray-tracers or more broadly speaking physcially based rendering frameworks (PBR) are used in real time in video-games, in turn creating a massive demand for high performance PBR systems, while the ray-tracer used in this paper only implements a very minimal subset it still relates directly to a domain in which performance is critical, again serving as an indicator of the viability of the applied interop techniques in performance demanding scenarios. Finally, despite the aforementioned complexity of ray-tracers they do tend to be very modular systems in some respects, this modularity should allow for an easier time separating predominantly logically distinct components and thus make the rewriting process easier. 

Now that we've established our motivation for testing and have an implementation to work with, the next step is figuring out how to test it in practice. To isolate the most performance-impacting component, we profile the application, analyzing both runtime and memory usage before making informed judgments based on this data. Regarding language choices for rewriting, we are constrained to those with embedding APIs for Julia, but we still have several options. It makes sense to choose two languages with fundamentally different properties—Python and C++—as they provide a broad spectrum of insights applicable to similar domains. Both languages have well-established interface libraries, making them practical choices for evaluation. To test the effectiveness of the component, we use benchmarking tools to analyze its performance in isolation, along with Julia-sided tools to assess the combined performance of the component, interface code, and any overhead introduced.

Writing the components alone isn't enough if we can't integrate them into the larger system, so the next step was selecting an embedding API to attach our hit functions to the ray tracer implementation. For Python, the choice was straightforward—Python/JuliaCall, which builds on an earlier implementation and supports a wider range of conversions between the two languages. C++, however, presented a more interesting challenge. Unlike Python, which has trivial reflection mechanisms making object conversion straightforward, C++ requires more deliberate choices. The two main options were CxxWrap, which has a strong feature set but lacks user-friendliness, and Jluna, a newer and more user-friendly alternative that is missing some mapping mechanisms. I chose Jluna because my focus was on minimizing additional code and effort while creating usable components in another language. Jluna, leveraging modern and extensible C++ techniques, proved to be more future-proof and developer-friendly. This ties into a broader consideration: when rewriting a component in another language, if the results are positive, you ideally want minimal refactoring to integrate it into the larger system. This means choosing an API that (1) requires the least additional code and (2) minimizes the code needed to attach the component. One key takeaway from this process and something which might already be quite evident given the discussion in [ref background here] is that working between Python and Julia is already posing significantly fewer challenges when searching for a binding generator due to the added feature set we get from both languages being designed with dynamism; and by extension runtime reflection; in mind.