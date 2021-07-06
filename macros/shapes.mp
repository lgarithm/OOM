path ubox;
ubox := unitsquare shifted (-.5, -.5);

def def_rcbox(expr rr) =
    begingroup
    pair p[];
    p[0] := left + (1 - rr) * up;
    p[1] := (1 - rr) * left + up;
    p[2] := (1 - rr) * right + up;
    p[3] := right + (1 - rr) * up;
    p[4] := right + (1 - rr) * down;
    p[5] := (1 - rr) * right + down;
    p[6] := (1 - rr) * left + down;
    p[7] := left + (1 - rr) * down;

    (
        p[0] .. rr [left + up, dir(135)] .. p[1] --
        p[2] .. rr [right + up, dir(45)] .. p[3] --
        p[4] .. rr [right + down, dir(-45)] .. p[5] --
        p[6] .. rr [left + down, dir(-135)] .. p[7] --
    cycle) scaled .5
    endgroup;
enddef;

path diamond;
diamond := (up -- left -- down -- right --cycle) scaled .5;
