From PFC Require Import Core.

Theorem add_0_r_firsttry : ∀ n:nat,
    n + 0 = n.
Proof. 
    intros n. 
    simpl. 
Abort.

Theorem add_0_r_secondtry : ∀ n:nat,
  n + 0 = n.
Proof.
  intros n. destruct n as [| n'] eqn:E.
  - (* n = 0 *)
    reflexivity. (* so far so good... *)
  - (* n = S n' *)  
    simpl. (* ...but here we are stuck again *)
Abort.

Theorem add_0_r : ∀ n:nat, n + 0 = n.
Proof.
    (* Introduce n into the context *)
    intros n.
    (* Perform induction on n *)
    induction n as [| n' IHn'].
    - (* Base case: n = 0 *)
        (* Simplify the goal: 0 + 0 = 0 *)
        simpl.
        (* Reflexivity solves the goal as both sides are equal *)
        reflexivity.
    - (* Inductive step: n = S n' *)
        (* Simplify the goal: S n' + 0 = S n' *)
        simpl.
        (* Use the induction hypothesis: n' + 0 = n' *)
        rewrite -> IHn'.
        (* Reflexivity solves the goal as both sides are equal *)
        reflexivity.
Qed.

