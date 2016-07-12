type  +'a t
val empty: 'a  t
val is_empty: 'a t -> bool
val mem:  string -> 'a t -> bool
val add: string -> 'a -> 'a t -> 'a t
val singleton: string -> 'a -> 'a t
val remove: string -> 'a t -> 'a t
val merge:
  (string -> 'a option -> 'b option -> 'c option [@bs]) -> 'a t -> 'b t -> 'c t
val compare: ('a -> 'a -> int [@bs]) -> 'a t -> 'a t -> int
val equal: ('a -> 'a -> bool [@bs]) -> 'a t -> 'a t -> bool
val iter: (string -> 'a -> unit [@bs]) -> 'a t -> unit
val fold: (string -> 'a -> 'b -> 'b [@bs]) -> 'a t -> 'b -> 'b
val for_all: (string -> 'a -> bool [@bs]) -> 'a t -> bool
val exists: (string -> 'a -> bool [@bs]) -> 'a t -> bool
val filter: (string -> 'a -> bool [@bs]) -> 'a t -> 'a t
val partition: (string -> 'a -> bool [@bs]) -> 'a t -> 'a t * 'a t
val cardinal: 'a t -> int
val bindings: 'a t -> (string * 'a) list
val min_binding: 'a t -> (string * 'a)
val max_binding: 'a t -> (string * 'a)
val choose: 'a t -> (string * 'a)
val split: string -> 'a t -> 'a t * 'a option * 'a t
val find: string -> 'a t -> 'a
val map: ('a -> 'b [@bs])  -> 'a t -> 'b t
val mapi: (string -> 'a -> 'b [@bs]) -> 'a t -> 'b t
