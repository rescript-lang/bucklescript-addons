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


(* 'res - type the promise will be resolved with
   'rej - type the promise will be rejected with *)
type ('res, 'rej) t

external make : (('res -> unit) -> ('rej -> unit) -> unit) -> ('res, 'rej) t = "Promise" [@@bs.new]
external create : (('res -> unit [@bs]) -> ('rej -> unit [@bs]) -> unit [@bs]) -> ('res, 'rej) t = "Promise" [@@bs.new]
[@@ocaml.deprecated "Please use `make` instead"]

external resolve : 'res -> ('res, 'a) t = "Promise.resolve" [@@bs.val]
external reject : 'rej -> ('a, 'rej) t = "Promise.reject" [@@bs.val]
external all : ('res, 'rej) t array -> ('res array, 'rej) t = "Promise.all" [@@bs.val]
external race : ('res, 'rej) t array -> ('res, 'rej) t = "Promise.race" [@@bs.val]

external then_ : ('res -> 'a) -> ('a, 'b) t = "then" [@@bs.send.pipe: ('res, 'rej') t]
external thenValue : ('res, 'rej) t -> ('res -> 'a [@bs]) -> ('a, 'b) t = "then" [@@bs.send]
[@@ocaml.deprecated "Please use `then_` instead"]
external (>>|): ('res, 'rej) t -> ('res -> 'a [@bs]) -> ('a, 'b) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `then_` instead"]
external andThen : ('res -> ('a, 'b) t) -> ('a, 'b) t = "then" [@@bs.send.pipe: ('res, 'rej) t]
external (>>=) : ('res, 'rej) t -> ('res -> ('a, 'b) t [@bs]) -> ('a, 'b) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `andThen` instead"]
external thenWithError : ('res, 'rej) t -> ('res -> 'a [@bs]) -> ('rej -> 'b [@bs]) -> ('a, 'b) t = "then" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use a combination of `then_` and `catch` instead"]

external catch : ('rej -> unit) -> ('a, 'b) t = "catch" [@@bs.send.pipe: ('res, 'rej) t]
external (>>?) : ('res, 'rej) t -> ('rej -> 'a [@bs]) -> ('a, 'b) t = "catch" [@@bs.send]
[@@ocaml.deprecated "Obscure operators are discouraged. Please use `or_` instead"]
external or_ : ('rej -> 'a) -> ('a, 'b) t = "catch" [@@bs.send.pipe: ('res, 'rej) t]
external orElse : ('rej -> ('a, 'b) t) -> ('a, 'b) t = "catch" [@@bs.send.pipe: ('res, 'rej) t]
