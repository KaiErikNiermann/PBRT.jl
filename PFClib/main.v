(* main.v *)

Require Import Coq.Strings.String.
Require Import Category.Theory.

Inductive bool : Type :=
  | true
  | false.

Definition negb (b:bool) : bool :=
  match b with
  | true => false
  | false => true
  end.
Definition andb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.
Definition orb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

Example test_orb1: (orb true false) = true.
Proof. simpl. reflexivity. Qed.
Example test_orb2: (orb false false) = false.
Proof. simpl. reflexivity. Qed.
Example test_orb3: (orb false true) = true.
Proof. simpl. reflexivity. Qed.
Example test_orb4: (orb true true) = true.
Proof. simpl. reflexivity. Qed.

(* basically aliases i think  *)
Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

(* Unit testing expressions *)
Example test_andb1: (true && true) = true.
Proof. simpl. reflexivity. Qed.
Example test_andb2: (false && true) = false.
Proof. simpl. reflexivity. Qed.

Definition negb' (b:bool) : bool :=
  if b then false
  else true.
Definition andb' (b1:bool) (b2:bool) : bool :=
  if b1 then b2
  else false.
Definition orb' (b1:bool) (b2:bool) : bool :=
  if b1 then true
  else b2.

(* printing the type of an expression *)
Check true.
Check negb. 

(* new types from old *)
Inductive rbg : Type :=
  | red
  | blue
  | green.

Inductive color : Type := 
    | black
    | white
    | primary (p:rbg).

Definition monochrome (c:color) : bool :=
    match c with
    | black => true
    | white => true
    | primary p => false
    end.

Definition isred (c:color) : bool :=
    match c with
    | black => false
    | white => false
    | primary red => true
    | primary _ => false
    end.

Compute (isred (primary red)).

Check (primary red).


Check S (S (S O)).

Definition minustwo( n : nat ) : nat := 
    match n with
    | O => O
    | S O => O
    | S (S n') => n'
    end.

Compute (minustwo 4).

(* Recursive functions via Fixpoint *)
Fixpoint evenb (n:nat) : bool :=
    match n with
    | O => true
    | S O => false
    | S (S n') => evenb n'
    end.

Definition oddb (n:nat) : bool := negb (evenb n).

Example test_oddb1: oddb 1 = true.
Proof. simpl. reflexivity. Qed.

Example test_oddb2: oddb 4 = false.
Proof. simpl. reflexivity. Qed.

(* Module *)
Module NatPlayground2. 

Fixpoint plus (n: nat) (m: nat): nat := 
    match n with
    | O => m
    | S n' => S (plus n' m)
    end.

Compute (plus 3 2).

Fixpoint mult (n m : nat): nat := 
    match n with
    | O => O
    | S n' => plus m (mult n' m)
    end.

Example test_mult1: (mult 3 3) = 9.
Proof. simpl. reflexivity. Qed.

End NatPlayground2.

(* pairs *)

