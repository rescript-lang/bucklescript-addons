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
