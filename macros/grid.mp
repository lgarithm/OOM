def def_grid(suffix g) =
    pair g.pos;
    set_grid_pos(g, origin);

    color g.c;
    set_grid_color(g, green);

    numeric g.grid.scale;
    numeric g.m; % height
    numeric g.n; % witdh

    set_grid_scale(g, 12mm);
    set_grid_number(g, 2);
enddef;

def set_grid_pos(suffix g) (expr o) =
    g.pos := o;
enddef;

def set_grid_number(suffix g) (expr u) =
    set_grid_numbers(g, u, u);
enddef;

def set_grid_numbers(suffix g) (expr u, v) =
    g.m := u;
    g.n := v;
enddef;

def set_grid_scale(suffix g) (expr sz) =
    g.grid.scale := sz;
enddef;

def set_grid_color(suffix g) (expr clr) =
    g.c := clr;
enddef;

def grid_dot(suffix g) (expr i, j) =
    begingroup
    t := identity shifted (-.5 g.n, -.5 g.m) shifted g.pos scaled g.grid.scale;
    (i, j) transformed t
    endgroup
enddef;

% return the center of a grid cell as pair
def grid_center(suffix g) (expr i, j) =
    begingroup
    t := identity shifted (-.5 g.n, -.5 g.m) shifted g.pos scaled g.grid.scale;
    (.5, .5) shifted (i, j) transformed t
    endgroup
enddef;

% return the border path of the grid cell
def grid_cell(suffix g) (expr i, j) =
    begingroup
    t := identity shifted (-.5 g.n, -.5 g.m) shifted g.pos scaled g.grid.scale;
    unitsquare shifted (i, j) transformed t
    endgroup
enddef;

def draw_grid(suffix g) =
    transform t;
    t := identity shifted (-.5 g.n, -.5 g.m) shifted g.pos scaled g.grid.scale;
    for i := 0 upto g.n:
        draw ((i, 0) -- (i, g.m)) transformed t
            withcolor g.c;% dashed evenly;
    endfor;

    for i := 0 upto g.m:
        draw ((0, i) -- (g.n, i)) transformed t
            withcolor g.c;% dashed evenly;
    endfor;
enddef;
