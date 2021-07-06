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
