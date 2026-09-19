:- module(thought_extract,
    [ extract_thoughts/2
    ]).

extract_thoughts(Program, Thoughts) :-
    text_from_program(Program, Text),
    findall(T, inferred_thought(Text, T), Ts),
    sort(Ts, Thoughts).

text_from_program(Program, Text) :-
    (   string(Program) -> Text = Program
    ;   atom(Program) -> atom_string(Program, Text)
    ;   term_string(Program, Text)
    ).

inferred_thought(Text, thought(run_decomposition, category(performance), problem(run_length_encoding), idea(consume_one_run_at_a_time), conditions([sequential_input, adjacent_equal_items]), effects([single_pass, reduced_intermediate_structures]))) :-
    sub_string(Text, _, _, _, "clump").
inferred_thought(Text, thought(accumulator_counting, category(performance), problem(run_length_encoding), idea(carry_local_count_in_accumulator), conditions([tail_scan]), effects([tail_recursive_inner_loop]))) :-
    sub_string(Text, _, _, _, "ccount").
inferred_thought(Text, thought(return_unprocessed_suffix, category(structure), problem(run_length_encoding), idea(return_remaining_suffix_after_prefix_consumption), conditions([processed_prefix]), effects([clean_outer_recursion]))) :-
    sub_string(Text, _, _, _, "T1").
inferred_thought(Text, thought(tail_recursive_inner_loop, category(termination), problem(local_scan), idea(use_tail_recursive_inner_loop), conditions([linear_scan]), effects([stack_stability]))) :-
    sub_string(Text, _, _, _, "|T").
