local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zimorphodon",
    name = ccb.content.plural_text("Dimorphodon zombie", "Dimorphodon zombie"),
    copy_from = "mon_zamptosaurus",
    looks_like = "mon_dimorphodon",
    volume = "30 L",
    mass = "40 kg",
    body_type = "bird",
    speed = 90,
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 0 } },
    hp = 50,
    description = ccb.content.text("The raggedly flying corpse  of a feathered reptile over three feet long, with short wings and a big colorful beak."),
    upgrade = false,
    armor = { bash = 4, cut = 4, bullet = 1 },
}

ccb.content.define_monster {
    id = "mon_zimorphodon_brute",
    name = ccb.content.plural_text("Winged Horror", "Winged Horrors"),
    copy_from = "mon_zimorphodon",
    description = ccb.content.text("The flying corpse of a feathered reptile over three feet long, with short wings and a big colorful beak.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    categories = { "DINOSAUR" },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { type = "cut", amount = 2 },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zimorphodon_bio_op",
    name = ccb.content.plural_text("Dimorphozombie bio-operator", "Dimorphozombie bio-operators"),
    copy_from = "mon_zimorphodon",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 100,
    luminance = 4,
    attacks = { { reference = "BIO_OP_TAKEDOWN", cooldown = 20 } },
    description = ccb.content.text("The raggedly flying corpse of a feathered reptile, with short wings and a colorful glowing beak.  It has been implanted with crackling bionics and is dripping black goo."),
    defense = { id = "ZAPBACK", chance = 75 },
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}
