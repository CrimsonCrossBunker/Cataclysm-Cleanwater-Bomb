local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_spider_cellar_giant_dm",
    copy_from = "mon_spider_cellar_giant",
    species = { "SPIDER_DM" },
    default_faction = "zombie",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_spider_jumping_mega_dm",
    copy_from = "mon_spider_jumping_mega",
    species = { "SPIDER_DM" },
    default_faction = "zombie",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_spider_web_dm",
    copy_from = "mon_spider_web",
    species = { "SPIDER_DM" },
    default_faction = "zombie",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_spider_widow_giant_dm",
    copy_from = "mon_spider_widow_giant",
    species = { "SPIDER_DM" },
    default_faction = "zombie",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

-- All monsters with faction ratkin should only appear in places that make sense for them to appear.  They are specific to a unique lab and any appearances by them outside of that lab prior to at minimum two seasons after the Cataclysm occurred is nonsensical and should be reported as a bug.
ccb.content.define_monster {
    id = "mon_big_rat",
    name = ccb.content.plural_text("big rat", "big rats"),
    description = ccb.content.text("This cat-sized rat snuffles along the ground looking for things to eat.  It hisses at anything that comes near it, baring sizable teeth."),
    default_faction = "ratkin",
    body_type = "pig",
    species = { "MUTANT" },
    volume = "2 L",
    mass = "2 kg",
    hp = 25,
    speed = 100,
    attack_cost = 95,
    materials = { "flesh" },
    symbol = "R",
    color = "dark_gray",
    aggression = 15,
    morale = 50,
    aggressive_to_characters = true,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 3,
    vision_day = 30,
    vision_night = 10,
    pathing = { max_distance = 50, avoid_sharp = true },
    upgrade = { half_life = 168, monster_group = "GROUP_RATKIN_EVOLVED" },
    anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE", "FRIEND_ATTACKED" },
    fear_triggers = { "HURT", "FIRE" },
    regenerates_morale = true,
    attacks = {
        {
            cooldown = 10,
            damage = { { type = "stab", amount = 6, armor_multiplier = 0.7 } },
            kind = "bite",
        },
        { id = "scratch", maximum_damage_multiplier = 1.5 },
    },
    attack_effects = { { id = "rat_bite_fever", duration = 400, chance = 10 } },
    flags = { "SEES", "SMELLS", "HEARS", "WARM", "SWIMS", "ANIMAL", "PATH_AVOID_DANGER" },
    harvest = "mutant_mammal_small_fur",
    dissect = "dissect_rat_sample_single",
}

ccb.content.define_monster {
    id = "mon_zap_rat",
    copy_from = "mon_zap_rat",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_tunnel_rat",
    copy_from = "mon_tunnel_rat",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_pack_rat",
    copy_from = "mon_pack_rat",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_teke_mouse",
    copy_from = "mon_teke_mouse",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_mausketeer",
    copy_from = "mon_mausketeer",
    aggressive_to_characters = true,
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie",
    copy_from = "mon_zombie",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_fat",
    copy_from = "mon_zombie_fat",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_tough",
    copy_from = "mon_zombie_tough",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_child",
    copy_from = "mon_zombie_child",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_rot",
    copy_from = "mon_zombie_rot",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_crawler",
    copy_from = "mon_zombie_crawler",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_dog",
    copy_from = "mon_zombie_dog",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_dog_zombie_cop",
    copy_from = "mon_dog_zombie_cop",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_dog_zombie_rot",
    copy_from = "mon_dog_zombie_rot",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_cop",
    copy_from = "mon_zombie_cop",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_fursuit",
    copy_from = "mon_zombie_fursuit",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_swat",
    copy_from = "mon_zombie_swat",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_medical",
    copy_from = "mon_zombie_medical",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_hazmat",
    copy_from = "mon_zombie_hazmat",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_fireman",
    copy_from = "mon_zombie_fireman",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_swimmer_base",
    copy_from = "mon_zombie_swimmer_base",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_static",
    copy_from = "mon_zombie_static",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_paramilitary",
    copy_from = "mon_zombie_paramilitary",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_survivor",
    copy_from = "mon_zombie_survivor",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_survivor_elite",
    copy_from = "mon_zombie_survivor_elite",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_beekeeper",
    copy_from = "mon_beekeeper",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_technician",
    copy_from = "mon_zombie_technician",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_runner",
    copy_from = "mon_zombie_runner",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_soldier",
    copy_from = "mon_zombie_soldier",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_milbase_personnel",
    copy_from = "mon_zombie_milbase_personnel",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_zombie_military_pilot",
    copy_from = "mon_zombie_military_pilot",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_crowbar",
    copy_from = "mon_feral_human_crowbar",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_cop",
    copy_from = "mon_feral_cop",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_pipe",
    copy_from = "mon_feral_human_pipe",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_axe",
    copy_from = "mon_feral_human_axe",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_human_tool",
    copy_from = "mon_feral_human_tool",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_sapien_spear",
    copy_from = "mon_feral_sapien_spear",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

ccb.content.define_monster {
    id = "mon_feral_soldier",
    copy_from = "mon_feral_soldier",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}
