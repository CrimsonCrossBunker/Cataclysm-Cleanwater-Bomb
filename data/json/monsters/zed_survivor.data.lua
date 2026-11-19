local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_zombie_survivor_no_weakpoints",
    name = ccb.content.text_without_extraction("zombie survivor test only", "zombie survivor test only"),
    description = ccb.content.text_without_extraction("This zombie survivor is used by hardcoded dps logic and for testing purposes only."),
    copy_from = "mon_zombie_survivor",
    speed = 90,
    dodge = 3,
    attacks = {
        { reference = "SHRIEK", cooldown = 20 },
        { id = "bite_humanoid", cooldown = 5, minimum_damage_multiplier = 1 },
        { id = "grab", cooldown = 7 },
    },
    inheritance = {
        add = { flags = { "NOT_HALLUCINATION" } },
        remove = {
            weakpoint_sets = {
                "wps_humanoid_body", "wps_vital_organs", "wps_eyes", "wps_humanoid_light_armor",
                "wps_humanoid_open_helmet",
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_paramilitary",
    name = ccb.content.plural_text("paramilitary zombie", "paramilitary zombies"),
    description = ccb.content.text("Wearing military surplus gear including an armored vest with patches of local militias, cartoon women, obscene statements, or local political groups.  This person definitely thought they were ready for the apocalypse."),
    copy_from = "mon_zombie_survivor",
    looks_like = "mon_zombie_survivor",
    armor = { bash = 10, cut = 22, bullet = 15, electric = 2 },
    inheritance = { add = { weakpoint_sets = { "wps_humanoid_light_armor", "wps_humanoid_open_helmet" } } },
    death = { drops = "mon_zombie_paramilitary_death_drops" },
}

ccb.content.define_monster {
    id = "mon_zombie_survivor_elite",
    name = ccb.content.plural_text("veteran survivor zombie", "veteran survivor zombies"),
    description = ccb.content.text("This zombie once was a survivor like you, and a pretty good one at that.  Unfortunately they didn't make it, despite the custom-made, heavy armor pieces they wear and the gear that they are still lugging around."),
    copy_from = "mon_zombie_survivor",
    looks_like = "mon_zombie_survivor",
    color = "light_red_green",
    speed = 90,
    melee_skill = 9,
    melee_sides = 4,
    melee_damage = { { type = "cut", amount = 5 } },
    armor = { acid = 4, bash = 15, cut = 25, stab = 18, bullet = 20, electric = 4 },
    inheritance = { add = { weakpoint_sets = { "wps_humanoid_body_armor", "wps_humanoid_full_helmet" } } },
    death = { drops = "mon_zombie_survivor_elite_death_drops" },
}
