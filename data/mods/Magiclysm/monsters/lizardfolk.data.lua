local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_lizardfolk_warrior",
    name = ccb.content.plural_text("lizardfolk warrior", "lizardfolk warriors"),
    description = ccb.content.text("A tall, powerful, reptilian humanoid with a muscular tail whose skin is covered in dark gray-green scales.  They are tribal and tend to be found in caves and near water, especially in areas inhabited by dragons and wyrms.  They aren't particularly hostile, though they don't care for outsiders and are highly dangerous when provoked.  While they usually prefer to fight with their greatclubs, they are equally ferocious with their sharp teeth and claws."),
    default_faction = "lizardfolk",
    body_type = "human",
    species = { "LIZARDFOLK" },
    volume = "80 L",
    mass = "100 kg",
    hp = 70,
    speed = 105,
    materials = { "flesh" },
    symbol = "L",
    color = "green",
    aggression = 50,
    morale = 80,
    vision_day = 10,
    vision_night = 20,
    pathing = { avoid_traps = true, avoid_sharp = true },
    melee_skill = 4,
    melee_dice = 2,
    melee_sides = 4,
    dodge = 5,
    harvest = "lizardfolk",
    weakpoint_sets = {
        "wps_humanoid_body",
        "wps_vital_organs",
        "wps_eyes",
        "wps_humanoid_body_armor",
        "wps_humanoid_open_helmet",
    },
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_wp_demihuman" },
    attacks = { { reference = "crush", cooldown = 5 }, { cooldown = 5, kind = "bite" } },
    flags = {
        "SEES", "INFRARED_VISION", "HEARS", "SMELLS", "KEENNOSE", "HAS_MIND", "PATH_AVOID_DANGER",
        "CLIMBS", "GROUP_MORALE", "SWIMS", "PUSH_MON", "SWARMS", "HUMAN", "CAN_OPEN_DOORS", "NO_BREATHE",
        "WIELDED_WEAPON",
    },
    armor = { bash = 2, cut = 12, stab = 6, bullet = 10 },
    death = {
        drops = {
            entries = {
                { item = "lizardfolk_club", probability = 30 },
                { item = "loincloth", probability = 40 },
                { item = "leather_belt", probability = 20 },
                { item = "bone_human", probability = 10 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_lizardfolk_hunter",
    name = ccb.content.plural_text("lizardfolk hunter", "lizardfolk hunters"),
    description = ccb.content.text("The hunter is a smaller lizardfolk than a warrior, but equally as deadly, with their lithe figures and accurate javelin throws."),
    copy_from = "mon_lizardfolk_warrior",
    symbol = "L",
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "lizardfolk_javelin_gun",
                skills = { { id = "gun", level = 8 }, { id = "rifle", level = 8 } },
                dexterity = 8,
                perception = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 10, mode = "DEFAULT" } },
                description = ccb.content.text("The hunter hurls a barbed javelin at you!"),
            },
            when = "monster_attack_armed",
        },
        { cooldown = 5, kind = "bite" },
    },
    death = {
        drops = {
            entries = {
                { item = "lizardfolk_javelin", probability = 30 },
                { item = "loincloth", probability = 40 },
                { item = "spearsling", probability = 20 },
                { item = "bone_human", probability = 10 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_lizardfolk_shaman",
    name = ccb.content.plural_text("lizardfolk shaman", "lizardfolk shamans"),
    description = ccb.content.text("Lizardfolk are very intelligent and cunning, but magical ability is a rare quality.  Shamans are chosen from the tribe during childhood, when magical abilities mark the fate of the young tribesman.  Not much is known about the initiation ritual they must undergo, but few survive the experience.  Shamans are druidic spellcasters that can use the forces of nature to battle enemies, as well as summoning assistance when needed."),
    copy_from = "mon_lizardfolk_warrior",
    symbol = "L",
    hp = 80,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 6,
    attacks = {
        {
            spell = { id = "spell_shaman_base" },
            cooldown = 10,
            kind = "spell",
            when = "allow_feral_human_magician_spell",
        },
        { reference = "scratch", cooldown = 5 },
    },
    inheritance = { add = { flags = { "MAGIC_USER" } } },
    death = {
        drops = {
            kind = "distribution",
            items = {
                { group = "enchanted_small_items", probability = 40 },
                { group = "enchanted_melee_weapons_plus1", probability = 20 },
                { group = "enchanted_wands_lesser", probability = 10 },
                { item = "robe", probability = 40 },
                { item = "leather_belt", probability = 20 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_lizardfolk_chieftan",
    name = ccb.content.plural_text("lizardfolk chieftain", "lizardfolk chieftains"),
    description = ccb.content.text("Among the lizardfolk, ambition is a rare quality.  Chieftains earn their place by exhibiting unusually high levels of ambition, often mistaken by outsiders as excessive, brutal violence.  This chief is the largest and strongest member of its tribe and carries a fierce trident to compliment its teeth and claws."),
    copy_from = "mon_lizardfolk_warrior",
    symbol = "L",
    hp = 200,
    melee_skill = 4,
    melee_dice = 3,
    melee_sides = 3,
    attacks = { { reference = "skewer", cooldown = 2 }, { cooldown = 5, kind = "bite" } },
    death = {
        drops = {
            entries = {
                { item = "lizardfolk_trident", probability = 30 },
                { group = "lair_loot_generic", probability = 40 },
                { item = "spearsling", probability = 20 },
                { item = "bone_human", probability = 10 },
            },
        },
    },
}

-- A copy of the standard mon_gator (now from Crazy Cataclysm) with a different description to match the lizardfolk lore.  Lizardfolk Shamans are able to shapeshift into crocodile form.
ccb.content.define_monster {
    id = "mon_crocodile",
    name = ccb.content.plural_text("crocodile", "crocodiles"),
    description = ccb.content.text("A once-and-future lizardfolk shaman, this large crocodile no longer has any hint of any humanoid characteristics and looks very, very dangerous."),
    default_faction = "lizardfolk",
    body_type = "gator",
    species = { "LIZARDFOLK" },
    volume = "108500 ml",
    mass = "120 kg",
    hp = 90,
    speed = 90,
    materials = { "flesh" },
    symbol = "C",
    color = "light_green",
    aggression = 30,
    morale = 50,
    melee_skill = 4,
    melee_dice = 1,
    melee_sides = 10,
    melee_damage = { { type = "cut", amount = 12 } },
    dodge = 2,
    vision_day = 3,
    vision_night = 35,
    families = { "prof_gross_anatomy", "prof_intro_biology", "prof_physiology" },
    harvest = "lizardfolk",
    dissect = "dissect_lizard_sample_large",
    grab_strength = 50,
    attacks = {
        {
            id = "bite_grab",
            cooldown = 20,
            accuracy = 6,
            damage = {
                { type = "stab", amount = 9, armor_multiplier = 0.5 },
                { type = "bash", amount = 27, armor_multiplier = 0.5 },
            },
            infection_chance = 50,
        },
    },
    anger_triggers = { "PLAYER_CLOSE", "PLAYER_WEAK" },
    fear_triggers = { "FIRE", "HURT" },
    pathing = { avoid_traps = true, avoid_sharp = true },
    flags = {
        "SEES", "INFRARED_VISION", "HEARS", "GRABS", "SMELLS", "KEENNOSE", "PATH_AVOID_DANGER",
        "PUSH_MON", "SWIMS", "GROUP_MORALE", "NO_BREATHE",
    },
    armor = { bash = 6, cut = 8, bullet = 6 },
}
