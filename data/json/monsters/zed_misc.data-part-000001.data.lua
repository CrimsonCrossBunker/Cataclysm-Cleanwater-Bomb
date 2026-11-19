local ccb = require("ccb")

-- Weight and volume reduced to reflect missing head parts.  Based on average headsize/weight, but are not exact.
-- Lower hp to reflect previous damage.  Plus they're virtually useless so might as well make them a quick kill.
-- Removed Bite attack to reflect damage to mouth.
-- Has NOHEAD flag to reflect the head is already catastrophically damaged.  Only detects through hearing.
ccb.content.define_monster {
    id = "mon_zombie_brainless",
    name = ccb.content.plural_text("brainless zombie", "brainless zombies"),
    description = ccb.content.text("A zombie like any other, except that its facial features and skull have been devastated.  It's unclear what caused the damage, but between the scraps of flesh you can see that its face and brain are gone, though its ears remain intact."),
    copy_from = "mon_zombie_base",
    volume = "61875 ml",
    mass = "78200 g",
    hp = 60,
    speed = 65,
    melee_skill = 3,
    vision_day = 2,
    vision_night = 0,
    weakpoint_sets = { "wps_humanoid_body_headless" },
    harvest = "zombie_humanoid_headless",
    decay = "zombie_decay_bone",
    upgrade = { half_life = 96, monster_group = "GROUP_ZOMBIE_BRAINLESS_UPGRADE" },
    inheritance = {
        add = { flags = { "NOHEAD", "GEN_DORMANT", "CLUMSY_ATTACKS" } },
        remove = { flags = { "SEES" }, attacks = { "bite_humanoid" } },
    },
}

-- the headless horror is technically blind, but its feelers allow it to sense your presence if you're close to it
ccb.content.define_monster {
    id = "mon_afs_headless_horror",
    name = ccb.content.plural_text("headless horror", "headless horrors"),
    description = ccb.content.text("This headless zombie has swollen to frightening proportions, towering almost nine feet tall.  Six-foot-long feelers of black ooze blindly wave from its neck, violently twitching at nearby sounds.  Its long stride allows it to quickly pursue its targets, which it pummels into pulp with its huge, swollen fists."),
    copy_from = "mon_zombie_base",
    hp = 300,
    speed = 130,
    color = "black_magenta",
    melee_skill = 5,
    melee_dice = 4,
    melee_sides = 6,
    vision_day = 2,
    vision_night = 2,
    weakpoint_sets = { "wps_humanoid_body_headless" },
    harvest = "zombie_humanoid_headless",
    decay = "zombie_decay_bone",
    grab_strength = 50,
    upgrade = false,
    armor = { electric = 2 },
    inheritance = {
        add = { flags = { "GOODHEARING", "NOHEAD", "LOUDMOVES" }, families = { "prof_wp_hulk" } },
        remove = { attacks = { "bite_humanoid" } },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_bruiser",
    name = ccb.content.plural_text("bruiser zombie", "bruiser zombies"),
    description = ccb.content.text("This zombie's right arm has been grotesquely deformed into a massive mace-like shape.  What remains of its hand has been covered in spiky bone, and the upper arm's skin is clearly coming apart from the pressure on it."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 2,
    hp = 110,
    speed = 80,
    materials = { "flesh", "bone" },
    color = "red_white",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 1 } },
    bleed_rate = 80,
    grab_strength = 15,
    upgrade = { half_life = 96, monster = "mon_zombie_brute" },
    fungalize_into = "mon_zombie_tough_dusted",
    armor = { bash = 3, cut = 2, bullet = 2, electric = 2 },
    inheritance = {
        add = {
            flags = { "SMELLS", "PUSH_VEH" },
            weakpoint_sets = { "wps_humanoid_head_small" },
            attacks = { { id = "staggering_blow" } },
        },
    },
}
