:- module(server,
    [ start_server/1,
      stop_server/0
    ]).

:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_json)).
:- use_module(library(http/http_parameters)).
:- use_module('../rank_lucian').

:- dynamic server_port/1.

:- http_handler(root(api/advice), advice_handler, []).

start_server(Port) :-
    http_server(http_dispatch, [port(Port)]),
    asserta(server_port(Port)).

stop_server :-
    retract(server_port(Port)),
    http_stop_server(Port, []).

advice_handler(Request) :-
    http_parameters(Request, [problem(Problem, [string])]),
    rank_lucian:rank_lucian(Problem, Advice),
    reply_json_dict(_{problem: Problem, advice: Advice}).
