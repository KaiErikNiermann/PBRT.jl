From Coq Require Export Program.
From Coq Require Export CMorphisms.

Open Scope nat_scope.

(* Declare the scope and make it available for export *)
Declare Scope basic_notations.
Delimit Scope basic_notations with basic_notations.

(* Open the scope locally in this file *)
Open Scope basic_notations.

(* Define notations within the scope *)
Notation "x ∧ y" := (and x y)
  (at level 80, right associativity) : basic_notations.

Definition iff {P Q : Prop} := (P -> Q) ∧ (Q -> P).

Notation "∀  x .. y , P" := (forall x, .. (forall y, P) ..)
  (at level 10, x binder, y binder, P at level 200, right associativity) :
  basic_notations.

Notation "'exists' x .. y , p" := (sigT (fun x => .. (sigT (fun y => p)) ..))
  (at level 200, x binder, right associativity,
   format "'[' 'exists'  '/  ' x  ..  y ,  '/  ' p ']'") :
  basic_notations.

Notation "∃  x .. y , P" := (exists x, .. (exists y, P) ..)
  (at level 10, x binder, y binder, P at level 200, right associativity) :
  basic_notations.

Notation "x → y" := (x -> y)
  (at level 99, y at level 200, right associativity): basic_notations.

Notation "x ↔ y" := (iff x y)
  (at level 95, no associativity) : basic_notations.

Notation "¬ x" := (x → False)
  (at level 75, right associativity) : basic_notations.

Notation "x ≠ y" := (x <> y) (at level 70) : basic_notations.

(* Notation "x × y" := (Nat.mul x y) (at level 80, right associativity) : basic_notations. *)
(* Infix "∏" := prod (at level 80, right associativity) : basic_notations. *)

Infix "×" := Nat.mul (at level 40, left associativity) : basic_notations.

Infix "∑" := sum (at level 85, right associativity) : basic_notations.

Notation "x =? y" := (Nat.eqb x y) (at level 70) : basic_notations.

Notation "'λ'  x .. y , t" := (fun x => .. (fun y => t) ..)
  (at level 10, x binder, y binder, t at level 200, right associativity) :
  basic_notations.