port module RenderDemo exposing (..)

import Task
import Html exposing (..)
import Html.App as App
import Html.Events exposing (..)
import Html.Attributes exposing (..)

type alias CellID = Int

type Msg
  = Push
  | Pop

type alias Model =
  { cells : List CellID
  }

init : (Model, Cmd Msg)
init =
  ({ cells = []
  }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update message ({cells} as model) =
  case message of

    Push ->
      let
        uid = List.length cells
      in
      ({ model
        | cells = [uid] ++ cells
      }, onCellAdded uid)

    Pop ->
      case cells of
          [] -> (model, Cmd.none)
          _ :: cells -> ({ model | cells = cells }, Cmd.none)

port onCellAdded : CellID -> Cmd msg

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch []

view : Model -> Html Msg
view model =
  let
    remove =
      button [ onClick Pop ] [ text "Pop" ]

    insert =
      button [ onClick Push ] [ text "Push" ]

    cells =
      List.map viewCell (List.reverse model.cells)
  in
    div [] ([remove, insert] ++ cells)

viewCell : CellID -> Html Msg
viewCell cellID =
    div [id ("cell:" ++ toString cellID)] [ text ("Here I am: " ++ toString cellID) ]

main =
    App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }
