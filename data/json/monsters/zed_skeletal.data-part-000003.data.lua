local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_skeleton_hulk",
    name = ccb.content.plural_text("skeletal juggernaut", "skeletal juggernauts"),
    description = ccb.content.text("This hideous golem of plated bones and misshapen flesh drags its heavy, pointed limbs behind it like an unwanted burden.  Formerly soft and vulnerable, bones grew around its form to protect it - only, they kept growing.  And growing.  And growing."),
    copy_from = "mon_zombie_hulk",
    species = { "ZOMBIE" },
    speed = 60,
    materials = { "bone" },
    color = "white",
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 15 } },
    vision_day = 50,
    harvest = "big_mr_bones",
    attacks = {
        { id = "grab" },
        { id = "bite_humanoid" },
        { id = "smash", throw_strength = 54, when = "allow_skeleton_hulk_smash" },
        { id = "smash_equal", throw_strength = 27, when = "allow_skeleton_hulk_smash_equal" },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        {
            id = "scratch_humanoid",
            damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } },
        },
    },
    fungalize_into = "mon_skeleton_hulk_dusted",
    armor = { bash = 20, cut = 45, bullet = 36, electric = 8 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_bone_armor" },
            families = { "prof_wp_skeleton" },
            flags = { "PULP_PRYING" },
        },
    },
}
