local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_boomer",
    name = ccb.content.plural_text("boomer", "boomers"),
    description = ccb.content.text("A rotund human body, bloated beyond belief and layered in rolls of fat.  It emits a horrible odor, and a putrid pink sludge dribbles from its mouth."),
    copy_from = "mon_zombie_base",
    difficulty_adjustment = 5,
    volume = "108500 ml",
    mass = "120 kg",
    hp = 40,
    speed = 55,
    color = "pink",
    melee_skill = 3,
    melee_sides = 4,
    harvest = "exempt",
    grab_strength = 25,
    upgrade = { half_life = 168, monster_group = "GROUP_ZOMBIE_BOOMER_UPGRADE" },
    fungalize_into = "mon_boomer_dusted",
    armor = { electric = 2 },
    starting_ammo = { boomer_bile = 999 },
    inheritance = {
        add = {
            flags = { "BILE_BLOOD" },
            weakpoint_sets = { "wps_humanoid_head_small" },
            attacks = {
                {
                    move_cost = 150,
                    cooldown = 5,
                    id = "boomer_bile",
                    kind = "gun",
                    gun = {
                        weapon = "boomer_head",
                        ammo = "boomer_bile",
                        skills = { { id = "gun", level = 3 }, { id = "rifle", level = 3 } },
                        dexterity = 10,
                        targeting_sound = ccb.content.text("gurgling."),
                        description = ccb.content.text("The %s spews bile!"),
                        empty_sound = ccb.content.text("dry heaving."),
                        ranges = { { minimum = 0, maximum = 2, mode = "DEFAULT" } },
                    },
                },
            },
        },
    },
    death = {
        drops = {
            kind = "collection",
            groups = {
                { id = "default_zombie_death_drops", weight = 100 },
                { id = "explode_zed", weight = 100 },
            },
        },
        outcome = {
            spell = { id = "death_boomer", hit_self = true },
            message = ccb.content.text("The %s explodes!"),
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_boomer_huge",
    name = ccb.content.plural_text("huge boomer", "huge boomers"),
    description = ccb.content.text("This boomer, normally swollen and ready to burst, has strengthened and solidified.  The bile dribbling from its mouth also appears to have changed…"),
    copy_from = "mon_boomer",
    hp = 110,
    speed = 85,
    color = "brown_cyan",
    melee_skill = 1,
    melee_dice = 3,
    melee_sides = 3,
    bleed_rate = 50,
    grab_strength = 30,
    armor = { bash = 5, cut = 5, bullet = 4, electric = 3 },
    starting_ammo = { boomer_bile_adv = 999 },
    inheritance = {
        add = {
            attacks = {
                {
                    move_cost = 150,
                    cooldown = 20,
                    id = "boomer_bile_adv",
                    kind = "gun",
                    gun = {
                        weapon = "boomer_head",
                        ammo = "boomer_bile_adv",
                        skills = { { id = "gun", level = 3 }, { id = "rifle", level = 3 } },
                        dexterity = 10,
                        targeting_sound = ccb.content.text("gurgling."),
                        description = ccb.content.text("The %s spews bile!"),
                        empty_sound = ccb.content.text("dry heaving."),
                        ranges = { { minimum = 0, maximum = 2, mode = "DEFAULT" } },
                    },
                },
            },
        },
        remove = { attacks = { "boomer_bile" } },
    },
    death = {
        outcome = {
            spell = { id = "death_boomer_glow", hit_self = true, min_level = 1 },
            message = ccb.content.text("A %s explodes!"),
            corpse = "NO_CORPSE",
        },
    },
}
