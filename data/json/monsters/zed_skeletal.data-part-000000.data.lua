local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_skeleton",
    name = ccb.content.plural_text("skeletal zombie", "skeletal zombies"),
    description = ccb.content.text("A monstrous overgrowth of ossified tissue has replaced this zombie's rotting skin with an organic armor of dense bone.  Large clumps of black goo seep from its joints as it shambles aimlessly, with sickening crackling sounds filling the surrounding air."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    speed = 60,
    materials = { "bone" },
    color = "white",
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 4 } },
    bleed_rate = 50,
    vision_day = 30,
    harvest = "mr_bones",
    attacks = {
        { id = "grab", cooldown = 21 },
        { id = "scratch_humanoid" },
        { id = "bite_humanoid", cooldown = 5 },
    },
    upgrade = { half_life = 128, monster_group = "GROUP_SKELETON_UPGRADE" },
    fungalize_into = "mon_skeleton_dusted",
    armor = { cut = 15, stab = 30, acid = 3, bullet = 24, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_bone_armor" },
            families = { "prof_wp_skeleton" },
            flags = { "PULP_PRYING" },
        },
    },
}
