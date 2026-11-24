local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_nemesis",
    copy_from = "mon_zombie",
    vision_day = 99,
    vision_night = 99,
    aggression = 100,
    morale = 100,
}

-- 5 hits to max intensity, 6 hits to max duration
ccb.content.define_monster {
    id = "mon_spider_web",
    name = ccb.content.plural_text("giant web spider", "giant web spiders"),
    description = ccb.content.text("A giant, light gray mutant grass spider, it waits for prey to become ensnared in the vast webs that it weaves between the trees."),
    default_faction = "spider_web",
    body_type = "spider",
    species = { "SPIDER" },
    difficulty_adjustment = 2,
    volume = "62500 ml",
    mass = "81500 g",
    hp = 40,
    speed = 110,
    materials = { "iflesh" },
    symbol = "s",
    color = "yellow",
    aggression = 100,
    morale = 100,
    aggressive_to_characters = true,
    melee_skill = 4,
    melee_dice = 1,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 6 } },
    attack_effects = { { id = "venom_dmg", duration = 400, affect_hit_body_part = true } },
    dodge = 2,
    weakpoint_sets = { "wps_arthropod", "wps_arthropod_spider" },
    families = { "prof_wp_basic_bug", "prof_wp_spider" },
    vision_day = 5,
    vision_night = 5,
    harvest = "arachnid",
    dissect = "dissect_spider_sample_single",
    reproduction = { offspring = { egg = "egg_spider_web" }, count = 3, interval = 15 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    fungalize_into = "mon_spider_fungus",
    anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE" },
    upgrade = { half_life = 168, monster = "mon_spider_web_mega" },
    zombify_into = "mon_meat_cocoon_small",
    trap_avoids = { "tr_sinkhole" },
    flags = { "SEES", "SMELLS", "HEARS", "WEBWALK", "CLIMBS", "PATH_AVOID_FIRE", "PATH_AVOID_FALL" },
    armor = { bash = 2, cut = 6, bullet = 5 },
}

ccb.content.define_monster {
    id = "mon_spider_cellar_giant",
    name = ccb.content.plural_text("giant cellar spider", "giant cellar spiders"),
    description = ccb.content.text("A huge brown spider in constant movement, with a small body the size of a child held up at chest level by a set of spindly legs that branch into three-pronged graspers at the end.  Unlike the smaller variant it obviously decided hunting you is worth a try, and follows you with mandibles chittering in anticipation."),
    default_faction = "spider_cellar",
    body_type = "spider",
    species = { "SPIDER" },
    difficulty_adjustment = 2,
    volume = "80 L",
    mass = "40750 g",
    hp = 60,
    speed = 100,
    materials = { "iflesh" },
    symbol = "s",
    color = "brown",
    aggression = -5,
    morale = 5,
    aggressive_to_characters = true,
    melee_skill = 6,
    melee_dice = 1,
    melee_sides = 9,
    melee_damage = { { type = "cut", amount = 4 } },
    grab_strength = 20,
    attacks = {
        { id = "grab", when = "monster_attack_intact_legs" },
        {
            damage = { { type = "cut", amount = 10 }, { type = "stab", amount = 6 } },
            cooldown = 5,
            effects = { { id = "venom_pain", chance = 50, duration = 350, affect_hit_body_part = true } },
            kind = "bite",
            when = "monster_attack_intact_mandibles",
        },
    },
    dodge = 8,
    weakpoint_sets = { "wps_arthropod", "wps_arthropod_spider" },
    families = { "prof_wp_basic_bug", "prof_wp_spider" },
    vision_day = 12,
    vision_night = 18,
    harvest = "arachnid_spider",
    dissect = "dissect_spider_sample_single",
    reproduction = { offspring = { egg = "egg_spider_cellar" }, count = 3, interval = 15 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    pathing = { max_distance = 50, avoid_sharp = true },
    fungalize_into = "mon_spider_fungus",
    upgrade = { grow_at_age = 14, monster_group = "GROUP_SPIDER_CELLAR_GIANT" },
    zombify_into = "mon_meat_cocoon_small",
    flags = { "SEES", "SMELLS", "HEARS", "GRABS", "WEBWALK", "CLIMBS", "HARDTOSHOOT", "PATH_AVOID_DANGER" },
    armor = { bash = 1, cut = 5, acid = 3, bullet = 2 },
}

ccb.content.define_monster {
    id = "mon_spider_widow_giant",
    name = ccb.content.plural_text("giant black widow", "giant black widows"),
    description = ccb.content.text("A dog-sized mutated black widow spider.  There is a red hourglass shape on its thorax.  A highly venomous nightmare come to life."),
    default_faction = "spider_widow",
    body_type = "spider",
    species = { "SPIDER" },
    difficulty_adjustment = 2,
    volume = "30 L",
    mass = "40750 g",
    hp = 60,
    speed = 90,
    materials = { "iflesh" },
    symbol = "s",
    color = "dark_gray",
    aggression = -10,
    morale = 100,
    aggressive_to_characters = true,
    melee_skill = 6,
    melee_dice = 1,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 2 } },
    dodge = 2,
    weakpoint_sets = { "wps_arthropod", "wps_arthropod_spider" },
    families = { "prof_wp_basic_bug", "prof_wp_spider" },
    vision_day = 5,
    vision_night = 5,
    harvest = "arachnid",
    dissect = "dissect_spider_sample_single",
    reproduction = { offspring = { egg = "egg_spider_widow" }, count = 3, interval = 15 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    fungalize_into = "mon_spider_fungus",
    upgrade = { half_life = 168, monster = "mon_spider_widow_mega" },
    zombify_into = "mon_meat_cocoon_small",
    flags = { "SEES", "SMELLS", "HEARS", "BADVENOM", "WEBWALK", "CLIMBS", "PATH_AVOID_FIRE" },
    armor = { bash = 2, cut = 4, bullet = 3 },
}

-- 13 hits to max intensity, 17 hits to max duration
ccb.content.define_monster {
    id = "mon_spider_jumping_giant",
    name = ccb.content.plural_text("giant jumping spider", "giant jumping spiders"),
    description = ccb.content.text("A dog-sized mutant spider with big forelegs and two pairs of inquisitive-looking eyes.  It can leap quite quickly, even into the treetops."),
    default_faction = "spider_jumping",
    body_type = "spider",
    species = { "SPIDER" },
    difficulty_adjustment = 2,
    volume = "30 L",
    mass = "40750 g",
    hp = 30,
    speed = 100,
    materials = { "iflesh" },
    symbol = "s",
    color = "white",
    aggression = -20,
    morale = 80,
    aggressive_to_characters = true,
    melee_skill = 5,
    melee_dice = 1,
    melee_sides = 1,
    melee_damage = { { type = "cut", amount = 4 } },
    attack_effects = { { id = "venom_weaken", duration = 250 } },
    dodge = 8,
    weakpoint_sets = { "wps_arthropod", "wps_arthropod_spider" },
    families = { "prof_wp_basic_bug", "prof_wp_spider" },
    vision_day = 5,
    vision_night = 5,
    harvest = "arachnid",
    dissect = "dissect_spider_sample_single",
    reproduction = { offspring = { egg = "egg_spider_jumping" }, count = 3, interval = 15 },
    mating_seasons = { "SPRING", "SUMMER", "AUTUMN" },
    attacks = {
        {
            cooldown = 2,
            maximum_range = 5,
            allow_no_target = true,
            kind = "leap",
            when = "monster_attack_intact_legs",
        },
    },
    fungalize_into = "mon_spider_fungus",
    upgrade = { half_life = 168, monster = "mon_spider_jumping_mega" },
    zombify_into = "mon_meat_cocoon_small",
    flags = { "SEES", "SMELLS", "HEARS", "HIT_AND_RUN", "CLIMBS", "PATH_AVOID_DANGER" },
    armor = { cut = 3, bullet = 2 },
}

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

ccb.content.define_monster {
    id = "mon_boss_shadow",
    name = ccb.content.plural_text("shadow of reality", "shadow of reality"),
    description = "Something is there!  Against all reason, this shadow lurks at the corners of your vision.  You close your eyes, but still, it is there.  No matter how far you run, it is there.  Behind heavy fortifications, it is there.  The maw of the void, the all consumer, the most powerful.  Now you will know why you fear the night, the day, and the unknown.",
    default_faction = "zombie",
    symbol = "L",
    body_type = "human",
    color = "red_white",
    volume = "100 L",
    mass = "100 kg",
    phase = "GAS",
    difficulty_adjustment = 500,
    hp = 3000,
    speed = 200,
    aggression = 100,
    morale = 300,
    tracking_distance = 6,
    attack_cost = 200,
    melee_skill = 10,
    melee_dice = 2,
    melee_sides = 2,
    dodge = 10,
    bleed_rate = 0,
    vision_day = 50,
    vision_night = 50,
    melee_training_cap = 0,
    flags = {
        "SEES",
        "HEARS",
        "SMELLS",
        "WARM",
        "BASHES",
        "NO_BREATHE",
        "HARDTOSHOOT",
        "CAN_OPEN_DOORS",
        "CLIMBS",
        "BORES",
        "DESTROYS",
        "FLIES",
        "FIREPROOF",
        "ALL_SEEING",
        "ALWAYS_SEES_YOU",
        "NIGHT_INVISIBILITY",
        "CAMOUFLAGE",
        "NO_FUNG_DMG",
        "FILTHY",
        "STUN_IMMUNE",
        "KEEP_DISTANCE",
        "PATH_AVOID_DANGER",
    },
    species = { "ZOMBIE", "HUMAN" },
    anger_triggers = { "HURT", "PLAYER_CLOSE", "PLAYER_WEAK" },
    scents_tracked = { "sc_human", "sc_fetid" },
    armor = {
        cut = 25,
        stab = 25,
        bash = 25,
        bullet = 25,
        heat = 25,
        cold = 25,
        electric = 25,
        acid = 25,
    },
    melee_damage = {
        { type = "pure", amount = 1, penetration = 999 },
    },
    pathing = {
        max_distance = 40,
        open_doors = true,
        climb_stairs = true,
        avoid_traps = true,
        avoid_sharp = true,
        avoid_dangerous_fields = true,
    },
    attacks = {
        { reference = "UPGRADE", cooldown = 0 },
        { reference = "RESURRECT", cooldown = 0 },
        { reference = "SHRIEK_ALERT", cooldown = 0 },
        {
            kind = "melee",
            id = "LTNT_ILLUMINATE_YOU",
            range = 30,
            dodgeable = false,
            blockable = false,
            effects_require_damage = false,
            cooldown = 1,
            damage = {
                { type = "pure", amount = 0.0 },
            },
            avatar_no_damage = "The shadows recede, leaving you with nowhere to hide!",
            npc_no_damage = "The shadows recede from <npcname>, and now they stand out like a floodlight!",
            effects = {
                { id = "Shadow_Reveal", chance = 100, duration = 60 },
            },
            when = "w16b_mon_when_defense_mode_8d44ce7161f9",
        },
        {
            kind = "spell",
            cooldown = 0,
            spell = { id = "gargantuan_raptor_spawn", hit_self = true },
            casting_message = "The shadow opens its mouth, and gore-smeared winged beasts fly out of it!",
        },
    },
    death = {
        outcome = {
            corpse = "NO_CORPSE",
            message = "Grasping at the air, the shadow melts away and vanishes!",
        },
    },
}
