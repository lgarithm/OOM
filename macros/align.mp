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

% move middle right of picture p to origin
def mr_to_origin(expr p) =
    p shifted (-.5 [lrcorner bbox(p), urcorner bbox(p)])
enddef;

def draw_picture(expr p, o) =
    draw p shifted o;
    % draw bbox(p) shifted o;
enddef;

def draw_left_right_with_gap(expr l, r, gap) =
    wl := arclength(llcorner bbox(l) -- lrcorner bbox(l));
    wr := arclength(llcorner bbox(r) -- lrcorner bbox(r));

    picture cl, cr;
    cl := center_to_origin(l);
    cr := center_to_origin(r);

    w_mean := (wl + wr) * 0.5 + gap;

    draw_picture(cl, left * w_mean * .5);
    draw_picture(cr, right * w_mean * .5);
enddef;

def draw_top_down_with_gap(expr t, d, gap) =
    height_top := arclength(llcorner bbox(t) -- ulcorner bbox(t));
    height_down := arclength(llcorner bbox(d) -- ulcorner bbox(d));

    picture ct, cd;
    ct := center_to_origin(t);
    cd := center_to_origin(d);

    h_mean := (height_top + height_down) * 0.5 + gap;

    draw_picture(ct, up * h_mean * .5);
    draw_picture(cd, down * h_mean * .5);
enddef;

def draw_left_right(expr l, r) =
    draw_left_right_with_gap(l, r, 20mm);
enddef;
