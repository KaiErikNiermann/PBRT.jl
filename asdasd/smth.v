(* smth.v *)

(* Load the standard library *)
Require Import Coq.Strings.String.

(* Define a simple theorem *)
Theorem hello_world : "Hello, World!" = "Hello, World!".
Proof.
    reflexivity.
Qed.