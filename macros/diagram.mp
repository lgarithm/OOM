% constructors
def def_diagram(suffix g) =
    numeric g.grid.size;
    numeric g.node.size;
    g.grid.size := 12 mm;
    g.node.size := 5 mm;

    g.arr.scale := 1;
    g.bbox.scale := 1;

    pair g.pos;
    g.pos := origin;

    numeric g.n;
    g.n := 0;
    pair g[].pos;
    picture g[].tex;
    string g[].name;
    path g[].bbox;
    boolean g[].hide_node;

    numeric g.m;
    g.m = 0;
    numeric g[]u, g[]v;
    numeric g[]s;  % the style
    boolean g[]d;  % is directed, default to true
    boolean g[].hide_edge;
enddef;

def new_node(suffix g) =
    begingroup
    idx := incr(g.n);
    g[idx].tex := btex etex;
    g[idx].pos := g.pos;
    %g[idx].bbox := fullcircle;
    g[idx].hide_node := false;
    idx
    endgroup;
enddef;

def new_tex_node(suffix g) (text lbl) =
    begingroup
    idx := incr(g.n);
    g[idx].name = lbl;
    %g[idx].pos := g.pos;
    %g[idx].bbox := fullcircle;
    idx
    endgroup;
enddef;

def new_node_with(suffix g) (expr b) =
    begingroup
    idx := new_node(g);
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
    begingroup
    idx := incr(g.m);
    g[idx]u = i;
    g[idx]v = j;
    g[idx]s = 0;
    g[idx]d = true;
    g[idx].hide_edge = false;
    % idx
    endgroup;
enddef;

def add_undirected_edge(suffix g) (expr i, j) =
    begingroup
    idx := incr(g.m);
    g[idx]u = i;
    g[idx]v = j;
    g[idx]s = 0;
    g[idx]d = false;
    % idx
    endgroup;
enddef;

% getters
def get_pos(suffix g) (expr i) =
    g[i].pos
enddef;

% setters
def diag_set_pos(suffix g) (expr p) =
  g.pos := p;
enddef;

def set_pos(suffix g) (expr i, p) =
    g[i].pos := p;
enddef;

def set_relative_pos(suffix g) (expr i, j, p) =
    g[i].pos := g[j].pos + p;
enddef;

def set_tex(suffix g) (expr i, p) =
    g[i].tex := p;
enddef;

def set_arr_scale(suffix g) (expr bs) =
    g.arr.scale := bs;
enddef;

def set_bbox(suffix g) (expr i, b) =
    g[i].bbox := b;
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

def set_hide_node(suffix g) (expr i) =
    g[i].hide_node := true;
enddef;

% methods
def draw_node(suffix g) (expr b, p, m) =
    pair pos;
    pos := p * g.grid.size;
    draw b scaled g.node.size shifted pos
        withpen pencircle scaled g.bbox.scale;
    label(m, pos);
enddef;

def diag_node_bbox(suffix g) (expr i) =
    begingroup
    g[i].bbox scaled g.node.size shifted (g[i].pos scaled g.grid.size)
    endgroup
enddef;

def draw_edge_with(suffix g) (expr p, pbbox, q, qbbox) (expr d) =
    pair start;
    pair stop;
    start := ((p -- q) scaled g.grid.size) intersectionpoint (pbbox scaled g.node.size shifted (p scaled g.grid.size));
    stop := ((q -- p) scaled g.grid.size) intersectionpoint (qbbox scaled g.node.size shifted (q scaled g.grid.size));

    path arr;
    arr := start -- stop;

    if d:
        drawarrow arr withpen pencircle scaled g.arr.scale;
    else:
        draw arr withpen pencircle scaled g.arr.scale;
    fi;
enddef;

def draw_edge_with_via(suffix g) (expr p, pbbox, q, qbbox) (expr d, m) =
    pair start;
    pair stop;
    start := ((p .. m .. q) scaled g.grid.size) intersectionpoint (pbbox scaled g.node.size shifted (p scaled g.grid.size));
    stop := ((q .. m .. p) scaled g.grid.size) intersectionpoint (qbbox scaled g.node.size shifted (q scaled g.grid.size));

    path arr;
    arr := start .. (m scaled g.grid.size) .. stop;

    if d:
        drawarrow arr withpen pencircle scaled g.arr.scale;
    else:
        draw arr withpen pencircle scaled g.arr.scale;
    fi;
enddef;

def draw_diagram_node(suffix g) (expr i) =
    draw_node(g, g[i].bbox, g[i].pos, g[i].tex);
enddef;

def draw_diagram_nodes(suffix g) =
    for i := 1 upto g.n:
        if g[i].hide_node:
            %
        else:
            draw_diagram_node(g, i);
        fi;
    endfor;
enddef;

def draw_diagram_edge(suffix g) (expr i, j) (expr d) =
    draw_edge_with(g, g[i].pos, g[i].bbox, g[j].pos, g[j].bbox, d);
enddef;

% draw curved edge controlled by position m
def draw_diagram_edge_via(suffix g) (expr i, j) (expr d, m) =
    draw_edge_with_via(g, g[i].pos, g[i].bbox, g[j].pos, g[j].bbox, d, m);
enddef;

def draw_diagram_edges(suffix g) =
    for i := 1 upto g.m:
        if g[i].hide_edge or g[g[i].u].hide_node or g[g[i].v].hide_node:
            %
        else:
            draw_diagram_edge(g, g[i]u, g[i]v, g[i]d);
        fi;
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
