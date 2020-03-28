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

def draw_rcbox(expr o) (expr size) (expr scale, rr) =
    path rcb;
    rcb := def_rcbox(rr);

    draw rcb scaled scale scaled size shifted (o scaled size);

    if oom.debug:
        for i := 0 upto 7:
            drawdot p[i] scaled .5
                scale scaled size
                shifted (o scaled size)
                withpen pencircle scaled 3pt;
        endfor;
    fi;
enddef;
