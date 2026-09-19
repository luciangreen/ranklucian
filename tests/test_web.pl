:- begin_tests(web).
:- use_module('../src/chatbot').

test(chatbot_menu_has_actions) :-
    chatbot:chatbot_menu(Menu),
    member('Solve problem', Menu),
    member('Queen Bug analysis', Menu).

:- end_tests(web).
