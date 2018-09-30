module Main exposing (main)

import Browser
import Cmd.Extra exposing (withCmd, withCmds, withNoCmd)
import Html exposing (Html, button, div, input, p, pre, span, text)
import Html.Attributes exposing (size, style, value)
import Html.Events exposing (onClick, onInput)
import Http
import Json.Encode as JE
import Task
import Xml
import Xml.Decode as Decode


type alias Model =
    { error : Maybe String
    , url : String
    , text : String
    , xml : Maybe Xml.Value
    }


init : ( Model, Cmd Msg )
init =
    { error = Nothing
    , url = "lisplog.xml"
    , text = ""
    , xml = Nothing
    }
        |> withCmd
            (Task.perform (\_ -> FetchUrl) <|
                Task.succeed ()
            )


type Msg
    = SetUrl String
    | FetchUrl
    | SetAndFetch String
    | ReceiveText (Result Http.Error String)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SetUrl url ->
            { model | url = url } |> withNoCmd

        FetchUrl ->
            { model | error = Nothing }
                |> withCmd
                    (Http.send ReceiveText <| Http.getString model.url)

        SetAndFetch url ->
            update FetchUrl { model | url = url }

        ReceiveText result ->
            case result of
                Err err ->
                    { model
                        | error = Just <| Debug.toString err
                        , text = ""
                        , xml = Nothing
                    }
                        |> withNoCmd

                Ok string ->
                    let
                        mdl =
                            { model | text = string }
                    in
                    case Decode.decode string of
                        Ok xml ->
                            { mdl | xml = Just xml } |> withNoCmd

                        Err err ->
                            { mdl
                                | xml = Nothing
                                , error = Just err
                            }
                                |> withNoCmd


b : String -> Html msg
b string =
    Html.b [] [ text string ]


br : Html msg
br =
    Html.br [] []


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ b "Url: "
            , input
                [ value model.url
                , onInput SetUrl
                , size 40
                ]
                []
            , text " "
            , button
                [ onClick FetchUrl ]
                [ text "Fetch" ]
            , br
            , span [ style "margin-left" "2em" ]
                [ button [ onClick <| SetAndFetch "lisplog.xml" ]
                    [ text "lisplog.xml" ]
                , text " "
                , button [ onClick <| SetAndFetch "antipope.xml" ]
                    [ text "antipope.xml" ]
                ]
            ]
        , case model.xml of
            Nothing ->
                text ""

            Just xml ->
                let
                    json =
                        Xml.xmlToJson xml
                in
                p []
                    [ b "XML:"
                    , br
                    , pre []
                        [ text <| JE.encode 2 json ]
                    ]
        , p []
            [ b "Text:"
            , br
            , pre []
                [ text model.text ]
            ]
        ]


main =
    Browser.element
        { init = \() -> init
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
