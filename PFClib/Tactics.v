Require Import PFC.Data.
Require Import PFC.Core.

Theorem silly1 : ∀ (n m : nat),
  n = m →
  n = m.
Proof.
  intros n m eq.
	rewrite -> eq.
	reflexivity.
Qed.

Theorem silly_apply : ∀ (n m : nat),
  n = m →
  n = m.
Proof.
  intros n m eq.
	apply eq.
Qed.

Theorem silly2 : ∀ (n m o p : nat),
  n = m →
  (n = m → [n;o] = [m;p]) →
  [n;o] = [m;p].
Proof.
  intros n m o p eq1 eq2.
  apply eq2. apply eq1. Qed.

Theorem silly2a : ∀ (n m : nat),
  (n,n) = (m,m) →
  (∀ (q r : nat), (q,q) = (r,r) → [q] = [r]) →
  [n] = [m].
Proof.
  intros n m eq1 eq2.
  apply eq2. apply eq1. Qed.

Example trans_eq_example'' : ∀ (a b c d e f : nat),
     [a;b] = [c;d] →
     [c;d] = [e;f] →
     [a;b] = [e;f].
Proof.
  intros a b c d e f eq1 eq2.
  transitivity [c;d].
  apply eq1. apply eq2. Qed.

Definition pred (n : nat) : nat :=
  match n with
  | O => O
  | S n' => n'
  end.

Theorem S_injective : ∀ (n m : nat),
  S n = S m →
  n = m.
Proof.
  intros n m H1.
  assert (H2: n = pred (S n)). { reflexivity. }
  rewrite H2. rewrite H1. simpl. reflexivity.
Qed.

Theorem S_injective' : ∀ (n m : nat),
  S n = S m →
  n = m.
Proof.
  intros n m H.
	injection H as Hnm.
	apply Hnm.
Qed.

Theorem S_inj : ∀ (n m : nat) (b : bool),
  ((S n) =? (S m)) = b → (n =? m) = b.
Proof.
  intros n m b H. simpl in H. apply H. 
Qed.

Theorem add_0_r : ∀ n:nat, n + 0 = n.
Proof.
  intros n. induction n as [| n' IHn'].
  - (* n = 0 *) reflexivity.
  - (* n = S n' *) simpl. rewrite -> IHn'. reflexivity. Qed.

Theorem add_comm : ∀ n m : nat,
  n + m = m + n.
Proof.
  intros n m.
  induction n as [| n' IHn'].
  - (* n = 0 *) simpl. rewrite -> add_0_r. reflexivity.
  - (* n = S n' *) simpl. rewrite -> IHn'. rewrite <- plus_n_Sm. reflexivity. Qed.

Theorem specialize_example: ∀ n: nat,
  (∀ m: nat, m × n = 0) → n = 0.
Proof.
  intros n H.
  specialize H with (m := 1).
  simpl in H.
  rewrite add_comm in H.
  simpl in H.
  apply H. 
Qed.