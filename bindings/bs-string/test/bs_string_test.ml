

let suites :  Bs_mocha.pair_suites ref  = ref []
let test_id = ref 0
let eq loc (x, y) = 
  incr test_id ; 
  suites := 
    (loc ^" id " ^ (string_of_int !test_id), (fun [@bs] () -> Bs_mocha.Eq(x,y))) :: !suites



let ()  = 
  begin
    eq __LOC__  (Bs_string.slice "hihi" 2, "hi"); 
    eq __LOC__ (
      Bs_string.split "  The quick brown fox jumps over the lazy dog. "
         [%bs.re {|/\s+/|}],
       [| "";
         "The";
         "quick";
         "brown";
         "fox";
         "jumps";
         "over";
         "the";
         "lazy";
         "dog.";
         "" |]
      )
  end

 
let () = 
  Bs_mocha.from_pair_suites __FILE__ !suites
