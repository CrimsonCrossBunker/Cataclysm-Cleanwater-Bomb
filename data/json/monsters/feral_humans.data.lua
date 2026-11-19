local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_feral_serum_user_lore",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("Despite their bloodshot eyes, this feral exhibits a level of awareness not seen among most of their fellows.  Their eyes purposefully scan their surroundings for danger, they carry a homemade spear, and they wear a set of armor they've cobbled together from bits of riot armor and lab supplies.  The remnants of an orange jumpsuit are visible under their improvised armor."),
    dodge = 3,
    vision_day = 50,
    attacks = { { reference = "PARROT_AT_DANGER", cooldown = 0 }, { id = "feral_weapon_spear_knife" } },
    zombify_into = "mon_zombie_survivor",
    armor = { bash = 9, cut = 14, acid = 4, bullet = 18 },
    inheritance = {
        add = {
            flags = { "PRIORITIZE_TARGETS" },
            weakpoint_sets = { "wps_humanoid_body_armor" },
            families = { "prof_wp_syn_armored" },
        },
    },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_learning", probability = 30, count = { 1, 3 } },
                { group = "feral_sapien_death_drops_spear", probability = 100 },
            },
        },
    },
}

-- No PARROT since Anaximander makes you silent
ccb.content.define_monster {
    id = "mon_feral_serum_user_anaximander",
    copy_from = "mon_feral_human_pipe",
    name = ccb.content.plural_text("feral test subject", "feral test subjects"),
    description = ccb.content.text("In light, this feral is clearly visible but they blend into the darkness like a ghost, despite the orange jumpsuit they still wear.  They don't seem to have any problems seeing in the dark either."),
    attacks = { { id = "feral_weapon_pipe" } },
    vision_night = 15,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
    death = {
        drops = {
            kind = "collection",
            items = {
                { item = "serum_night_operations", probability = 30, count = { 1, 3 } },
                { group = "feral_humans_death_drops_pipe", probability = 100 },
            },
        },
    },
}
