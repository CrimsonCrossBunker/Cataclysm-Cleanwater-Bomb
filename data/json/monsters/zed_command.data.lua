local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_skeleton_master",
    name = ccb.content.plural_text("skeletal master", "skeletal masters"),
    description = ccb.content.text("A strange zombie covered in bone plates from face to toe.  Despite the added weight on its body, its movements are coordinated, almost as if capable of analyzing your movements."),
    copy_from = "mon_zombie_master",
    species = { "ZOMBIE" },
    hp = 90,
    speed = 60,
    materials = { "bone" },
    color = "red_white",
    melee_skill = 4,
    melee_dice = 3,
    melee_damage = { { type = "cut", amount = 4 } },
    dodge = 2,
    vision_day = 30,
    vision_night = 3,
    harvest = "mr_bones",
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

ccb.content.define_monster {
    id = "mon_skeleton_necro",
    name = ccb.content.plural_text("zombie lich", "zombie liches"),
    description = ccb.content.text("A twisted visage of the human body decked in bone from head to toe.  Its vague shape is reminiscent of some tabletop monster, and it walks and watches your actions with a cold and calculating demeanor."),
    copy_from = "mon_zombie_necro",
    species = { "ZOMBIE" },
    speed = 70,
    materials = { "bone" },
    color = "dark_gray",
    melee_damage = { { type = "cut", amount = 4 } },
    vision_day = 30,
    vision_night = 3,
    harvest = "mr_bones",
    fungalize_into = "mon_skeleton_brute_dusted",
    armor = { cut = 15, stab = 30, acid = 3, bullet = 24, electric = 3 },
    inheritance = {
        add = {
            weakpoint_sets = { "wps_bone_armor" },
            families = { "prof_wp_skeleton" },
            flags = { "PULP_PRYING" },
        },
    },
}
