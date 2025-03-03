
Require Import Coq.Arith.Arith.
Require Import Coq.Logic.JMeq.
Require Import Coq.Logic.Eqdep.

Require Import Coq.Strings.String.
(* Require Import Category.Lib. *)

From Coq Require Export Program.
From Coq Require Export CMorphisms.

Open Scope nat_scope.

Declare Scope basic_notations. 
Delimit Scope basic_notations with basic_notations.
Open Scope basic_notations.

Definition iff {P Q : Prop} := (P -> Q) /\ (Q -> P).

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

Notation "x × y" := (prod x y) (at level 80, right associativity) : basic_notations.

Notation "x → y" := (x -> y)
  (at level 99, y at level 200, right associativity): basic_notations.
Notation "x ↔ y" := (iffT x y)
  (at level 95, no associativity) : basic_notations.
Notation "¬ x" := (x → False)
  (at level 75, right associativity) : basic_notations.
Notation "x ≠ y" := (x <> y) (at level 70) : basic_notations.

Infix "∏" := prod (at level 80, right associativity) : basic_notations.
Infix "∑" := sum (at level 85, right associativity) : basic_notations.

Notation "'λ'  x .. y , t" := (fun x => .. (fun y => t) ..)
  (at level 10, x binder, y binder, t at level 200, right associativity) :
  basic_notations.

Theorem plus_O_n : ∀ n : nat, 0 + n = n.
Proof.
  intros n. reflexivity. Qed.

Theorem plus_1_l : ∀ n : nat, 1 + n = S n.
Proof.
  intros n. reflexivity. Qed.

Theorem plus_id_example : ∀ n m:nat,
  n = m →
  n + n = m + m.
Proof.
  (* We move the quantifers into the context *)
  intros n m. 
  (* We move the hypothesis into the context *)
  intros H. 
  (* We rewrite the goal using the hypothesis *)  
  rewrite -> H. 
  (* Now the goal is an easy consequence of the definition of + *)
  reflexivity. Qed.

Theorem plus_1_neq_0_firsttry : ∀ n : nat,
  (n + 1) =? 0 = false.
Proof.
  intros n.
  simpl. (* does nothing! *)
Abort.

(** The tactic `destruct` considers the cases where `n = 0` and `n = S n'` separately. *)
Theorem plus_1_neq_0 : ∀ n : nat,
  (n + 1) =? 0 = false.
Proof.
  (** `destruct` generates two subgoals, which must be proved separately. *)
  intros n. destruct n as [| n'] eqn:E.
  (** The intro pattern `as [| n']` introduces variable names for each subgoal:
      - `O` constructor: no arguments.
      - `S` constructor: introduces `n'`.
      The `eqn:E` annotation names the equation `E`. *)
  - reflexivity.
  - reflexivity.
Qed.
(** Bullets (`-`) mark the parts of the proof for each subgoal:
    - Each subgoal is proved by `reflexivity`, which simplifies the goal.
    - The second subgoal simplifies `(S n' + 1) =? 0` to `false` by rewriting and unfolding `eqb`.
    - Using bullets improves readability and ensures subgoals are complete before moving on. *)

Theorem andb_commutative' : ∀ b c, andb b c = andb c b.
Proof.
  intros b c. destruct b eqn:Eb.
  { destruct c eqn:Ec.
    { reflexivity. }
    { reflexivity. } }
  { destruct c eqn:Ec.
    { reflexivity. }
    { reflexivity. } }
Qed.

Theorem andb3_exchange :
  ∀ b c d, andb (andb b c) d = andb (andb b d) c.
Proof.
  intros b c d. destruct b eqn:Eb.
  - destruct c eqn:Ec.
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
  - destruct c eqn:Ec.
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
    { destruct d eqn:Ed.
      - reflexivity.
      - reflexivity. }
Qed.

