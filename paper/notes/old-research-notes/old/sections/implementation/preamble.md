
# Versions
## Draft
- I think it makes sense to kind of bridge alot of the more theoretical stuff into a nice comfortable intro about the practical portion here 
	- Maybe talk about the initial lego idea you had
	- I think a nice motivating example here could be the whole performance thing with Julia
	- So once we have the general idea and the whole motivation established you could briefly connect this with the ray tracer and sorta broadly I guess why you chose that 
- Maybe give like a brief overview or summary of how you will structure the practical portions 
	- So we will start with some general information about the system and how the idea will be made a bit more concrete 
	- Then some information regarding the binding generator choices, as the kind of natural next step to achieving what you want here 
	- We can then bridge this into the main issue, here we will elaborate on the ray tracer design and what the root of the problem is 
	- We can also compare and contrast this problem with the case where its a non-issue
	- We then talk about what the approach is for the solution 
		- Here we start with an introduction to how Jluna is designed 
		- Then our contributing to solving the issue which we have 
	- Finally with this solution we move into benchmarking and analysis to figure out how well this solution works in practice, again contrasting it with the case of Python <-> Julia 
	- Then in the end we will talk about some of the limitiations and possible future directions of the work

## Refined Draft 


## Final Draft

So to begin this exploration of the practical side language interoperability I had to first think of a piece of software I could use to test this idea. Before doing so I thought it would be important to further refine my idea beyond just wanting to test out my `lego idea'. As said before the concept of rewriting code is by no means new, I don't believe it would be absurd by any means to suggest that most programmers at one point or another, while writing some piece of code, or even after the fact, recognized ways in which their solution can be improved. Often improvements or iterations on the original piece of code just naturally have to occur to fit the evolving goal for a given piece of software. So it would make sense that there should be some type of reason as to why we want to rewrite a specific piece of code, in our case performance would be a pretty natural choice. While most programming languages of course aim to be performant, respective to their application, due to differences in their design and execution methods they naturally exhibit differences. 

Ok, so we want to choose a piece of software, preferably one with a performance-critical component, which we want to rewrite. Looking back at my previous projects one specifically came to mind, my implementation of a simple Ray Tracer in the Julia programming languages based on Peter Shirley's wonderful guide and C++ implementation. My initial goal with this project was to learn Julia as I had heard and seen that if written in a very idiomatic manner it can exhibit performance characteristics close to that of C while offering the dynamically-typed high-level simplicity of Python. Naturally, when benchmarking my final implementation my results were less than desirable. To elaborate on why my program exhibited these performance characteristics it makes sense to briefly go into the core of how Julia's code is run. There is a very nice quote on the Julia forums which I believe effectively conveys this.

\begin{quote}
    \textit{in short, it's a reasonably good static compiler but a terrible JIT}
\end{quote}

The first response some people might have to this is confusion. Julia is a JIT-compiled language so how is its JIT compiler terrible. Well, this comes down in large part to how its JIT compilation works, the core of this is how it performs online partial evaluation (OPE) w.r.t. its type system. OPE w.r.t the type system in this instance refers to the process of, at runtime (online), Julia specializes (partially evaluates) methods for which it can infer the types of every local variable from the types of the arguments or any other constants; in this instance, a method is said to be `type stable'. Specializing type stable methods simply means it compiles methods for the set of concrete types it can infer. Practically speaking this mechanism can also be seen as a form of \textbf{monomorphizing} a set of functions for which the JIT compiler can determine the concrete types. The reason then why Julia's JIT compiler could be called `terrible' would be that it, currently at least, does not implement profile-guided optimization (PGO). The lack of PGO and its reliance on type stable code for speed means that there is a correlation between idiomatically written Julia and its performance. With this understanding, it might now be apparent why my Ray-Tracer performed so poorly, as I was not fully aware of this strong dependence and I simply wrote the code how I would write something in any other dynamically typed high-level language.

We've now established that we have a piece of performance-critical software written in a very non-idiomatic and by extension inefficient manner. Furthermore, we've seen that its execution method is not only different from ahead-of-time (AOT) compiled languages but also from other JIT-compiled languages by its unique approach to generating machine code. The conventional route, and quite frankly recommended route, one should go here would be to simply rewrite everything with Julia's idiomatic principles in mind, though this would lead to a rather short exploration, so to question the alternative, what if we rewrote the most performance-critical segment of our ray tracer in languages which have less of a reliance on a highly idiomatic programming style.

In the following I'll briefly start by giving an overview o the ray tracer itself and then how I approached integrated the two different languages Python and C++ into this system. I'll then also motivate or give some insights into the reasoning behind why I chose the binding generators that I did, and some of their internal architecture and how it relates to some of the things discussed previously. Once all this is established I will elaborate on the issue which I encountered as a byproduct of the design of this raytracer when working with the C++ rewrite. From this I will go into the nature of the problem and by extension the constraints that came with the design of the C++ <-> Python bridge Jluna. With this information I will explain how I came to my approach for a solution and some of the pitfalls I had in its design. Finally I will do some benchmarking of my solution and compare and constrast this with the approach that PythonCall employs. Ending things on a discussion about the limitations and possible future directions.
