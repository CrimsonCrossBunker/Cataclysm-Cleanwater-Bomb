local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zombie_hammer_hands",
    name = ccb.content.plural_text("rust fist brute", "rust fist brutes"),
    description = ccb.content.text("This brute of a zombie is covered in rusted metal detritus.  Chunks of metal smashed through its arms have deformed them into hammers."),
    copy_from = "mon_zombie_base",
    mass = "90 kg",
    hp = 120,
    speed = 75,
    materials = { "flesh", "steel" },
    looks_like = "mon_zombie_brute",
    color = "brown",
    scents_tracked = { "sc_human", "sc_fetid" },
    melee_dice = 3,
    melee_sides = 8,
    melee_damage = { { type = "cut", amount = 2 } },
    bleed_rate = 0,
    vision_day = 14,
    vision_night = 1,
    harvest = "zombie_rust",
    decay = "zombie_decay_bone_human_skull_rust",
    attacks = {
        { id = "bite_humanoid", cooldown = 5 },
        {
            id = "smash",
            damage = { { type = "bash", amount = 10 } },
            throw_strength = 35,
            cooldown = 10,
        },
    },
    attack_effects = { { id = "tetanus", duration = 300, chance = 10 } },
    burn_into = "mon_zombie_fiend_rust",
    upgrade = false,
    armor = { bash = 8, cut = 8, stab = 8, bullet = 8 },
    inheritance = { add = { flags = { "SMELLS", "PUSH_VEH" } }, remove = { flags = { "GRABS" } } },
}

ccb.content.define_monster {
    id = "mon_zombie_urchin",
    name = "rust urchin",
    description = "A spiked horror of a zombie covered in long, rusty spikes.  A walking tetanus infection waiting to happen.",
    copy_from = "mon_zombie_base",
    color = "brown",
    mass = "90 kg",
    harvest = "zombie_rust",
    decay = "zombie_decay_bone_human_skull_rust",
    burn_into = "mon_zombie_scorched_rust",
    hp = 100,
    speed = 60,
    melee_skill = 3,
    melee_sides = 6,
    grab_strength = 35,
    bleed_rate = 0,
    species = { "ZOMBIE" },
    scents_tracked = { "sc_human", "sc_fetid" },
    materials = { "flesh", "steel" },
    armor = { bash = 5, cut = 5, stab = 5, bullet = 5 },
    melee_damage = {
        { type = "cut", amount = 12 },
    },
    attack_effects = {
        { id = "tetanus", chance = 20, duration = 300 },
    },
    upgrade = false,
    inheritance = {
        add = {
            flags = { "CLUMSY_ATTACKS" },
            attacks = {
                { id = "impale" },
            },
        },
    },
}
