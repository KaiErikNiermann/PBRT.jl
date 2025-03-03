Require Import Coq.Sets.Ensembles.

Section SetsCategory.

    (* Import the Category class definition from before *)
    Class Category := {
        Obj : Type;
        Hom : Obj -> Obj -> Type;
        id : forall {A : Obj}, Hom A A;
        (* For any morphism from A to B and B to C we have a composite morphism from A to C *)
        comp : forall {A B C : Obj}, Hom A B -> Hom B C -> Hom A C
        (* comp_assoc : forall {A B C D : Obj} (f : Hom C D) (g : Hom B C) (h : Hom A B),
            comp f (comp g h) = comp (comp f g) h;
        id_left : forall {A B : Obj} (f : Hom A B),
            comp id f = f;
        id_right : forall {A B : Obj} (f : Hom A B),
            comp f id = f *)
    }.

    Instance SetCat : Category := {
        Obj := Type;
        Hom := fun (A B : Type) => A -> B;
        id := fun (A : Type) (a : A) => a;
        comp := fun (A B C : Type) (f : A -> B) (g : B -> C) (a : A) => g (f a)
    }.

End SetsCategory.
