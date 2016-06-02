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

[@@@bs.config{non_export = true; obj_type_auto_uncurry = true}]

let port = 3000
let hostname = "127.0.0.1"
let create_server  http = 
  let server = http##createServer (fun [@uncurry]  (req,  resp)  -> 
      resp##statusCode_set 200;
      resp##setHeader("Content-Type", "text/plain");
      resp##end_ "Hello world\n"
    )
  in
  server##listen(port, hostname,  fun [@uncurry] () -> 
      Js.log ("Server running at http://"^ hostname ^ ":" ^ string_of_int port ^ "/")
    ) 

type req 

type resp =  <
   statusCode_set : int -> unit  ;
   setHeader : string * string -> unit ;
   end_ : string ->  unit 
> [@bs.obj] 

type server =  <
   listen : int * string *  (unit -> unit) -> unit 
> [@bs.obj] 



type http = <
   createServer : (req  * resp  -> unit ) ->  server
> [@bs.obj] 


external http : http  = "http"  [@@bs.val_of_module ]


let () = 
  create_server http



(* local variables: *)
(* compile-command: "./node_modules/bs-platform/bin/bsc -c test_http_server.ml" *)
(* end: *)
