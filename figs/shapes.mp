input macros/shapes;
input macros/grid;
input macros/rcbox;

beginfig(80);
    gn := 3;
    gs := 10mm;

    def_grid(gd);
    set_grid_scale(gd, gs);
    set_grid_number(gd, gn);
    draw_grid(gd);

    draw_rcbox(origin, gs, gn, 1/3);
endfig;

beginfig(88);
    gn := 3;
    gs := 10mm;

    def_grid(gd);
    set_grid_scale(gd, gs);
    set_grid_number(gd, gn);
    draw_grid(gd);

    draw diamond scaled gd.grid.scale;
endfig;
