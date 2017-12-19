
(* Copyright (C) 2015-2016 Bloomberg Finance L.P.
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)

external describe : string -> (unit -> unit) -> unit = "describe"
    [@@bs.val]

external it : string -> (unit -> unit) -> unit = "it"
    [@@bs.val]

external eq : 'a -> 'a -> unit = "deepEqual"
    [@@bs.val]
    [@@bs.module "assert"]

external neq : 'a -> 'a -> unit = "notDeepEqual"
    [@@bs.val]
    [@@bs.module "assert"]

external ok : Js.boolean -> unit = "ok"
    [@@bs.val]
    [@@bs.module "assert"]

external fail : 'a -> 'a -> string Js.undefined -> string -> unit = "fail"
    [@@bs.val]
    [@@bs.module "assert"]


external dump : 'a array -> unit = "console.log" [@@bs.val ] [@@bs.splice]
external throws : (unit -> unit) -> unit = "throws" [@@bs.val] [@@bs.module "assert"]
(** There is a problem --
    it does not return [unit ]
 *)

let assert_equal = eq
let assert_notequal = neq
let assert_ok = fun a -> ok (Js.Boolean.to_js_boolean a)
let assert_fail = fun msg -> fail () () (Js.Undefined.return msg) ""
(* assert -- raises an AssertionError which mocha handls better
*)
let from_suites name (suite :  (string * ('a -> unit)) list) =
    describe name (fun () ->
        List.iter (fun (name, code) -> it name code) suite)

type eq =
  | Eq :  'a *'a  -> eq
  | Neq : 'a * 'a -> eq
  | Ok : bool -> eq
  | Approx : float * float -> eq
  | ApproxThreshold : float * float * float -> eq
  | ThrowAny : (unit -> unit) -> eq
  | Fail : unit -> eq
  | FailWith : string -> eq
  (* TODO: | Exception : exn -> (unit -> unit) -> _ eq  *)

type  pair_suites = (string * (unit ->  eq)) list

let close_enough ?(threshold=0.0000001 (* epsilon_float *)) a b =
  abs_float (a -. b) < threshold

let from_pair_suites name (suites :  pair_suites) =
  describe name (fun () ->
      suites |>
      List.iter (fun (name, code) ->
          it name (fun _ ->
              match code () with
              | Eq(a,b) -> assert_equal a b
              | Neq(a,b) -> assert_notequal a b
              | Ok(a) -> assert_ok a
              | Approx(a, b) ->
                if not (close_enough a b) then assert_equal a b (* assert_equal gives better ouput *)
              | ApproxThreshold(t, a, b) ->
                if not (close_enough ~threshold:t a b) then assert_equal a b (* assert_equal gives better ouput *)
              | ThrowAny fn -> throws fn
              | Fail _ -> assert_fail "failed"
              | FailWith msg -> assert_fail msg
            )
        )
    )
