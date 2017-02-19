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

open Bs_promise

let assert_bool b loc =
  if b then ()
  else
    print_endline ("Assertion Failure. " ^ loc)

let fail loc =
  assert_bool false loc

let thenTest () =
  let p = resolve 4 in
  p |> then_ (fun [@bs] x -> assert_bool (x = 4) __LOC__)

let andThenTest () =
  let p = resolve 6 in
  p |> andThen (fun [@bs] _ -> resolve (12))
    |> then_ (fun [@bs] y -> assert_bool (y = 12) __LOC__)

let catchTest () =
  let p = reject "error" in
  p |> then_ (fun [@bs] _ -> fail __LOC__)
    |> catch (fun [@bs] error -> assert_bool (error = "error") __LOC__)

let orResolvedTest () =
  let p = resolve 42 in
  p |> or_ (fun [@bs] _ -> 22)
    |> then_ (fun [@bs] value -> assert_bool (value = 42) __LOC__)
    |> catch (fun [@bs] _ -> fail __LOC__)

let orRejectedTest () =
  let p = reject "error" in
  p |> or_ (fun [@bs] _ -> 22)
    |> then_ (fun [@bs] value -> assert_bool (value = 22) __LOC__)
    |> catch (fun [@bs] _ -> fail __LOC__)

let orElseResolvedTest () =
  let p = resolve 42 in
  p |> orElse (fun [@bs] _ -> resolve 22)
    |> then_ (fun [@bs] value -> assert_bool (value = 42) __LOC__)
    |> catch (fun [@bs] _ -> fail __LOC__)

let orElseRejectedResolveTest () =
  let p = reject "error" in
  p |> orElse (fun [@bs] _ -> resolve 22)
    |> then_ (fun [@bs] value -> assert_bool (value = 22) __LOC__)
    |> catch (fun [@bs] _ -> fail __LOC__)

let orElseRejectedRejectTest () =
  let p = reject "error" in
  p |> orElse (fun [@bs] _ -> reject "error 2")
    |> then_ (fun [@bs] _ -> fail __LOC__)
    |> catch (fun [@bs] error -> assert_bool (error = "error 2") __LOC__)

let resolveTest () =
  let p1 = resolve 10 in
  p1 |> then_ (fun [@bs] x -> assert_bool (x = 10) __LOC__)

let rejectTest () =
  let p = reject "error" in
  p |> catch (fun [@bs] error -> assert_bool (error = "error") __LOC__)

let thenCatchChainResolvedTest () =
  let p = resolve 20 in
  p |> then_ (fun [@bs] value -> assert_bool (value = 20) __LOC__ )
    |> catch (fun [@bs] _ -> fail __LOC__)

let thenCatchChainRejectedTest () =
  let p = reject "error" in
  p |> then_ (fun [@bs] _ -> fail __LOC__)
    |> catch (fun [@bs] error -> assert_bool (error = "error") __LOC__)

let allResolvedTest () =
  let p1 = resolve 1 in
  let p2 = resolve 2 in
  let p3 = resolve 3 in
  let promises = [| p1; p2; p3 |] in
  (all promises)
    |> then_
      (fun [@bs] resolved ->
        assert_bool (resolved.(0) = 1) __LOC__ ;
        assert_bool (resolved.(1) = 2) __LOC__ ;
        assert_bool (resolved.(2) = 3) __LOC__)

let allRejectTest () =
  let p1 = resolve 1 in
  let p2 = resolve 3 in
  let p3 = reject "error" in
  let promises = [| p1; p2; p3 |] in
  (all promises)
    |> then_ (fun [@bs] _ -> fail __LOC__)
    |> catch (fun [@bs] error -> assert_bool (error = "error") __LOC__)

let raceTest () =
  let p1 = resolve "first" in
  let p2 = resolve "second" in
  let p3 = resolve "third" in
  let promises = [| p1; p2; p3 |] in
  (race promises)
    |> then_ (fun [@bs] resolved -> assert_bool (resolved = "first") __LOC__)
    |> catch (fun [@bs] _ -> fail __LOC__)

let createPromiseRejectTest () =
  make (fun [@bs] _ reject -> reject "error" [@bs])
    |> catch (fun [@bs] error -> assert_bool (error = "error") __LOC__)

let createPromiseFulfillTest () =
  make (fun [@bs] resolve _ -> resolve "success" [@bs])
    |> then_ (fun [@bs] resolved -> assert_bool (resolved = "success") __LOC__)
    |> catch (fun [@bs] _ -> fail __LOC__)

let () =
  ignore @@ thenTest ();
  ignore @@ andThenTest ();
  ignore @@ catchTest ();
  ignore @@ orResolvedTest ();
  ignore @@ orRejectedTest ();
  ignore @@ orElseResolvedTest ();
  ignore @@ orElseRejectedResolveTest ();
  ignore @@ orElseRejectedRejectTest ();
  ignore @@ thenCatchChainResolvedTest ();
  ignore @@ thenCatchChainRejectedTest ();
  ignore @@ allResolvedTest ();
  ignore @@ allRejectTest ();
  ignore @@ raceTest ();
  ignore @@ createPromiseRejectTest ();
  ignore @@ createPromiseFulfillTest ();
