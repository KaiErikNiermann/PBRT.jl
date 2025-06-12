
% we want to talk about allocation, liveness, deallocation 
  % objects in cpp have a memory region 
    % objects passed by value   
      % stack allocated - automatic storage duration 
        % destroyed when out of scope
      % heap allocated - new block / raw pointer or smart pointer 
        % smart - destroyed when no more references to it 
        % raw - destroyed when freed manually
      % statically allocated - program storage duration
        % destroyed when exit()
    % objects passed by reference
      % objects passed by pointer

    % memory region can be allocated cpp side and have a pointer to it 
      % rust side just holds the opaque pointer which it passses back to cpp for everything (similar to other scenario)
      % drawbacks 
        % we use the cpp allocator, we dont have that easy control over the actual memory, might be deallocated or smth ??
          % we need to ensure the cpp sided code doesnt run the destructor while Rust is still holding the reference

    % memory region can be allocated rust sided and have a pointer passed to cpp to populate it 
      % requires an understanding of the layout
      % if the memory is rust sided then we need to handle the move semantics properly
        % beneifts 
        % rust controls the memory, so we dont have the risk of it being dropped by cpp ig ? 
        % doesnt require running cpp sided allocation mechanisms 
        % drawbacks 
        % memory needs to be pinned unless triviall movable because rust does memcpy i.e. destructive vs non-destructive move

% 

% ------------ old -----------

% What's generally relied in from Rust's perspective are mutable references, in tools such as cxx and autocxx, we create Rust-sided objects and pass mutable references of these objects to the embedded C++-IDL. While performant, relying on mutable references to cross the language boundary comes with various limitations, namely in that we loose certain Rust saftey guarantees. To avoid data-races Rust implemented a compile-time constraint that only allows a single mutable reference to a value at a time. As there is no trivial analgoue to this constraint in C++, we end up falling back on the more unsafe environment within C++. Another type of object are \textit{opaque types}. Objects of an opaque type are meant to represent objects who's underlying layout is abstracted away from the user. As opposed to member accesses occuring directly on the object itself i.e. its memory location, we generate a host language object which implements a partially or fully mirrored interface of the opaque type, who's members internally access the underlying object through a set of generated shims. Put more simply opaque types more or less side-step the issue of different memory management models by just using a layer of indirection to access the underlying object. A natural byproduct of this application of indirection is the additional overhead we have for accessing the underlying object, as we have to go through the shim layer to access the underlying memory, though with the benefit of religating memory handling largely to the own languages. 

% Both with the case of using mutable references and opaque types we essentially approach the case of cross-language memory management by not really approaching it at all, instead opting to either rely on the basic dynamics provided by the C-FFI or by using a layer of indirection to manage the underlying memory. 

% An important example to look at of statically typed cross-language systems are the different attempts at bridging C++ and Rust. C++ and Rust have been mentioned a fair bit in this paper already but for good reason, a considerable amount of software has been written in C++ but as new languages emerged it became quite evident that despite the iterative improvements to the memory safety of C++ its hard match the deterministic safety of the Rust borrow checker. Yet as mentioned before, despite these languages roughly falling into the same category of languages; with both being aimed at high performance through granular control, static typing and minimal overhead inducing abstractions; they employ some considerably different memory management models. Despite these differences one thing we can observe, not just in how C++ and Rust have evolved over time but also how languages more broadly evolve is that they often either through a deliberate effort or just through natural changes implement common features. C++ adopted the aforementioned destructive move semantics, albeit implemented in a slightly different manner to Rusts. Additionally there have been various approaches, implementations and proposals to introduce Rust-style lifetime annotations into clang to get similar benefits in term of statically derivable safety guarantees about code. Where we then commonly see interoperability layers come in is in their translation and mapping of these design approaches in a manner consistent with what the programmer would expect. In the case of crubit \cite{crubit}; Google's glue code generator for Rust and C++; we can see this take shape in the form of the application of clangs lifetime bounds to preform static analysis on C++ code headers to describe lifetimes in a language agnostic manner such that C++ APIs can be used on the Rust sided end with the lifetime properties of exposed methods sufficiently mapped.

% % maybe insert an example of that here

% Something which becomes more complex to bridge are the different implementations of move semantics, despite their abstractly similar nature the aforementioned key difference of the C++ moved-from object needing to remain in a valid state while the Rust analogue does not leads us to the fact that we need a solution in our host language (Rust) such that we do not break the expected behavior of either Rust or C++. The attempts at solutions here have primarily relied on the use of rusts pin feature, the most important property of which is that data which is pinned remains in a fixed memory location, thus ensuring that the C++ side invariant of validity till destruction is met. One other notable consideration is the notion of things being trivially movable. Something being trivially movable implies that the compiler can statically preform a move operation; meaning that it knows implicitly how to change the ownership of an object, in Rust all objects are trivially movable, in C++ this is not the case. An example of C++ objects which are not trivially movable are Polymorphic types, which is to say classes which define virtual functions that are declared in inherited classes. As these functions rely on v-tables to work properly there is no trivial implementation which could safely define a move. The common way to deal with this discrepancy at least in the context of C++ and Rust is to simply limit interoperability to types which have sufficiently close analogues in the other language such that their move semantics sufficiently overlap as to limit the complexity of interoperability layers. Now despite these differences we can still observe that due to the languages existing and evolving in a somewhat similar domain, under a well defined set of constraints we can create systems which sufficiently bridge functionality. Furthermore, despite the constraints currently placed on most interoperability systems there is research and practical work aimed at widening these constraints. A natural aspect of language evolution especially when talking about a languages type system is the goal of creating a language which allows for systems that are well defined and behave deterministically under clear constraints but also exhibit enough features to be sufficiently expressive for the domain they are usually applied in. The point of this being as languages have become and will become increasingly better at translating ideas within their domain into concrete programs so too is there a desire within the context of cross-language systems to bridge these dynamics such that we aren't as limited by the minimal safe common subset when working through interoperability layers.