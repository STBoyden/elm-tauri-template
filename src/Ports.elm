port module Ports exposing (..)

import Json.Encode as E


type alias FunctionArgs =
    { name : String, args : E.Value }


port invokeFunction : FunctionArgs -> Cmd msg


port addMessage : (String -> msg) -> Sub msg
