local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_north_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " ttttt      ",
            " th.ht      ",
            " t.c.t      ",
            " t...t      ",
            " tt+tt      ",
            "  ,_, ttttt ",
            "   ,  th.ht ",
            "      t.c.t ",
            "      t...t ",
            "      tt+tt ",
            "       ,_,  ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            G = "t_dirtfloor_thatchroof",
            g = "t_dirtfloor_thatchroof",
            c = "t_dirtfloor",
            ["."] = "t_dirtfloor_thatchroof",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_north_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   tttttttt ",
            "   tRRRRRRt ",
            "   tR....Rt ",
            "   tR....Rt ",
            "   ttt+tttt ",
            "            ",
            "      @     ",
            "     ,,,    ",
            "    @,O,@   ",
            "     ,,,    ",
            "      @     ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_storage", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_north_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "    ,,,,    ",
            "   ,,___,,  ",
            " ,,_L___,   ",
            "  ,,___L,,  ",
            " ,,,_L___,  ",
            ",,_L_ ___,  ",
            "  ,,,,,     ",
            "            ",
            "            ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = { L = "t_dirt" },
        furniture = { L = "f_log_stack_mid" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_storage", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_north_nest",
    weight = 750,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "    LLLL    ",
            "   LL__LL   ",
            "  LL_G__LL  ",
            "  L______L  ",
            "  L______L  ",
            "  LL__G_LL  ",
            "   LL__LL   ",
            "    LLLL    ",
            "            ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof", L = "t_trunk", G = "t_dirt" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 3 } } },
        monster_glyphs = { G = { id = "mon_goblin_chieftain" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_north_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "  L X    XL ",
            "  L X   X L ",
            "  L X  X  L ",
            "  L      XL ",
            "  L   X   L ",
            "  L X     L ",
            "  L     X L ",
            "  LLLLGLLLL ",
            "            ",
            "            ",
            "            ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            ["."] = "t_dirtfloor_thatchroof",
            X = "t_dirt",
            L = "t_splitrail_fence",
            G = "t_splitrail_fencegate_c",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested_glyphs = { X = { choices = { { id = "human_gore", weight = 2 }, { id = "null", weight = 1 } } } },
        monster_placements = {
            { id = "mon_wolf_goblin", x = { 4, 7 }, y = { 0, 6 }, repetitions = { 2, 5 } },
            { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 8, 11 }, repetitions = { 1, 2 } },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_north_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   %     %  ",
            "     %%   % ",
            "    %%%%    ",
            "    %%%%%   ",
            "   %%%%%%   ",
            "   %%%%%%%  ",
            "    %%%%%   ",
            "    %%%%%   ",
            "     %%     ",
            "          % ",
            "            ",
        },
        palettes = { "goblin_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_west",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   ttttttt  ",
            "   th....t  ",
            "   th..ggt  ",
            "   t..hggt,,",
            "  %t.....+_,",
            "  %tG.c. +_,",
            " %%tR...bt,,",
            " %%tR.h.bt  ",
            "   tbb..ht  ",
            "   ttttttt  ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            G = "t_dirtfloor_thatchroof",
            g = "t_dirtfloor_thatchroof",
            b = "t_dirtfloor_thatchroof",
            R = "t_dirtfloor_thatchroof",
            c = "t_dirtfloor",
            ["."] = "t_dirtfloor_thatchroof",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "magic_tools_and_loot", chance = 50, repetitions = { 1, 3 } } },
        monster_glyphs = { G = { id = "mon_goblin_mage_poison" }, g = { group = "GROUP_ALL_GOBLINS" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_west",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " tttttttttt ",
            " t.h....h.t ",
            " t.....h..t ",
            " tR.h.....t ",
            " tR...c...+ ",
            " tRh..c...+ ",
            " t.....h..t ",
            " t..h.....t ",
            " t.......ht ",
            " t.h..h...t ",
            " tttttttttt ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_foodstuffs", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 4, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_west",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " tttttttttt ",
            " t.h....h.t ",
            " t.....h..t ",
            " tR.h.....t ",
            " tR...c...+ ",
            " tRh..c...+ ",
            " t.....h..t ",
            " t..h.....t ",
            " t.......ht ",
            " t.h..h...t ",
            " tttttttttt ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            ["."] = { { id = "t_dirtfloor", copies = 1 }, { id = "t_dirt", copies = 1 } },
            t = { { id = "t_wall_wattle_broken", copies = 2 }, { id = "t_wall_wattle", copies = 1 } },
        },
        furniture = {
            h = { { id = "f_straw_bed", copies = 1 }, { id = "f_rubble_landfill", copies = 3 } },
            R = { { id = "f_rack_wood", copies = 1 }, { id = "f_rubble_landfill", copies = 6 } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_west",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   ttttt    ",
            "   tR.ht,   ",
            "   th..+_,  ",
            "   t...t,   ",
            "   t.h.t    ",
            "   ttttt    ",
            "       ,@,  ",
            "      ,___, ",
            "      @_O_@ ",
            "      ,___, ",
            "       ,@,  ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof", h = "t_dirtfloor_thatchroof" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_foodstuffs", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 3 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_west",
    weight = 750,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "    LLLL    ",
            "   LL__LL   ",
            "  LL_G__LL  ",
            "  L______L  ",
            "  L______L  ",
            "  LL__G_LL  ",
            "   LL__LL   ",
            "    LLLL    ",
            "            ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof", L = "t_trunk", G = "t_dirt" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 3 } } },
        monster_glyphs = { G = { id = "mon_goblin_chieftain" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_west",
    weight = 750,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   %     %  ",
            "     %%   % ",
            "    %%%%    ",
            "    %%%%%   ",
            "   %%%%%%   ",
            "   %%%%%%%  ",
            "    %%%%%   ",
            "    %%%%%   ",
            "     %%     ",
            "          % ",
            "            ",
        },
        palettes = { "goblin_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_east",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " tttttttttt ",
            " t.h....h.t ",
            " t..h.....t ",
            " t.....h.Rt ",
            "_+...c...Rt ",
            "_+...c..hRt ",
            " t..h.....t ",
            " t.....h..t ",
            " th.......t ",
            " t...h..h.t ",
            " tttttttttt ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_foodstuffs", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 4, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_east",
    weight = 750,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "  ttttttt   ",
            "  t.h.bbt  %",
            "  tb...Rt%% ",
            ",,tb...Rt%% ",
            ",_+..c.Gt%  ",
            ",_+....ht%  ",
            ",,tgg...t   ",
            "  tgg...t   ",
            "  t...hht   ",
            "  ttttttt   ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            G = "t_dirtfloor_thatchroof",
            g = "t_dirtfloor_thatchroof",
            b = "t_dirtfloor_thatchroof",
            R = "t_dirtfloor_thatchroof",
            c = "t_dirtfloor",
            ["."] = "t_dirtfloor_thatchroof",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "magic_tools_and_loot", chance = 50, repetitions = { 1, 3 } } },
        monster_glyphs = { G = { id = "mon_goblin_mage_poison" }, g = { group = "GROUP_ALL_GOBLINS" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_east",
    weight = 750,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "       ,@,  ",
            "   @,,,,,   ",
            "    ,,@,    ",
            "  ,,____,@  ",
            "   @___@_,, ",
            " ,,_____,,  ",
            "   ,,___@   ",
            "  @,,,,,,,, ",
            "       @    ",
            "    @       ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            G = "t_dirtfloor_thatchroof",
            g = "t_dirtfloor_thatchroof",
            b = "t_dirtfloor_thatchroof",
            R = "t_dirtfloor_thatchroof",
            c = "t_dirtfloor",
            ["."] = "t_dirtfloor_thatchroof",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "magic_tools_and_loot", chance = 50, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 6 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_east",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " tttttttttt ",
            " t.h....h.t ",
            " t..h.....t ",
            " t.....h.Rt ",
            "_+...c...Rt ",
            "_+...c..hRt ",
            " t..h.....t ",
            " t.....h..t ",
            " th.......t ",
            " t...h..h.t ",
            " tttttttttt ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            ["."] = "t_dirtfloor_thatchroof",
            R = "t_dirtfloor_thatchroof",
            h = "t_dirtfloor_thatchroof",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_foodstuffs", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 4, 10 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_east",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            " tttttttttt ",
            " t.h....h.t ",
            " t..h.....t ",
            " t.....h.Rt ",
            " +...c...Rt ",
            " +...c..hRt ",
            " t..h.....t ",
            " t.....h..t ",
            " th.......t ",
            " t...h..h.t ",
            " tttttttttt ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            ["."] = { { id = "t_dirtfloor", copies = 1 }, { id = "t_dirt", copies = 1 } },
            t = { { id = "t_wall_wattle_broken", copies = 2 }, { id = "t_wall_wattle", copies = 1 } },
        },
        furniture = {
            h = { { id = "f_straw_bed", copies = 1 }, { id = "f_null", copies = 3 } },
            R = { { id = "f_rack_wood", copies = 1 }, { id = "f_null", copies = 6 } },
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_east",
    weight = 750,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "    LLLL    ",
            "   LL__LL   ",
            "  LL_G__LL  ",
            "  L______L  ",
            "  L______L  ",
            "  LL__G_LL  ",
            "   LL__LL   ",
            "    LLLL    ",
            "            ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof", L = "t_trunk", G = "t_dirt" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 3 } } },
        monster_glyphs = { G = { id = "mon_goblin_chieftain" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_center_nest_east",
    weight = 650,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   %     %  ",
            "     %%   % ",
            "    %%%%    ",
            "    %%%%%   ",
            "   %%%%%%   ",
            "   %%%%%%%  ",
            "    %%%%%   ",
            "    %%%%%   ",
            "     %%     ",
            "          % ",
            "            ",
        },
        palettes = { "goblin_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 2 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_south_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    ,__,    ",
            " tttt++tttt ",
            " t.....bb.t ",
            " t.hgg....t ",
            " t.h..c..ht ",
            " t..g..g.bt ",
            " thhGggGgbt ",
            " tttttttttt ",
            "     %%%%   ",
            "       %%   ",
            "         %  ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = {
            G = "t_dirtfloor_thatchroof",
            g = "t_dirtfloor_thatchroof",
            b = "t_dirtfloor_thatchroof",
            c = "t_dirtfloor",
            ["."] = "t_dirtfloor_thatchroof",
        },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_glyphs = { G = { id = "mon_goblin_chieftain" }, g = { group = "GROUP_ALL_GOBLINS" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_south_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "     @      ",
            "    ,,,     ",
            "   @,O,@    ",
            "    ,,,     ",
            "     @      ",
            "            ",
            " tttt+ttt   ",
            " tR....Rt   ",
            " tR.R..Rt   ",
            " tR.RRRRt   ",
            " tttttttt   ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_storage", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_south_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "            ",
            "    LLLL    ",
            "   LL__LL   ",
            "  LL_G__LL  ",
            "  L______L  ",
            "  L______L  ",
            "  LL__G_LL  ",
            "   LL__LL   ",
            "    LLLL    ",
            "            ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof", L = "t_trunk", G = "t_dirt" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 3 } } },
        monster_glyphs = { G = { id = "mon_goblin_chieftain" } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_south_nest",
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "    ,___,   ",
            "  %%,___,   ",
            "   ttt+tttt ",
            "  %t.R...Rt%",
            "   tR.....t ",
            " % t....R.t ",
            "   t..R...t ",
            " % t.R..R.t%",
            "   t.R..R.t ",
            "  %tRRRRRRt ",
            "   tttttttt ",
            "            ",
        },
        palettes = { "goblin_palette" },
        terrain = { ["."] = "t_dirtfloor_thatchroof" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        item_groups = { R = { group = "orc_village_foodstuffs", chance = 70, repetitions = { 1, 3 } } },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 1 }, repetitions = { 1, 5 } } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_south_nest",
    weight = 450,
    layout = {
        size = { width = 12, height = 12 },
        rows = {
            "            ",
            "   %     %  ",
            "     %%   % ",
            "    %%%%    ",
            "    %%%%%   ",
            "   %%%%%%   ",
            "   %%%%%%%  ",
            "    %%%%%   ",
            "    %%%%%   ",
            "     %%     ",
            "          % ",
            "            ",
        },
        palettes = { "goblin_palette" },
        rotation = { 0, 3 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        monster_placements = { { group = "GROUP_ALL_GOBLINS", x = { 0, 11 }, y = { 0, 11 }, repetitions = { 1, 2 } } },
    },
}

-- goblin campfire
ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_campfire",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "h    ",
            "     ",
            " ~~c ",
            "    h",
            "     ",
        },
        palettes = { "goblin_palette" },
        terrain = { c = "t_dirtfloor", ["~"] = "t_dirtfloor", h = "t_dirtfloor", [" "] = "t_dirtfloor" },
        rotation = { 0, 3 },
        monster_group_placements = { { group = "GROUP_GOBLIN_STANDARD", x = { 1, 3 }, y = { 1, 3 }, chance = 100 } },
    },
}

-- goblin campfire
ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_campfire",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "h    ",
            "h    ",
            " ~~  ",
            " h ~h",
            "  h  ",
        },
        palettes = { "goblin_palette" },
        terrain = { c = "t_dirtfloor", ["~"] = "t_dirtfloor", h = "t_dirtfloor", [" "] = "t_dirtfloor" },
        rotation = { 0, 3 },
        monster_group_placements = { { group = "GROUP_GOBLIN_STANDARD", x = { 1, 3 }, y = { 1, 3 }, chance = 100 } },
    },
}

-- goblin campfire
ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_campfire",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "~    ",
            "     ",
            "     ",
            "    c",
            "    ~",
        },
        palettes = { "goblin_palette" },
        terrain = { c = "t_dirtfloor", ["~"] = "t_dirtfloor", h = "t_dirtfloor", [" "] = "t_dirtfloor" },
        rotation = { 0, 3 },
        monster_group_placements = { { group = "GROUP_GOBLIN_STANDARD", x = { 1, 3 }, y = { 1, 3 }, chance = 100 } },
    },
}

-- goblin campfire
ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_campfire",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "~    ",
            " ~~~ ",
            " c~~~",
            "   ~h",
            "    ~",
        },
        palettes = { "goblin_palette" },
        terrain = { c = "t_dirtfloor", ["~"] = "t_dirtfloor", h = "t_dirtfloor", [" "] = "t_dirtfloor" },
        rotation = { 0, 3 },
        monster_group_placements = { { group = "GROUP_GOBLIN_STANDARD", x = { 1, 3 }, y = { 1, 3 }, chance = 100 } },
    },
}

-- goblin campfire
ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_campfire",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "~   ~",
            "h  ~~",
            "h  ~~",
            "h  ~~",
            "h   ~",
        },
        palettes = { "goblin_palette" },
        terrain = { c = "t_dirtfloor", ["~"] = "t_dirtfloor", h = "t_dirtfloor", [" "] = "t_dirtfloor" },
        rotation = { 0, 3 },
        monster_group_placements = { { group = "GROUP_GOBLIN_STANDARD", x = { 1, 3 }, y = { 1, 3 }, chance = 100 } },
    },
}

-- goblin campfire
ccb.content.define_mapgen {
    kind = "nested",
    id = "goblin_campfire",
    layout = {
        size = { width = 5, height = 5 },
        rows = {
            "     ",
            " c ~ ",
            "  h~ ",
            "     ",
            "    ~",
        },
        palettes = { "goblin_palette" },
        terrain = { c = "t_dirtfloor", ["~"] = "t_dirtfloor", h = "t_dirtfloor", [" "] = "t_dirtfloor" },
        rotation = { 0, 3 },
        monster_group_placements = { { group = "GROUP_GOBLIN_STANDARD", x = { 1, 3 }, y = { 1, 3 }, chance = 100 } },
    },
}
