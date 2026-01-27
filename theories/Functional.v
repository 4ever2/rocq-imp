From Stdlib Require Import Arith.
From Stdlib Require Import EqNat.
From Stdlib Require Import Init.Nat.
From Stdlib Require Import Lia.
From Stdlib Require Import List. Import ListNotations.
From Imp Require Import Maps.
From Imp Require Import Imp.
From Imp Require Import Smallstep.

Definition stack_step_exec (st : state) (ps : prog * stack) : option (prog * stack) :=
match fst ps, snd ps with
| SPush n :: p, stk => Some (p, n :: stk)
| SLoad i :: p, stk => Some (p, st i :: stk)
| SPlus :: p, n::m::stk => Some (p, (m+n) :: stk)
| SMinus :: p, n::m::stk => Some (p, (m-n) :: stk)
| SMult :: p, n::m::stk => Some (p, (m*n)::stk)
| _ , _ => None
end.

Lemma stack_step_exec_correct :
 forall  st ps ps',
 stack_step_exec st ps = Some ps' <->
 stack_step st ps ps'.
Proof.
split.
- destruct ps; destruct p; cbn.
  * intros; congruence.
  * destruct ps'; destruct s0; cbn.
    + intros Hp; inversion Hp; subst.
      apply SS_Push.
    + intros Hp; inversion Hp; subst.
      apply SS_Load.
    + destruct s; try congruence.
      destruct s; try congruence.
      intros Hp; inversion Hp; subst.
      apply SS_P.
    + destruct s; try congruence.
      destruct s; try congruence.
      intros Hp; inversion Hp; subst.
      apply SS_Minus.
    + destruct s; try congruence.
      destruct s; try congruence.
      intros Hp; inversion Hp; subst.
      apply SS_Mult.
- intros Hsp; inversion Hsp; subst; cbn; reflexivity.
Qed.
