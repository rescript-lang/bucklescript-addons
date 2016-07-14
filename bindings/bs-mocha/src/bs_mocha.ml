
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



external describe : string -> (unit -> unit[@bs]) -> unit = 
  "describe" [@@bs.call]

external it : string -> (unit -> unit [@bs]) -> unit = 
  "it" [@@bs.call ]

external eq : 'a -> 'a -> unit = "deepEqual"
    [@@bs.call ]
    [@@bs.module "assert"]

external neq : 'a -> 'a -> unit = "notDeepEqual"
    [@@bs.call ]
    [@@bs.module "assert"]



external dump : 'a array -> unit = "console.log" 
    [@@bs.call ] 
    [@@bs.splice]

external throws : (unit -> unit [@bs]) 
  -> unit = "throws" [@@bs.call] [@@bs.module "assert"]

let assert_equal = eq 
let assert_notequal = neq
(* assert -- raises an AssertionError which mocha handls better
*)
let from_suites name (suite :  (string * (unit ->  unit [@bs])) list) = 
  describe name (fun [@bs]() -> 
      List.iter (fun (name, code) -> it name code) suite)

type eq = 
  | Eq :  'a *'a  ->  eq
  | Neq : 'a * 'a ->  eq
  | Approx : float * float ->  eq  
  | ThrowAny : (unit -> unit [@bs]) ->  eq
  (* TODO: | Exception : exn -> (unit -> unit) -> _ eq  *)

type  pair_suites = (string * (unit ->  eq [@bs])) list

let close_enough x y = 
  abs_float (x -. y) < (* epsilon_float *) 0.0000001

let from_pair_suites name (suites :  pair_suites) = 
  describe name (fun [@bs] () -> 
      suites |> 
      List.iter (fun (name, code) -> 
          it name (fun [@bs] () -> 
              match code () [@bs] with 
              | Eq(a,b) -> assert_equal a b 
              | Neq(a,b) -> assert_notequal a b 
              | Approx(a,b) 
                -> 
                assert (close_enough a b)
              | ThrowAny fn -> throws fn 
            )
        ) 
    ) 

