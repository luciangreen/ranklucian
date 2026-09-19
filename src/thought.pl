:- module(thought,
    [ thought_signature/1,
      thought_name/2,
      thought_problem/2,
      thought_conditions/2,
      thought_effects/2
    ]).

thought_signature(
    thought(_Name, category(_Category), problem(_Problem), idea(_Idea), conditions(_Conditions), effects(_Effects))
).

thought_name(thought(Name, _, _, _, _, _), Name).
thought_problem(thought(_, _, problem(Problem), _, _, _), Problem).
thought_conditions(thought(_, _, _, _, conditions(Conditions), _), Conditions).
thought_effects(thought(_, _, _, _, _, effects(Effects)), Effects).
