local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_lizardfolk_warrior",
    looks_like = "mon_lizardfolk_warrior",
    name = ccb.content.plural_text("lizardfolk warrior", "lizardfolk warriors"),
    description = ccb.content.text("One of the lizardfolk of the swamps.  The size and armaments indicate this is a warrior."),
    default_faction = "lizardfolk_nonhostile",
    body_type = "human",
    species = { "LIZARDFOLK" },
    volume = "80 L",
    mass = "100 kg",
    hp = 130,
    speed = 105,
    materials = { "flesh" },
    symbol = "L",
    color = "green",
    aggression = -10,
    morale = 80,
    vision_day = 40,
    vision_night = 5,
    pathing = { avoid_traps = true, avoid_sharp = true },
    melee_skill = 4,
    melee_dice = 1,
    melee_sides = 6,
    dodge = 3,
    harvest = "harvest_lizardfolk",
    anger_triggers = { "FRIEND_ATTACKED", "FRIEND_DIED", "HURT" },
    weakpoint_sets = { "wps_humanoid_body" },
    families = { "prof_wp_demihuman" },
    attacks = {
        { id = "feral_weapon_spear_knife", accuracy = 4 },
        { id = "scratch", cooldown = 2, when = "monster_attack_armed" },
        { cooldown = 3, kind = "bite", when = "monster_attack_armed" },
    },
    flags = {
        "SEES", "HEARS", "SMELLS", "KEENNOSE", "PATH_AVOID_DANGER", "CLIMBS", "GROUP_MORALE", "SWIMS",
        "PUSH_MON", "SWARMS", "CAN_OPEN_DOORS", "NO_BREATHE", "INFRARED_VISION",
    },
    armor = { bash = 2, cut = 8, stab = 5, bullet = 10 },
    death = {
        drops = {
            entries = {
                { item = "spear_stone", probability = 30 },
                { item = "leather_belt", probability = 20 },
            },
        },
    },
}

ccb.content.define_monster {
    id = "mon_lizardfolk_hunter",
    looks_like = "mon_lizardfolk_hunter",
    name = ccb.content.plural_text("lizardman hunter", "lizardman hunters"),
    description = ccb.content.text("One of the lizardfolk of the swamps.  Lithe and deadly, this is a hunter, bringing back the game that the lizardfolk require."),
    copy_from = "mon_lizardfolk_warrior",
    symbol = "L",
    attacks = {
        {
            cooldown = 5,
            move_cost = 150,
            kind = "gun",
            gun = {
                weapon = "lizardfolk_javelin_throw",
                skills = { { id = "gun", level = 5 }, { id = "rifle", level = 4 } },
                dexterity = 8,
                perception = 8,
                lock_player = false,
                ranges = { { minimum = 2, maximum = 10, mode = "DEFAULT" } },
                description = ccb.content.text("The lizardman hunter hurls a javelin at you!"),
            },
        },
        { id = "scratch", cooldown = 2, when = "monster_attack_armed" },
        { cooldown = 3, kind = "bite", when = "monster_attack_armed" },
    },
    inheritance = { scale = { hp = 0.9, volume = 0.9, mass = 0.9, speed = 0.97 } },
    death = {
        drops = {
            entries = {
                { item = "spear_stone", probability = 30 },
                { item = "javelin", probability = 40 },
                { item = "spearsling", probability = 20 },
            },
        },
    },
}
