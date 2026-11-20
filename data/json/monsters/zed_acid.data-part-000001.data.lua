local ccb = require("ccb")

-- Basic zed grab strength but icky icky acid on the hands
ccb.content.define_monster {
    id = "mon_zombie_corrosive",
    name = ccb.content.plural_text("corrosive zombie", "corrosive zombies"),
    description = ccb.content.text("This zombie has swollen to immense proportions, but still manages to hold itself together with semi-congealed acid all over its bloated, leathery body.  It moves clumsily, but spits from a large reserve of acid with uncanny accuracy."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    difficulty_adjustment = 15,
    volume = "108500 ml",
    mass = "120 kg",
    hp = 140,
    speed = 75,
    color = "yellow_white",
    melee_skill = 1,
    melee_dice = 1,
    melee_sides = 6,
    bleed_rate = 50,
    harvest = "zombie_humanoid_acid",
    attacks = {
        {
            id = "grab",
            damage = { { type = "acid", amount = 2 } },
            effects = { { id = "corroding", duration = { 2, 10 }, affect_hit_body_part = true } },
        },
        {
            cooldown = 5,
            move_cost = 50,
            kind = "gun",
            gun = {
                weapon = "acid_spit",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 8,
                perception = 8,
                lock_player = false,
                target_moving_vehicles = true,
                description = ccb.content.text("The corrosive zombie spits a glob of acid!"),
                ranges = { { minimum = 2, maximum = 10, mode = "DEFAULT" } },
            },
        },
        { reference = "ACID_BARF", cooldown = 5 },
    },
    defense = { id = "ACIDSPLASH", chance = 100 },
    fungalize_into = "mon_zombie_acidic_dusted",
    upgrade = false,
    armor = { bash = 10, cut = 2, stab = 12, bullet = 2, electric = 2 },
    inheritance = {
        add = {
            flags = { "ACIDPROOF", "ACID_BLOOD", "RANGED_ATTACKER" },
            weakpoint_sets = { "wps_natural_armor" },
            families = { "prof_wp_nat_armored" },
        },
    },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}
