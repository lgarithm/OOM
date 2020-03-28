def def_list(suffix ls) (text type) =
  numeric ls.n;
  ls.n := 0;
  type ls[];
enddef;

def add_to_list(suffix ls) (expr e) =
  ls[incr(ls.n)] := e;
enddef;

def append_to_list(suffix ls, ap) (text f) =
  for i := 1 upto ap.n:
    add_to_list(ls, f(ap[i]));
  endfor;
enddef;
