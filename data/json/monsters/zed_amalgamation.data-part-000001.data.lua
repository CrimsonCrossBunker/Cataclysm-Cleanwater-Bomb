local ccb = require("ccb")

-- Small, nasty glass cannon spawning in groups.  WP: mandible, leg
ccb.content.define_monster {
    id = "mon_amalgamation_swarmer",
    copy_from = "mon_amalgamation_abstract_small",
    name = ccb.content.plural_text("swarming amalgamation", "swarming amalgamations"),
    description = ccb.content.text("A small, flat creature dashing around erratically on seven short legs.  Its form is dominated by an oversized set of black mandibles on an almost comically small head, featureless apart from a single black eye.  The rest of the body is covered with sickly white skin crisscrossed by black veins."),
    volume = "20 L",
    mass = "20 kg",
    hp = 35,
    speed = 120,
    move_skills = { climb = 6 },
    attack_cost = 120,
    melee_dice = 2,
    melee_damage = { { type = "cut", amount = 3 } },
    attacks = {
        {
            cooldown = 3,
            move_cost = 150,
            damage = { { type = "cut", amount = 15, penetration = 5 } },
            minimum_hit_size = 4,
            minimum_damage_multiplier = 0.5,
            maximum_damage_multiplier = 1.2,
            infection_chance = 10,
            attack_upper = false,
            kind = "bite",
            when = "monster_attack_intact_mandibles",
        },
    },
    vision_day = 18,
    inheritance = {
        add = {
            flags = { "SWARMS", "HARDTOSHOOT", "HIT_AND_RUN" },
            weakpoint_sets = { "wps_amalgamation_mandible" },
        },
    },
}
