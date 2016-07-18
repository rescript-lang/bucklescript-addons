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

[@@@bs.config{no_export}]

let first_line = ref true 

let rl = Bs_readline.createInterface 
    (Bs_readline.from_options 
       ~input:Bs_process.process##stdin
       ~output:Bs_process.process##stdout
       ~terminal:Js.false_ ())


external on_line : Bs_readline.t ->  string -> (string -> unit [@bs]) -> unit = "on"[@@bs.send]
external on_close : Bs_readline.t -> string -> (unit -> unit [@bs] ) -> unit = "on" [@@bs.send]
let on_line rl cb = on_line rl  "line" cb 
let on_close rl cb = on_close rl "close" cb

let a_char_code = Char.code 'A'
let zero_char_code = Char.code '0'
let process str = 
  let digits = 
    Bs_array.map (Bs_string.split_by_string str "")
      (fun[@bs] x -> 
         let v = Bs_string.charCodeAt x 0 in 
         if v >= a_char_code then v - a_char_code + 10 + 1
         else 
           v - zero_char_code + 1 )
  in 
  Bs_array.reduce digits (fun[@bs] acc a -> Bs_math.max_int acc a ) 1 

let lines : string Bs_array.t = [||]

let process_lines lines = 
  match lines with 
  | [| firstline; secondline|]
    -> let a , b = process firstline , process secondline in 
    let first = (Bs_nativeint.parseInt firstline a) in
    let second = ( Bs_nativeint.parseInt secondline b) in
    (* Js.log (first, second) *)
    (* Js.log ( Nativeint.add first second   ) *)
    ignore (Bs_process.process##stdout##write (Bs_string.of_any ( Nativeint.add first second   )))
  | _ ->  assert false 
let () = 
  on_line rl begin fun [@bs] line -> 
    ignore (Bs_array.push lines line)
  end;
  on_close rl begin fun [@bs] () -> 
    process_lines lines
  end

(*
let () = 
  Bs_readline.on_line rl begin fun [@bs] line -> 
      if !first_line then 
        first_line:= false 
      else
        begin 
          Js.log line;
          Js.log 42
        end
  end;
  Bs_readline.on_close rl begin fun[@bs] () -> 
    Bs_process.exit 0 
  end
*)

(* local variables: *)
(* compile-command: "npm --no-color run build" *)
(* end: *)
