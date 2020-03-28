% constructors
def def_diagram(suffix g) =
    numeric g.grid.size;
    numeric g.node.size;
    g.grid.size := 12 mm;
    g.node.size := 5 mm;
    g.arr.scale := 1;
    g.bbox.scale := 1;

    numeric g.n;
    g.n := 0;
    pair g[].pos;
    picture g[].lbl;
    string g[].name;
    path g[].bbox;

    numeric g.m;
    g.m = 0;
    numeric g[]u, g[]v;
    numeric g[]s;  % the style
enddef;

def new_node(suffix g) =
    incr(g.n)
enddef;

def new_tex_node(suffix g) (text lbl) =
    begingroup
    idx := incr(g.n);
    g[idx].name = lbl;
    idx
    endgroup;
enddef;

def new_node_with(suffix g) (expr b) =
    begingroup
    idx := incr(g.n);
    g[idx].bbox = b;
    idx
    endgroup;
enddef;

def new_data_node(suffix g) =
    new_node_with(g, ubox)
enddef;

def new_op_node(suffix g) =
    new_node_with(g, fullcircle)
enddef;

def add_edge(suffix g) (expr i, j) =
    idx := incr(g.m);
    g[idx]u = i;
    g[idx]v = j;
    g[idx]s = 0;
enddef;

% getters
def get_pos(suffix g) (expr i) =
    g[i].pos
enddef;

% setters
def set_pos(suffix g) (expr i, p) =
    g[i].pos = p;
enddef;

def reset_pos(suffix g) (expr i, p) =
    g[i].pos := p;
enddef;

def set_relative_pos(suffix g) (expr i, j, p) =
    g[i].pos = g[j].pos + p;
enddef;

def set_arr_scale(suffix g) (expr bs) =
    g.arr.scale := bs;
enddef;

def set_bbox_scale(suffix g) (expr bs) =
    g.bbox.scale := bs;
enddef;

def set_grid_size(suffix g) (expr gs) =
    g.grid.size := gs;
enddef;

def set_node_size(suffix g) (expr ns) =
    g.node.size := ns;
enddef;

% methods
def draw_node(suffix g) (expr b, p, m) =
    pair pos;
    pos := p * g.grid.size;
    draw b scaled g.node.size shifted pos
        withpen pencircle scaled g.bbox.scale;
    label(m, pos);
enddef;

def draw_edge_with(suffix g) (expr p, pbbox, q, qbbox) =
    pair start;
    pair stop;
    start := ((p -- q) scaled g.grid.size) intersectionpoint (pbbox scaled g.node.size shifted (p scaled g.grid.size));
    stop := ((q -- p) scaled g.grid.size) intersectionpoint (qbbox scaled g.node.size shifted (q scaled g.grid.size));
    drawarrow (start -- stop)
        withpen pencircle scaled g.arr.scale;
enddef;

def draw_diagram_node(suffix g) (expr i) =
    draw_node(g, g[i].bbox, g[i].pos, g[i].lbl);
enddef;

def draw_diagram_nodes(suffix g) =
    for i := 1 upto g.n:
        draw_diagram_node(g, i);
    endfor;
enddef;

def draw_diagram_edge(suffix g) (expr i, j) =
    draw_edge_with(g, g[i].pos, g[i].bbox, g[j].pos, g[j].bbox);
enddef;

def draw_diagram_edges(suffix g) =
    for i := 1 upto g.m:
        draw_diagram_edge(g, g[i]u, g[i]v);
    endfor;
enddef;

def get_mid_offset(suffix g) (expr i, j) =
    .5 (get_pos(g, j) - get_pos(g, i))
enddef;

def get_midup_offset(suffix g) (expr i, j) =
    begingroup
    pair htmp;
    htmp := .5 (get_pos(g, j) - get_pos(g, i));
    htmp + (htmp rotated 90)
    endgroup
enddef;

def draw_diagram(suffix g) =
    draw_diagram_nodes(g);
    draw_diagram_edges(g);
enddef;
