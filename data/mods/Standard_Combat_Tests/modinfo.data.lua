local ccb = require("ccb")

ccb.content.define_scenario {
    id = "evacuee",
    name = "Evacuee",
    points = 0,
    description = "You have survived the initial wave of panic, and have achieved (relative) safety in one of the many government evac shelters.  You also took the time to cobble together some improvised weaponry!",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    professions = { "sct_day1" },
    map_extra = "mx_sct_day1",
    flags = { "CITY_START", "LONE_START" },
}

ccb.content.define_scenario {
    id = "scavenger",
    name = "Scavenger",
    points = 0,
    description = "You are getting by in the Apocalypse.  Your gear is still scavenged from the ruins of the old world, but you have gathered the skills to use it to good effect.  Midsummer start.",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    professions = { "sct_mid" },
    map_extra = "mx_sct_mid",
    flags = { "CITY_START", "LONE_START" },
    start_of_cataclysm = { hour = 0, day = 56, season = "spring", year = 1 },
    start_of_game = { hour = 8, day = 45, season = "summer", year = 1 },
}

ccb.content.define_scenario {
    id = "survivor",
    name = "Survivor",
    points = 0,
    description = "You are as close to thriving as anybody can be these days.  Your gear is handcrafted with the threats of the new world in mind, and your skills are honed to perfection.  Mid-autumn start.",
    locations = { "sloc_shelter_safe" },
    start_name = "Evac Shelter",
    professions = { "sct_late" },
    map_extra = "mx_sct_late",
    flags = { "CITY_START", "LONE_START" },
    start_of_cataclysm = { hour = 0, day = 56, season = "spring", year = 1 },
    start_of_game = { hour = 8, day = 45, season = "autumn", year = 1 },
}

ccb.content.define_map_extra {
    id = "mx_sct_day1",
    name = ccb.content.text("Standard early game combat test area"),
    description = ccb.content.text("There are some improvised weapons nearby."),
    generator = { method = "update_mapgen", id = "mx_sct_day1" },
    z_levels = { 0, 0 },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_sct_day1",
    layout = {
        terrain_placements = {
            { id = "t_utility_light", x = 5, y = 10 },
            { id = "t_utility_light", x = 7, y = 22 },
            { id = "t_utility_light", x = 17, y = 9 },
            { id = "t_utility_light", x = 17, y = 22 },
        },
        loot_placements = {
            { id = "makeshift_machete", x = 11, y = 10, chance = 100 },
            { id = "mace_pipe", x = 12, y = 10, chance = 100 },
            { id = "spear_knife", x = 13, y = 10, chance = 100 },
            { id = "glock_17", x = 14, y = 10, ammo = 100, magazine = 100, chance = 100 },
            { id = "glock17_17", x = 14, y = 10, ammo = 100, chance = 100 },
        },
    },
}

ccb.content.define_map_extra {
    id = "mx_sct_mid",
    name = ccb.content.text("Standard midgame combat test area"),
    description = ccb.content.text("There are some scavenged weapons nearby."),
    generator = { method = "update_mapgen", id = "mx_sct_mid" },
    z_levels = { 0, 0 },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_sct_mid",
    layout = {
        terrain_placements = {
            { id = "t_utility_light", x = 5, y = 10 },
            { id = "t_utility_light", x = 7, y = 22 },
            { id = "t_utility_light", x = 17, y = 9 },
            { id = "t_utility_light", x = 17, y = 22 },
        },
        loot_placements = {
            { id = "fire_ax", x = 11, y = 10, chance = 100 },
            { id = "shillelagh", x = 12, y = 10, chance = 100 },
            { id = "knife_combat", x = 13, y = 10, chance = 100 },
            { group = "modular_ar15", x = 14, y = 10, ammo = 100, magazine = 100, chance = 100 },
            { id = "stanag30", x = 14, y = 10, ammo = 100, chance = 100 },
        },
    },
}

ccb.content.define_map_extra {
    id = "mx_sct_late",
    name = ccb.content.text("Standard lategame combat test area"),
    description = ccb.content.text("There are some survivor weapons nearby."),
    generator = { method = "update_mapgen", id = "mx_sct_late" },
    z_levels = { 0, 0 },
}

ccb.content.define_mapgen {
    kind = "update",
    id = "mx_sct_late",
    layout = {
        terrain_placements = {
            { id = "t_utility_light", x = 5, y = 10 },
            { id = "t_utility_light", x = 7, y = 22 },
            { id = "t_utility_light", x = 17, y = 9 },
            { id = "t_utility_light", x = 17, y = 22 },
        },
        loot_placements = {
            { id = "nodachi", x = 11, y = 10, chance = 100 },
            { id = "broadsword", x = 11, y = 10, chance = 100 },
            { id = "mace", x = 12, y = 10, chance = 100 },
            { id = "lucern_hammer", x = 12, y = 10, chance = 100 },
            { id = "pike", x = 13, y = 10, chance = 100 },
            { id = "rapier", x = 13, y = 10, chance = 100 },
            { id = "m107a1", x = 14, y = 10, ammo = 100, chance = 100 },
            { id = "m107a1mag", x = 14, y = 10, ammo = 100, chance = 100 },
        },
    },
}

ccb.content.define_profession {
    id = "sct_day1",
    name = "Day 1",
    description = "Starter evacuee gear, no skills - probably not going to have a good time.",
    copy_from = "unemployed",
}

ccb.content.define_profession {
    id = "sct_mid",
    name = "Midgame",
    points = 0,
    description = "Scavenged armor and mid-range skills, meant to represent an established survivor before making the jump to (self)-fabricated custom gear.",
    skills = {
        { level = 4, id = "melee" },
        { level = 4, id = "bashing" },
        { level = 4, id = "cutting" },
        { level = 4, id = "stabbing" },
        { level = 4, id = "unarmed" },
        { level = 4, id = "dodge" },
        { level = 4, id = "gun" },
        { level = 4, id = "rifle" },
    },
    items = {
        both = {
            items = { "socks", "bunker_pants", "gambeson", "boots_combat", "gloves_tactical", "tac_helmet" },
            entries = { { group = "us_ballistic_vest_pristine" } },
        },
        male = { legacy = { "boxer_shorts" } },
        female = { legacy = { "bra", "boy_shorts" } },
    },
}

ccb.content.define_profession {
    id = "sct_late",
    name = "Lategame",
    points = 0,
    description = "Heavy (survivor pneumatic) post-Cataclysm gear, excluding rare lootables.",
    skills = {
        { level = 8, id = "melee" },
        { level = 8, id = "bashing" },
        { level = 8, id = "cutting" },
        { level = 8, id = "stabbing" },
        { level = 8, id = "unarmed" },
        { level = 8, id = "dodge" },
        { level = 8, id = "gun" },
        { level = 8, id = "rifle" },
    },
    items = {
        both = {
            items = {
                "robofac_kevlar_vambraces",
                "robofac_kevlar_greaves",
                "armor_nomad_heavyplate",
                "nomad_bodyglove_2",
                "boots_combat",
                "hc_helm_close",
                "hc_demi_gaunt",
            },
        },
    },
}
