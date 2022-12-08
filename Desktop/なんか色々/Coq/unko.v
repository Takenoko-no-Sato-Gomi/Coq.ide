Axiom Sekai_no_Ssinri :False.

(*排中律*)
Axiom Law_of_excluded_middle : forall p : Prop, p \/ ~p.
(*対偶*)
Theorem  Contraposition:forall p q:Prop,(q->p)->(~p->~q).
Proof.
intros. destruct (Law_of_excluded_middle q). specialize (H H1). specialize (H0 H).
destruct H0. apply H1.
Qed.
(*三段論法*)
Theorem Syllogism:forall p q r:Prop,((p->q)/\(q->r))->(p->r).
Proof.
intros. destruct H. apply H1. apply H. apply H0.
Qed.
(*二重否定*)
Theorem Double_negative_elimination:forall p:Prop,~~p->p.
Proof.
intros. destruct (Law_of_excluded_middle p). apply H0. destruct H. apply H0.
Qed.
(*パースの法則*)
Theorem Peirce's_law :forall p q:Prop,((p->q)->p)->p.
Proof.
intros. destruct (Law_of_excluded_middle p). apply H0. apply H. intros. destruct H0.
apply H1.
Qed.
Theorem new_theorem1:forall p:Set->Set->Prop,(forall x y:Set,p x y)->(forall y x:Set,p x y).
Proof.
intros. specialize (H x y). apply H.
Qed.
Theorem new_theorem2:forall p:Set->Set->Prop,(exists x y:Set,p x y)->(exists y x:Set,p x y).
Proof.
intros. destruct H. destruct H. exists x0,x. apply H.
Qed.
Theorem new_theorem3:forall p:Set->Set->Prop,(exists y:Set,forall x:Set,p x y)->(forall x:Set,
exists y:Set,p x y).
Proof.
intros. destruct H. specialize (H x). exists x0. apply H.
Qed.
Theorem new_theorem4:forall p q:Prop,(p<->q)<->(~p<->~q).
Proof.
split. intro. split. intro. destruct H. intro. specialize (H1 H2). specialize (H0 H1).
apply H0. intro. destruct H. intro. specialize (H H2). specialize (H0 H). apply H0.
intro. destruct H. split. intro. destruct (Law_of_excluded_middle q). apply H2.
specialize (H0 H2). specialize (H0 H1). destruct H0. intro. destruct
(Law_of_excluded_middle p). apply H2. specialize (H H2). specialize (H H1). destruct H.
Qed.
Theorem new_theorem5:forall p:Set->Prop,(~exists x:Set,p x)<->(forall x:Set,~p x).
Proof.
split. intros. intro. destruct H. exists x. apply H0. intros. intro. destruct H0.
specialize (H x). specialize (H H0). apply H.
Qed.
Theorem new_theorem6:forall p:Set->Prop,(~forall x:Set,p x)<->(exists x:Set,~p x).
Proof.
intro. destruct (new_theorem4 (~(forall x:Set,p x)) (exists x:Set,~p x)). apply H0.
split. destruct (new_theorem5 p). intro. intro. destruct H4.
specialize (Double_negative_elimination (forall x:Set,p x) H3). intro. specialize (H5 x).
specialize (H4 H5). destruct H4. intro. destruct (Law_of_excluded_middle (forall x:Set,p x)).
intro. specialize (H3 H2). apply H3. destruct H2. intro. destruct (new_theorem5 (fun x=>
~p x)). specialize (H2 H1). specialize (H2 x). destruct (Law_of_excluded_middle (p x)).
apply H4. specialize (H2 H4). destruct H2.
Qed.
(*ド・モルガンの命題*)
Theorem De_Morggans_Prop_1:forall p q:Prop,~(p\/q)<->(~p/\~q).
Proof.
intros. destruct (Law_of_excluded_middle p). split. intro. split. intro. apply H0. left.
apply H. intro. apply H0. left. apply H. intro. intro. apply H0. destruct H0. specialize
(H0 H). destruct H0. split. intro. split. apply H. intro. apply H0. right. apply H1. intro.
intro. destruct H0. destruct H1. apply H. apply H1. apply H2. apply H1. 
Qed.
Theorem De_Morggans_Prop_2:forall p q:Prop,~(p/\q)<->(~p\/~q).
Proof.
intros. destruct (Law_of_excluded_middle p). destruct (Law_of_excluded_middle q). split.
intro. assert (p/\q). split. apply H. apply H0. specialize (H1 H2). destruct H1. intro.
destruct H1. specialize (H1 H). destruct H1. specialize (H1 H0). destruct H1. split.
intro. right. apply H0. intro. intro. destruct H1. specialize (H1 H). apply H1. destruct H2.
specialize (H0 H3). apply H0. split. intro. left. apply H. intro. intro. destruct H1.
specialize (H H1). apply H.
Qed.



(*ZFC公理系*)
Axiom contain :Set->Set->Prop.



(*外延性公理*)
Axiom Axiom_of_Extensionality:forall x y:Set,((forall z:Set,(contain z x<->contain z y))
->x=y).
Theorem Theorem_of_Extensionality:forall x y:Set,((forall z:Set,(contain z x<->contain z y))
<->x=y).
Proof.
intros. split. apply Axiom_of_Extensionality. intros. rewrite <- H. split. intro. apply H0.
intro. apply H0.
Qed.



(*部分集合*)
Definition Sub_Set (A B:Set):=forall x:Set,contain x A->contain x B.
(*部分集合の反射律、推移律、反対称律*)
Theorem Reflexive_Relation_of_Sub_Set:forall x:Set,Sub_Set x x. 
Proof.
unfold Sub_Set. intros. apply H.
Qed.
Theorem Transitive_Reration_of_Sub_Set :forall x y z:Set,(Sub_Set x y /\ Sub_Set y z)->
Sub_Set x z.
Proof.
unfold Sub_Set. intros. specialize H. destruct H. apply H1. apply H. apply H0.
Qed.
Theorem Antisymmetric_Relation_of_Sub_Set :forall x y: Set, Sub_Set x y /\ Sub_Set y x ->
x=y. 
Proof.
intros. apply Axiom_of_Extensionality. destruct H. unfold Sub_Set in H. unfold Sub_Set in H0.
split. apply H. apply H0.
Qed.



(*空集合公理*)
Axiom Axiom_of_Empty_Set :exists x:Set,forall y : Set,~ contain y x.
Axiom _0: Set.
Axiom Definition_of_Empty_Set:forall x :Set,~ contain x _0.
(*空集合の基本定理*)
Theorem Empty_Set_Law_1:forall X:Set,(~X=_0)<->exists x:Set,contain x X.
Proof.
intro. split. intro. assert (~forall x:Set,contain x X<->contain x _0). intro. apply H. apply
Theorem_of_Extensionality. intro. apply H0. assert (exists x:Set,~(contain x X <-> contain
x _0)). apply new_theorem6 in H0. destruct H0. exists x. apply De_Morggans_Prop_2 in H0.
destruct H0. intro. apply H0. destruct H1. apply H1. intro. apply H0. destruct H1. apply H2.
destruct H1. exists x. assert (~(contain x X<->False)). intro. apply H1. split. intro. apply
H2 in H3. destruct H3. intro. apply Definition_of_Empty_Set in H3. destruct H3. destruct
(Law_of_excluded_middle (contain x X)). apply H3. destruct H2. split. intro. apply H3. apply
H2. intro. destruct H2. intro. intro. destruct H. assert (contain x X<->contain x _0).
rewrite -> H0. split. intro. apply H1. intro. apply H1. apply H1 in H. apply
Definition_of_Empty_Set in H. apply H.
Qed.
Theorem Empty_Set_Law_2:forall X:Set,(~_0=X)<->exists x:Set,contain x X.
Proof.
intro. split. intro. assert (X<>_0). intro. apply H. symmetry. apply H0. apply
Empty_Set_Law_1. apply H0. intro. apply Empty_Set_Law_1 in H. intro. apply H. symmetry. apply
H0.
Qed.



(*Well Defined性*)
Theorem Well_Defined_for_All_Formula:forall P:Set->Prop,exists! x:Set,((exists! y:Set,P y)/\
P x)\/(~ exists! y:Set, P y)/\x=_0.
Proof.
intros. destruct (Law_of_excluded_middle (exists ! y : Set, P y)). destruct H.
unfold unique in H. destruct H. exists x. split. left. split. exists x. unfold unique. split.
apply H. intros. specialize (H0 x'). specialize (H0 H1). apply H0. apply H. intros.
destruct H1. destruct H1. destruct H1. unfold unique in H1. destruct H1. specialize (H0 x').
specialize (H0 H2). apply H0. destruct H1. destruct H1. exists x. unfold unique. split.
apply H. intros. destruct (H0 x'0). apply H1. specialize (H0 x). specialize (H0 H). apply H0.
exists _0. split. right. split. apply H. split. intros. destruct H0. destruct H0. destruct H.
apply H0. destruct H0. symmetry. apply H1.
Qed.
Axiom Well_Defined:(Set->Prop)->Set.
Axiom Definition_Well_defined:forall P:Set->Prop,((exists! y:Set,P y)/\P (Well_Defined P))\/
(~(exists! y:Set,P y)/\Well_Defined P =_0).
Theorem Well_Defined_1:forall P:Set->Prop,(exists! y : Set,P y)->P(Well_Defined P).
Proof.
intros. destruct (Definition_Well_defined P). destruct H0. apply H1. destruct H0.
specialize (H0 H). destruct H0. 
Qed.
Theorem Well_Defined_2:forall P:Set->Prop,~(exists ! y:Set,P y)->Well_Defined P=_0.
Proof.
intros. destruct (Definition_Well_defined P). destruct H0. specialize (H H0). destruct H.
destruct H0. apply H1.
Qed.



(*分出公理*)
Axiom Axiom_Schema_of_Separation:forall p:Set->Prop,forall x:Set,exists y:Set,forall z:Set,
contain z y<->contain z x/\p z.
Definition Set_of_Prop_Function(P:Set->Prop):=Well_Defined(fun A=>forall x:Set,contain x
A<->P x).
Theorem Well_Defined_Set_of_Prop_Function:forall P:Set->Prop,(exists A:Set,forall x:Set,P x->
contain x A)->forall x:Set,contain x(Set_of_Prop_Function P)<->P x.
Proof.
intro. intro. apply (Well_Defined_1 (fun A=>forall x:Set,contain x A<->P x)). destruct H.
destruct (Axiom_Schema_of_Separation P x). exists x0. unfold unique. split. intros. split.
intro. specialize (H0 x1). destruct H0. specialize (H0 H1). destruct H0. apply H3.
specialize (H0 x1). destruct H0. intro. apply H1. split. specialize (H x1).
specialize (H H2). apply H. apply H2. intros. apply (Axiom_of_Extensionality x0 x').
intros. split. intro. apply H1. apply H0. apply H2. intro. apply H0. split. apply H.
apply H1. apply H2. apply H1. apply H2.
Qed.
Theorem Well_dedfined_Empty_Set:forall x:Set,(x=_0)<->(forall y:Set,~contain y x).
Proof.
intro. split. intro. intro. rewrite H. apply (Definition_of_Empty_Set y). intro. specialize
H. apply (Axiom_of_Extensionality x _0). intro. specialize (H z). specialize
(Definition_of_Empty_Set z). intro. split. intro. specialize (H H1). destruct H. intro.
specialize (H0 H1). destruct H0.
Qed.



(*対の公理*)
Axiom Axiom_of_Pairing:forall x y:Set,exists z:Set,forall w:Set,contain w z<->( w=x )\/
( w=y ) .
(*二点集合*)
Definition Double_Point_Set(x y:Set):=Set_of_Prop_Function(fun z=>(z=x)\/(z=y)).
Theorem Well_Defined_Double_Point_Set:forall x y:Set,forall z:Set,contain z (Double_Point_Set
x y)<->(z=x)\/(z=y).
Proof.
intro. intro. apply Well_Defined_Set_of_Prop_Function. destruct (Axiom_of_Pairing x y).
exists x0. intro. specialize (H x1). destruct H. apply H0.
Qed.
Theorem Equal_of_Double_Point_Set:forall x y z w:Set,Double_Point_Set x y=
Double_Point_Set z w<->(x=z/\y=w)\/(x=w/\y=z).
Proof.
intros. split. intro. specialize (Well_Defined_Double_Point_Set x y). intro.
specialize (H0 z). specialize (Well_Defined_Double_Point_Set x y). intro. specialize (H1 w).
symmetry in H. rewrite <- H in H0. rewrite <- H in H1. specialize
(Well_Defined_Double_Point_Set z w). intro. specialize (H2 z). specialize
(Well_Defined_Double_Point_Set z w). intro. specialize (H3 w). assert (forall z w:Set,z=z\/
z=w). intros. left. split. specialize (H4 z w). destruct H2. specialize (H5 H4).
destruct H0. specialize (H0 H5). assert (forall z w:Set,w=z\/w=w). intros. right. split.
specialize (H7 z w). destruct H3. specialize (H8 H7). destruct H1. specialize (H1 H8).
destruct H0. destruct H1. symmetry in H0. rewrite <- H0 in H. symmetry in H1. rewrite <- H1
in H. specialize (Well_Defined_Double_Point_Set x y y). specialize
(Well_Defined_Double_Point_Set x x y). intros. destruct H10. destruct H11. assert (forall x
y:Set,y=x\/y=y). intros. right. split. specialize (H14 x y). specialize (H13 H14). rewrite
<- H in H13. specialize (H10 H13). destruct H10. left. split. apply H0. rewrite <- H10 in H1.
apply H1. left. split. apply H0. rewrite <- H10 in H1. apply H1. left. split. symmetry in H0.
apply H0. symmetry in H1. apply H1. destruct H1. right. split. symmetry in H1. apply H1.
symmetry in H0. apply H0. symmetry in H0. rewrite <- H0 in H. symmetry in H1. rewrite <- H1
in H. specialize (Well_Defined_Double_Point_Set x y x). specialize
(Well_Defined_Double_Point_Set y y x). intros. destruct H10. destruct H11. assert (forall x
y:Set,x=x\/x=y). intros. left. split. specialize (H14 x y). specialize (H13 H14). rewrite <-
H in H13. specialize (H10 H13). left. split. destruct H10. rewrite <- H10 in H0. apply H0.
rewrite <- H10 in H0. apply H0. apply H1. intro. destruct H. destruct H. rewrite <- H.
rewrite <- H0. split. destruct H. rewrite <- H. rewrite <- H0. apply Axiom_of_Extensionality.
intro. split. intro. apply (Well_Defined_Double_Point_Set y x z0). apply
(Well_Defined_Double_Point_Set x y) in H1. destruct H1. right. apply H1. left. apply H1.
intro. apply (Well_Defined_Double_Point_Set x y z0). apply (Well_Defined_Double_Point_Set y
x) in H1. destruct H1. right. apply H1. left. apply H1.
Qed.
(*二点集合の基本定理*)
Theorem Double_of_Finite_Set:forall x y:Set,Double_Point_Set x y=Double_Point_Set y x.
Proof.
intros. apply (Axiom_of_Extensionality (Double_Point_Set x y) (Double_Point_Set y x)).
intro. split. intro. apply (Well_Defined_Double_Point_Set y x z). destruct
(Well_Defined_Double_Point_Set x y z). specialize (H0 H). destruct H0. right. apply H0.
left. apply H0. intro. apply (Well_Defined_Double_Point_Set x y z). destruct
(Well_Defined_Double_Point_Set y x z). specialize (H0 H). destruct H0. right. apply H0.
left. apply H0.
Qed.



(*一点集合*)
Definition One_Point_Set(x:Set):=Set_of_Prop_Function(fun y=>contain y
(Double_Point_Set x x)).
Theorem Well_Defined_One_Point_Set:forall x:Set,forall y :Set,contain y (One_Point_Set x)
<->contain y (Double_Point_Set x x).
Proof.
intros. unfold One_Point_Set. specialize Well_Defined_Set_of_Prop_Function. intro.
specialize (H (fun y=>contain y (Double_Point_Set x x))). apply H.
exists (Double_Point_Set x x). intros. apply H0.
Qed.
Theorem Well_Defined_One_Point_Set_1:forall x:Set,(One_Point_Set x)=(Double_Point_Set x x).
Proof.
intro. specialize (Well_Defined_One_Point_Set x). intro. specialize (Axiom_of_Extensionality
(One_Point_Set x) (Double_Point_Set x x)). intro. specialize (H0 H). apply H0.
Qed.
(*一点集合の基本定理*)
Theorem One_Point_Set_Law_1:forall x y:Set,One_Point_Set x=One_Point_Set y<->x=y.
Proof.
intros. split. intro. rewrite -> Well_Defined_One_Point_Set_1 in H. rewrite ->
Well_Defined_One_Point_Set_1 in H. apply (Equal_of_Double_Point_Set x x y y) in H. destruct H.
destruct H. apply H. destruct H. apply H. intro. rewrite <- H. split.
Qed.
Theorem One_Point_Set_Law_2:forall x:Set,forall y:Set,contain y (One_Point_Set x)<->y=x.
Proof.
split. intro. rewrite -> Well_Defined_One_Point_Set_1 in H.
apply Well_Defined_Double_Point_Set in H. destruct H. apply H. apply H. intro.
rewrite -> H. apply (Well_Defined_One_Point_Set x x).
apply (Well_Defined_Double_Point_Set x x x). left. split.
Qed.



(*和集合公理*)
Axiom Axiom_of_Union :forall X:Set,exists A:Set,forall t:Set,contain t A<->exists x:Set,
contain x X /\ contain t x.
(*和集合*)
Definition Union_Set(X:Set):=Set_of_Prop_Function(fun t=>exists x:Set,contain x X /\contain t
x).
Theorem Well_Defined_Union_Set:forall X:Set,forall t:Set,contain t (Union_Set X)<->exists
x:Set,contain x X/\contain t x.
Proof.
intro. apply Well_Defined_Set_of_Prop_Function. destruct (Axiom_of_Union X). exists x.
apply H.
Qed.
(*和集合の基本定理*)
Theorem Union_of_Empty_Set:(Union_Set _0)=_0.
Proof.
apply Theorem_of_Extensionality. intro. split. intro. apply Well_Defined_Union_Set in H.
destruct H. destruct H. apply Definition_of_Empty_Set in H. destruct H. intro. apply
Definition_of_Empty_Set in H. destruct H.
Qed.
Theorem Union_Set_Law_1:forall X Y:Set,(forall x:Set,contain x X->Sub_Set x Y)->(Sub_Set
(Union_Set X) Y).
Proof.
intros. intro. intro. apply Well_Defined_Union_Set in H0. destruct H0. destruct H0. apply H
in H0. apply H0. apply H1.
Qed.
(*有限和集合*)
Definition Double_Union_Set(x y:Set):=Set_of_Prop_Function(fun z=>contain z (Union_Set
(Double_Point_Set x y))).
Theorem Well_Defined_Double_Union_Set:forall x y:Set,forall z:Set,contain z (Double_Union_Set
x y)<->contain z (Union_Set(Double_Point_Set x y)).
Proof.
intro. intro. apply Well_Defined_Set_of_Prop_Function. exists (Union_Set (Double_Point_Set x
y)). intros. apply H. 
Qed.
Theorem Contain_of_Double_Union_Set:forall x y:Set,forall z:Set,contain z (Double_Union_Set
x y)<->contain z x\/contain z y.
Proof.
intros. split. intro. apply Well_Defined_Double_Union_Set in H. apply Well_Defined_Union_Set
in H. destruct H. destruct H. apply Well_Defined_Double_Point_Set in H. destruct H. left.
rewrite -> H in H0. apply H0. right. rewrite -> H in H0. apply H0. intro. apply
Well_Defined_Double_Union_Set. apply Well_Defined_Union_Set. destruct H. exists x. split.
apply Well_Defined_Double_Point_Set. left. split. apply H. exists y. split. apply
Well_Defined_Double_Point_Set. right. split. apply H.
Qed.
(*有限和集合の基本定理*)
Theorem Double_Union_Set_Law_1:forall x y:Set,(Double_Union_Set x y)=
(Double_Union_Set y x).
Proof.
unfold Double_Union_Set. intro. intro. destruct (Double_of_Finite_Set x y). split.
Qed.
Theorem Double_Union_Set_Law_2:forall x y z:Set,(Double_Union_Set (Double_Union_Set x
y) z)=(Double_Union_Set x (Double_Union_Set y z)).
Proof.
intros. apply Axiom_of_Extensionality. intro. split. intro. apply Contain_of_Double_Union_Set.
apply Contain_of_Double_Union_Set in H. destruct H. apply Contain_of_Double_Union_Set in H.
destruct H. left. apply H. right. apply Contain_of_Double_Union_Set. left. apply H. right.
apply Contain_of_Double_Union_Set. right. apply H. intro. apply Contain_of_Double_Union_Set.
apply Contain_of_Double_Union_Set in H. destruct H. left. apply Contain_of_Double_Union_Set.
left. apply H. apply Contain_of_Double_Union_Set in H. destruct H. left. apply
Contain_of_Double_Union_Set. right. apply H. right. apply H.
Qed.



(*積集合*)
Definition Meet_Set(x:Set):=Set_of_Prop_Function(fun y=>forall z:Set,contain z x->contain y
z).
Theorem Well_Defined_Meet_Set:forall x:Set,~(x=_0)->(forall y:Set,contain y (Meet_Set x)<->
(forall z:Set,contain z x->contain y z)).
Proof.
intro. intro. apply Well_Defined_Set_of_Prop_Function. destruct (Well_dedfined_Empty_Set x).
specialize (Contraposition (x=_0) (forall y : Set, ~ contain y x) H1). intro. specialize
(H2 H). specialize H2. destruct (new_theorem6 (fun y=>~contain y x)). specialize (H3 H2).
destruct H3. exists x0. specialize (Axiom_Schema_of_Separation (fun y=>forall z:Set, contain
z x->contain y z)). intros. specialize (H6 x0). apply H6. destruct (Law_of_excluded_middle
(contain x0 x)). apply H7. specialize (H3 H7). destruct H3.
Qed.
(*積集合の基本定理*)
Theorem Meet_Set_Law_1:forall X Y:Set,(~X=_0)->((exists x:Set,contain x X/\Sub_Set x Y)->
(Sub_Set (Meet_Set X) Y)).
Proof.
intros. intro. intro. specialize Well_Defined_Meet_Set. intro. specialize (H2 X). specialize
(H2 H). specialize (H2 x). destruct H2. specialize (H2 H1). destruct H0. destruct H0. apply
H4. apply H2. apply H0.
Qed.
(*有限積集合*)
Definition Double_Meet_Set(x y:Set):=Set_of_Prop_Function(fun z=>contain z (Meet_Set
(Double_Point_Set x y))).
Theorem Well_Defined_Double_Meet_Set:forall x y:Set,forall z:Set,contain z (Double_Meet_Set
x y)<->contain z (Meet_Set(Double_Point_Set x y)).
Proof.
intro. intro. apply Well_Defined_Set_of_Prop_Function. exists (Meet_Set (Double_Point_Set x
y)). intros. apply H.
Qed.
Theorem Contain_of_Double_Meet_Set:forall x y:Set,forall z:Set,contain z (Double_Meet_Set
x y)<->contain z x/\contain z y.
Proof.
assert (forall x y:Set,~(forall z0:Set, contain z0 (Double_Point_Set x y)<->contain z0 _0)).
intros. intro. apply (Definition_of_Empty_Set x). specialize (H x). apply H. apply
Well_Defined_Double_Point_Set. left. split. intros. specialize (H x). specialize (H y).
assert (~((Double_Point_Set x y)=_0)). intro. apply H. intro. rewrite -> H0. split.
intro. apply H1. intro. apply H1. split. intro. apply Well_Defined_Double_Meet_Set in H1.
specialize Well_Defined_Meet_Set. intro. specialize (H2 (Double_Point_Set x y)). specialize
(H2 H0). specialize (H2 z). destruct H2. specialize (H2 H1). split. specialize (H2 x). apply
H2. apply Well_Defined_Double_Point_Set. left. split. specialize (H2 y). apply H2. apply
Well_Defined_Double_Point_Set. right. split. intro. specialize Well_Defined_Meet_Set. intro.
specialize (H2 (Double_Point_Set x y)). specialize (H2 H0). specialize (H2 z). apply
Well_Defined_Double_Meet_Set. apply H2. intros. destruct H1. apply
Well_Defined_Double_Point_Set in H3. destruct H3. rewrite -> H3. apply H1. rewrite -> H3.
apply H4.
Qed.
(*有限積集合の基本定理*)
Theorem Double_Meet_Set_Law_1:forall x y:Set,(Double_Meet_Set x y)=(Double_Meet_Set
y x).
Proof.
unfold Double_Meet_Set. intros. destruct (Double_of_Finite_Set x y). split.
Qed.
Theorem Double_Meet_Set_Law_2:forall x y z:Set,(Double_Meet_Set (Double_Meet_Set x
y) z)=(Double_Meet_Set x (Double_Meet_Set y z)).
Proof.
intros. apply Axiom_of_Extensionality. intro. split. intro. apply Contain_of_Double_Meet_Set.
apply Contain_of_Double_Meet_Set in H. destruct H. apply Contain_of_Double_Meet_Set in H.
destruct H. split. apply H. apply Contain_of_Double_Meet_Set. split. apply H1. apply H0.
intro. apply Contain_of_Double_Meet_Set. apply Contain_of_Double_Meet_Set in H. destruct H.
apply Contain_of_Double_Meet_Set in H0. destruct H0. split. apply Contain_of_Double_Meet_Set.
split. apply H. apply H0. apply H1.
Qed.



(*和集合と積集合の法則*)
Theorem Union_and_Meet_Law_1:forall x y z:Set,Double_Meet_Set x (Double_Union_Set y z)
=Double_Union_Set (Double_Meet_Set x y) (Double_Meet_Set x z).
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply
Contain_of_Double_Meet_Set in H. apply Contain_of_Double_Union_Set. destruct H. apply
Contain_of_Double_Union_Set in H0. destruct H0. left. apply Contain_of_Double_Meet_Set.
split. apply H. apply H0. right. apply Contain_of_Double_Meet_Set. split. apply H. apply H0.
intro. apply Contain_of_Double_Meet_Set. apply Contain_of_Double_Union_Set in H. destruct H.
split. apply Contain_of_Double_Meet_Set in H. destruct H. apply H. apply
Contain_of_Double_Meet_Set in H. apply  Contain_of_Double_Union_Set. destruct H. left.
apply H0. split.  apply Contain_of_Double_Meet_Set in H. destruct H. apply H. apply
Contain_of_Double_Meet_Set in H. apply  Contain_of_Double_Union_Set. destruct H. right.
apply H0.
Qed.
Theorem Union_and_Meet_Law_2:forall x y z:Set,Double_Union_Set x (Double_Meet_Set y z)
=Double_Meet_Set (Double_Union_Set x y) (Double_Union_Set x z).
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply
Contain_of_Double_Meet_Set. apply Contain_of_Double_Union_Set in H. destruct H. split.
apply Contain_of_Double_Union_Set. left. apply H. apply Contain_of_Double_Union_Set.
left. apply H. apply Contain_of_Double_Meet_Set in H. destruct H. split. apply
Contain_of_Double_Union_Set. right. apply H. apply Contain_of_Double_Union_Set. right.
apply H0. intro. apply Contain_of_Double_Union_Set. apply Contain_of_Double_Meet_Set in H.
destruct H. apply Contain_of_Double_Union_Set in H. apply Contain_of_Double_Union_Set in H0.
destruct H. left. apply H. destruct H0. left. apply H0. right. apply
Contain_of_Double_Meet_Set. split. apply H. apply H0.
Qed.



(*順序対*)
Definition Ordered_Pair(x y:Set):=Double_Point_Set (One_Point_Set x) (Double_Point_Set x y).
Theorem Well_Defined_Ordered_Pair:forall x y:Set,forall z:Set,(contain z (Ordered_Pair x y))
<->contain z (Double_Point_Set (One_Point_Set x) (Double_Point_Set x y)).
Proof.
intro. intro. unfold Ordered_Pair. split. intro. apply H. intro. apply H.
Qed.
Theorem Equal_of_Ordered_Pair:forall x y z w:Set,(Ordered_Pair x y=Ordered_Pair z w)->
x=z/\y=w.
Proof.
intros. unfold Ordered_Pair in H. apply (Equal_of_Double_Point_Set (One_Point_Set x)
(Double_Point_Set x y)) in H. destruct H. destruct H. apply (One_Point_Set_Law_1 x z)
in H. apply Equal_of_Double_Point_Set in H0. destruct H0. destruct H0. split. apply H.
apply H1. destruct H0. split. apply H. rewrite -> H1. rewrite <- H. apply H0. destruct H.
rewrite -> Well_Defined_One_Point_Set_1 in H. apply Equal_of_Double_Point_Set in H.
rewrite -> Well_Defined_One_Point_Set_1 in H0. apply Equal_of_Double_Point_Set in H0.
destruct H. destruct H0. destruct H. destruct H0. split. apply H. rewrite -> H2.
rewrite <- H1. symmetry. apply H0. destruct H. destruct H0. split. apply H. rewrite -> H2.
rewrite <- H. apply H1. destruct H0. destruct H. destruct H0. split. apply H1. rewrite -> H2.
rewrite <- H0. apply H. destruct H. destruct H0. split. rewrite <- H0. split. rewrite <- H.
rewrite -> H2. rewrite <- H0. split.
Qed.



(*冪集合公理*)
Axiom Axiom_of_Power_Set:forall A:Set,exists P:Set,forall B:Set,(contain B P)<->(Sub_Set B A).
Definition Power_Set(x:Set):=Set_of_Prop_Function(fun y=>(Sub_Set y x)).
Theorem Well_Defined_Power_Set:forall x:Set,forall y:Set,((contain y (Power_Set x))<->
(Sub_Set y x)).
Proof.
intro. apply Well_Defined_Set_of_Prop_Function. destruct (Axiom_of_Power_Set x). exists x0.
intros. specialize (H x1). destruct H. specialize (H1 H0). apply H1.
Qed.



(*差集合*)
Definition Complement_Set(x U:Set):=Set_of_Prop_Function (fun y=>contain y U/\~contain y x).
Theorem Well_Defined_Complement_Set:forall x U:Set,forall y:Set,contain y (Complement_Set x U)
<->(contain y U/\~contain y x).
Proof.
intros. apply Well_Defined_Set_of_Prop_Function. exists U. intros. destruct H. apply H.
Qed.
(*ド・モルガンの法則*)
Theorem De_Morgans_Law_1:forall U x y:Set,(Double_Union_Set (Complement_Set x U)
(Complement_Set y U))=(Complement_Set (Double_Meet_Set x y) U).
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply
Well_Defined_Complement_Set. apply Contain_of_Double_Union_Set in H. destruct H. split.
apply Well_Defined_Complement_Set in H. destruct H. apply H. intro. apply
Well_Defined_Complement_Set in H. apply Contain_of_Double_Meet_Set in H0. destruct H.
destruct H0. apply H1. apply H0. split. apply Well_Defined_Complement_Set in H. destruct H.
apply H. intro. apply Well_Defined_Complement_Set in H. apply Contain_of_Double_Meet_Set in
H0. destruct H. destruct H1. apply H0. intro. apply Well_Defined_Complement_Set
in H. apply Contain_of_Double_Union_Set. destruct H. assert (~(contain z x/\contain z y)).
intro. apply H0. apply Contain_of_Double_Meet_Set in H1. apply H1. apply De_Morggans_Prop_2
in H1. destruct H1. left. apply Well_Defined_Complement_Set. split. apply H. apply H1. right.
apply Well_Defined_Complement_Set. split. apply H. apply H1.
Qed.
Theorem De_Morgans_Law_2:forall U x y:Set,(Double_Meet_Set (Complement_Set x U)
(Complement_Set y U))=(Complement_Set (Double_Union_Set x y) U).
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply
Well_Defined_Complement_Set. apply Contain_of_Double_Meet_Set in H. destruct H. split. apply
Well_Defined_Complement_Set in H. destruct H. apply H. intro. apply
Well_Defined_Complement_Set in H. apply Contain_of_Double_Union_Set in H1. apply
Well_Defined_Complement_Set in H0. destruct H. destruct H0. destruct H1. apply H2.
apply H1. apply H3. apply H1. intro. apply Contain_of_Double_Meet_Set. apply
Well_Defined_Complement_Set in H. destruct H. split. apply Well_Defined_Complement_Set.
split. apply H. intro. apply H0. apply Contain_of_Double_Union_Set. left. apply H1.
apply Well_Defined_Complement_Set. split. apply H. intro. apply H0. apply
Contain_of_Double_Union_Set. right. apply H1.
Qed.
Theorem De_Morgans_Law_3:forall X U:Set,(~X=_0)->Complement_Set (Union_Set X) U=Meet_Set
(Set_of_Prop_Function (fun x=>exists y:Set,(x=Complement_Set y U)/\contain y X)).
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply Well_Defined_Meet_Set. 
apply Empty_Set_Law_1 in H. apply Empty_Set_Law_1. destruct H. exists (Complement_Set x U).
apply Well_Defined_Set_of_Prop_Function. exists (Power_Set U). intros. apply
Well_Defined_Power_Set. intro. intro. destruct H1. destruct H1. rewrite -> H1 in H2.
apply Well_Defined_Complement_Set in H2. destruct H2. apply H2. exists x. split. split.
apply H. intros. apply (Well_Defined_Set_of_Prop_Function (fun x=>exists y:Set,x=
Complement_Set y U/\contain y X)) in H1. apply Well_Defined_Complement_Set in H0. destruct H0.
assert (forall z1:Set,~(contain z1 X/\contain z z1)). intro. intro. apply H2. apply
Well_Defined_Union_Set. exists z1. apply H3. destruct H1. specialize (H3 x). destruct H1.
rewrite -> H1. apply Well_Defined_Complement_Set. split. apply H0. intro. apply H3. split.
apply H4. apply H5. exists (Power_Set U). intros. apply Well_Defined_Power_Set. intro.
intro. destruct H3. destruct H3. rewrite -> H3 in H4. apply Well_Defined_Complement_Set in H4.
destruct H4. apply H4. intro. assert ((Set_of_Prop_Function (fun x=>exists y:Set,x=
Complement_Set y U/\contain y X))<>_0). apply Empty_Set_Law_1 in H. apply Empty_Set_Law_1.
destruct H. exists (Complement_Set x U). apply Well_Defined_Set_of_Prop_Function. exists
(Power_Set U). intros. apply Well_Defined_Power_Set. intro. intro. destruct H1. destruct H1.
rewrite -> H1 in H2. apply Well_Defined_Complement_Set in H2. destruct H2. apply H2.
exists x. split. split. apply H. specialize Well_Defined_Meet_Set. intro. specialize (H2
(Set_of_Prop_Function (fun x=>exists y:Set,x=Complement_Set y U/\contain y X))). specialize
(H2 H1). specialize (H2 z). destruct H2. specialize (H2 H0). assert (forall z0:Set,(exists
y:Set,z0=Complement_Set y U/\contain y X)->(contain z z0)). intros. apply H2. apply
Well_Defined_Set_of_Prop_Function. exists (Power_Set U). intros. apply Well_Defined_Power_Set.
intro. intro. destruct H5. destruct H5. rewrite -> H5 in H6. apply Well_Defined_Complement_Set
in H6. destruct H6. apply H6. apply H4. apply Empty_Set_Law_1 in H. destruct H. apply
Well_Defined_Complement_Set. assert (contain z (Complement_Set x U)). apply H4. exists
x. split. split. apply H. apply Well_Defined_Complement_Set in H5. destruct H5. split.
apply H5. intro. apply Well_Defined_Union_Set in H7. destruct H7. destruct H7. assert
(contain z (Complement_Set x0 U)). apply H4. exists x0. split. split. apply H7. apply
Well_Defined_Complement_Set in H9. destruct H9. destruct H10. apply H8.
Qed.
Theorem De_Morgans_Law_4:forall X U:Set,(~X=_0)->Complement_Set (Meet_Set X) U=Union_Set
(Set_of_Prop_Function (fun x=>exists y:Set,(x=Complement_Set y U)/\contain y X)).
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply
Well_Defined_Complement_Set in H0. apply Well_Defined_Union_Set. destruct H0.

apply Empty_Set_Law_1 in H. destruct H.

exists
(Meet_Set X).

split. apply Well_Defined_Set_of_Prop_Function. exists
(Power_Set U). intros. destruct H2. destruct H2. apply Well_Defined_Power_Set. intro. intro.
rewrite -> H2 in H4. apply Well_Defined_Complement_Set in H4. destruct H4. apply H4. exists
(Meet_Set X). split.

destruct Sekai_no_Ssinri. destruct Sekai_no_Ssinri. destruct Sekai_no_Ssinri. destruct
Sekai_no_Ssinri.
Qed.
(*差集合の定理一覧*)
Theorem Complement_Set_Law_1:forall x U:Set,contain x (Power_Set U)->contain
(Complement_Set x U) (Power_Set U).
Proof.
intros. apply Well_Defined_Power_Set. apply Well_Defined_Power_Set in H. intro. intro.
apply Well_Defined_Complement_Set in H0. destruct H0. apply H0.
Qed.
Theorem Complement_Set_Law_2:forall x:Set,_0=Complement_Set x x.
Proof.
intro. apply Theorem_of_Extensionality. intro. split. intro. apply Definition_of_Empty_Set
in H. destruct H. intro. apply Well_Defined_Complement_Set in H. destruct H. destruct H0.
apply H.
Qed.
Theorem Complement_Set_Law_3:forall x:Set,x=Complement_Set _0 x.
Proof.
intro. apply Theorem_of_Extensionality. intro. split. intro. apply
Well_Defined_Complement_Set. split. apply H. intro. apply Definition_of_Empty_Set in H0.
apply H0. intro. apply Well_Defined_Complement_Set in H. destruct H. apply H.
Qed.
Theorem Complement_Set_Law_4:forall x U:Set,Sub_Set x U->(Complement_Set (Complement_Set x U)
U)=x.
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply
Well_Defined_Complement_Set in H0. destruct H0. assert (~contain z U\/~~contain z x).
apply De_Morggans_Prop_2. intro. apply Well_Defined_Complement_Set in H2. apply H1. apply H2.
destruct H2. specialize (H2 H0). destruct H2. destruct (Law_of_excluded_middle (contain z x)).
apply H3. specialize (H2 H3). destruct H2. intro. apply Well_Defined_Complement_Set.
split. apply H. apply H0. intro. apply Well_Defined_Complement_Set in H1. destruct H1.
apply H2. apply H0.
Qed.
Theorem Complement_Set_Law_5:forall X U:Set,(Sub_Set X (Power_Set U))->X=(Set_of_Prop_Function
(fun y1=>exists x1:Set,y1=(Complement_Set x1 U)/\(contain x1 (Set_of_Prop_Function ((fun y2=>
exists x2:Set,y2=(Complement_Set x2 U)/\contain x2 X)))))).
Proof.
intros. apply Theorem_of_Extensionality. intro. split. intro. apply
Well_Defined_Set_of_Prop_Function. exists (Power_Set U). intros. destruct H1. destruct H1.
apply (Well_Defined_Set_of_Prop_Function (fun y2=>exists x2:Set,y2=Complement_Set x2 U/\
contain x2 X)) in H2. destruct H2. destruct H2. rewrite -> H2 in H1. rewrite ->
Complement_Set_Law_4 in H1. apply H. rewrite -> H1. apply H3. apply Well_Defined_Power_Set.
apply H. apply H3. exists (Power_Set U). intros. destruct H4. destruct H4. rewrite -> H4.
apply Well_Defined_Power_Set. intro. intro. apply Well_Defined_Complement_Set in H6. destruct
H6. apply H6. exists (Complement_Set z U). split. rewrite -> Complement_Set_Law_4. split.
apply Well_Defined_Power_Set. apply H. apply H0. apply Well_Defined_Set_of_Prop_Function.
exists (Power_Set U). intros. destruct H1. destruct H1. rewrite -> H1. apply
Well_Defined_Power_Set. intro. intro. apply Well_Defined_Complement_Set in H3. destruct H3.
apply H3. exists z. split. split. apply H0. intro. apply (Well_Defined_Set_of_Prop_Function
(fun y1=> exists x1:Set,y1=Complement_Set x1 U/\contain x1 (Set_of_Prop_Function (fun y2=>
exists x2:Set,y2=Complement_Set x2 U/\contain x2 X)))) in H0. destruct H0. destruct H0. apply
(Well_Defined_Set_of_Prop_Function (fun y2=>exists x2:Set,y2=Complement_Set x2 U/\contain x2
X)) in H1. destruct H1. destruct H1. rewrite -> H0. rewrite -> H1. rewrite ->
Complement_Set_Law_4. apply H2. apply Well_Defined_Power_Set. apply H. apply H2. exists
(Power_Set U). intros. destruct H3. destruct H3. rewrite -> H3. apply Well_Defined_Power_Set.
intro. intro. apply Well_Defined_Complement_Set in H5. destruct H5. apply H5. exists
(Power_Set U). intros. destruct H2. destruct H2. apply (Well_Defined_Set_of_Prop_Function
(fun y2=>exists x2:Set,y2=Complement_Set x2 U/\contain x2 X)) in H3. destruct H3. destruct H3.
rewrite -> H2. rewrite -> H3. apply H. rewrite -> Complement_Set_Law_4. apply H4. apply
Well_Defined_Power_Set. apply H. apply H4. exists (Power_Set U). intros. destruct H5. destruct
H5. rewrite -> H5. apply Well_Defined_Power_Set. intro. intro. apply
Well_Defined_Complement_Set in H7. destruct H7. apply H7.
Qed.



(*有限直積*)
Definition Double_Direct_Product(X Y:Set):=Set_of_Prop_Function(fun z=>exists x y:Set,
Ordered_Pair x y=z/\contain x X/\contain y Y).
Theorem Well_Defined_Double_Direct_Product:forall X Y z:Set,contain z
(Double_Direct_Product X Y)<->exists x y:Set,Ordered_Pair x y=z/\contain x X/\contain y Y.
Proof.
intro. intro. apply Well_Defined_Set_of_Prop_Function. exists (Power_Set (Power_Set
(Double_Union_Set X Y))). intros. destruct H. destruct H. destruct H. destruct H. destruct H0.
apply Well_Defined_Power_Set. intro. intro. apply Well_Defined_Power_Set.
apply Well_Defined_Double_Point_Set in H1. destruct H1. symmetry in H1. destruct H1.
intro. intro. apply One_Point_Set_Law_2 in H1. rewrite -> H1. apply
(Well_Defined_Double_Union_Set X Y x0). apply (Well_Defined_Union_Set (Double_Point_Set X Y)).
 exists X. split. apply (Well_Defined_Double_Point_Set X Y). left. split. apply H. rewrite ->
H1. intro. intro. apply (Well_Defined_Double_Union_Set X Y x2). apply
(Well_Defined_Double_Point_Set x0 x1 x2) in H2. apply (Well_Defined_Union_Set
(Double_Point_Set X Y) x2). destruct H2. rewrite -> H2. exists X. split. apply
(Well_Defined_Double_Point_Set X Y). left. split. apply H. rewrite -> H2. exists Y. split.
apply (Well_Defined_Double_Point_Set X Y). right. split. apply H0.
Qed.



(*一般的な直和*)
Definition Direct_Sum(X:Set):=Set_of_Prop_Function(fun z=>exists x y:Set,contain x X/\
contain y x/\z=(Ordered_Pair y x)).
Theorem Well_Defined_Direct_Sum:forall X:Set,forall z:Set,contain z (Direct_Sum X)<->exists
x y:Set,contain x X/\contain y x/\z=(Ordered_Pair y x).
Proof.
intros. apply Well_Defined_Set_of_Prop_Function. exists (Double_Direct_Product (Union_Set X)
X). intros. apply Well_Defined_Double_Direct_Product. destruct H. destruct H. destruct H.
destruct H0. exists x1. exists x0. split. rewrite -> H1. split. split. apply
Well_Defined_Union_Set. exists x0. split. apply H. apply H0. apply H.
Qed.



(*包含関係の順序的な次*)
Definition Ordinal_Next(x:Set):=Double_Union_Set x (One_Point_Set x).
Theorem Well_Defined_Union_Set_Ordinal_Next:forall x:Set,exists! y:Set,y=Ordinal_Next x.
Proof.
intro. unfold Ordinal_Next. exists (Double_Union_Set x (One_Point_Set x)). split. split.
intros. symmetry in H. apply H.
Qed.
(*無限集合*)
Axiom Axiom_of_Infinity:exists x : Set, contain Empty_set x /\ forall y : Set, contain y x
-> contain (Ordinal_Next y) x.



(*写像*)
Definition Map_Set(X Y:Set):=Set_of_Prop_Function(fun f=>Sub_Set f (Double_Direct_Product X
Y)/\(forall x:Set,contain x X->exists! y:Set,contain (Ordered_Pair x y) f)).
Theorem Well_Defined_Map_Set:forall X Y:Set,forall f:Set,contain f (Map_Set X Y)<->Sub_Set f
(Double_Direct_Product X Y)/\(forall x:Set,contain x X->exists! y:Set,contain (Ordered_Pair x
y) f).
Proof.
intros. apply Well_Defined_Set_of_Prop_Function. exists (Power_Set (Double_Direct_Product
X Y)). intros. destruct H. apply (Well_Defined_Power_Set (Double_Direct_Product X Y)).
apply H.
Qed.
(*代入*)
Definition Map_Assignment(f x:Set):=Well_Defined (fun y=>contain (Ordered_Pair x y) f).



(*全射*)
Definition Surjective_Function(f X Y:Set):=contain f (Map_Set X Y)/\(forall y:Set,contain y Y
->exists x:Set,contain x X->y=Map_Assignment f x).
(*単射*)
Definition injective_Function(f X Y:Set):=contain f (Map_Set X Y)/\(forall x:Set,contain x X
->exists y:Set,contain y Y->y=Map_Assignment f x).
(*全単射*)
Definition Bijective_Function(f X Y:Set):=injective_Function f X Y/\Surjective_Function f X Y.
(*恒等射*)
Definition Identify_Function(f X:Set):=contain f (Map_Set X X)/\forall x:Set,
Map_Assignment f x=x.



(*二項関係*)
Definition Binary_Relation(X:Set):=Well_Defined (fun R=>Sub_Set R (Double_Direct_Product X
X)).
(*正誤判定*)
Definition Binary_Relation_Prop(X x0 x1:Set):=contain x0 X/\contain x1 X/\contain
(Ordered_Pair x0 x1) (Binary_Relation X).
(*同値関係*)
Definition Reflexive_Relation(R:Set):=exists X:Set,R=(Binary_Relation X)->forall x:Set,
contain x X->contain (Ordered_Pair x x) R.
Definition Symmetric_Relation(R:Set):=exists X:Set,R=(Binary_Relation X)->forall x y:Set,
(contain x X/\contain y X)->(contain (Ordered_Pair x y) R->contain (Ordered_Pair y x) R).
Definition Transitive_Relation(R:Set):=exists X:Set,R=(Binary_Relation X)->forall x y z:Set,
(contain x X/\contain y X/\contain z X)->((contain (Ordered_Pair x y) R/\contain
(Ordered_Pair y z) R)->contain (Ordered_Pair x z) R).
Definition Equivalence_Relation(R:Set):=Reflexive_Relation R/\Symmetric_Relation R/\
Transitive_Relation R.



(*分割*)
Definition Partition(P X:Set):=(contain _0 P)/\(Union_Set P=X)/\(forall x y:Set,
Double_Meet_Set x y=_0).
(*同値類*)
Definition Equivalence_Class(R X:Set):=Well_Defined (fun P=>Partition P X/\forall p:Set,
contain p P->Equivalence_Relation p).



(*開集合と閉集合の定義*)
Definition Open_Set_Famaily(O X:Set):=(Sub_Set O (Power_Set X))/\(contain _0 O)/\(contain X
O)/\(forall x y:Set,(contain x O/\contain y O)->contain (Double_Meet_Set x y) O)/\(forall x
:Set,(forall y:Set,contain y x->contain y O)->contain (Union_Set x) O).
Definition Close_Set_Famaily(C X:Set):=(Sub_Set C (Power_Set X))/\(contain _0 C)/\(contain X
C)/\(forall x y:Set,(contain x C/\contain y C)->contain (Double_Union_Set x y) C)/\(forall x
:Set,~x=_0->((forall y:Set,(contain y x->contain y C))->contain (Meet_Set x) C)).
(*開集合と閉集合の定義の等価性*)
Theorem Reverse_of_Open_and_Close_Set_1:forall O X:Set,~X=_0->((Open_Set_Famaily O X)->
(Close_Set_Famaily (Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=(Complement_Set
x X))) X)).
Proof.
intros. unfold Open_Set_Famaily in H0. unfold Close_Set_Famaily. destruct H0. destruct H1.
destruct H2. destruct H3. split. intro. intro. apply (Well_Defined_Set_of_Prop_Function
(fun z=>exists x:Set,contain x O/\z=Complement_Set x X)) in H5. destruct H5. destruct H5.
apply Well_Defined_Power_Set. intro. intro. rewrite -> H6 in H7. apply
Well_Defined_Complement_Set in H7. destruct H7. apply H7. exists (Power_Set X). intros.
destruct H7. destruct H7. apply Well_Defined_Power_Set. intro. intro. rewrite -> H8 in H9.
apply Well_Defined_Complement_Set in H9. destruct H9. apply H9. split. apply 
(Well_Defined_Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=Complement_Set x X)).
exists (Power_Set X). intros. destruct H5. destruct H5. apply Well_Defined_Power_Set. intro.
intro. rewrite -> H6 in H7. apply Well_Defined_Complement_Set in H7. destruct H7. apply H7.
exists X. split. apply H2. apply Complement_Set_Law_2. split. apply
Well_Defined_Set_of_Prop_Function. exists (Power_Set X). intros. destruct H5. destruct H5.
apply Well_Defined_Power_Set. intro. intro. rewrite -> H6 in H7.
apply Well_Defined_Complement_Set in H7. destruct H7. apply H7. exists _0. split.
apply H1. apply Complement_Set_Law_3. split. intros. destruct H5. apply
(Well_Defined_Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=Complement_Set x X))
in H5. apply (Well_Defined_Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=
Complement_Set x X)) in H6. apply (Well_Defined_Set_of_Prop_Function). exists (Power_Set X).
intros. apply Well_Defined_Power_Set. intro. intro. destruct H7. destruct H7.
rewrite -> H9 in H8. apply Well_Defined_Complement_Set in H8. destruct H8. apply H8.
destruct H5. destruct H5. destruct H6. destruct H6. exists (Complement_Set
(Double_Union_Set x y) X). split. rewrite -> H7. rewrite -> H8. rewrite -> De_Morgans_Law_1.
rewrite -> Complement_Set_Law_4. apply H3. split. apply H5. apply H6. intro. intro.
apply Contain_of_Double_Meet_Set in H9. destruct H9. apply H0 in H6. apply
Well_Defined_Power_Set in H6. apply H6. apply H10. rewrite Complement_Set_Law_4. split.
intro. intro. rewrite -> H7 in H9. rewrite -> H8 in H9. apply Contain_of_Double_Union_Set
in H9. destruct H9. apply Well_Defined_Complement_Set in H9. destruct H9. apply H9.
apply Well_Defined_Complement_Set in H9. destruct H9. apply H9. exists (Power_Set X).
intros. apply Well_Defined_Power_Set. intro. intro. destruct H8. destruct H8. rewrite -> H10
in H9. apply Well_Defined_Complement_Set in H9. destruct H9. apply H9. exists (Power_Set X).
intros. apply Well_Defined_Power_Set. intro. intro. destruct H8. destruct H8. rewrite -> H10
in H9. apply Well_Defined_Complement_Set in H9. destruct H9. apply H9. intros. apply
Well_Defined_Set_of_Prop_Function. exists (Power_Set X). intros. destruct H7. destruct H7.
apply Well_Defined_Power_Set. intro. intro. rewrite -> H8 in H9. apply
Well_Defined_Complement_Set in H9. destruct H9. apply H9. exists (Union_Set
(Set_of_Prop_Function (fun z1=>exists z0:Set,z1=(Complement_Set z0 X)/\contain z0 x))). split.
apply H4. intros. apply (Well_Defined_Set_of_Prop_Function (fun z1=>exists z0:Set,z1=
Complement_Set z0 X/\contain z0 x)) in H7. destruct H7. destruct H7. apply H6 in H8. apply
(Well_Defined_Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=Complement_Set x X))
in H8. destruct H8. destruct H8. rewrite -> H7. rewrite -> H9. rewrite ->
Complement_Set_Law_4. apply H8. intro. intro. apply H0 in H8. apply Well_Defined_Power_Set
in H8. apply H8. apply H10. exists (Power_Set X). intros. apply Well_Defined_Power_Set.
intro. intro. destruct H10. destruct H10. rewrite -> H12 in H11. apply
Well_Defined_Complement_Set in H11. destruct H11. apply H11. exists (Power_Set X). intros.
apply Well_Defined_Power_Set. intro. intro. destruct H9. destruct H9. rewrite -> H9 in H10.
apply Well_Defined_Complement_Set in H10. destruct H10. apply H10. rewrite ->
De_Morgans_Law_3. assert (x=(Set_of_Prop_Function (fun x0=>exists y:Set,x0=Complement_Set y X
/\contain y (Set_of_Prop_Function (fun z1=>exists z0:Set,z1=Complement_Set z0 X/\contain z0
x))))).

rewrite -> Complement_Set_Law_4. split. intro. apply Meet_Set_Law_1.
apply H5. apply Empty_Set_Law_1 in H5. destruct H5. exists x1. split. apply H5. apply
Well_Defined_Power_Set. apply H6 in H5. assert (Sub_Set (Set_of_Prop_Function
(fun z=>exists x:Set,contain x O/\z=Complement_Set x X)) (Power_Set X)). intro. intro.
apply (Well_Defined_Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=Complement_Set
x X)) in H7. destruct H7. destruct H7. apply Well_Defined_Power_Set. rewrite -> H8. intro.
intro. apply Well_Defined_Complement_Set in H9. destruct H9. apply H9. exists (Power_Set X).
intros. destruct H9. destruct H9. apply Well_Defined_Power_Set. intro. intro. rewrite -> H10
in H11. apply Well_Defined_Complement_Set in H11. destruct H11. apply H11. apply
Well_Defined_Power_Set. intro. intro. apply (Well_Defined_Set_of_Prop_Function (fun z=>
exists x:Set,contain x O/\z=Complement_Set x X)) in H5. destruct H5. destruct H5. apply H0 in
H5. rewrite -> H9 in H8. apply Well_Defined_Complement_Set in H8. destruct H8. apply H8.
exists (Power_Set X). intros. apply Well_Defined_Power_Set. intro. intro. destruct H10.
destruct H10. rewrite -> H12 in H11. apply Well_Defined_Complement_Set in H11. destruct H11.
apply H11. apply H5.
Qed.
Theorem Reverse_of_Open_and_Close_Set_2:forall O X:Set,~X=_0->((Close_Set_Famaily O X)->
(Open_Set_Famaily (Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=(Complement_Set
x X))) X)).
Proof.
intros. destruct H0. destruct H1. destruct H2. destruct H3. assert (forall z0:Set,contain z0
(Set_of_Prop_Function (fun z=>exists x:Set,contain x O/\z=Complement_Set x X))<->exists x:Set,
contain x O/\z0=Complement_Set x X). intro. apply Well_Defined_Set_of_Prop_Function. exists
(Power_Set X). intros. destruct H5. destruct H5. apply Well_Defined_Power_Set. intro. intro.
rewrite -> H6 in H7. apply Well_Defined_Complement_Set in H7. destruct H7. apply H7. split.
intro. intro. apply H5 in H6. destruct H6. destruct H6. apply Well_Defined_Power_Set. intro.
intro. rewrite -> H7 in H8. apply Well_Defined_Complement_Set in H8. destruct H8. apply H8.
split. apply H5. exists X. split. apply H2. apply Complement_Set_Law_2. split. apply H5.
exists _0. split. apply H1. apply Complement_Set_Law_3. split. intros. apply H5. destruct H6.
apply H5 in H6. apply H5 in H7. exists (Complement_Set (Double_Meet_Set x y) X). destruct H6.
destruct H6. destruct H7. destruct H7. split. rewrite <- De_Morgans_Law_1. apply H3. split.
rewrite -> H8. rewrite -> Complement_Set_Law_4. apply H6. apply Well_Defined_Power_Set.
apply H0. apply H6. rewrite -> H9. rewrite -> Complement_Set_Law_4. apply H7. apply
Well_Defined_Power_Set. apply H0. apply H7. rewrite -> Complement_Set_Law_4. split. intro.
intro. apply Contain_of_Double_Meet_Set in H10. destruct H10. rewrite -> H8 in H10. apply
Well_Defined_Complement_Set in H10. destruct H10. apply H10. intros. apply H5.

exists
(Complement_Set (Union_Set x) X). split. rewrite -> De_Morgans_Law_3. apply H4. apply
Empty_Set_Law_1. apply Empty_Set_Law_1 in H. destruct H. exists (Complement_Set x0 X). apply
Well_Defined_Set_of_Prop_Function. exists (Power_Set X). intros. destruct H7. destruct H7.
apply Well_Defined_Power_Set. intro. intro. rewrite -> H7 in H9. apply
Well_Defined_Complement_Set in H9. destruct H9. apply H9.

exists x0. split. split.

destruct Sekai_no_Ssinri. destruct Sekai_no_Ssinri. destruct Sekai_no_Ssinri. destruct
Sekai_no_Ssinri.
Qed.



(*選択公理と同値な命題*)
Definition Axiom_of_Choice:=forall a:Set,
(forall x:Set,contain x a->exists w,contain w x)->
(forall x y z:Set,contain x a->contain y a->contain z x->contain z y->x=y)->
(exists c,forall x:Set,contain x a->exists! y,(contain y c/\contain y x)).



(**)
(*工事中*)




(*写像の合成*)





(*群論*)
(*二項演算*)
Definition Binary_Oparation(f X:Set):=contain f (Map_Set (Double_Direct_Product X X) X).
(*結合律*)
Definition Associative_Property(f X:Set):=(Binary_Oparation f X)/\(forall x y z:Set,
Map_Assignment x (Map_Assignment y z)=Map_Assignment (Map_Assignment x y) z).
(*単位元*)
Definition Exists_of_Identify_Element(f X:Set):=exists e:Set,contain e X/\forall x:Set,
Map_Assignment f (Ordered_Pair e x)=x/\Map_Assignment f (Ordered_Pair x e)=x.
Theorem Uniqueness_of_Identify_Element_1:forall f X:Set,forall e0 e1:Set,
(((forall x0:Set,Map_Assignment f (Ordered_Pair e0 x0)=x0/\Map_Assignment f (Ordered_Pair
x0 e0)=x0)/\(forall x1:Set,Map_Assignment f (Ordered_Pair e1 x1)=x1/\Map_Assignment f
(Ordered_Pair x1 e1)=x1))->e0=e1).
Proof.
intros. destruct H. specialize (H e1). specialize (H0 e0). destruct H. destruct H0.
rewrite -> H2 in H. apply H.
Qed.
Definition Identify_Element(f X:Set):=Well_Defined (fun e=>contain e X/\forall x:Set,
Map_Assignment f (Ordered_Pair e x)=x/\Map_Assignment f (Ordered_Pair x e)=x).
Theorem Identify_Element_Operation:forall f X:Set,forall x:Set,(Map_Assignment f
(Ordered_Pair (Identify_Element f X) x)=x/\Map_Assignment f (Ordered_Pair x (Identify_Element
f X))=x).
Proof.
intros. split.
Qed.
Theorem Uniqueness_of_Identify_Element_3:forall f X:Set,forall e:Set,
(forall x:Set,Map_Assignment f (Ordered_Pair e x)=x/\Map_Assignment f (Ordered_Pair x e)=x)
<->e=Identify_Element f X.
Proof.
intros. split. intro. assert (forall x : Set,Map_Assignment f (Ordered_Pair e x)=x/\
Map_Assignment f (Ordered_Pair x e) = x). apply H. specialize (H0 e). specialize (H
(Identify_Element f X)). destruct H. destruct H0.
Qed.
(*逆元の存在*)
Definition Exists_of_Inverse_Element(f X:Set):=forall x:Set,contain x X->exists x0:Set,
contain x0 X/\Map_Assignment f (Ordered_Pair x0 x)=x/\Map_Assignment f (Ordered_Pair x x0)=x.
Theorem new_theorem : .
Proof.
Qed.
Definition Inverse_Element(f X x:Set):=Well_Defined (fun y=>contain y X/\Map_Assignment f
(Ordered_Pair y x)=Identify_Element f X/\Map_Assignment f (Ordered_Pair x y)=
Identify_Element f X).
(*群の定義*)
Definition Group(f X:Set):=Associative_Property f X/\Exists_of_Identify_Element f X/\
Exists_of_Inverse_Element f X.
(*群における単位元の一意性*)
Theorem Well_Defined_Inverse_Identify_Element:forall f X:Set,Group f X->forall x y:Set,
(forall z0:Set,Map_Assignment f (Ordered_Pair x z0)=z0/\Map_Assignment f (Ordered_Pair z0
x)=z0)/\(forall z1:Set,Map_Assignment f (Ordered_Pair x z1)=z1/\forall z1:Set,
Map_Assignment f (Ordered_Pair z1 x)=z1).
Proof.

Qed.
(*群における逆元の一意性*)
Theorem Well_Defined_Inverse_Element:forall f X x:Set,(Group f X/\contain x X)->exists! y:Set,
y=Inverse_Element f X.
Proof.

Qed.




(*これ何？*)
Axiom Axiom_Schema_of_Replacement:forall p :Set -> Set -> Prop,forall x y z:Set,((p x y/\
p x z)->y=z)->forall X:Set,exists A:Set,forall y:Set,((contain y A)<->exists x:Set,p x y).




(*写像の基本定理*)
Theorem Map_Law_1:forall f X Y:Set,contain f (Map_Set X Y)->(forall x:Set,contain x X->exists!
y:Set,contain y Y/\y=(Map_Assignment f x)).
Proof.
intros. apply Well_Defined_Map_Set in H. destruct H. apply H1 in H0. destruct H0. unfold
unique in H0. exists x0. unfold unique. destruct H0. split. split.
Qed.



(*包含関係の順序的な次*)
Definition Ordinal_Next(x:Set):=Double_Union_Set x (One_Point_Set x).
Theorem Well_Defined_Union_Set_Ordinal_Next:forall x:Set,exists! y:Set,y=Ordinal_Next x.
Proof.
intro. unfold Ordinal_Next. exists (Double_Union_Set x (One_Point_Set x)). split. split.
intros. symmetry in H. apply H.
Qed.
(*無限集合*)
Axiom Axiom_of_Infinity:exists x : Set, contain Empty_set x /\ forall y : Set, contain y x
-> contain (Ordinal_Next y) x.