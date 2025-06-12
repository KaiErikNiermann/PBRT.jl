# Versions 
Idea : We have a problem 
## Draft
- *The nature of the problem*
- Start with what we need to do to get our implementation working 
	- Explain this on a high level for now or using like a concrete example 
- Show how with the basic implementation this does not work 
	- More or less just state the constraints for the implementation 
- Go back to what we need to do but elaborate on it in the general case, so like state formally what our implementation needs to do for arbitrary polymorphic structures 
	- Explain the boxing case 
	- Explain the unboxing case
	- => Dont introduce code stuff just yet just try to talk about it using idk diagrams or some shit
- Now I would say develop what need to have happen into some clear like implementation plan or pseudocode algorithm esque thing, just liek a checklist of things that need to work
	- Maybe get into formalism stuff here ? 
	
- *Our toolkit to solve the problem*
- From this checklist bridge over into a basic introduction to metaprogramming in C++ using existing things that the implementation does
	- Introduce template packs 
	- Introduce concepts 
	- Introduce template metaprogramming 
		- introduce template metafunctions 

## Refined Draft
- *The basic nature of the problem*
- Start with what we need to do to get our implementation working 
	- Introduce the BVH and how it relates to polymorphism
	- Explain this on a high level for now or using like a concrete example 
	- Maybe base it around a central like visual display since its a graph n all 
- Show how with the basic implementation this does not work 
	- More or less just state the initial constraints for the implementation 

- *The more concrete considerations*
- Go back to what we need to do but elaborate on it in the general case, so like state formally what our implementation needs to do for arbitrary polymorphic structures 
	- Explain the boxing case : (C++ -> Julia)
	- Explain the unboxing case : (Julia -> C++)
	- => Dont introduce code stuff just yet just try to talk about it using idk diagrams or some shit
- Now I would say develop what need to have happen into some clear like implementation plan or pseudocode algorithm esque thing, just liek a checklist of things that need to work
	- Define clear constraints on the implementation, so describe the bounds of what it can and cant do 
		- Define these constraints using formal notation maybe ? 
	
- *Our toolkit to solve the problem*
- From this checklist bridge over into a basic introduction to meta programming in C++ using existing things that the implementation does
	- Start by introducing the genera notion of compile time programming
	- Introduce concepts 
	- Introduce template packs 
	- Introduce template metaprogramming 
		- introduce template metafunctions 

## Final Draft
- *The basic nature of the problem*
- Start with what we need to do to get our implementation working 
	- Introduce the BVH and how it relates to polymorphism
	- Explain this on a high level for now or using like a concrete example 
	- Maybe base it around a central like visual display since its a graph n all 
- Show how with the basic implementation this does not work 
	- More or less just state the initial constraints for the implementation 

Now while in theory the implementation here was straightforward a major issue I encountered was related to the constraints placed in the binding generator between Julia and C++. To explain the cause of this issue it makes sense to first go into what our implementation actually needs to do, or more specifically what we are bridging in our case. As the hit detection functions; the functions which made up the BVH traversal; served as the nicest component to isolate due to their aforementioned logical separation from other aspects I chose them to serve as the bridge. Now broadly speaking the 3 main things needed when we are trying to do hit detection is our BVH which spatially structures the objects in our scene, the actual ray for which we are trying to compute a hit, and finally a hit record which stores the actual information from the hit (e.g. material, normal vector to the surface, etc.). Assessing the complexity of these types the simplest one is the ray at is just stores an object and direction, next we have the hit record; which despite being a struct; does have polymorphic attributes, namely the material of the object which the ray hit, finally we have the BVH tree which as implied in the name is a tree structure which adds another layer of complexity as we now have recursive polymorphic attributes with the left and right child being BVH nodes which subtypes that define the underlying type of the shape represent (e.g. Triangle, Sphere, etc.). In both of these instance the type of polymorphism we are talking about is subtyping polymorphism, while both C++ and Julia; abstractly speaking; implement similar conventions in terms of enabling subtyping polymorphism, namely some abstract type and a means of specifying a type hierarchy, there are considerable differences when it comes to the practical case of interop. A very distinction between the high level notions of interop and the low level practicalities is how types are actually represented, as we are still fundamentally working through the C-ABI or more accurately through an abstraction (Jluna) over the Julia C-API before we do anything we need to actually parse the underlying representation of Julia types. Pleasantly enough this process is elegantly implemented within Jluna for all types up to structs. The manner in which Jluna does this is largely by using generics to recursively deconstruct the low level representation of a Julia type. To ensure constraints on the implementation, by which I mean rejecting types which it cannot parse for some C++ analogue the implementation utilizes constraints (the implementation being concepts in this case) on its generic deconstruction methods which ensure certain invariants hold that constrain the set of bridgeable types to only those specified by the programmer. One of these constraints was a static assertion which prevent bridging abstract types, in other words types which exhibited subtyping polymorphism, which brings us back to the issue I ran into. The question then becomes how does one solve this problem. To contrast this with the case of Python and Julia; somewhat expectedly; the story was a lot easier. JuliaCall, which is the library I chose for bridging between these two languages simply wraps Julia types with python objects that idiomatically mirror their Julia counterparts, which in turn means that we retain all the means to easily replicate the polymorphic behavior in Python. Trivially a straightforward solution to the C++ and Julia interop. would have been to simply rewrite the ray tracer such that the BVH and hit record represent everything in a non polymorphic format, though there a few reasons I was curious about trying to bridge these types. 
1. Its a somewhat common notion when you look at the interoperability goals for bigger companies to simply constrain the set of bridgeable behaviors to minimal things. I was curious to challenge this notion; with the increasingly expansive type systems even mainstream languages implement, sooner or later, a hyper restrictive approach to cross-language systems will substantially limit libraries which apply more complex aspects of their type system in library design. 
2. Furthermore I wanted some clarity on if this general discrepancy in flexibility between dynamic languages and statically compiled languages in the context of cross-language systems spoke to some deeper nature of type systems and execution models or was more a function of certain implementation philosophies or limited applications of a languages features.
3. I was curious to test the viability of loosening the constraints both in terms of implementation complexity of the system and the resulting performance effects that come from bridging these types 
4. I was generally curious about the feasibility as a whole, given that its a lot rarer to see complex type bridgeings for cross-language systems involving statically typed languages, especially ones where the statically typed language is in focus (as opposed to relying heavily on the dynamic language) I felt this would potentially provide some interesting insights.

- *The more concrete considerations*
- Go back to what we need to do but elaborate on it in the general case, so like state formally what our implementation needs to do for arbitrary polymorphic structures 
	- Explain the boxing case : (C++ -> Julia)
	- Explain the unboxing case : (Julia -> C++)
	- => Dont introduce code stuff just yet just try to talk about it using idk diagrams or some shit
- Now I would say develop what need to have happen into some clear like implementation plan or pseudocode algorithm esque thing, just liek a checklist of things that need to work
	- Define clear constraints on the implementation, so describe the bounds of what it can and cant do 
		- Define these constraints using formal notation maybe ? 

With the broad idea in mind of what we want to achieve now and some motivation as to why it makes sense to establish a more concrete approach. Before we asses the details for how to extend the Jluna library it makes sense to first asses in detail how the library works currently. As was discussed throughout [ref background] if we think of C++ as our host language and Julia as the target then boxing would be the operation of representing a C++ type in Julia, and unboxing the reverse. In Jluna the boxing and unboxing  have multiple steps, we can give a high level overview of it as follows.

- *Our toolkit to solve the problem*
- From this checklist bridge over into a basic introduction to meta programming in C++ using existing things that the implementation does
	- Start by introducing the genera notion of compile time programming
	- Introduce concepts 
	- Introduce template packs 
	- Introduce template metaprogramming 
		- introduce template metafunctions 
