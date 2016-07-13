

let v = 
  String_map.(
    empty 
    |> add "3" 3
    |> add "1" 1 )

;;Bs_mocha.from_pair_suites __FILE__
  [ __LOC__, begin fun [@bs] () -> Bs_mocha.Eq (String_map.find "3" v,  3)  end]
