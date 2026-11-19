local ccb = require("ccb")

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_grave",
    layout = {
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        nested = {
            {
                choices = {
                    { id = "human_corpse", weight = 95 },
                    { id = "pet_corpse", weight = 95 },
                    { id = "grave_easter_egg", weight = 5 },
                },
                x = { 0, 22 },
                y = { 0, 22 },
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "human_corpse",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        loot_placements = { { group = "grave_contents", x = 0, y = 1 } },
        sign_placements = { { snippet = "grave_label", x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grave_easter_egg",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 }, { id = "t_grave_new", x = 1, y = 1 } },
        item_placements = { { id = "sw_619", x = 0, y = 1, chance = 100 } },
        sign_placements = {
            { text = ccb.content.text("R."), x = 0, y = 0 },
            { text = ccb.content.text("M."), x = 1, y = 0 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grave_easter_egg",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        item_placements = {
            { id = "glasses_eye", x = 0, y = 1, chance = 100 },
            { id = "hazmat_suit", x = 0, y = 1, chance = 100 },
            { id = "crowbar", x = 0, y = 1, chance = 100 },
        },
        sign_placements = { { text = ccb.content.text("- Man of few words, aren't you?\n- …"), x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grave_easter_egg",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        item_placements = {
            { id = "fedora", x = 0, y = 1, chance = 100 },
            { id = "jacket_leather", x = 0, y = 1, chance = 100 },
            { id = "bullwhip", x = 0, y = 1, chance = 100 },
        },
        sign_placements = { { text = ccb.content.text("Fortune and glory, kid.  Fortune and glory."), x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grave_easter_egg",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        item_placements = { { id = "indoor_volleyball", x = 0, y = 1, chance = 100 } },
        sign_placements = { { text = ccb.content.text("Wilson"), x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grave_easter_egg",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        item_placements = {
            { id = "machete", x = 0, y = 1, chance = 100 },
            { id = "usp_45", x = 0, y = 1, chance = 100 },
            { id = "mossberg_590_shockwave", x = 0, y = 1, chance = 100 },
            { id = "holybook_bible1", x = 0, y = 1, chance = 100 },
            { id = "sunglasses", x = 0, y = 1, chance = 100 },
        },
        sign_placements = { { text = ccb.content.text("I walk by faith, not by sight."), x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grave_easter_egg",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        item_placements = {
            { id = "glasses_eye", x = 0, y = 1, chance = 100 },
            { id = "acoustic_guitar", x = 0, y = 1, chance = 100 },
            { id = "umbrella", x = 0, y = 1, chance = 100 },
            { id = "tux", x = 0, y = 1, chance = 100 },
        },
        sign_placements = {
            {
                text = ccb.content.text("Float away, little butterfly.  Just flutter away.  I got a gig in Vegas.  And the wastelands ain't no place for kids."),
                x = 0,
                y = 0,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "grave_easter_egg",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        item_placements = { { id = "touring_suit", x = 0, y = 1, chance = 100 } },
        sign_placements = { { text = ccb.content.text("Wiggle your big toe."), x = 0, y = 0 } },
    },
}

ccb.content.define_mapgen {
    kind = "nested",
    id = "pet_corpse",
    layout = {
        size = { width = 2, height = 2 },
        flags = { "ERASE_ALL_BEFORE_PLACING_TERRAIN" },
        terrain_placements = { { id = "t_grave_new", x = 0, y = 1 } },
        corpse_placements = { { group = "GROUP_PETS", x = 0, y = 1 } },
        sign_placements = { { snippet = "grave_label", x = 0, y = 0 } },
    },
}
