


let re = [%bs.re {|/quick\s(brown).+?(jumps)/ig|} ]

let result = Bs_re.exec "The Quick Brown Fox Jumps Over The Lazy Dog"

let () = 
  match Js.Null.to_opt result with 
  | None -> assert false 
  | Some output -> 
    (Bs_re.out_values output = 
    [|"Quick Brown Fox Jumps";
      "Brown";
      "Jumps"
    |],
     Bs_re.out_index output = 4)     
