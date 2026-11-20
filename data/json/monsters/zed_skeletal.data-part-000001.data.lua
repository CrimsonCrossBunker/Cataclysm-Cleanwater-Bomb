local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_skeleton_brute",
    name = ccb.content.plural_text("skeletal brute", "skeletal brutes"),
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this zombie's rotten skin.  Joints and cracks around its body ooze with black goo."),
    copy_from = "mon_zombie_brute",
    species = { "ZOMBIE" },
    volume = "108500 ml",
    mass = "120 kg",
    hp = 175,
    speed = 60,
    materials = { "bone" },
    color = "white",
    melee_dice = 2,
    melee_damage = { { type = "cut", amount = 10 } },
    bleed_rate = 0,
    vision_day = 35,
    vision_night = 3,
    harvest = "mr_bones",
    grab_strength = 35,
    attacks = {
        { id = "grab", cooldown = 21 },
        { id = "staggering_blow" },
        { id = "bite_humanoid", cooldown = 5 },
        { id = "smash", throw_strength = 56, cooldown = 45, when = "allow_zombie_brute_smash" },
        {
            id = "scratch_humanoid",
            damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } },
        },
    },
    upgrade = { half_life = 180, monster = "mon_skeleton_hulk" },
    fungalize_into = "mon_skeleton_brute_dusted",
    armor = { bash = 12, cut = 30, acid = 1, bullet = 30, electric = 4 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_bone_armor" },
            families = { "prof_wp_skeleton" },
            flags = { "PULP_PRYING" },
        },
    },
}
