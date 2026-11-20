local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_march_lord_spring",
    copy_from = "mon_march_lord",
    speed = 120,
    attacks = {
        { id = "march_lord_sword_spring" },
        {
            id = "xe_march_lord_create_grasses",
            spell = { id = "summon_grass_field_monster", min_level = 7 },
            cooldown = 25,
            casting_message = ccb.content.text("%1$s idly waves a hand at %3$s."),
            kind = "spell",
            when = "allow_march_lord_spring_xe_march_lord_create_grasses",
        },
        {
            id = "xe_spring_march_lord_viridian_cuirass",
            spell = { id = "viridian_cuirass_monster", min_level = 0 },
            cooldown = 50,
            casting_message = ccb.content.text("%1$s gestures and an armor of vines and leaves grows around them."),
            kind = "spell",
            when = "allow_march_lord_spring_xe_spring_march_lord_viridian_cuirass",
        },
        {
            id = "xe_march_lord_summon_plants",
            spell = { id = "summon_bashing_vine_changeling_monster" },
            cooldown = 45,
            casting_message = ccb.content.text("%1$s gestures and plants grow in moments."),
            kind = "spell",
            when = "allow_march_lord_spring_xe_march_lord_summon_plants",
        },
    },
    inheritance = { add = { armor = { biological = 26 } } },
    death = { drops = "changeling_lord_spring_death_drops" },
}
