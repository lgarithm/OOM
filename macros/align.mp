% move center of picture p to origin
def center_to_origin(expr p) =
    p shifted (-center bbox(p))
enddef;

% move lower left of picture p to origin
def ll_to_origin(expr p) =
    p shifted (-llcorner bbox(p))
enddef;

% move middle left of picture p to origin
def ml_to_origin(expr p) =
    p shifted (-.5 [llcorner bbox(p), ulcorner bbox(p)])
enddef;

def draw_lefg_right(expr l, r) =
    wl := arclength(llcorner bbox(l) -- lrcorner bbox(l));
    wr := arclength(llcorner bbox(r) -- lrcorner bbox(r));

    picture cl, cr;
    cl := center_to_origin(l);
    cr := center_to_origin(r);

    w_mean := (wl + wr) * 0.5 + 20mm;

    draw_picture(cl, left * w_mean * .5);
    draw_picture(cr, right * w_mean * .5);
enddef;
