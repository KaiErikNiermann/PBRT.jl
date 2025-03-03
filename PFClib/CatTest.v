Require Import Category.Theory.
From Category Require Import Lib.

Program Definition NatCategory : Category := {|
    obj := nat;
    Category.hom x y := nat -> nat;   
    homset x y := {| equiv f g := forall n, f n = g n |};
    id x := fun n => n;
    Category.compose x y z f g := fun n => f (g n);
|}.

Next Obligation.
    intros. 
    split; intros.
    - intros f n. reflexivity.
    - intros f. intros y0. symmetry. apply H.
    - intros f. intros y0. intros z. intros H1 H2 n. specialize (H1 n). specialize (H2 n). rewrite H1. apply H2.
Qed.

Next Obligation.
    intros A B f g y0 H1 H2. rewrite (H1 H2). apply f.
Qed.

Program Definition SetCategory : Category := {|
    obj := Type;
    Category.hom x y := x -> y;   
    homset x y := {| equiv f g := forall n, f n = g n |};
    id x := fun n => n;
    Category.compose x y z f g := fun n => f (g n);
|}.

Next Obligation.
    intros.
    split; intros.
    - intros f n. reflexivity.
    - intros f n. symmetry. apply H.
    - intros f g h H1 H2 n. rewrite (H1 n), (H2 n). reflexivity.
Qed.

Next Obligation.
    intros A B f g y0 H1 H2. rewrite (H1 H2). apply f.
Qed.



