-ifndef(_gossiperl_client_records_included).
-define(_gossiperl_client_records_included, yeah).

-include_lib("../../gossiperl_core/include/gossiperl_types.hrl").

-record(clientNames, {
          client :: atom(),
          fsm :: atom(),
          messaging :: atom(),
          encryption :: atom() }).

-record(clientConfig, {
          overlay :: atom(),
          name :: binary(),
          port :: integer(),
          secret :: binary(),
          symmetric_key :: binary(),
          overlay_port :: integer(),
          socket :: pid(),
          names :: #clientNames{},
          listener :: atom(),
          thrift_window_size :: integer() }).

-define(CONFIG_ETS, ets_gossiperl_client_configuration).
-define(AES_PAD(Bin), <<Bin/binary, 0:(( 32 - ( byte_size(Bin) rem 32 ) ) *8 )>>).

-define(FSM(Config), Config#clientConfig.names#clientNames.fsm).
-define(CLIENT(Config), Config#clientConfig.names#clientNames.client).
-define(MESSAGING(Config), Config#clientConfig.names#clientNames.messaging).
-define(ENCRYPTION(Config), Config#clientConfig.names#clientNames.encryption).

-define(MEMBER( AtomName, Module, Config ), { AtomName, { Module, start_link, [ Config ]}, permanent, brutal_kill, supervisor, [] }).

-endif.
