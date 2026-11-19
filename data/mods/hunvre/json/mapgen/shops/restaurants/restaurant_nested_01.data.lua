local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_n",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "#+##C##---#",
            "#_eC.o#=.A#",
            "#_eC.O#=.d#",
            "#_eC..+..d#",
            "#_eCC.#j.O#",
            "#__ee_#D.o#",
            "#_____##+##",
            "#hh_hh#H.F#",
            "#TT_TT#H.f#",
            "#hh_hh#H.f#",
            "###########",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_e",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#hTh______+",
            "#hTh__eeee#",
            "#____eCCCC#",
            "#hTh_eC...C",
            "#hTh__..Oo#",
            "#######+###",
            "#HHH#Dj.==-",
            "#...+.....-",
            "#ffF#oOddA-",
            "###########",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_s",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#f.H#hh_hh#",
            "#f.H#TT_TT#",
            "#F.H#hh_hh#",
            "##+##_____#",
            "#o.D#_ee__#",
            "#O.j#.CCe_#",
            "#d..+..Ce_#",
            "#d.=#O.Ce_#",
            "#A.=#o.Ce_#",
            "#---##C##+#",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_w",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "-AddOo#Fff#",
            "-.....+...#",
            "-==.jD#HHH#",
            "###+#######",
            "#oO..__hTh#",
            "C...Ce_hTh#",
            "#CCCCe____#",
            "#eeee__hTh#",
            "+______hTh#",
            "###########",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_n",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "#---##C##+#",
            "#A.=#o.Ce_#",
            "#d.=#O.Ce_#",
            "#d..+..Ce_#",
            "#O.j#.CCe_#",
            "#o.D#_ee__#",
            "##+##_____#",
            "#F.H#hh_hh#",
            "#f.H#TT_TT#",
            "#f.H#hh_hh#",
            "###########",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_e",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#ffF#oOddA-",
            "#...+.....-",
            "#HHH#Dj.==-",
            "#######+###",
            "#hTh__..Oo#",
            "#hTh_eC...C",
            "#____eCCCC#",
            "#hTh__eeee#",
            "#hTh______+",
            "###########",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_s",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "#hh_hh#H.f#",
            "#TT_TT#H.f#",
            "#hh_hh#H.F#",
            "#_____##+##",
            "#__ee_#D.o#",
            "#_eCC.#j.O#",
            "#_eC..+..d#",
            "#_eC.O#=.d#",
            "#_eC.o#=.A#",
            "#+##C##---#",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "11x11_restaurant_w",
    layout = {
        size = { width = 11, height = 11 },
        rows = {
            "###########",
            "+______hTh#",
            "#eeee__hTh#",
            "#CCCCe____#",
            "C...Ce_hTh#",
            "#oO..__hTh#",
            "###+#######",
            "-==.jD#HHH#",
            "-.....+...#",
            "-AddOo#Fff#",
            "###########",
        },
        palettes = { "restaurant_palette_hunvre" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}
