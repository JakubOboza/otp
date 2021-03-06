%%
%% %CopyrightBegin%
%%
%% Copyright Ericsson AB 2002-2010. All Rights Reserved.
%%
%% The contents of this file are subject to the Erlang Public License,
%% Version 1.1, (the "License"); you may not use this file except in
%% compliance with the License. You should have received a copy of the
%% Erlang Public License along with this software. If not, it can be
%% retrieved online at http://www.erlang.org/.
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and limitations
%% under the License.
%%
%% %CopyrightEnd%
%%
-module(dets_sup).

-behaviour(supervisor).

-export([start_link/0, init/1]).

-spec start_link() -> {'ok', pid()} | 'ignore' | {'error', term()}.

start_link() ->
    supervisor:start_link({local, dets_sup}, dets_sup, []).

-spec init([]) ->
        {'ok', {{'simple_one_for_one', 4, 3600},
		[{'dets', {'dets', 'istart_link', []},
		  'temporary', 30000, 'worker', ['dets']}]}}.

init([]) ->
    SupFlags = {simple_one_for_one, 4, 3600},
    Child = {dets, {dets, istart_link, []}, temporary, 30000, worker, [dets]},
    {ok, {SupFlags, [Child]}}.
