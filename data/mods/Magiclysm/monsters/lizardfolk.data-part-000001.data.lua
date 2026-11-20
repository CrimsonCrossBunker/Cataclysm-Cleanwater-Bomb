local ccb = require("ccb")

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
