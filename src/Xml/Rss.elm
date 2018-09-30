----------------------------------------------------------------------
--
-- Rss.elm
-- Decode RSS into Elm
-- Copyright (c) 2018 Bill St. Clair <billstclair@gmail.com>
-- Some rights reserved.
-- Distributed under the MIT License
-- See LICENSE
--
----------------------------------------------------------------------


module Xml.Rss exposing
    ( Rss, RssEntry
    , stringToRss, xmlToRss
    )

{-| Parse Rss into Elm.

Simple translation of [github.com/billstclair/lisplog/src/rss-reader.lisp](https://github.com/billstclair/Lisplog/blob/master/src/rss-reader.lisp) from Lisp to Elm.

This currently groks two formats:

1.  Atom: e.g. [www.antipope.org/charlie/blog-static/atom.xml](http://www.antipope.org/charlie/blog-static/atom.xml)
2.  Simple RSS: e.g. [lisplog.org/rss.xml](https://lisplog.org/rss.xml)


# Types

@docs Rss, RssEntry


# Functions

@docs stringToRss, xmlToRss

-}

import Time exposing (Posix)
import Xml
import Xml.Decode as XD


type alias Rss =
    { feedLink : String
    , title : String
    , link : Maybe String
    , base : Maybe String
    , updatedTime : Maybe Posix
    , subtitle : Maybe String
    , editor : Maybe String
    , image : Maybe String
    , entries : List RssEntry
    , rawParse : Maybe Xml.Value
    }


type alias RssEntry =
    { title : Maybe String
    , link : Maybe String
    , id : Maybe String
    , publishedTime : Maybe Posix
    , pulishedTimeString : Maybe String
    , updatedTime : Maybe Posix
    , summary : Maybe String
    , author : Maybe String
    , authorUri : Maybe String
    , content : String
    }


{-| TODO
-}
stringToRss : String -> Result String Rss
stringToRss string =
    Err "TODO"


{-| TODO
-}
xmlToRss : String -> Xml.Value -> Rss
xmlToRss feedLink xml =
    { feedLink = feedLink
    , title = ""
    , link = Nothing
    , base = Nothing
    , updatedTime = Nothing
    , subtitle = Nothing
    , editor = Nothing
    , image = Nothing
    , entries = []
    , rawParse = Nothing
    }
