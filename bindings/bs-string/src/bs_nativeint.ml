

type t = nativeint 


external parseInt : string -> int -> t  = "parseInt" [@@bs.call]

(* local variables: *)
(* compile-command: "npm run postinstall" *)
(* end: *)
