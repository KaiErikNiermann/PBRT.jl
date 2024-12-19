(* test.v *)

(* Import the standard library *)
Require Import Coq.Init.Prelude.
Require Import Coq.Arith.Arith.
Require Import Coq.Lists.List.
Require Import Coq.Logic.FunctionalExtensionality.

(* Basic inductive type to represent a binary operator *)

(* Import the standard library *)

(* Basic inductive type to represent a binary operator *)
Inductive binop : Set := Plus | Times. 

(* Type to represent an expression *)
Inductive exp : Set :=
  | Const : nat -> exp
  | Binop : binop -> exp -> exp -> exp.

(* Function to evaluate an expression *)
Definition eval := fun b =>
    match b with 
    | Plus => plus
    | Times => mult
    end. 

Fixpoint eval_exp (e: exp): nat :=
    match e with 
    | Const n => n
    | Binop b e1 e2 => (eval b) (eval_exp e1) (eval_exp e2)
    end.

Eval compute in eval_exp (Binop Plus (Const 2) (Const 3)).
Eval compute in eval_exp (Binop Times (Const 2) (Const 3)).

Inductive instr : Set :=
  | IConst : nat -> instr
  | IBinop : binop -> instr.

Definition prog := list instr.
Definition stack := list nat.

Definition instr_exec (i: instr) (s: stack): option stack := 
    match i with 
    | IConst n => Some (n :: s)
    | IBinop b => 
        match s with 
        | n1 :: n2 :: s' => Some ((eval b) n1 n2 :: s')
        | _ => None
        end
    end.

Fixpoint prog_exec (p: prog) (s: stack): option stack :=
    match p with 
    | nil => Some s
    | i :: p' => 
        match instr_exec i s with 
        | Some s' => prog_exec p' s'
        | None => None
        end
    end.

Fixpoint compile (e: exp): prog := 
    match e with 
    | Const n => IConst n :: nil 
    | Binop b e1 e2 => compile e2 ++ compile e1 ++ IBinop b :: nil
    end.

Eval compute in compile (Const 2).

Eval compute in prog_exec (compile (Const 2)) nil.

Theorem compile_correct: forall e, prog_exec (compile e) nil = Some (eval_exp e :: nil).


Lemma compile_correct': /forall e p s, 
    prog_exec (compile e ++ p) s = prog_exec p (eval_exp e :: s).
Proof.
    induction e.
    intros.
    unfold eval_exp.
    unfold prog_exec at 1.
    simpl.
    fold prog_exec.
    reflexivity.
    intros.
    unfold compile. 
    fold compile.
    unfold eval_exp.
    fold eval_exp.
    rewrite <- app_assoc.
    rewrite IHe2.
    rewrite <- app_assoc.
    rewrite IHe1.
    unfold prog_exec at 1.
    simpl.
    fold prog_exec.
    reflexivity.
Qed.

Inductive type : Set := Nat | Bool.

Inductive exp' : type -> type -> type -> Set :=
    | TPlus : exp' Nat Nat Nat
    | TTimes : exp' Nat Nat Nat
    | TEq : forall t, exp' t t Bool
    | TLt : exp' Nat Nat Bool. 

Inductive instr' : type -> Set :=
    | TNConst : nat -> instr' Nat 
    | TBConst : bool -> instr' Bool
    | TBinop : forall t1 t2 t, exp' t1 t2 t -> instr' t1 -> instr' t2 -> instr' t.

Definition typeDenote (t: type): Set := 
    match t with 
    | Nat => nat
    | Bool => bool
    end.

Definition plus (n m: typeDenote Nat): typeDenote Nat := n + m.

Definition tbinopDenote t1 t2 t (b: exp' t1 t2 t)
    : typeDenote t1 -> typeDenote t2 -> typeDenote t :=
    match b with 
    | TPlus => plus
    | TTimes => mult
    | TEq Nat => Nat.eqb
    | TEq Bool => Bool.eqb
    | TLt => leb
    end.



Fixpoint texpDenote t (e: instr' t): typeDenote t := 
    match e with 
    | TNConst n => n
    | TBConst b => b
    | TBinop t1 t2 t' b e1 e2 => (tbinopDenote t1 t2 t' b) (texpDenote t1 e1) (texpDenote t2 e2)
    end.

Eval simpl in (texpDenote Nat (TNConst 42)).

Eval simpl in texpDenote Bool (TBConst true).

Eval simpl in texpDenote Nat (TBinop Nat Nat Nat TTimes 
                                (TBinop Nat Nat Nat TPlus (TNConst 2) (TNConst 2)) 
                                (TNConst 7)).

