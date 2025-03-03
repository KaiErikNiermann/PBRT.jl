Module NatList.
Require Import PFC.Core.

Inductive natprod : Type := 
    | pair (n1 n2 : nat).

Check (pair 3 5).
Check pair 3 5.
Check pair (3) (5).

Definition fst (p : natprod): nat := 
    match p with
    | pair x y => x
    end.

Definition snd (p : natprod): nat :=
    match p with
    | pair x y => y
    end.

Compute (fst (pair 3 5)).

Notation "( x , y )" := (pair x y).

Compute (fst (3, 5)).

Definition fst' (p : natprod) : nat :=
  match p with
  | (x, y) => x
  end.
Definition snd' (p : natprod) : nat :=
  match p with
  | (x, y) => y
  end.
Definition swap_pair (p : natprod) : natprod :=
  match p with
  | (x, y) => (y, x)
  end.

(* 
    - Define an inductive type `natlist` representing lists of natural numbers.
    - `nil` represents the empty list.
    - `cons` constructs a list from a head element `n` and a tail list `l`.
    
    - Introduce infix notation `::` for `cons` with right associativity at level 60.
    - Introduce notation `[]` for the empty list `nil`.
    - Introduce notation `[x; .. ; y]` for constructing lists with multiple elements.
    
    - Example: `mylist` is a list containing the elements 1, 2, and 3.
*)
Inductive natlist : Type :=
	| nil
	| cons (n : nat) (l : natlist).

Notation "x :: l" := (cons x l)
                     (at level 60, right associativity).

Notation "[ ]" := nil.

Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) ..).

Definition mylist := cons 1 (cons 2 (cons 3 nil)).

Fixpoint repeat (n count : nat) : natlist :=
	match count with
	| O => nil
	| S count' => n :: (repeat n count')
	end.

Fixpoint length (l:natlist) : nat :=
  match l with
  | nil => O
  | h :: t => S (length t)
  end.

Fixpoint app (l1 l2 : natlist) : natlist :=
  match l1 with
  | nil => l2
  | h :: t => h :: (app t l2)
  end.

Notation "x ++ y" := (app x y)
										(right associativity, at level 60).

Example test_app1: [1;2;3] ++ [4;5] = [1;2;3;4;5].
Proof. reflexivity. Qed.
Example test_app2: nil ++ [4;5] = [4;5].
Proof. reflexivity. Qed.
Example test_app3: [1;2;3] ++ nil = [1;2;3].
Proof. reflexivity. Qed.

Definition hd (default : nat) (l : natlist) : nat :=
  match l with
  | nil => default
  | h :: t => h
  end.

Definition tl (l : natlist) : natlist :=
  match l with
  | nil => nil
  | h :: t => t
  end.

Example test_hd1: hd 0 [1;2;3] = 1.
Proof. reflexivity. Qed.
Example test_hd2: hd 0 [] = 0.
Proof. reflexivity. Qed.
Example test_tl: tl [1;2;3] = [2;3].
Proof.	 reflexivity. Qed.

Theorem app_assoc : ∀ l1 l2 l3 : natlist,
  (l1 ++ l2) ++ l3 = l1 ++ (l2 ++ l3).
Proof.
  intros l1 l2 l3. induction l1 as [| n l1' IHl1'].
  - (* l1 = nil *)
    reflexivity.
  - (* l1 = cons n l1' *)
    simpl. rewrite -> IHl1'. reflexivity. Qed.

Theorem repeat_double_firsttry : ∀ c n: nat,
  repeat n c ++ repeat n c = repeat n (c + c).
Proof.
  intros c. induction c as [| c' IHc'].
  - (* c = 0 *)
    intros n. simpl. reflexivity.
  - (* c = S c' *)
    intros n. simpl.
    (*  Now we seem to be stuck.  The IH cannot be used to 
        rewrite repeat n (c' + S c'): it only works
        for repeat n (c' + c'). If the IH were more liberal here
        (e.g., if it worked for an arbitrary second summand),
        the proof would go through. *)
Abort.

Theorem repeat_plus: ∀ c1 c2 n: nat,
    repeat n c1 ++ repeat n c2 = repeat n (c1 + c2).
Proof.
  intros c1 c2 n.
  induction c1 as [| c1' IHc1'].
  - simpl. reflexivity.
  - simpl.
    rewrite <- IHc1'.
    reflexivity.
  Qed.
End NatList.
Export NatList.