From Coq Require Import Arith.
From Coq Require Import Bool.
From Coq Require Export Strings.String.
Open Scope string_scope.
From Coq Require Import FunctionalExtensionality.
From Coq Require Import List.
Require Import PFC.Core.
Require Import PFC.Data.

Inductive R_t (L : Type) (T : L -> Type) : Type :=
  | BuildProduct : (forall (l : L), T l) -> R_t L T.

Record Lens (L : Type) (T : L -> Type) : Type := {
	get : forall (l : L), R_t L T -> T l;
	put : forall (l : L), R_t L T -> T l -> R_t L T;
	rw : forall (l : L) (t : T l) (r : R_t L T), get l ((put l r) t) = t;
	wr : forall (l : L) (r : R_t L T), put l r (get l r) = r;
	ww : forall (l : L) (t : T l) (t' : T l) (r : R_t L T), put l (put l r t) t' = put l r t'
}.

Inductive P_L : Type :=
  | Name
  | Age
  | IsStudent.

Definition P_TL  (l : P_L) : Type :=
  match l with
  | Name => string
  | Age => nat
  | IsStudent => bool
  end.

(* Uninstantiated Type *)
Definition Person_t : Type :=
  R_t P_L P_TL.

Definition P_L_dec (l1 l2 : P_L) : {l1 = l2} + {l1 <> l2}.
Proof.
  decide equality.
Defined.

Definition P_lens : Lens P_L P_TL.
Proof.
	refine {|
		get := fun (l : P_L) (r : R_t P_L P_TL) =>
      match l with
      	| Name => match r with
										| BuildProduct _ _ f => f Name
                	end
      	| Age => match r with
										| BuildProduct _ _ f => f Age
             			end
	  		| IsStudent => match r with
										|	BuildProduct _ _ f => f IsStudent
									end
      end;
    put := fun (l : P_L) (r : R_t P_L P_TL) (t : P_TL l) =>
      match l with
      | Name => match r with
									| BuildProduct _ _ f => BuildProduct P_L P_TL 
										(fun (l' : P_L) =>
											if P_L_dec l' Name then t else f l'
										)
                end
      | Age => match r with
									| BuildProduct _ _ f => BuildProduct P_L P_TL 
										(fun (l' : P_L) =>
											if P_L_dec l' Age then t else f l'
										)
								end
			| IsStudent => match r with
										| BuildProduct _ _ f => BuildProduct P_L P_TL 
											(fun (l' : P_L) =>
												if P_L_dec l' IsStudent then t else f l'
											)
									end
      end
  |}.
  - (* rw *)
    intros l t r.
    destruct l; simpl; auto.
    destruct r; simpl.
    rewrite P_L_dec_refl; auto.
  - (* wr *)
    intros l r.
    destruct l; simpl; auto.
    destruct r; simpl.
    rewrite P_L_dec_refl; auto.
  - (* ww *)
    intros l t t' r.
    destruct l; simpl; auto.
    destruct r; simpl.
    rewrite P_L_dec_refl; auto.
Defined.


