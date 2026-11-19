local ccb = require("ccb")

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
