def def_list(suffix ls) (text type) =
  numeric ls.n;
  ls.n := 0;
  type ls[];
enddef;

def list_len(suffix ls) =
  ls.n
enddef;

% todo rename the following APIs to conform the form list_xxx

def add_to_list(suffix ls) (expr e) =
  ls[incr(ls.n)] := e;
enddef;

def append_to_list(suffix ls, ap) (text f) =
  for i := 1 upto ap.n:
    add_to_list(ls, f(ap[i]));
  endfor;
enddef;

def fill_list(suffix ls) (expr l, x) =
  ls.n := 0;
  for i := 1 upto l:
    add_to_list(ls, x);
  endfor;
enddef;
