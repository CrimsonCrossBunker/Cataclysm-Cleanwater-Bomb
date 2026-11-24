local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_lab_security_drone_GM",
    copy_from = "base_drone",
    name = ccb.content.plural_text("GM security drone", "GM security drones"),
    description = ccb.content.text("A small quadcopter drone, it has a camera and speaker visible.  It patrols the surrounding area in a regular manner, continuously scanning individuals it encounters even if there is hardly anything left of them."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "light_green",
    dodge = 3,
    default_faction = "science",
    attacks = {
        {
            spell = { id = "green_maintenance_check" },
            cooldown = 20,
            casting_message = ccb.content.text("Remain still.  Scanning for authorization."),
            kind = "spell",
        },
    },
    revert_item = "bot_lab_security_drone_GM",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "COLDPROOF", "PRIORITIZE_TARGETS" } } },
    death = {
        drops = { groups = { { id = "robots", weight = 4 }, { id = "eyebot", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_spell {
    id = "yellow_maintenance_check",
    shape = "line",
    name = ccb.content.text_without_extraction("Ocher Maintenance Badge Trait"),
    description = ccb.content.text_without_extraction("Adds trait for badge check."),
    message = "the drone scans for your ID badge.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 10000,
    max_damage = 10000,
    min_range = 15,
    max_range = 15,
    max_level = 1,
    impact_handler = "w16b_sp_imp_dda_3d7c5813cf5e",
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_YM",
    copy_from = "base_drone",
    name = ccb.content.plural_text("OM security drone", "OM security drones"),
    description = ccb.content.text("A small quadcopter drone, it has a camera and speaker visible.  It patrols the surrounding area in a regular manner, continuously scanning individuals it encounters even if there is hardly anything left of them."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "yellow",
    dodge = 3,
    default_faction = "science",
    attacks = {
        {
            spell = { id = "yellow_maintenance_check" },
            cooldown = 120,
            casting_message = ccb.content.text("Remain still.  Scanning for authorization."),
            kind = "spell",
        },
    },
    revert_item = "bot_lab_security_drone_YM",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "COLDPROOF", "PRIORITIZE_TARGETS" } } },
    death = {
        drops = { groups = { { id = "robots", weight = 4 }, { id = "eyebot", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_spell {
    id = "blue_maintenance_check",
    shape = "line",
    name = ccb.content.text_without_extraction("Blue Maintenance Badge Trait"),
    description = ccb.content.text_without_extraction("Adds trait for badge check."),
    message = "the drone scans for your ID badge.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 10000,
    max_damage = 10000,
    min_range = 15,
    max_range = 15,
    max_level = 1,
    impact_handler = "w16b_sp_imp_dda_adc6b30fc1d5",
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_BM",
    copy_from = "base_drone",
    name = ccb.content.plural_text("BM security drone", "BM security drones"),
    description = ccb.content.text("A small quadcopter drone, it has a camera and speaker visible.  It patrols the surrounding area in a regular manner, continuously scanning individuals it encounters even if there is hardly anything left of them."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "blue",
    dodge = 3,
    default_faction = "science",
    attacks = {
        {
            spell = { id = "blue_maintenance_check" },
            cooldown = 120,
            casting_message = ccb.content.text("Remain still.  Scanning for authorization."),
            kind = "spell",
        },
    },
    revert_item = "bot_lab_security_drone_BM",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "COLDPROOF", "PRIORITIZE_TARGETS" } } },
    death = {
        drops = { groups = { { id = "robots", weight = 4 }, { id = "eyebot", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_spell {
    id = "blue_maintenance_check2",
    shape = "line",
    name = ccb.content.text_without_extraction("Blue Maintenance Badge Trait"),
    description = ccb.content.text_without_extraction("Adds trait for badge check."),
    message = "the drone scans for your ID badge.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 10000,
    max_damage = 10000,
    min_range = 15,
    max_range = 15,
    max_level = 1,
    impact_handler = "w16b_sp_imp_dda_c35f22b19969",
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_BM2",
    copy_from = "base_drone",
    name = ccb.content.plural_text("BM security drone", "BM security drones"),
    description = ccb.content.text("A small quadcopter drone, it has a camera and speaker visible.  It patrols the surrounding area in a regular manner, continuously scanning individuals it encounters even if there is hardly anything left of them."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "cyan",
    dodge = 3,
    default_faction = "science",
    attacks = {
        {
            spell = { id = "blue_maintenance_check2" },
            cooldown = 120,
            casting_message = ccb.content.text("Remain still.  Scanning for authorization."),
            kind = "spell",
        },
    },
    revert_item = "bot_lab_security_drone_BM2",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "COLDPROOF", "PRIORITIZE_TARGETS" } } },
    death = {
        drops = { groups = { { id = "robots", weight = 4 }, { id = "eyebot", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_spell {
    id = "green_researcher_check",
    shape = "line",
    name = ccb.content.text_without_extraction("Light Green Researcher Badge Trait"),
    description = ccb.content.text_without_extraction("Adds trait for badge check."),
    message = "the drone scans for your ID badge.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 10000,
    max_damage = 10000,
    min_range = 15,
    max_range = 15,
    max_level = 1,
    impact_handler = "w16b_sp_imp_dda_5be4cecec09d",
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_GR",
    copy_from = "base_drone",
    name = ccb.content.plural_text("LGR security drone", "LGR security drones"),
    description = ccb.content.text("A small quadcopter drone, it has a camera and speaker visible.  It patrols the surrounding area in a regular manner, continuously scanning individuals it encounters even if there is hardly anything left of them."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "light_green",
    dodge = 3,
    default_faction = "science",
    attacks = {
        {
            spell = { id = "green_researcher_check" },
            cooldown = 120,
            casting_message = ccb.content.text("Remain still.  Scanning for authorization."),
            kind = "spell",
        },
    },
    revert_item = "bot_lab_security_drone_GR",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "COLDPROOF", "PRIORITIZE_TARGETS" } } },
    death = {
        drops = { groups = { { id = "robots", weight = 4 }, { id = "eyebot", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

ccb.content.define_spell {
    id = "black_security_check",
    shape = "line",
    name = ccb.content.text_without_extraction("Black Security Badge Trait"),
    description = ccb.content.text_without_extraction("Adds trait for badge check."),
    message = "the drone scans for your ID badge.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 10000,
    max_damage = 10000,
    min_range = 15,
    max_range = 15,
    max_level = 1,
    impact_handler = "w16b_sp_imp_dda_101a0512a08d",
}

ccb.content.define_monster {
    id = "mon_lab_security_drone_BS",
    copy_from = "base_drone",
    name = ccb.content.plural_text("BS security drone", "BS security drones"),
    description = ccb.content.text("A small quadcopter drone, it has a camera and speaker visible.  It patrols the surrounding area in a regular manner, continuously scanning individuals it encounters even if there is hardly anything left of them."),
    difficulty_adjustment = 2,
    speed = 190,
    color = "dark_gray",
    dodge = 3,
    default_faction = "science",
    attacks = {
        {
            spell = { id = "black_security_check" },
            cooldown = 120,
            casting_message = ccb.content.text("Remain still.  Scanning for authorization."),
            kind = "spell",
        },
    },
    revert_item = "bot_lab_security_drone_BS",
    armor = { bash = 2, cut = 8, bullet = 6 },
    inheritance = { add = { flags = { "COLDPROOF", "PRIORITIZE_TARGETS" } } },
    death = {
        drops = { groups = { { id = "robots", weight = 4 }, { id = "eyebot", weight = 1 } } },
        outcome = { corpse = "BROKEN" },
    },
}

-- Opens bot release if you lack a green maintenance ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "bots_center_garage",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 1,
                y = 11,
                end_x = 1,
                end_y = 12,
            },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_e",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 17, y = 4 },
            { id = "t_thconc_r", x = 17, y = 6 },
            { id = "t_thconc_r", x = 6, y = 4 },
            { id = "t_thconc_r", x = 6, y = 6 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_f",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 17, y = 13 },
            { id = "t_thconc_r", x = 17, y = 15 },
            { id = "t_thconc_r", x = 6, y = 13 },
            { id = "t_thconc_r", x = 6, y = 15 },
        },
    },
}

-- Opens bot release if you lack a light green researcher ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "bot_release_rearcher_green",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 19,
                y = 15,
                end_x = 19,
                end_y = 16,
            },
        },
    },
}

-- Opens bot release if you lack a light green researcher ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "bot_release_rearcher_green_2",
    layout = {
        tile_edits = {
            {
                shape = "line",
                operation = "terrain",
                id = "t_thconc_r",
                x = 4,
                y = 15,
                end_x = 4,
                end_y = 16,
            },
        },
    },
}

-- Releases if you lack a black security ID card.
ccb.content.define_mapgen {
    kind = "update",
    id = "toxic_gas_corridor",
    layout = {
        field_placements = {
            { id = "fd_toxic_gas", x = 0, y = 10, intensity = 2, age_turns = 20 },
            { id = "fd_toxic_gas", x = 3, y = 16, intensity = 2, age_turns = 20 },
            { id = "fd_toxic_gas", x = 20, y = 10, intensity = 2, age_turns = 20 },
            { id = "fd_toxic_gas", x = 23, y = 16, intensity = 2, age_turns = 20 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_c",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 19, y = 8 },
            { id = "t_thconc_r", x = 19, y = 10 },
            { id = "t_thconc_r", x = 4, y = 8 },
            { id = "t_thconc_r", x = 4, y = 10 },
        },
    },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "lab_security_corridor_d",
    layout = {
        terrain_placements = {
            { id = "t_thconc_r", x = 19, y = 17 },
            { id = "t_thconc_r", x = 19, y = 19 },
            { id = "t_thconc_r", x = 4, y = 17 },
            { id = "t_thconc_r", x = 4, y = 19 },
        },
    },
}

ccb.content.define_spell {
    id = "green_maintenance_check",
    shape = "line",
    name = ccb.content.text_without_extraction("Green Maintenance Badge Trait"),
    description = ccb.content.text_without_extraction("Adds trait for badge check."),
    message = "the drone scans for your ID badge.",
    flags = { "SILENT", "NO_EXPLOSION_SFX" },
    valid_targets = { "hostile" },
    min_damage = 10000,
    max_damage = 10000,
    min_range = 15,
    max_range = 15,
    max_level = 1,
    impact_handler = "w16b_sp_imp_dda_4f13e241e51a",
}
