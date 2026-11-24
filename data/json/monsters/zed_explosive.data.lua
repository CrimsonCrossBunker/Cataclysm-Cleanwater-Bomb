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

ccb.content.define_monster {
    id = "mon_zombie_gasbag",
    name = ccb.content.plural_text("bloated zombie", "bloated zombies"),
    description = ccb.content.text("With its gray skin swollen to near-rupture with putrid gas, this cyst-covered zombie looks like it could violently burst under the slightest of disturbances."),
    copy_from = "mon_boomer",
    hp = 15,
    speed = 80,
    color = "magenta_yellow",
    emissions = { { id = "emit_toxic_leak", delay = "1 s" } },
    attacks = { { reference = "SUICIDE", cooldown = 20 }, { reference = "scratch", cooldown = 15 } },
    fungalize_into = "mon_gasbag_dusted",
    armor = { electric = 1 },
    inheritance = {
        remove = {
            flags = { "BILE_BLOOD", "BASHES", "GROUP_BASH", "GRABS", "PUSH_MON" },
            attacks = { "boomer_bile" },
        },
    },
    death = {
        outcome = {
            message = ccb.content.text("The %s explodes!"),
            spell = { id = "death_gas", hit_self = true },
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_relax_gasbag",
    name = ccb.content.plural_text("sleepwalker zombie", "sleepwalker zombies"),
    description = ccb.content.text("A zombie swollen with a bluish, oddly sweet smelling gas.  It stumbles around even more than regular zombies, as if heavily intoxicated."),
    copy_from = "mon_zombie_gasbag",
    difficulty_adjustment = 10,
    hp = 40,
    speed = 70,
    color = "magenta_cyan",
    emissions = { { id = "emit_relax_gas_leak", delay = "1 s" } },
    death = {
        outcome = {
            message = ccb.content.text("The %s explodes!"),
            spell = { id = "death_relax_gas", hit_self = true },
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombie_tear_gasbag",
    name = ccb.content.plural_text("swollen tearjerker", "swollen tearjerkers"),
    description = ccb.content.text("A bloated corpse, its ballooning skin blistered and rashy and its face caked in mucus.  The off-color orange gas that occasionally leaks from it makes your eyes water and smells faintly of pepper."),
    copy_from = "mon_zombie_gasbag",
    difficulty_adjustment = 9,
    hp = 45,
    speed = 60,
    color = "yellow",
    melee_skill = 2,
    vision_night = 2,
    emissions = { { id = "emit_tear_gas_leak", delay = "1 s" } },
    death = {
        outcome = {
            message = ccb.content.text("The %s explodes!"),
            spell = { id = "death_tearburst", hit_self = true },
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_boomer_glutton",
    name = ccb.content.plural_text("boomer glutton", "boomer gluttons"),
    description = ccb.content.text("A large, grotesque ball of flesh and fat.  Seemingly vestigial limbs flop around haphazardly as it rolls across the ground.  You occasionally catch a glimpse of bulging eyes and a distended gaping maw oozing some sort of black sludge."),
    copy_from = "mon_boomer",
    body_type = "blob",
    difficulty_adjustment = 8,
    mass = "180kg",
    hp = 200,
    speed = 75,
    color = "pink",
    melee_skill = 4,
    melee_dice = 0,
    melee_sides = 0,
    vision_night = 5,
    emissions = { { id = "emit_sludge_puddle", delay = "1 s" } },
    grab_strength = 30,
    starting_ammo = { boomer_bile_adv = 999 },
    attacks = {
        {
            move_cost = 150,
            cooldown = 7,
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
        {
            id = "bite_humanoid",
            cooldown = 3,
            minimum_damage_multiplier = 0.75,
            maximum_damage_multiplier = 1.25,
            damage = { { type = "stab", amount = 15, armor_multiplier = 0.8 } },
        },
        {
            spell = { id = "spread_sludge", min_level = 1 },
            cooldown = 28,
            casting_message = ccb.content.text("The glutton vomits sludge!"),
            kind = "spell",
        },
    },
    armor = { bash = 20, cut = 5, bullet = 5, electric = 2 },
    inheritance = { add = { flags = { "PACIFIST", "SLUDGEPROOF" } } },
}

ccb.content.define_monster {
    id = "mon_boomer_claymore",
    name = ccb.content.plural_text("bombardier boomer", "bombardier boomers"),
    description = ccb.content.text("This zombie's exposed ribcage is encircled by swollen lungs and other organs.  You would prefer to be far away when they burst."),
    copy_from = "mon_boomer",
    difficulty_adjustment = 9,
    mass = "135 kg",
    hp = 150,
    speed = 95,
    color = "red",
    melee_skill = 1,
    vision_night = 2,
    attacks = {
        {
            cooldown = 0,
            spell = { id = "boomer_claymore_initial", min_level = 0 },
            casting_message = ccb.content.text("A bombardier boomer explodes!"),
            kind = "spell",
        },
    },
    armor = { bash = 10, cut = 5, bullet = 5, electric = 2 },
    inheritance = { remove = { flags = { "BILE_BLOOD", "GRABS", "GROUP_BASH", "PUSH_MON" } } },
}
