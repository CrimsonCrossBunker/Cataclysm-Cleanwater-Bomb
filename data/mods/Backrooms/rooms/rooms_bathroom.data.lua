local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "===========",
            "=T=T=T=T=T=",
            "=D=D=D=D=D=",
            "=         =",
            "=  CBCBC  =",
            "D n=====n d",
            "=  CBCBC  =",
            "=         =",
            "=D=D=D=D=D=",
            "=T=T=T=T=T=",
            "===========",
        },
        terrain = { n = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "===========",
            "=T C= =@ B=",
            "=  B= =  B=",
            "=  B= =  C=",
            "==D== ==D==",
            "=         =",
            "=  nCBCBn =",
            "=         =",
            "=D=D=D=D===",
            "=T=T=T=  T=",
            "===========",
        },
        terrain = { n = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "=====d=====",
            "=j       j=",
            "=  BC CB  =",
            "=  ==D==  =",
            "=  =   =  =",
            "?  D T D  ?",
            "=  =   =  =",
            "=  ==D==  =",
            "=  nn BC  =",
            "=j       j=",
            "=====D=====",
        },
        terrain = { n = "t_tile_backrooms", j = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "=D=========",
            "= =T=T=  T=",
            "= = = =   =",
            "= =D=D=D===",
            "=        j=",
            "d         ?",
            "= jCBCBCnn=",
            "=D=========",
            "= @  @  $ =",
            "=         =",
            "=?=========",
        },
        terrain = { n = "t_tile_backrooms", j = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "========",
            "=T=T= T=",
            "=D=D=D==",
            "D     C=",
            "d     C=",
            "=D=D=D==",
            "=T=T= T=",
            "========",
        },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "========",
            "=T=T= T=",
            "=D=D=  =",
            "=   =D==",
            "=     j=",
            "D      d",
            "=BCCCBn=",
            "========",
        },
        terrain = { n = "t_tile_backrooms", j = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "========",
            "=TTTTTT=",
            "=j    j=",
            "d  CC  d",
            "D  CC  d",
            "=j    j=",
            "=TTTTTT=",
            "========",
        },
        terrain = { j = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_big_bathroom",
    layout = {
        size = { width = 8, height = 8 },
        rows = {
            "========",
            "=! ==! =",
            "=  ==  =",
            "==D==D==",
            "=n    n=",
            "D      D",
            "=BCCCCB=",
            "========",
        },
        terrain = { n = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_small_bathroom",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "====",
            "D T=",
            "=nC=",
            "====",
        },
        terrain = { n = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_small_bathroom",
    layout = {
        size = { width = 4, height = 4 },
        rows = {
            "====",
            "D C=",
            "=nT=",
            "====",
        },
        terrain = { n = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_small_bathroom",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "======",
            "=T= T=",
            "=D=D==",
            "D    ?",
            "=nCCB=",
            "======",
        },
        terrain = { n = "t_tile_backrooms" },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "mx_backroom_small_bathroom",
    layout = {
        size = { width = 6, height = 6 },
        rows = {
            "======",
            "=BnTu=",
            "=C ff=",
            "=C   ?",
            "=B ij=",
            "==D===",
        },
        terrain = {
            ["?"] = {
                { id = "t_door_c", copies = 10 },
                { id = "t_door_o", copies = 5 },
                { id = "t_backroom_wall_gray", copies = 75 },
            },
            n = "t_tile_backrooms",
            j = "t_tile_backrooms",
        },
        palettes = { "backrooms_palette", "backrooms_bathroom_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
