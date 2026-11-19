local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_tadpole_grabber",
    name = ccb.content.plural_text("tadpole constrictor", "tadpole constrictors"),
    description = ccb.content.text("The only resemblance this creature bears to a tadpole is its slick black-green skin and slender body.  Its three appendages, resembling long tentacles or pseudopods, propel it across the ground at maddening speed.  It has no outward sensory organs or a mouth, and steam rises from its skin as if it is burning away its own lifeforce to catch you."),
    default_faction = "zombie",
    body_type = "snake",
    species = { "ZOMBIE" },
    volume = "10 L",
    mass = "18 kg",
    hp = 20,
    speed = 200,
    materials = { "flesh" },
    symbol = "S",
    color = "black_green",
    aggression = 100,
    morale = 100,
    melee_skill = 7,
    melee_dice = 1,
    melee_sides = 2,
    dodge = 4,
    vision_day = 7,
    vision_night = 7,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_basic_amphibian",
    },
    harvest = "exempt",
    grab_strength = 15,
    attacks = {
        {
            cooldown = 10,
            move_cost = 0,
            maximum_range = 4,
            minimum_target_distance = 2,
            kind = "leap",
        },
        { id = "grab", cooldown = 1 },
    },
    flags = { "SEES", "HEARS", "SMELLS", "KEENNOSE", "STUMBLES", "WARM", "POISON", "GRABS", "NO_BREATHE" },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body melts away."),
            spell = { id = "death_acid", hit_self = true },
            corpse = "NO_CORPSE",
        },
    },
}

ccb.content.define_monster {
    id = "mon_zombullfrog",
    name = ccb.content.plural_text("giant zombie bullfrog", "giant zombie bullfrogs"),
    description = ccb.content.text("The wound covered skin of this large bullfrog appears to be peeling in places, revealing a black goop beneath the surface.  Its vacant stare passes by anything that isn't food, and it will leap to devour anything it can."),
    copy_from = "mon_proxy_frog_zombie",
    attack_cost = 50,
    burn_into = "mon_frog_mummy",
    upgrade = { half_life = 136, monster_group = "GROUP_ZOMBULL_FROG_UPGRADE" },
}
