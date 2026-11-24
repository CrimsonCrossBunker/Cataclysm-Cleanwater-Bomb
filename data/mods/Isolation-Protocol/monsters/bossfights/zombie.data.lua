local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_necro_boss",
    name = ccb.content.plural_text("zombie dreadlord", "zombie dreadlords"),
    description = ccb.content.text("A twisted mockery of the human form, emaciated, with jet-black skin and glowing red eyes.  It is somehow painful to look at, awakening fears deep within your psyche, and even the surrounding air seems more sinister, somehow darker and more dangerous."),
    attacks = {
        { reference = "RESURRECT", cooldown = 2 },
        {
            id = "mon_zombie_dreadlord_heal",
            spell = { id = "dreadlord_heal", min_level = 1, hit_self = true },
            casting_message = ccb.content.text("Glowing strands of distortion accumulate around %1$s."),
            cooldown = 10,
            kind = "spell",
        },
    },
    looks_like = "mon_zombie_necro",
    pathing = { max_distance = 10 },
    aggression = 100,
    morale = 100,
    copy_from = "mon_zombie_necro",
    vision_night = 50,
    inheritance = { add = { flags = { "ALWAYS_SEES_YOU" } } },
}

-- NO_I18N
-- NO_I18N
ccb.content.define_spell {
    id = "dreadlord_heal",
    name = ccb.content.text_without_extraction("Dreadlord Heal"),
    description = ccb.content.text_without_extraction("Heals zombie dreadlord and nearby allies."),
    valid_targets = { "ground", "self", "ally" },
    effect = "attack",
    shape = "blast",
    flags = { "LOUD", "RANDOM_DAMAGE", "NO_PROJECTILE", "NO_EXPLOSION_SFX" },
    base_casting_time = 100,
    min_damage = -10,
    max_damage = -15,
    min_aoe = 12,
    max_aoe = 12,
    min_range = 2,
    max_range = 6,
    field = "fd_biolum",
    field_chance = 2,
    min_field_intensity = 1,
    max_field_intensity = 3,
}

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

-- NO_I18N
-- NO_I18N
ccb.content.define_monster {
    id = "mon_zombie_soldier_no_weakpoints",
    name = ccb.content.text_without_extraction("zombie soldier test only", "zombie soldier test only"),
    description = ccb.content.text_without_extraction("This zombie soldier is used by hardcoded dps logic and for testing purposes only."),
    copy_from = "mon_zombie_soldier",
    dodge = 1,
    inheritance = {
        add = { flags = { "NOT_HALLUCINATION" } },
        remove = {
            weakpoint_sets = {
                "wps_humanoid_body",
                "wps_vital_organs",
                "wps_eyes",
                "wps_humanoid_body_armor",
                "wps_humanoid_open_helmet",
            },
        },
    },
}
