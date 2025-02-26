### rough draft
- this is a big thing how we deal with memory management and variable lifetimes
	- dying when it goes out of scope
	- dying when its destroyed (destructive move)
	- dying when its not used anymore (statically checked)
- so the question becomes how do you reconcile differences in memory management
	- annotations seems to be a common approach
		- crubit lifetime annotations (uses like clangs annotations i think) based on clangs lifetime bounds i think
			- they run static lifetime analysis on the c++ code basically they try to mirror Rust's lifetime system
		- clang lifetime bound annotation
- the main question is how do you deal with the lifetimes of objects
	- value types : copying
		- Here when passing things across the language boundary and between things in the target language we copy the object
		- Obviously mutations to this object are not reflected in the source language
	- reference types
		- so by this we mean pointers or references to objects
		- clearly here mutations will be reflected in the source language
		- types of references
			- raw pointers (*)
			- reference types (&)
			- "safe" pointer types (e.g. shared_ptr)
---
### annotated draft
- this is a big thing how we deal with **memory management** and **variable lifetimes** (*how long a variable stays in memory and is accessible*) ; object lifetime (how long an object is accessible)
	- dying when it goes out of scope
		- stack based memory simply reclaimed when we return 
		- heap based allocations we destroy memory somehow
	- dying when its destroyed (destructive move)
		- manual deletion of the object (`delete`, `free()`)
		- destructive moves which end the lifetime
	- dying when its not used anymore (compile time or runtime determination or both)
		- e.g. reference count drops to 0
- so one key question becomes how do you *reconcile differences in memory management* 
	- between statically typed languages: annotations seems to be a common approach
		- crubit lifetime annotations (uses like clangs annotations i think) based on clangs lifetime bounds i think
			- they run static lifetime analysis on the c++ code basically they try to mirror Rust's lifetime system
		- clang lifetime bound annotation
	- with garbage collected languages
		- we need to ensure that the code in the target language does not cause incompatibilities with the garbage collector
			- ! we need to explicitly communicate with the garbage collector what to preserve
		- **example #1 (target sided):** simple example is we allocate something in the target language while not informing or providing any mechanism to free this object in the host, thus when say the wrapper representing the memory goes out of scope we have a leak
			- assumption - our system works by wrapping target language objects as opposed to representing them directly, as would generally be the case with substantially different memory models
		- **example #2 (host sided):** we allocate something in the host language and pass it as a reference to our target but the GC deallocates the underlying memory of the reference even though we still wish to use it in our target
			- again we need to communicate to the gc that we which to preserve the memory, this can be done by either directly telling the garbage collector to preserve this memory or by placing it in a pinned (fixed) location for some duration 
		- The general question that emerges here is how can we best automate a system to prevent accidently deallocations, or in other words to effectively convey the required information to the host languages GC of our target language.
		- proposal: one approach could be to use reflection/analysis on lifetime annotations as a means to generate explicit communication with garbage collection system for how long to persist something in a context its not directly aware of
			- more specifically we utilize static lifetime analysis on our target language (possibly in conjunction with explicit annotations)
			- using the annotations we can derive usage information in our target language which can be used to override/manage the garbage collector to take into account our target language and prevent accidental deallocations 
- the main question is how do you deal with the lifetimes of objects
	- how do you handle memory in a way that makes sense to the programmer : goals 
		- liveness: things should stay in use for as long as we are using them 
		- utility: things should be usable in a way we expect them to be used in 
		- performance: things should move around as efficiently as possible
	- value types
		- Here when passing things across the language boundary and between things in the target language we copy the object
			- Obviously mutations to this object are not reflected in the source language
	- reference types
		- assuming we have a system that correctly expresses liveness we are left with utility
		- with reference types we want them I guess to behave in some reliable way
			- so by this we mean pointers or references to objects
		-  types of references
			- raw pointers (\*)
				- call by address 
			- reference types (&)
				- call by reference / sharing 
			- "safe/managed" pointer types (e.g. `shared_ptr`)
				- call by reference / sharing / address
		- clearly here mutations will be reflected in the source language, (how do we do this?)
		- call by address / reference | full mutations
			-  here we want to make sure assignments of both properties and the object itself mutates the source object
			- not to difficult, either the wrapper or the processed object in the target language corresponds the memory of that in the source language such that assignment behaviors overlap
		- call by sharing 
			- does it make sense to try and mirror this ? if yes then how implement ?
				- an object assignment should not modify the underlying memory 
				- the object types assignment operator needs to have behavior defined in such a way that we leave the original memory untouched
				- in essence we need to implement call by sharing behavior in our target language on objects for which we expect this behavior, which in practice would mean objects would have to be wrapped in some system which provides the level of indirection required to leave the original memory untouched
	- callbacks and closures
		- when we pass a closure that uses reference's in the context of where it lives we need to ensure those reference are valid when we call the closure in the target language
			- we need to make sure the garbage collector doesnt destroy any reference in the context of closure
			- more abstractly speaking if the captured resources are either managed by a system or correspond to a memory specific context (thread local data) then we need to account for this across language boundaries
			- we can also just ensure that the captured resources will not be deallocated before calling the closure in the target language 
				- static analysis should be used to to pick up on these cases
- concluding notes
	- we introduced basic memory management concepts
	- we then talked about approaches for how to reconcile memory management models with garbage collected and statically typed languages, specifically a focus on 
		- utilizing lifetime annotations and static analysis to convey liveness across language boundaries 
		- utilizing GC APIs as a means of preventing accidental deallocations
			- e.g. explicit memory pinning while its used in the target language
		- utilizing lifetime annotations as a possible means of helping the garbage collector know for how long references are in use for 
	- getting more concrete we talked about how might want to treat different types of variables including closures across the language boundary
	- the concluding note here being that in the context of reconciling different memory models there are two key points of focus
		- firstly the expectations of programmers, any implemented system should behave in a way most programmers would expect it to, which is to say safely, with good performance and following standard language idioms
		- secondly we can use a conjunction of language design tools to facilitate in the process of better bridging different memory systems, though it also makes sense to define clear limits to any system as to prevent unsafe behavior commonly this is said to be goals and non-goals
### final draft