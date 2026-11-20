local ccb = require("ccb")

-- In the future, it would be nice if these guys could be resistant to fall damage.
ccb.content.define_monster {
    id = "mon_zombie_winged",
    name = ccb.content.plural_text("batwing zombie", "batwing zombies"),
    description = ccb.content.text("This zombie's arms have stretched far beyond human limits, the skin lengthened into a gruesome, fleshy membrane.  The mutation does not suit it well: it moves clumsily, even compared to other zombies, but can occasionally leap a significant distance."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    mass = "65200 g",
    hp = 64,
    color = "light_green",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_skill = 2,
    melee_sides = 2,
    bleed_rate = 50,
    weakpoints = {
        {
            id = "arm",
            name = ccb.content.text("the wing"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 2, melee = 1 },
            attack_coverage = { point = 0.25 },
            effects = {
                {
                    effect = "staggered",
                    chance = 15,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 10, 100 },
                },
            },
            coverage = 12,
        },
    },
    grab_strength = 15,
    attacks = {
        { id = "bite_humanoid", cooldown = 5 },
        { id = "grab", cooldown = 12 },
        { id = "scratch_humanoid" },
        { cooldown = 10, maximum_range = 5, kind = "leap" },
    },
    burn_into = "mon_zombie_scorched_lasher",
    upgrade = { half_life = 140, monster = "mon_zombie_brute_winged" },
    inheritance = { add = { families = { "prof_wp_flying" }, flags = { "SMELLS" } } },
}

-- Slow at actual movement, made up for by its rapid leaps.  This should work to simulate its clumsy form.  When charge attacks are possible it should get one, and that will be its main damaging ability.
ccb.content.define_monster {
    id = "mon_zombie_brute_winged",
    name = ccb.content.plural_text("garghoul", "garghouls"),
    description = ccb.content.text("This zombie's arms have stretched far beyond human limits, the skin lengthened into a gruesome, fleshy membrane.  The rest has become emaciated, with thin, rope-like muscles ripping through taut flesh.  While it doesn't appear to be able to fly, it uses its mutated arms to make shockingly fast leaps through the air."),
    copy_from = "mon_zombie_base",
    species = { "ZOMBIE" },
    difficulty_adjustment = 2,
    volume = "52 L",
    mass = "41 kg",
    hp = 70,
    speed = 65,
    color = "white",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 3 } },
    bleed_rate = 0,
    vision_night = 7,
    weakpoints = {
        {
            id = "arm",
            name = ccb.content.text("the wing"),
            critical_multiplier = { all = 0.75 },
            difficulty = { ranged = 2, melee = 1 },
            attack_coverage = { point = 0.25 },
            effects = {
                {
                    effect = "staggered",
                    chance = 15,
                    message = ccb.content.text("The %s is knocked off-balance!"),
                    damage_percent = { 10, 100 },
                },
            },
            coverage = 12,
        },
    },
    grab_strength = 15,
    attacks = {
        {
            id = "bite_humanoid",
            damage = { { type = "stab", amount = 12, armor_multiplier = 0.7 } },
        },
        { id = "grab", cooldown = 12 },
        { id = "scratch_humanoid" },
        { cooldown = 2, maximum_range = 8, kind = "leap" },
    },
    burn_into = "mon_zombie_scorched_lasher",
    upgrade = false,
    armor = { bash = 2, cut = 2, bullet = 2, electric = 1 },
    inheritance = { add = { families = { "prof_wp_flying" }, flags = { "SMELLS" } } },
}
