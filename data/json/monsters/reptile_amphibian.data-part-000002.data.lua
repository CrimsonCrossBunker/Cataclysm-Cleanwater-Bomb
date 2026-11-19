local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_strange_bigfrog",
    name = ccb.content.plural_text("mutant bullfrog", "mutant bullfrogs"),
    description = ccb.content.text("A mutant bullfrog larger than most dogs.  It looks unwell, as if this growth spurt was less than comfortable."),
    copy_from = "mon_proxy_bigfrog",
    color = "light_green",
    aggression = 0,
    upgrade = { grow_at_age = 30, monster_group = "GROUP_FROGS_UPGRADE_STRANGE" },
    zombify_into = "mon_zombullfrog",
    reproduction = { offspring = { egg = "egg_strange_bigfrog" }, count = 12, interval = 20 },
    inheritance = { remove = { flags = { "SWARMS" } } },
}

ccb.content.define_monster {
    id = "mon_odd_bigfrog",
    name = ccb.content.plural_text("oversized toad", "oversized toads"),
    description = ccb.content.text("This toad seems to have been mutated to absurd size by the Cataclysm.  It's only half your size but that hardly feels comforting."),
    copy_from = "mon_proxy_bigfrog",
    aggression = 0,
    upgrade = { grow_at_age = 30, monster_group = "GROUP_FROGS_UPGRADE_ODD" },
    zombify_into = "mon_toad_zombie",
    reproduction = { offspring = { egg = "egg_odd_bigfrog" }, count = 12, interval = 20 },
    inheritance = { add = { flags = { "POISON" } }, remove = { flags = { "SWARMS" } } },
}

ccb.content.define_monster {
    id = "mon_pattern_bigfrog",
    name = ccb.content.plural_text("staticskin frog", "staticskin frogs"),
    description = ccb.content.text("Bioluminescent trails trace through the dark speckled patterns on this oversized frog's skin.  What would be cleanly defined spots on another frog, are instead fragmented collages of gray and black pigment over pale skin.  Its vestigial gills have grown into something else.  You can see them bulging the flesh under its mouth."),
    copy_from = "mon_proxy_bigfrog",
    volume = "30 L",
    mass = "20 kg",
    hp = 40,
    speed = 80,
    symbol = "x",
    color = "light_blue",
    melee_sides = 4,
    melee_damage = { { type = "electric", amount = 3 }, { type = "cut", amount = 1 } },
    armor = { bash = 2, acid = 2, heat = 1, electric = 4 },
    weakpoint_sets = { "wps_amphibian_body", "wps_amphibian_frog", "wps_amphibian_electric" },
    luminance = 3,
    defense = { id = "ZAPBACK", chance = 100 },
    upgrade = { grow_at_age = 30, monster_group = "GROUP_FROGS_UPGRADE_PATTERN" },
    zombify_into = "mon_frog_shocker",
    reproduction = { offspring = { egg = "egg_pattern_bigfrog" }, count = 12, interval = 20 },
}
