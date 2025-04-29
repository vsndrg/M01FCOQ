Lemma L1 : forall a b : Prop, a \/ b -> b \/ a.
Proof.
  intros.
  destruct H.
  right.
  exact H.
  left.
  exact H.
Qed.

Lemma L2 : forall a b : Prop, a /\ b -> b /\ a.
Proof.
  intros a b H.
  split.
  destruct H as [H1 H2].
  exact H2.
  intuition.
Qed.

Axiom A1 : forall P : Prop, P \/ ~P.

Theorem T1 : forall a b c : Prop, a /\ (b /\ c) -> a /\ b /\ c.
Proof.
  intros a b c H.
  destruct H as [Ha Hbc].
  destruct Hbc as [Hb Hc].
  split.
    - exact Ha.
    - split.
      + exact Hb.
      + exact Hc.
Qed.

Theorem T2 : forall a b c d : Prop, (a -> b) /\ (c -> d) /\ a /\ c -> b /\ d.
Proof.
  intros a b c d H.
  destruct H as [Hab Hcdac].
  destruct Hcdac as [Hcd Hac].
  destruct Hac as [Ha Hc].
  split.
  - exact (Hab Ha).
  - exact (Hcd Hc).
Qed.

Theorem T3 : forall a : Prop, ~(a /\ ~a).
Proof.
  intros a H.
  destruct H as [Ha Hna].
  exact (Hna Ha).
Qed.

(*
Theorem T1 : forall a b : Prop, (a -> b) <-> (~a \/ b).
Proof.
  split.
  - intros H.
    destruct (A a) as [Ha | Hna].
    + right. apply H. exact Ha. (* or assumption instead of exact Ha *)
    + left. exact Hna.          (* or assumption instead of exact Hna *)
  - intros H.
    destruct H as [Hna | Hb].   (* or intros [Hna | Hb] Ha. instead of these two lines *)
    + 
*)
