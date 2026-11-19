local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zilophosaurus_brute",
    name = ccb.content.plural_text("Crested Crusher", "Crested Crushers"),
    copy_from = "mon_zilophosaurus",
    description = ccb.content.text("The shuffling corpse of a medium-sized dinosaur with sharp teeth and two prominent bony crests on its head, with ragged strips of ripped flesh hanging down like a frill.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "480 L",
    mass = "480 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeratosaurus_brute",
    name = ccb.content.plural_text("Draco Titan", "Draco Titans"),
    copy_from = "mon_zeratosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("This zombie is enormous, scaly, and studded with long bony spikes.  Its colorful horns and bone spikes sit on a body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "650 L",
    mass = "650 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zpinosaurus_brute",
    name = ccb.content.plural_text("Spino Sledge", "Spino Sledges"),
    copy_from = "mon_zpinosaurus",
    description = ccb.content.text("Enormous putrid dinosaur corpse with a ferocious crocodile-like head, oozing black eyes, and a tattered sail on its back.  Its body is even bigger than normal, bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zorvosaurus_brute",
    name = ccb.content.plural_text("Torvosaurus Terror", "Torvosaurus Terrors"),
    copy_from = "mon_zorvosaurus",
    description = ccb.content.text("Enormous putrid dinosaur corpse with long, sharp teeth, oozing black eyes, and a tail.  Its body is even bigger than normal, bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zallosaurus_brute",
    name = ccb.content.plural_text("Allosaurus Avalanche", "Allosaurus Avalanches"),
    copy_from = "mon_zallosaurus",
    description = ccb.content.text("The shambling corpse of a large predatory bipedal dinosaur.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zallosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zacrocanthosaurus_brute",
    name = ccb.content.plural_text("Acrocanthosaurus Avenger", "Acrocanthosaurus Avengers"),
    copy_from = "mon_zacrocanthosaurus",
    description = ccb.content.text("The shambling corpse of a large predatory bipedal dinosaur with curved, sawblade-like teeth.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zallosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ziganotosaurus_brute",
    name = ccb.content.plural_text("Giganotosaurus Avenger", "Giganotosaurus Avengers"),
    copy_from = "mon_ziganotosaurus",
    description = ccb.content.text("The shambling corpse of a huge predatory bipedal dinosaur with a strong chin.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zallosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ziats_brute",
    name = ccb.content.plural_text("Siats Stonehenge", "Siats Stonehenges"),
    copy_from = "mon_ziats",
    description = ccb.content.text("The shambling corpse of a large predatory bipedal dinosaur with long claws and strong arms for grappling.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zallosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zryptosaurus_brute",
    name = ccb.content.plural_text("Dryptosaurus Dynamo", "Dryptosaurus Dynamos"),
    copy_from = "mon_zryptosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Large jaws lifted by an upright undead dinosaur body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { id = "bite_grab", cooldown = 7 }, { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanotyrannus_brute",
    name = ccb.content.plural_text("Nasty Nano", "Nasty Nanos"),
    copy_from = "mon_zanotyrannus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Large jaws lifted by a long legged upright undead dinosaur body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { id = "bite_grab", cooldown = 7 }, { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zappalachiosaurus_brute",
    name = ccb.content.plural_text("Appalachian Anvil", "Appalachian Anvils"),
    copy_from = "mon_zappalachiosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Massive jaws lifted by an upright undead dinosaur body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { id = "bite_grab", cooldown = 7 }, { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zorgosaurus_brute",
    name = ccb.content.plural_text("Gorgosaurus Goliath", "Gorgosaurus Goliaths"),
    copy_from = "mon_zorgosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Massive jaws lifted by an upright undead dinosaur body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 }, { id = "bite_grab", cooldown = 7 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zalbertosaurus_brute",
    name = ccb.content.plural_text("Alberta Anvil", "Alberta Anvils"),
    copy_from = "mon_zalbertosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Massive jaws and grabbing claws lifted by an undead body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 }, { id = "bite_grab", cooldown = 7 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zianzhousaurus_brute",
    name = ccb.content.plural_text("Qianzhousaurus chéngqiáng", "Qianzhousaurus chéngqiáng"),
    copy_from = "mon_zianzhousaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Massive jaws on a long snout lifted by an undead body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "925 L",
    mass = "925 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 }, { id = "bite_grab", cooldown = 7 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanuqsaurus_brute",
    name = ccb.content.plural_text("Ice Horror", "Ice Horrors"),
    copy_from = "mon_zanuqsaurus",
    description = ccb.content.text("Massive jaws with long, sharp teeth lifted by an undead body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 }, { id = "bite_grab", cooldown = 7 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zaspletosaurus_brute",
    name = ccb.content.plural_text("Daspletosaurus Damage", "Daspletosaurus Damages"),
    copy_from = "mon_zaspletosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Massive jaws with long, sharp teeth lifted by an undead body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 }, { id = "bite_grab", cooldown = 7 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zyrannosaurus_brute",
    name = ccb.content.plural_text("Rage Rex", "Rage Rexes"),
    copy_from = "mon_zyrannosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("A massive pile of ragged, stinking flesh lifting enormous teeth.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zyrannosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zedcolbertia_brute",
    name = ccb.content.plural_text("Nedcolbertia Knuckles", "Nedcolbertia Knuckles"),
    copy_from = "mon_zedcolbertia",
    description = ccb.content.text("The shuffling corpse of a bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "60 L",
    mass = "60 kg",
    color = "red",
    attack_cost = 202,
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zallimimus_brute",
    name = ccb.content.plural_text("Gruesome Gallimimus", "Gruesome Gallimimus"),
    copy_from = "mon_zallimimus",
    description = ccb.content.text("The shuffling corpse of a bipedal beaked dinosaur covered with tattered feathers and black, putrid liquid.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "530 L",
    mass = "530 kg",
    color = "red",
    attack_cost = 202,
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ztruthiomimus_brute",
    name = ccb.content.plural_text("Struthiomimus Striker", "Struthiomimus Strikers"),
    copy_from = "mon_zallimimus_brute",
    looks_like = "mon_gallimimus",
    volume = "500 L",
    mass = "500 kg",
    speed = 210,
    attack_cost = 210,
    burn_into = "mon_ztruthiomimus_scorched",
    fungalize_into = "mon_ztruthiomimus_fungus",
}

ccb.content.define_monster {
    id = "mon_zornithomimus_brute",
    name = ccb.content.plural_text("Ornery Ornithomimus", "Ornery Ornithomimus"),
    copy_from = "mon_zallimimus_brute",
    looks_like = "mon_gallimimus",
    volume = "200 L",
    mass = "200 kg",
    speed = 185,
    attack_cost = 185,
    burn_into = "mon_zornithomimus_scorched",
    fungalize_into = "mon_zornithomimus_fungus",
    inheritance = { add = { flags = { "CLIMBS" } } },
}

ccb.content.define_monster {
    id = "mon_zalcarius_brute",
    name = ccb.content.plural_text("Fatal Falcarius", "Fatal Falcarius"),
    copy_from = "mon_zalcarius",
    description = ccb.content.text("The shuffling corpse of a bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Long claws protrude from its hands.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "120 L",
    mass = "120 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zerizinosaurus_brute",
    name = ccb.content.plural_text("Thundering Therizinosaurus", "Thundering Therizinosaurus"),
    copy_from = "mon_zerizinosaurus",
    description = ccb.content.text("The shuffling corpse of a huge bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Long claws protrude from its hands.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zothronychus_brute",
    name = ccb.content.plural_text("Nefarious Nothronychus", "Nefarious Nothronychus"),
    copy_from = "mon_zothronychus",
    description = ccb.content.text("The shuffling corpse of a large bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Long curved claws protrude from its hands.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "950 L",
    mass = "950 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanzu_brute",
    name = ccb.content.plural_text("Clawed Crusher", "Clawed Crushers"),
    copy_from = "mon_zanzu",
    description = ccb.content.text("The shuffling corpse of a large bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Long claws protrude from its hands.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "300 L",
    mass = "300 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeinonychus_brute",
    name = ccb.content.plural_text("Deino Destroyer", "Deino Destroyers"),
    copy_from = "mon_zeinonychus",
    description = ccb.content.text("The shuffling corpse of a medium-sized bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Both feet brandish a large sickle-shaped claw.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "85 L",
    mass = "85 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zutahraptor_brute",
    name = ccb.content.plural_text("Utah Hoodoo", "Utah Hoodoos"),
    copy_from = "mon_zutahraptor",
    description = ccb.content.text("The swaying, hopping corpse of a large bipedal dinosaur with feathered arms, a long tail, and long, sharp, scythe-shaped claws.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "600 L",
    mass = "600 kg",
    color = "red",
    speed = 150,
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zarahsaurus_brute",
    name = ccb.content.plural_text("Savage Sarah", "Savage Sarahs"),
    copy_from = "mon_zarahsaurus",
    description = ccb.content.text("Long-necked, two-legged dinosaur corpse with a long tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "240 L",
    mass = "240 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanchisaurus_brute",
    name = ccb.content.plural_text("American Ammo", "American Ammo"),
    copy_from = "mon_zanchisaurus",
    description = ccb.content.text("Long-necked, four-legged dinosaur corpse.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "36 L",
    mass = "36 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zissi_brute",
    name = ccb.content.plural_text("Frozen Fury", "Frozen Furies"),
    copy_from = "mon_zissi",
    description = ccb.content.text("Large, long-necked, two-legged dinosaur corpse with a long tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zoabosaurus_brute",
    name = ccb.content.plural_text("Moab Masher", "Moab Mashers"),
    copy_from = "mon_zoabosaurus",
    description = ccb.content.text("Huge, long-necked, four-legged dinosaur corpse with a long tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zaplocanthosaurus_brute",
    name = ccb.content.plural_text("Haplosmashosaurus", "Haplosmashosaurus"),
    copy_from = "mon_zaplocanthosaurus",
    description = ccb.content.text("Huge, long-necked, four-legged dinosaur corpse with a long tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zamargasaurus_brute",
    name = ccb.content.plural_text("Spiked Dreadnaught", "Spiked Dreadnaughts"),
    copy_from = "mon_zamargasaurus",
    description = ccb.content.text("Huge, long-necked, four-legged dinosaur corpse with two parallel rows of tall spines down its neck and back and a whip-like tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zapatosaurus_brute",
    name = ccb.content.plural_text("Anabolic Apatosaurus", "Anabolic Apatosaurus"),
    copy_from = "mon_zapatosaurus",
    description = ccb.content.text("Massive, long-necked, four-legged dinosaur corpse with a long, whip-like tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zrontosaurus_brute",
    name = ccb.content.plural_text("Brontosaurus Brute", "Brontosaurus Brutes"),
    copy_from = "mon_zrontosaurus",
    description = ccb.content.text("Massive, long-necked, four-legged dinosaur corpse with a long, whip-like tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zapatosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ziplodocus_brute",
    name = ccb.content.plural_text("Flail Fiend", "Flail Fiends"),
    copy_from = "mon_ziplodocus",
    description = ccb.content.text("Huge, long-necked, four-legged dinosaur corpse with a long, whip-like tail and a tiny head with vacant white eyes.  Sways and staggers.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zapatosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zarosaurus_brute",
    name = ccb.content.plural_text("Barosaurus Brute", "Barosaurus Brutes"),
    copy_from = "mon_zarosaurus",
    description = ccb.content.text("Huge, long-necked, four-legged dinosaur corpse with a long, whip-like tail.  There is a large claw on each foreleg.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zapatosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zamarasaurus_brute",
    name = ccb.content.plural_text("Zombie Freight Train", "Zombie Freight Trains"),
    copy_from = "mon_zamarasaurus",
    description = ccb.content.text("Massive, four-legged dinosaur corpse with a square head and even bulkier frame.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zapatosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zrachiosaurus_brute",
    name = ccb.content.plural_text("Brachiosaurus Brute", "Brachiosaurus Brutes"),
    copy_from = "mon_zrachiosaurus",
    description = ccb.content.text("Gigantic four-legged dinosaur corpse with longer forelegs and a whip-like tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zapatosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zastrodon_brute",
    name = ccb.content.plural_text("Astrodon Assault", "Astrodon Assaults"),
    copy_from = "mon_zastrodon",
    description = ccb.content.text("Gigantic four-legged dinosaur corpse with an enormous nose.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zapatosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zalamosaurus_brute",
    name = ccb.content.plural_text("Anabolic Alamosaurus", "Anabolic Alamosaurus"),
    copy_from = "mon_zalamosaurus",
    description = ccb.content.text("Gigantic, four-legged dinosaur corpse with a long neck and a spiked whip-like tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zapatosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ztegosaurus_brute",
    name = ccb.content.plural_text("Stegosaurus Sledge", "Stegosaurus Sledges"),
    copy_from = "mon_ztegosaurus",
    description = ccb.content.text("A large, shambling, quadrupedal dinosaur corpse with tall plates on its back, waving a spiked tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zesperosaurus_brute",
    name = ccb.content.plural_text("Hesperosaurus Horror", "Hesperosaurus Horrors"),
    copy_from = "mon_zesperosaurus",
    description = ccb.content.text("A large, shambling, quadrupedal dinosaur corpse with long plates on its back, waving a spiked tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zastonia_brute",
    name = ccb.content.plural_text("Spiked Gauntlet", "Spiked Gauntlets"),
    copy_from = "mon_zastonia",
    description = ccb.content.text("Heavily armored four legged dinosaur corpse with a long tail, a beak, and large shoulder spikes.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zargoyleosaurus_brute",
    name = ccb.content.plural_text("Grim Gargoyle", "Grim Gargoyles"),
    copy_from = "mon_zargoyleosaurus",
    description = ccb.content.text("Armored four legged zombie dinosaur with a beak and rigid tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "500 L",
    mass = "600 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zauropelta_brute",
    name = ccb.content.plural_text("Horrorpelta", "Horrorpeltas"),
    copy_from = "mon_zauropelta",
    description = ccb.content.text("Heavily-armored four-legged zombie dinosaur with large bone spikes along the sides and two very large ones protecting the neck.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zodosaurus_brute",
    name = ccb.content.plural_text("Nodosaurus Neutralizer", "Nodosaurus Neutralizers"),
    copy_from = "mon_zodosaurus",
    description = ccb.content.text("Heavily-armored zombie dinosaur.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanoplosaurus_brute",
    name = ccb.content.plural_text("Panoply of Pain", "Panoply of Pains"),
    copy_from = "mon_zanoplosaurus",
    description = ccb.content.text("This heavily armored four legged dinosaur corpse has a lumpy armored head with a beak and thick plates protecting the cheeks and small short spikes along the sides.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zedmontonia_brute",
    name = ccb.content.plural_text("Edmontonia Elbow", "Edmontonia Elbows"),
    copy_from = "mon_zedmontonia",
    description = ccb.content.text("Heavily-armored zombie dinosaur with long, bony spikes.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zzuul_brute",
    name = ccb.content.plural_text("Rule of Zuul", "Rules of Zuul"),
    copy_from = "mon_zzuul",
    description = ccb.content.text("Heavily-armored four-legged zombie dinosaur covered with spikes with a club-like tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zyoplosaurus_brute",
    name = ccb.content.plural_text("Dino Tankette", "Dino Tankettes"),
    copy_from = "mon_zyoplosaurus",
    description = ccb.content.text("Heavily-armored zombie dinosaur with a thick, spiked tail.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zankylosaurus_brute",
    name = ccb.content.plural_text("Dino Tank", "Dino Tanks"),
    copy_from = "mon_zankylosaurus",
    description = ccb.content.text("Heavily-armored four legged zombie dinosaur with a beak and a massive spiked tail of bone.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zuoplocephalus_brute",
    name = ccb.content.plural_text("Horned Horror", "Horned Horrors"),
    copy_from = "mon_zuoplocephalus",
    description = ccb.content.text("This heavily armored four legged dinosaur corpse has a horny beak, two bony rings protecting the neck, a horn studded and bone plated back, and a long tail ending in a heavy club of bone.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zcolosaurus_brute",
    name = ccb.content.plural_text("Cutler Crusher", "Cutler Crushers"),
    copy_from = "mon_zcolosaurus",
    description = ccb.content.text("This heavily armored four legged dinosaur corpse has several long spikes along the back and a long spiked tail ending in a club of bone.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zankylosaurus_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zenontosaurus_brute",
    name = ccb.content.plural_text("Sinewy Striker", "Sinewy Strikers"),
    copy_from = "mon_zenontosaurus",
    description = ccb.content.text("The shuffling corpse of a feathered dinosaur with grossly-bulging legs, massive hulking shoulders, a vicious pointed beak and long powerful tail.  Its tattered feathers are stained with black, sticky liquid."),
    difficulty_adjustment = 2,
    volume = "950 L",
    mass = "950 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zryosaurus_brute",
    name = ccb.content.plural_text("Dry Destroyer", "Dry Destroyers"),
    copy_from = "mon_zryosaurus",
    description = ccb.content.text("The shuffling corpse of a feathered, bipedal dinosaur with grossly-bulging legs, long thick neck, and a vicious pointed beak.  Its tattered feathers are stained with black, sticky liquid."),
    difficulty_adjustment = 2,
    volume = "55 L",
    mass = "55 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zamptosaurus_brute",
    name = ccb.content.plural_text("Crusher Camp", "Crusher Camps"),
    copy_from = "mon_zamptosaurus",
    description = ccb.content.text("The shuffling corpse of a large, feathered, bipedal dinosaur with grossly-bulging legs, massive hulking shoulders, and a vicious pointed beak.  Its tattered feathers are stained with black, sticky liquid."),
    difficulty_adjustment = 2,
    volume = "1000 L",
    mass = "1000 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ziguanodon_brute",
    name = ccb.content.plural_text("Inevitable Iguanodon", "Inevitable Iguanodons"),
    copy_from = "mon_ziguanodon",
    description = ccb.content.text("A bulky, four-legged dinosaur with a beak and spiked thumbs, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeolambia_brute",
    name = ccb.content.plural_text("Rampage", "Rampages"),
    copy_from = "mon_zeolambia",
    description = ccb.content.text("A four-legged dinosaur with a long neck and beak, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zadrosaurus_brute",
    name = ccb.content.plural_text("Hulking Hadrosaur", "Hulking Hadrosaurs"),
    copy_from = "mon_zadrosaurus",
    description = ccb.content.text("A bulky, four-legged dinosaur with a beak, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zaiasaura_brute",
    name = ccb.content.plural_text("Mother Crusher", "Mother Crushers"),
    copy_from = "mon_zaiasaura",
    description = ccb.content.text("A huge, mottled dinosaur with hooves and a heavy tail, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zryposaurus_brute",
    name = ccb.content.plural_text("Roman Wrecker", "Roman Wreckers"),
    copy_from = "mon_zryposaurus",
    description = ccb.content.text("A huge, scaly dinosaur with a toothless beak and large nasal arch, dead but walking, eyes vacant and white.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zrosaurolophus_brute",
    name = ccb.content.plural_text("Pro Punishment", "Pro Punishments"),
    copy_from = "mon_zrosaurolophus",
    description = ccb.content.text("A huge, scaly dinosaur with hooves, a short beak and a tall head crest, dead but walking, eyes vacant and white.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zaurolophus_brute",
    name = ccb.content.plural_text("Spiked Smasher", "Spiked Smashers"),
    copy_from = "mon_zaurolophus",
    description = ccb.content.text("A huge, scaly dinosaur with hooves, a broad beak and a spiky head crest, dead but walking, eyes vacant and white.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zedmontosaurus_brute",
    name = ccb.content.plural_text("Edmonton Everest", "Edmonton Everests"),
    copy_from = "mon_zedmontosaurus",
    description = ccb.content.text("A huge, scaly dinosaur with a broad, toothless beak, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zarasaurolophus_brute",
    name = ccb.content.plural_text("Parasaur Punch", "Parasaur Punches"),
    copy_from = "mon_zarasaurolophus",
    description = ccb.content.text("A huge, mottled dinosaur with a blunt head crest, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zambeosaurus_brute",
    name = ccb.content.plural_text("Hatchet Horror", "Hatchet Horrors"),
    copy_from = "mon_zambeosaurus",
    description = ccb.content.text("A huge, scaly dinosaur with a short beak and a head crest shaped like a hatchet, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zorythosaurus_brute",
    name = ccb.content.plural_text("Cory Crusher", "Cory Crushers"),
    copy_from = "mon_zorythosaurus",
    description = ccb.content.text("A huge, scaly dinosaur with a short beak and a tall head crest, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zypacrosaurus_brute",
    name = ccb.content.plural_text("Ridgeback Ripper", "Ridgeback Rippers"),
    copy_from = "mon_zypacrosaurus",
    description = ccb.content.text("A huge, scaly dinosaur with a tall ridge down the back, a short beak and a wide, rounded head crest, dead but walking, eyes vacant and swollen.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zachycephalosaurus_brute",
    name = ccb.content.plural_text("Skull Breaker", "Skull Breakers"),
    copy_from = "mon_zachycephalosaurus",
    description = ccb.content.text("The shuffling corpse of a medium-sized bipedal dinosaur, covered with tattered feathers and black, putrid liquid.  Its hard-looking domed head sits on a body bulging with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "550 L",
    mass = "550 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeptoceratops_brute",
    name = ccb.content.plural_text("Leaping Leptoceratops", "Leaping Leptoceratops"),
    copy_from = "mon_zeptoceratops",
    description = ccb.content.text("A shambling, four-legged dinosaur corpse with a bony crest and beak.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "120 L",
    mass = "120 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = {
        { reference = "SMASH", cooldown = 30 },
        { cooldown = 20, maximum_range = 5, allow_no_target = true, kind = "leap" },
    },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zzuniceratops_brute",
    name = ccb.content.plural_text("Zuni Flood", "Zuni Floods"),
    copy_from = "mon_zzuniceratops",
    description = ccb.content.text("A four-legged dinosaur with a tall thin bony head crest, two long brow horns, and a beak.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "200 L",
    mass = "200 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zokiceratops_brute",
    name = ccb.content.plural_text("Loki Lug", "Loki Lugs"),
    copy_from = "mon_zokiceratops",
    description = ccb.content.text("A four-legged dinosaur with a bony head crest with two curved horns pointing out and down, two long brow horns, and a beak.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ztyracosaurus_brute",
    name = ccb.content.plural_text("Spear Lizard", "Spear Lizards"),
    copy_from = "mon_ztyracosaurus",
    description = ccb.content.text("A massive, four-legged dinosaur corpse with a spiked frill, a hooked beak, and a long horn above the nose.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zentrosaurus_brute",
    name = ccb.content.plural_text("Pain Central", "Pain Centrals"),
    copy_from = "mon_zentrosaurus",
    description = ccb.content.text("A massive, rhino-like dinosaur corpse with a beak and long horn above the nose.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeiniosaurus_brute",
    name = ccb.content.plural_text("Horn Hook", "Horn Hooks"),
    copy_from = "mon_zeiniosaurus",
    description = ccb.content.text("A massive, four-legged dinosaur corpse with a hooked beak, long frill, and long horn curving forward towards the nose.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zachelousaurus_brute",
    name = ccb.content.plural_text("Achelousaurus Anvil", "Achelousaurus Anvils"),
    copy_from = "mon_zachelousaurus",
    description = ccb.content.text("A massive, four-legged dinosaur corpse with a tall bony crest with two long curved spikes and three rough bosses above the eyes and nose as well as a short tail and hooked beak.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zachyrhinosaurus_brute",
    name = ccb.content.plural_text("Dino Rhino", "Dino Rhinos"),
    copy_from = "mon_zachyrhinosaurus",
    description = ccb.content.text("A massive, shambling, rhino-like dinosaur corpse with two massive bony bosses on its brow and nose.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zasmosaurus_brute",
    name = ccb.content.plural_text("Crashing Chasm", "Crashing Chasms"),
    copy_from = "mon_zasmosaurus",
    description = ccb.content.text("A massive, four-legged dinosaur corpse with a tall bony crest from which three short horns emerge above the eyes and beak.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zentaceratops_brute",
    name = ccb.content.plural_text("Pentapanic", "Pentapanics"),
    copy_from = "mon_zentaceratops",
    description = ccb.content.text("A massive, shambling, rhino-like dinosaur corpse with a tall bony crest from which four long horns and a short nose horn emerge.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zosmoceratops_brute",
    name = ccb.content.plural_text("Kosmic Horror", "Kosmic Horrors"),
    copy_from = "mon_zosmoceratops",
    description = ccb.content.text("A massive, shambling, rhino-like dinosaur corpse with a bony crest and two wavy side horns.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zorosaurus_brute",
    name = ccb.content.plural_text("Bull Dino", "Bull Dinos"),
    copy_from = "mon_zorosaurus",
    description = ccb.content.text("A massive, shambling, rhino-like dinosaur corpse with a bony crest from which two wicked-looking horns emerge.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zriceratops_brute",
    name = ccb.content.plural_text("Triceratruck", "Triceratrucks"),
    copy_from = "mon_zriceratops",
    description = ccb.content.text("A massive, shambling, rhino-like dinosaur corpse with a bony crest from which three wicked-looking horns emerge.  Its eyes ooze black, putrid tears.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    color = "red",
    bleed_rate = 50,
    upgrade = { half_life = 168, monster_group = "GROUP_zriceratops_BRUTE" },
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zona_brute",
    name = ccb.content.plural_text("Fona Fury", "Fona Furies"),
    copy_from = "mon_zona",
    description = ccb.content.text("The shuffling corpse of a bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "60 L",
    mass = "60 kg",
    color = "red",
    attack_cost = 120,
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zescelosaurus_brute",
    name = ccb.content.plural_text("Godlike Goliath", "Godlike Goliaths"),
    copy_from = "mon_zescelosaurus",
    description = ccb.content.text("The shuffling corpse of a beaked bipedal dinosaur covered with tattered feathers and black, putrid liquid.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "300 L",
    mass = "300 kg",
    color = "red",
    attack_cost = 180,
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zteranodon_brute",
    name = ccb.content.plural_text("Winged Horror", "Winged Horrors"),
    copy_from = "mon_zteranodon",
    description = ccb.content.text("The ragged but flying corpse of a large feathered reptile with a long, pointed, toothless beak and a long, pointy head crest.  Its entire body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 2,
    volume = "85 L",
    mass = "60 kg",
    color = "red",
    bleed_rate = 50,
    upgrade = false,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "cut", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zilophosaurus_shady",
    name = ccb.content.plural_text("shady dilophosaurus zombie", "shady dilophosaurus zombies"),
    copy_from = "mon_zilophosaurus",
    looks_like = "mon_dilophosaurus",
    upgrade = { half_life = 60, monster = "mon_zilophosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with sharp teeth and bulges on the head."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zeratosaurus_shady",
    name = ccb.content.plural_text("shady ceratosaurus zombie", "shady ceratosaurus zombies"),
    copy_from = "mon_zeratosaurus",
    upgrade = { half_life = 60, monster = "mon_zeratosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of an enormous, bipedal dinosaur with horns, spikes, and big sharp teeth."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zpinosaurus_shady",
    name = ccb.content.plural_text("shady spinosaurus zombie", "shady spinosaurus zombies"),
    copy_from = "mon_zpinosaurus",
    upgrade = { half_life = 60, monster = "mon_zpinosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with a tattered sail.  The head is long and narrow, with a V-shaped snout."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zorvosaurus_shady",
    name = ccb.content.plural_text("shady torvosaurus zombie", "shady torvosaurus zombies"),
    copy_from = "mon_zorvosaurus",
    upgrade = { half_life = 60, monster = "mon_zorvosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bipedal dinosaur with a large head and a tail."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zallosaurus_shady",
    name = ccb.content.plural_text("shady allosaurus zombie", "shady allosaurus zombies"),
    copy_from = "mon_zallosaurus",
    looks_like = "mon_allosaurus",
    upgrade = { half_life = 60, monster = "mon_zallosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bipedal dinosaur with big, sharp teeth."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zacrocanthosaurus_shady",
    name = ccb.content.plural_text("shady acrocanthosaurus zombie", "shady acrocanthosaurus zombies"),
    copy_from = "mon_zacrocanthosaurus",
    upgrade = { half_life = 60, monster = "mon_zacrocanthosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bipedal dinosaur with big, sharp teeth."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_ziganotosaurus_shady",
    name = ccb.content.plural_text("shady giganotosaurus zombie", "shady giganotosaurus zombies"),
    copy_from = "mon_ziganotosaurus",
    upgrade = { half_life = 60, monster = "mon_ziganotosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with big, sharp teeth."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_ziats_shady",
    name = ccb.content.plural_text("shady siats zombie", "shady siats zombies"),
    copy_from = "mon_ziats",
    upgrade = { half_life = 60, monster = "mon_ziats_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bipedal dinosaur with big, sharp teeth."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zryptosaurus_shady",
    name = ccb.content.plural_text("shady dryptosaurus zombie", "shady dryptosaurus zombies"),
    copy_from = "mon_zryptosaurus",
    upgrade = { half_life = 60, monster = "mon_zryptosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bipedal dinosaur with feathery edges.  The head looks big and the claws look long."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zanotyrannus_shady",
    name = ccb.content.plural_text("shady nanotyrannus zombie", "shady nanotyrannus zombies"),
    copy_from = "mon_zanotyrannus",
    upgrade = { half_life = 60, monster = "mon_zanotyrannus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bipedal dinosaur with feathery edges.  The head looks big and the legs look long."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zappalachiosaurus_shady",
    name = ccb.content.plural_text("shady appalachiosaurus zombie", "shady appalachiosaurus zombies"),
    copy_from = "mon_zappalachiosaurus",
    upgrade = { half_life = 60, monster = "mon_zappalachiosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with feathery edges.  The head looks big, like it could hold many enormous sharp teeth."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zorgosaurus_shady",
    name = ccb.content.plural_text("shady gorgosaurus zombie", "shady gorgosaurus zombies"),
    copy_from = "mon_zorgosaurus",
    upgrade = { half_life = 60, monster = "mon_zorgosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with feathery edges.  The head looks big, like it could hold many enormous sharp teeth."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zalbertosaurus_shady",
    name = ccb.content.plural_text("shady albertosaurus zombie", "shady albertosaurus zombies"),
    copy_from = "mon_zalbertosaurus",
    upgrade = { half_life = 60, monster = "mon_zalbertosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with feathery edges.  The head looks big, and below are long, grasping claws."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zianzhousaurus_shady",
    name = ccb.content.plural_text("shady qianzhousaurus zombie", "shady qianzhousaurus zombies"),
    copy_from = "mon_zianzhousaurus",
    upgrade = { half_life = 60, monster = "mon_zianzhousaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with feathery edges and a large head."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zanuqsaurus_shady",
    name = ccb.content.plural_text("shady nanuqsaurus zombie", "shady nanuqsaurus zombies"),
    copy_from = "mon_zanuqsaurus",
    upgrade = { half_life = 60, monster = "mon_zanuqsaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with feathery edges and a large head."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zaspletosaurus_shady",
    name = ccb.content.plural_text("shady daspletosaurus zombie", "shady daspletosaurus zombies"),
    copy_from = "mon_zaspletosaurus",
    upgrade = { half_life = 60, monster = "mon_zaspletosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with feathery edges and a large head."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zyrannosaurus_shady",
    name = ccb.content.plural_text("shady tyrannosaurus zombie", "shady tyrannosaurus zombies"),
    copy_from = "mon_zyrannosaurus",
    upgrade = { half_life = 60, monster = "mon_zyrannosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with feathery edges.  The head looks large - lots of big teeth would fit in it."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zedcolbertia_shady",
    name = ccb.content.plural_text("shady nedcolbertia zombie", "shady nedcolbertia zombies"),
    copy_from = "mon_zedcolbertia",
    upgrade = { half_life = 60, monster = "mon_zedcolbertia_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    looks_like = "mon_zallimimus_shady",
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zallimimus_shady",
    name = ccb.content.plural_text("shady gallimimus zombie", "shady gallimimus zombies"),
    copy_from = "mon_zallimimus",
    upgrade = { half_life = 60, monster = "mon_zallimimus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges and a beak."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    looks_like = "mon_gallimimus",
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_ztruthiomimus_shady",
    name = ccb.content.plural_text("shady struthiomimus zombie", "shady struthiomimus zombies"),
    copy_from = "mon_ztruthiomimus",
    looks_like = "mon_gallimimus",
    upgrade = { half_life = 60, monster = "mon_ztruthiomimus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges and a beak."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zornithomimus_shady",
    name = ccb.content.plural_text("shady ornithomimus zombie", "shady ornithomimus zombies"),
    copy_from = "mon_zornithomimus",
    upgrade = { half_life = 60, monster = "mon_zornithomimus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges and a beak."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zalcarius_shady",
    name = ccb.content.plural_text("shady falcarius zombie", "shady falcarius zombies"),
    copy_from = "mon_zalcarius",
    upgrade = { half_life = 60, monster = "mon_zalcarius_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges.  Long claws protrude from its hands."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zerizinosaurus_shady",
    name = ccb.content.plural_text("shady therizinosaurus zombie", "shady therizinosaurus zombies"),
    copy_from = "mon_zerizinosaurus",
    upgrade = { half_life = 60, monster = "mon_zerizinosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges.  Long claws protrude from its hands."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zothronychus_shady",
    name = ccb.content.plural_text("shady nothronychus zombie", "shady nothronychus zombies"),
    copy_from = "mon_zothronychus",
    upgrade = { half_life = 60, monster = "mon_zothronychus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges.  Long curved claws protrude from its hands."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zanzu_shady",
    name = ccb.content.plural_text("shady anzu zombie", "shady anzu zombies"),
    copy_from = "mon_zanzu",
    upgrade = { half_life = 60, monster = "mon_zanzu_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large bipedal dinosaur with feathery edges.  Long claws protrude from its hands."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zeinonychus_shady",
    name = ccb.content.plural_text("shady deinonychus zombie", "shady deinonychus zombies"),
    copy_from = "mon_zeinonychus",
    upgrade = { half_life = 60, monster = "mon_zeinonychus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges.  Both feet brandish a large, sickle-shaped claw."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zutahraptor_shady",
    name = ccb.content.plural_text("shady utahraptor zombie", "shady utahraptor zombies"),
    copy_from = "mon_zutahraptor",
    upgrade = { half_life = 60, monster = "mon_zutahraptor_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a big, bipedal dinosaur with feathery edges.  Both feet brandish a large, sickle-shaped claw."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zankylosaurus_shady",
    name = ccb.content.plural_text("shady ankylosaurus zombie", "shady ankylosaurus zombies"),
    copy_from = "mon_zankylosaurus",
    upgrade = { half_life = 60, monster = "mon_zankylosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, heavily-armored, four-legged dinosaur with a spiked tail."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zona_shady",
    name = ccb.content.plural_text("shady fona zombie", "shady fona zombies"),
    copy_from = "mon_zona",
    upgrade = { half_life = 60, monster = "mon_zona_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges and a long tail."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zescelosaurus_shady",
    name = ccb.content.plural_text("shady thescelosaurus zombie", "shady thescelosaurus zombies"),
    copy_from = "mon_zescelosaurus",
    upgrade = { half_life = 60, monster = "mon_zescelosaurus_nightstalker" },
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bipedal dinosaur with feathery edges and a beak."),
    color = "light_gray",
    vision_day = 3,
    vision_night = 40,
    inheritance = { add = { flags = { "NIGHT_INVISIBILITY" } } },
}

ccb.content.define_monster {
    id = "mon_zilophosaurus_nightstalker",
    name = ccb.content.plural_text("dilophosaurus nightstalker", "dilophosaurus nightstalkers"),
    copy_from = "mon_zilophosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with sharp teeth and bulges on the head."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeratosaurus_nightstalker",
    name = ccb.content.plural_text("ceratosaurus nightstalker", "ceratosaurus nightstalkers"),
    copy_from = "mon_zeratosaurus_shady",
    looks_like = "mon_zeratosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of an enormous, bulky bipedal dinosaur with horns, spikes, and big sharp teeth."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zpinosaurus_nightstalker",
    name = ccb.content.plural_text("spinosaurus nightstalker", "spinosaurus nightstalkers"),
    copy_from = "mon_zpinosaurus_shady",
    looks_like = "mon_zpinosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with a tattered sail.  The head is long and narrow, with a V-shaped snout."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zorvosaurus_nightstalker",
    name = ccb.content.plural_text("torvosaurus nightstalker", "torvosaurus nightstalkers"),
    copy_from = "mon_zorvosaurus_shady",
    looks_like = "mon_zorvosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bulky bipedal dinosaur with a large head and a tail."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zallosaurus_nightstalker",
    name = ccb.content.plural_text("allosaurus nightstalker", "allosaurus nightstalkers"),
    copy_from = "mon_zallosaurus_shady",
    looks_like = "mon_zallosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bulky bipedal dinosaur with big, sharp teeth."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zacrocanthosaurus_nightstalker",
    name = ccb.content.plural_text("acrocanthosaurus nightstalker", "acrocanthosaurus nightstalkers"),
    copy_from = "mon_zacrocanthosaurus_shady",
    looks_like = "mon_zacrocanthosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bipedal dinosaur with big, sharp teeth."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ziganotosaurus_nightstalker",
    name = ccb.content.plural_text("giganotosaurus nightstalker", "giganotosaurus nightstalkers"),
    copy_from = "mon_ziganotosaurus_shady",
    looks_like = "mon_ziganotosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bipedal dinosaur with big, sharp teeth."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ziats_nightstalker",
    name = ccb.content.plural_text("siats nightstalker", "siats nightstalkers"),
    copy_from = "mon_ziats_shady",
    looks_like = "mon_ziats_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bulky bipedal dinosaur with big, sharp teeth."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zryptosaurus_nightstalker",
    name = ccb.content.plural_text("dryptosaurus nightstalker", "dryptosaurus nightstalkers"),
    copy_from = "mon_zryptosaurus_shady",
    looks_like = "mon_zryptosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bulky bipedal dinosaur with feathery edges.  The head looks big and the claws look long."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanotyrannus_nightstalker",
    name = ccb.content.plural_text("nanotyrannus nightstalker", "nanotyrannus nightstalkers"),
    copy_from = "mon_zanotyrannus_shady",
    looks_like = "mon_zanotyrannus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bulky bipedal dinosaur with feathery edges.  The head looks big and the legs look long."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zappalachiosaurus_nightstalker",
    name = ccb.content.plural_text("appalachiosaurus nightstalker", "appalachiosaurus nightstalkers"),
    copy_from = "mon_zappalachiosaurus_shady",
    looks_like = "mon_zappalachiosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with feathery edges.  The head looks big, like it could hold many enormous sharp teeth."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zorgosaurus_nightstalker",
    name = ccb.content.plural_text("gorgosaurus nightstalker", "gorgosaurus nightstalkers"),
    copy_from = "mon_zorgosaurus_shady",
    looks_like = "mon_zorgosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with feathery edges.  The head looks big, like it could hold many enormous sharp teeth."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zalbertosaurus_nightstalker",
    name = ccb.content.plural_text("albertosaurus nightstalker", "albertosaurus nightstalkers"),
    copy_from = "mon_zalbertosaurus_shady",
    looks_like = "mon_zalbertosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with feathery edges.  The head looks big, and below are long, grasping claws."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zianzhousaurus_nightstalker",
    name = ccb.content.plural_text("qianzhousaurus nightstalker", "qianzhousaurus nightstalkers"),
    copy_from = "mon_zianzhousaurus_shady",
    looks_like = "mon_zianzhousaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with feathery edges and a large head."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanuqsaurus_nightstalker",
    name = ccb.content.plural_text("nanuqsaurus nightstalker", "nanuqsaurus nightstalkers"),
    copy_from = "mon_zanuqsaurus_shady",
    looks_like = "mon_zanuqsaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with feathery edges and a large head."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zaspletosaurus_nightstalker",
    name = ccb.content.plural_text("daspletosaurus nightstalker", "daspletosaurus nightstalkers"),
    copy_from = "mon_zaspletosaurus_shady",
    looks_like = "mon_zaspletosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with feathery edges and a large head."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zyrannosaurus_nightstalker",
    name = ccb.content.plural_text("tyrannosaurus nightstalker", "tyrannosaurus nightstalkers"),
    copy_from = "mon_zyrannosaurus_shady",
    looks_like = "mon_zyrannosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a huge, bulky bipedal dinosaur with feathery edges.  The head looks large - lots of big teeth would fit in it."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zedcolbertia_nightstalker",
    name = ccb.content.plural_text("nedcolbertia nightstalker", "nedcolbertia nightstalkers"),
    copy_from = "mon_zedcolbertia_shady",
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zallimimus_nightstalker",
    name = ccb.content.plural_text("gallimimus nightstalker", "gallimimus nightstalkers"),
    copy_from = "mon_zallimimus_shady",
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_ztruthiomimus_nightstalker",
    name = ccb.content.plural_text("struthiomimus nightstalker", "struthiomimus nightstalkers"),
    copy_from = "mon_ztruthiomimus_shady",
    looks_like = "mon_ztruthiomimus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges and a beak."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zornithomimus_nightstalker",
    name = ccb.content.plural_text("ornithomimus nightstalker", "ornithomimus nightstalkers"),
    copy_from = "mon_zornithomimus_shady",
    looks_like = "mon_zornithomimus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges and a beak."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zalcarius_nightstalker",
    name = ccb.content.plural_text("falcarius nightstalker", "falcarius nightstalkers"),
    copy_from = "mon_zalcarius_shady",
    looks_like = "mon_zalcarius_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges.  Long claws protrude from its hands."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zerizinosaurus_nightstalker",
    name = ccb.content.plural_text("therizinosaurus nightstalker", "therizinosaurus nightstalkers"),
    copy_from = "mon_zerizinosaurus_shady",
    looks_like = "mon_zerizinosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges.  Long claws protrude from its hands."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zothronychus_nightstalker",
    name = ccb.content.plural_text("nothronychus nightstalker", "nothronychus nightstalkers"),
    copy_from = "mon_zothronychus_shady",
    looks_like = "mon_zothronychus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges.  Long curved claws protrude from its hands."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zanzu_nightstalker",
    name = ccb.content.plural_text("anzu nightstalker", "anzu nightstalkers"),
    copy_from = "mon_zanzu_shady",
    looks_like = "mon_zanzu_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, bulky bipedal dinosaur with feathery edges.  Long claws protrude from its hands."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeinonychus_nightstalker",
    name = ccb.content.plural_text("deinonychus nightstalker", "deinonychus nightstalkers"),
    copy_from = "mon_zeinonychus_shady",
    looks_like = "mon_zeinonychus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges.  Both feet brandish a large, sickle-shaped claw."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zutahraptor_nightstalker",
    name = ccb.content.plural_text("utahraptor nightstalker", "utahraptor nightstalkers"),
    copy_from = "mon_zutahraptor_shady",
    looks_like = "mon_zutahraptor_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a big, bulky bipedal dinosaur with feathery edges.  Both feet brandish a large, sickle-shaped claw."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zankylosaurus_nightstalker",
    name = ccb.content.plural_text("ankylosaurus nightstalker", "ankylosaurus nightstalkers"),
    copy_from = "mon_zankylosaurus_shady",
    looks_like = "mon_zankylosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a large, heavily-armored, four-legged dinosaur with a spiked tail."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zona_nightstalker",
    name = ccb.content.plural_text("fona nightstalker", "fona nightstalkers"),
    copy_from = "mon_zona_shady",
    looks_like = "mon_zona_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges and a long tail."),
    difficulty_adjustment = 2,
    attack_cost = 120,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zescelosaurus_nightstalker",
    name = ccb.content.plural_text("thescelosaurus nightstalker", "thescelosaurus nightstalkers"),
    copy_from = "mon_zescelosaurus_shady",
    looks_like = "mon_zescelosaurus_shady",
    description = ccb.content.text("An uncanny shadow envelops this creature.  You can make out the outline of a bulky bipedal dinosaur with feathery edges and a beak."),
    difficulty_adjustment = 2,
    bleed_rate = 50,
    attacks = { { reference = "SMASH", cooldown = 30 } },
    upgrade = false,
    inheritance = {
        add = { flags = { "GROUP_BASH", "PUSH_MON", "PUSH_VEH", "SMELLS" } },
        scale = { hp = 1.5, speed = 1.5 },
        offset = {
            melee_dice = 1,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 2 } },
            vision_night = 1,
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_silophosaurus",
    name = ccb.content.plural_text("skeletal dilophosaurus", "skeletal dilophosaurus"),
    looks_like = "mon_syrannosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, pointed teeth dripping with black goo.  Two especially bony crests on the top of the head complete the effect."),
    default_faction = "zombie",
    symbol = "Z",
    color = "white",
    materials = { "bone" },
    species = { "ZOMBIE", "DINOSAUR" },
    volume = "400 L",
    mass = "400 kg",
    body_type = "ostrich",
    hp = 48,
    aggression = 100,
    morale = 100,
    speed = 65,
    attack_cost = 65,
    melee_skill = 4,
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 6 } },
    bleed_rate = 50,
    vision_day = 30,
    vision_night = 3,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = { half_life = 60, monster = "mon_silophosaurus_brute" },
    attacks = { { reference = "scratch", cooldown = 10 }, { id = "teeth_zino_mid", cooldown = 10 } },
    flags = { "SEES", "HEARS", "PET_MOUNTABLE", "POISON", "NO_BREATHE", "REVIVES", "FILTHY" },
    harvest = "mr_bones",
    weakpoint_sets = { "wps_dinosaur_body" },
    categories = { "DINOSAUR" },
    armor = { bash = 0, cut = 19, acid = 3, bullet = 26, electric = 2 },
}

ccb.content.define_monster {
    id = "mon_seratosaurus",
    name = ccb.content.plural_text("skeletal ceratosaurus", "skeletal ceratosaurus"),
    copy_from = "mon_silophosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, pointed teeth dripping with black goo.  Spikes and colorful horns jut out to complete the effect."),
    volume = "540 L",
    mass = "540 kg",
    speed = 60,
    attack_cost = 60,
    hp = 55,
}

-- When large volumes are fixed this should be 15000 L
ccb.content.define_monster {
    id = "mon_skinosaurus",
    name = ccb.content.plural_text("skeletal spinosaurus", "skeletal spinosaurus"),
    copy_from = "mon_silophosaurus",
    looks_like = "mon_zpinosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting enormous, sharp, pointed teeth dripping with black goo.  There is a ridge of long spikes on the back."),
    volume = "1000 L",
    mass = "15000 kg",
    body_type = "elephant",
    speed = 35,
    attack_cost = 35,
    hp = 170,
    melee_dice = 5,
    melee_sides = 8,
    melee_damage = { { type = "cut", amount = 8 } },
    upgrade = { half_life = 60, monster = "mon_skinosaurus_brute" },
    inheritance = { add = { flags = { "DESTROYS" } } },
}

ccb.content.define_monster {
    id = "mon_sorvosaurus",
    name = ccb.content.plural_text("skeletal torvosaurus", "skeletal torvosaurus"),
    copy_from = "mon_skinosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting a long snout full of sharp, pointed teeth dripping with black goo."),
    body_type = "ostrich",
    hp = 105,
    melee_sides = 10,
    melee_damage = { { type = "cut", amount = 16 } },
    upgrade = { half_life = 60, monster = "mon_sorvosaurus_brute" },
    flags = { "SEES", "HEARS", "POISON", "BASHES", "NO_BREATHE", "REVIVES", "FILTHY" },
}

ccb.content.define_monster {
    id = "mon_sallosaurus",
    name = ccb.content.plural_text("skeletal allosaurus", "skeletal allosaurus"),
    copy_from = "mon_sorvosaurus",
    looks_like = "mon_zallosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, serrated teeth dripping with black goo."),
    speed = 80,
    attack_cost = 80,
    hp = 75,
    melee_dice = 3,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 8 } },
    upgrade = { half_life = 60, monster = "mon_sallosaurus_brute" },
}

ccb.content.define_monster {
    id = "mon_sacrocanthosaurus",
    name = ccb.content.plural_text("skeletal acrocanthosaurus", "skeletal acrocanthosaurus"),
    copy_from = "mon_sallosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, curved teeth dripping with black goo.  A tall ridge runs down the back."),
    speed = 55,
    attack_cost = 55,
    hp = 105,
    melee_dice = 5,
    melee_sides = 8,
    upgrade = { half_life = 60, monster = "mon_sallosaurus_brute" },
}

ccb.content.define_monster {
    id = "mon_siganotosaurus",
    name = ccb.content.plural_text("skeletal giganotosaurus", "skeletal giganotosaurus"),
    copy_from = "mon_sallosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, curved teeth dripping with black goo."),
    speed = 90,
    attack_cost = 90,
    hp = 350,
    melee_dice = 5,
    melee_sides = 8,
    upgrade = { half_life = 60, monster = "mon_sallosaurus_brute" },
}

ccb.content.define_monster {
    id = "mon_skiats",
    name = ccb.content.plural_text("skeletal siats", "skeletal siats"),
    copy_from = "mon_sacrocanthosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp teeth dripping with black goo.  There are long claws and strong arms for grappling."),
    hp = 145,
    melee_dice = 3,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 6 } },
    attacks = {
        { id = "bio_op_takedown", cooldown = 20 },
        { id = "ranged_pull", cooldown = 20 },
        { id = "grab_drag" },
        { id = "drag_followup" },
    },
    upgrade = { half_life = 60, monster = "mon_sallosaurus_brute" },
}

ccb.content.define_monster {
    id = "mon_sryptosaurus",
    name = ccb.content.plural_text("skeletal dryptosaurus", "skeletal dryptosaurus"),
    copy_from = "mon_sallosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting large jaws full of sharp, pointed teeth dripping with black goo."),
    hp = 80,
    melee_dice = 4,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 18 } },
    attacks = {
        { id = "teeth_zino_mid", cooldown = 15 },
        { id = "bite_grab", cooldown = 15 },
        { cooldown = 20, maximum_range = 5, allow_no_target = true, kind = "leap" },
    },
    upgrade = { half_life = 60, monster = "mon_syrannosaurus_brute" },
}

ccb.content.define_monster {
    id = "mon_sanotyrannus",
    name = ccb.content.plural_text("skeletal nanotyrannus", "skeletal nanotyrannus"),
    copy_from = "mon_sallosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Columns of dense bone lifting large jaws full of sharp, pointed teeth dripping with black goo."),
    speed = 70,
    hp = 60,
    melee_dice = 3,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 18 } },
    attacks = {
        { id = "teeth_zino_mid", cooldown = 15 },
        { id = "bite_grab", cooldown = 15 },
        { cooldown = 20, maximum_range = 5, allow_no_target = true, kind = "leap" },
    },
    upgrade = { half_life = 60, monster = "mon_syrannosaurus_brute" },
}

ccb.content.define_monster {
    id = "mon_sappalachiosaurus",
    name = ccb.content.plural_text("skeletal appalachiosaurus", "skeletal appalachiosaurus"),
    copy_from = "mon_sryptosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, pointed teeth dripping with black goo."),
    hp = 88,
    attacks = {
        { id = "teeth_zino_mid", cooldown = 15 },
        { id = "bite_grab", cooldown = 15 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 20 },
    },
}

ccb.content.define_monster {
    id = "mon_sorgosaurus",
    name = ccb.content.plural_text("skeletal gorgosaurus", "skeletal gorgosaurus"),
    copy_from = "mon_sappalachiosaurus",
    speed = 45,
    attack_cost = 45,
    melee_damage = { { type = "cut", amount = 17 } },
    hp = 100,
}

ccb.content.define_monster {
    id = "mon_salbertosaurus",
    name = ccb.content.plural_text("skeletal albertosaurus", "skeletal albertosaurus"),
    copy_from = "mon_sorgosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, pointed teeth dripping with black goo.  Skeletal claws reach ahead."),
    speed = 35,
    attack_cost = 35,
    hp = 110,
    melee_dice = 4,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 18 } },
    attacks = {
        { id = "teeth_zino_mid", cooldown = 10 },
        { id = "bite_grab", cooldown = 7 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 5 },
        { id = "longswipe", cooldown = 25 },
    },
}

ccb.content.define_monster {
    id = "mon_sianzhousaurus",
    name = ccb.content.plural_text("skeletal qianzhousaurus", "skeletal qianzhousaurus"),
    copy_from = "mon_salbertosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting a long snout with narrow, pointed teeth dripping with black goo."),
    volume = "550 L",
    mass = "770 kg",
    hp = 65,
    speed = 50,
    attack_cost = 50,
    melee_dice = 4,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 17 } },
}

ccb.content.define_monster {
    id = "mon_sanuqsaurus",
    name = ccb.content.plural_text("skeletal nanuqsaurus", "skeletal nanuqsaurus"),
    copy_from = "mon_saspletosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting a large jaw with long, pointed teeth dripping with black goo."),
    hp = 100,
}

ccb.content.define_monster {
    id = "mon_saspletosaurus",
    name = ccb.content.plural_text("skeletal daspletosaurus", "skeletal daspletosaurus"),
    copy_from = "mon_salbertosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting a large jaw with long, pointed teeth dripping with black goo."),
    melee_dice = 5,
    melee_sides = 8,
    melee_damage = { { type = "cut", amount = 19 } },
    attacks = {
        { id = "teeth_zino_max", cooldown = 10 },
        { id = "bite_grab", cooldown = 7 },
        { reference = "scratch", cooldown = 20 },
        { reference = "LUNGE", cooldown = 5 },
    },
    hp = 120,
    weakpoint_sets = { "wps_lg_theropod_body" },
}

ccb.content.define_monster {
    id = "mon_syrannosaurus",
    name = ccb.content.plural_text("S-Rex", "S-Rexes"),
    copy_from = "mon_saspletosaurus",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting enormous, sharp, pointed teeth dripping with black goo."),
    hp = 160,
    melee_skill = 5,
    melee_dice = 5,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 25 } },
    attacks = {
        { reference = "scratch", cooldown = 10 },
        { id = "bite_grab", cooldown = 7 },
        { id = "teeth_zino_max", cooldown = 5 },
    },
}

ccb.content.define_monster {
    id = "mon_sedcolbertia",
    name = ccb.content.plural_text("skeletal nedcolbertia", "skeletal nedcolbertia"),
    copy_from = "mon_silophosaurus",
    description = ccb.content.text("Monstrous columns of dense bone covering feathers and claws, cracks dripping black goo."),
    volume = "50 L",
    mass = "50 kg",
    speed = 120,
    attack_cost = 118,
    hp = 50,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 7,
    melee_damage = { { type = "bash", amount = 6 } },
    upgrade = { half_life = 60, monster = "mon_sallimimus_brute" },
}

ccb.content.define_monster {
    id = "mon_sallimimus",
    name = ccb.content.plural_text("skeletal gallimimus", "skeletal gallimimus"),
    copy_from = "mon_silophosaurus",
    description = ccb.content.text("Monstrous columns of dense bone covering beak, feathers, and claws, cracks dripping black goo."),
    volume = "440 L",
    mass = "440 kg",
    speed = 118,
    attack_cost = 118,
    hp = 50,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 7,
    melee_damage = { { type = "bash", amount = 6 } },
    upgrade = { half_life = 60, monster = "mon_sallimimus_brute" },
}

ccb.content.define_monster {
    id = "mon_sktruthiomimus",
    name = ccb.content.plural_text("skeletal struthiomimus", "skeletal struthiomimus"),
    copy_from = "mon_sallimimus",
    looks_like = "mon_gallimimus",
    volume = "420 L",
    mass = "420 kg",
    speed = 122,
    attack_cost = 122,
}

ccb.content.define_monster {
    id = "mon_sornithomimus",
    name = ccb.content.plural_text("skeletal ornithomimus", "skeletal ornithomimus"),
    copy_from = "mon_sallimimus",
    looks_like = "mon_gallimimus",
    volume = "170 L",
    mass = "170 kg",
    speed = 109,
    attack_cost = 109,
    inheritance = { add = { flags = { "CLIMBS" } } },
}

ccb.content.define_monster {
    id = "mon_salcarius",
    name = ccb.content.plural_text("skeletal falcarius", "skeletal falcarius"),
    copy_from = "mon_sallimimus",
    description = ccb.content.text("Monstrous columns of dense bone lifting a twisted bony beak dripping with black goo.  Long, sharp claws extend from its hands"),
    volume = "100 L",
    mass = "100 kg",
    speed = 80,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 8 } },
    upgrade = { half_life = 60, monster = "mon_salcarius_brute" },
}

-- When large volumes are fixed this should be 4000 L
ccb.content.define_monster {
    id = "mon_serizinosaurus",
    name = ccb.content.plural_text("skeletal therizinosaurus", "skeletal therizinosaurus"),
    copy_from = "mon_sallimimus",
    description = ccb.content.text("Monstrous columns of dense bone lifting a twisted bony beak dripping with black goo.  Long, sharp claws extend from its hands"),
    volume = "1000 L",
    mass = "4000 kg",
    speed = 100,
    melee_skill = 3,
    melee_dice = 3,
    melee_sides = 6,
    melee_damage = { { type = "cut", amount = 8 } },
    upgrade = { half_life = 60, monster = "mon_serizinosaurus_brute" },
}

ccb.content.define_monster {
    id = "mon_sothronychus",
    name = ccb.content.plural_text("skeletal nothronychus", "skeletal nothronychus"),
    copy_from = "mon_sallimimus",
    description = ccb.content.text("Monstrous columns of dense bone lifting a twisted bony beak dripping with black goo.  Long, sharp claws extend from its hands"),
    volume = "800 L",
    mass = "800 kg",
    speed = 40,
    attack_cost = 40,
    melee_dice = 5,
    melee_sides = 7,
    melee_damage = { { type = "cut", amount = 8 } },
    upgrade = { half_life = 60, monster = "mon_sothronychus_brute" },
}

ccb.content.define_monster {
    id = "mon_sanzu",
    name = ccb.content.plural_text("skeletal anzu", "skeletal anzu"),
    copy_from = "mon_sothronychus",
    volume = "250 L",
    mass = "250 kg",
    speed = 85,
    attack_cost = 85,
    upgrade = { half_life = 60, monster = "mon_sanzu_brute" },
}

ccb.content.define_monster {
    id = "mon_seinonychus",
    name = ccb.content.plural_text("skeletal deinonychus", "skeletal deinonychus"),
    copy_from = "mon_silophosaurus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, pointed teeth dripping with black goo.  There is a long tail and long, sharp, scythe-shaped claws"),
    volume = "70 L",
    mass = "70 kg",
    speed = 55,
    attack_cost = 55,
    hp = 20,
    melee_skill = 5,
    melee_dice = 2,
    melee_sides = 11,
    melee_damage = { { type = "cut", amount = 8 } },
    upgrade = { half_life = 60, monster = "mon_sutahraptor_brute" },
    attacks = {
        { cooldown = 5, maximum_range = 5, allow_no_target = true, kind = "leap" },
        { reference = "scratch", cooldown = 10 },
        { id = "bite_grab" },
        { id = "teeth_zino_mid", cooldown = 5 },
    },
    vision_day = 20,
    vision_night = 10,
}

ccb.content.define_monster {
    id = "mon_sutahraptor",
    name = ccb.content.plural_text("skeletal utahraptor", "skeletal utahraptor"),
    copy_from = "mon_seinonychus",
    description = ccb.content.text("Monstrous columns of dense bone lifting sharp, pointed teeth dripping with black goo.  There is a long tail and long, sharp, scythe-shaped claws"),
    volume = "500 L",
    mass = "500 kg",
    hp = 50,
    melee_dice = 3,
    melee_sides = 9,
    melee_damage = { { type = "cut", amount = 12 } },
    upgrade = { half_life = 60, monster = "mon_sutahraptor_brute" },
}

ccb.content.define_monster {
    id = "mon_skarahsaurus",
    name = ccb.content.plural_text("armored sarahsaurus", "armored sarahsaurus"),
    copy_from = "mon_zarahsaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified sauropod has grown dense bone armor, completely covering the large, two-legged body and long neck."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 8, bullet = 6, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sanchisaurus",
    name = ccb.content.plural_text("armored anchisaurus", "armored anchisaurus"),
    copy_from = "mon_zanchisaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified sauropod has grown dense bone armor, completely covering the large, four-legged body and long neck."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 8, bullet = 6, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sissi",
    name = ccb.content.plural_text("armored issi", "armored issi"),
    copy_from = "mon_zissi",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified sauropod has grown dense bone armor, completely covering the large, two-legged body and long neck."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 8, bullet = 6, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_soabosaurus",
    name = ccb.content.plural_text("armored moabosaurus", "armored moabosaurus"),
    copy_from = "mon_zoabosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified sauropod has grown dense bone armor, completely covering the huge, four-legged body and long neck and tail."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_saplocanthosaurus",
    name = ccb.content.plural_text("armored haplocanthosaurus", "armored haplocanthosaurus"),
    copy_from = "mon_zaplocanthosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified sauropod has grown dense bone armor, completely covering the huge, four-legged body and long neck and tail."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_samargasaurus",
    name = ccb.content.plural_text("armored amargasaurus", "armored amargasaurus"),
    copy_from = "mon_zamargasaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified amargasaurus has grown even more spikes and denser bone armor, completely covering the massive, four-legged body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 8, bullet = 6, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sapatosaurus",
    name = ccb.content.plural_text("armored apatosaurus", "armored apatosaurus"),
    copy_from = "mon_zapatosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified apatosaurus has grown dense bone armor, completely covering the massive, four-legged body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_srontosaurus",
    name = ccb.content.plural_text("armored brontosaurus", "armored brontosaurus"),
    copy_from = "mon_sapatosaurus",
    description = ccb.content.text("This zombified brontosaurus has grown dense bone armor, completely covering the massive, four-legged body and long, whip-like tail."),
    inheritance = { scale = { hp = 0.8 } },
}

ccb.content.define_monster {
    id = "mon_siplodocus",
    name = ccb.content.plural_text("armored diplodocus", "armored diplodocus"),
    copy_from = "mon_ziplodocus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified diplodocus has grown dense bone armor, completely covering the massive, four-legged body and small head."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sarosaurus",
    name = ccb.content.plural_text("boneplate barosaurus", "boneplate barosaurus"),
    copy_from = "mon_zarosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified barosaurus has grown dense bone armor, completely covering the massive, four-legged body and small head."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_samarasaurus",
    name = ccb.content.plural_text("armored camarasaurus", "armored camarasaurus"),
    copy_from = "mon_sapatosaurus",
    description = ccb.content.text("This zombified camarasaurus has grown dense body armor, completely covering the massive, long-necked, four-legged body."),
    inheritance = { scale = { speed = 0.8 } },
}

ccb.content.define_monster {
    id = "mon_srachiosaurus",
    name = ccb.content.plural_text("armored brachiosaurus", "armored brachiosaurus"),
    copy_from = "mon_sapatosaurus",
    description = ccb.content.text("This zombified brachiosaurus has grown dense body armor, completely covering the gigantic, long-necked, four-legged body."),
    inheritance = { scale = { speed = 0.6, hp = 3 } },
}

ccb.content.define_monster {
    id = "mon_sastrodon",
    name = ccb.content.plural_text("armored astrodon", "armored astrodons"),
    copy_from = "mon_sapatosaurus",
    description = ccb.content.text("This zombified astrodon has grown dense body armor, completely covering the gigantic, long-necked, four-legged body."),
    inheritance = { scale = { speed = 0.7, hp = 2 } },
}

ccb.content.define_monster {
    id = "mon_salamosaurus",
    name = ccb.content.plural_text("armored alamosaurus", "armored alamosaurus"),
    copy_from = "mon_zalamosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This zombified alamosaurus has grown denser bone armor, completely covering the gigantic, four-legged body and spiked tail."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 19, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sktegosaurus",
    name = ccb.content.plural_text("skeletal stegosaurus", "skeletal stegosaurus"),
    copy_from = "mon_ztegosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified stegosaurus has grown thick bone armor below its back plates as well as a larger and spikier bony tail."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 13, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sesperosaurus",
    name = ccb.content.plural_text("skeletal hesperosaurus", "skeletal hesperosaurus"),
    copy_from = "mon_zesperosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified hesperosaurus has grown thick bone armor below its back plates as well as a larger and spikier bony tail."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 15, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sastonia",
    name = ccb.content.plural_text("armored gastonia", "armored gastonia"),
    copy_from = "mon_zastonia",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor and spikes."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 23, bullet = 11, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sargoyleosaurus",
    name = ccb.content.plural_text("armored gargoyleosaurus", "armored gargoyleosaurus"),
    copy_from = "mon_zargoyleosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor and spikes."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 13, bullet = 6, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_skauropelta",
    name = ccb.content.plural_text("armored sauropelta", "armored sauropelta"),
    copy_from = "mon_zauropelta",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor and spikes; it must also be even slower, which is hard to imagine."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 23, bullet = 11, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sodosaurus",
    name = ccb.content.plural_text("armored nodosaurus", "armored nodosaurus"),
    copy_from = "mon_zodosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor; it must also be even slower, which is hard to imagine."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 23, bullet = 11, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sanoplosaurus",
    name = ccb.content.plural_text("protected panoplosaurus", "protected panoplosaurus"),
    copy_from = "mon_zanoplosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor, while keeping the long, bony spikes."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 23, bullet = 11, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sedmontonia",
    name = ccb.content.plural_text("armored edmontonia", "armored edmontonia"),
    copy_from = "mon_zedmontonia",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor, while keeping the long, bony spikes."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 23, bullet = 11, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_suul",
    name = ccb.content.plural_text("skeletal zuul", "skeletal zuul"),
    copy_from = "mon_zzuul",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser spiked bone armor as well as a larger and spikier bony tail.  It must be even slower, which is difficult to imagine."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 21, bullet = 7, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_syoplosaurus",
    name = ccb.content.plural_text("skeletal dyoplosaurus", "skeletal dyoplosaurus"),
    copy_from = "mon_zyoplosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor as well as a larger and spikier bony tail.  It must be even slower, which is difficult to imagine."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 21, bullet = 7, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sankylosaurus",
    name = ccb.content.plural_text("armored ankylosaurus", "armored ankylosaurus"),
    copy_from = "mon_zankylosaurus",
    looks_like = "mon_ankylosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor as well as a larger and spikier bony tail.  It must be even slower, which is difficult to imagine."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 23, bullet = 11, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_suoplocephalus",
    name = ccb.content.plural_text("armored euoplocephalus", "armored euoplocephalus"),
    copy_from = "mon_zuoplocephalus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor as well as a larger and spikier bony tail.  It must be even slower, which is difficult to imagine."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 21, bullet = 7, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_skcolosaurus",
    name = ccb.content.plural_text("boneplate scolosaurus", "boneplate scolosaurus"),
    copy_from = "mon_zcolosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("Already heavily protected, this zombified four legged dinosaur with a beak and tail has grown even denser bone armor as well as a larger and spikier bony tail.  It must be even slower, which is difficult to imagine."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy", "prof_intro_biology", "prof_physiology", "prof_wp_zombie",
        "prof_wp_nat_armored", "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 21, bullet = 7, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_samptosaurus",
    name = ccb.content.plural_text("armored camptosaurus", "armored camptosaurus"),
    copy_from = "mon_zamptosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with strong legs, broad shoulders, and a pointed beak has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_senontosaurus",
    name = ccb.content.plural_text("armored tenontosaurus", "armored tenontosaurus"),
    copy_from = "mon_zenontosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This four-legged dinosaur corpse with a beak and large long tail has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sryosaurus",
    name = ccb.content.plural_text("armored dryosaurus", "armored dryosaurus"),
    copy_from = "mon_zryosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This two-legged dinosaur corpse with a long neck and beak has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bullet = 2, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_siguanodon",
    name = ccb.content.plural_text("armored iguanodon", "armored iguanodons"),
    copy_from = "mon_ziguanodon",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This bulky, four-legged dinosaur corpse with a beak and spiked thumbs has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_seolambia",
    name = ccb.content.plural_text("armored eolambia", "armored eolambia"),
    copy_from = "mon_zeolambia",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This four-legged dinosaur corpse with a long neck and beak has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sadrosaurus",
    name = ccb.content.plural_text("armored hadrosaurus", "armored hadrosaurus"),
    copy_from = "mon_zadrosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This bulky, four-legged dinosaur corpse with a beak has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_saiasaura",
    name = ccb.content.plural_text("armored maiasaura", "armored maiasaura"),
    copy_from = "mon_zaiasaura",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a flat beak, thick nose, and small, spiky head crest has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sryposaurus",
    name = ccb.content.plural_text("armored gryposaurus", "armored gryposaurus"),
    copy_from = "mon_zryposaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a toothless beak and powerful nasal arch has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 6, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_srosaurolophus",
    name = ccb.content.plural_text("protected prosaurolophus", "protected prosaurolophus"),
    copy_from = "mon_zrosaurolophus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with hooves, a short beak and a tall head crest has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 6, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_skaurolophus",
    name = ccb.content.plural_text("boneplate saurolophus", "boneplate saurolophus"),
    copy_from = "mon_zaurolophus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with hooves, a broad beak and a spiky head crest has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 6, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sedmontosaurus",
    name = ccb.content.plural_text("armored edmontosaurus", "armored edmontosaurus"),
    copy_from = "mon_zedmontosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a broad, toothless beak has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 6, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sarasaurolophus",
    name = ccb.content.plural_text("armored parasaurolophus", "armored parasaurolophus"),
    copy_from = "mon_zarasaurolophus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a blunt head crest has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sambeosaurus",
    name = ccb.content.plural_text("boneplate lambeosaurus", "boneplate lambeosaurus"),
    copy_from = "mon_zambeosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a long stiff tail, hooves, a narrow beak and a tall head crest has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 6, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sorythosaurus",
    name = ccb.content.plural_text("armored corythosaurus", "armored corythosaurus"),
    copy_from = "mon_zorythosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a short beak and a tall head crest has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 6, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sypacrosaurus",
    name = ccb.content.plural_text("armored hypacrosaurus", "armored hypacrosaurus"),
    copy_from = "mon_zypacrosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a tall ridge down the back, a tail, hooves, a short beak and a wide, rounded head crest has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 6, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sachycephalosaurus",
    name = ccb.content.plural_text("protected pachycephalosaurus", "protected pachycephalosaurus"),
    copy_from = "mon_zachycephalosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This bipedal dinosaur corpse with a hard-looking, domed head has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_septoceratops",
    name = ccb.content.plural_text("boneplate leptoceratops", "boneplate leptoceratops"),
    copy_from = "mon_zeptoceratops",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This dinosaur corpse with a bony crest and sharp beak has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_suniceratops",
    name = ccb.content.plural_text("boneplate zuniceratops", "boneplate zuniceratops"),
    copy_from = "mon_zzuniceratops",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This four-legged dinosaur with a tall thin bony head crest, two long brow horns, and a beak has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sokiceratops",
    name = ccb.content.plural_text("boneplate lokiceratops", "boneplate lokiceratops"),
    copy_from = "mon_zokiceratops",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This four-legged dinosaur with a bony head crest with two horns curving out and down, two long brow horns, and a beak has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sktyracosaurus",
    name = ccb.content.plural_text("shielded styracosaurus", "shielded styracosaurus"),
    copy_from = "mon_ztyracosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a spiked frill, a hooked beak and long horn above the nose has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sentrosaurus",
    name = ccb.content.plural_text("armored centrosaurus", "armored centrosaurus"),
    copy_from = "mon_zentrosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a hooked beak and long horn above the nose has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_seiniosaurus",
    name = ccb.content.plural_text("armored einiosaurus", "armored einiosaurus"),
    copy_from = "mon_zeiniosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a tall bony crest and one large horn curving forward towards the beak has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sachelousaurus",
    name = ccb.content.plural_text("armored achelousaurus", "armored achelousaurus"),
    copy_from = "mon_zachelousaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a tall bony crest with two long curved spikes and three rough bosses above the eyes and nose has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sachyrhinosaurus",
    name = ccb.content.plural_text("protected pachyrhinosaurus", "protected pachyrhinosaurus"),
    copy_from = "mon_zachyrhinosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with massive bony bosses on its nose and brow has grown dense bone armor over the rest of its body."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sasmosaurus",
    name = ccb.content.plural_text("boneplate chasmosaurus", "boneplate chasmosaurus"),
    copy_from = "mon_zasmosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a tall bony crest from which three short horns emerge above the eyes and beak has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 9, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sentaceratops",
    name = ccb.content.plural_text("protected pentaceratops", "protected pentaceratops"),
    copy_from = "mon_zentaceratops",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a tall bony crest, four long horns, and a short nose horn has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 9, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sosmoceratops",
    name = ccb.content.plural_text("armored kosmoceratops", "armored kosmoceratops"),
    copy_from = "mon_zosmoceratops",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a bony crest and two wavy side horns has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 4, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "bash", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sorosaurus",
    name = ccb.content.plural_text("armored torosaurus", "armored torosaurus"),
    copy_from = "mon_zorosaurus",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This large, four-legged dinosaur corpse with a tall bony crest and two wicked-looking horns has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 9, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sriceratops",
    name = ccb.content.plural_text("armored triceratops", "armored triceratops"),
    copy_from = "mon_zriceratops",
    color = "white",
    materials = { "bone" },
    description = ccb.content.text("This massive, four-legged dinosaur corpse with a tall bony crest and three wicked-looking horns has grown dense bone armor."),
    bleed_rate = 50,
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_wp_skeleton",
    },
    upgrade = false,
    harvest = "mr_bones",
    armor = { cut = 7, bullet = 3, bash = 0 },
    inheritance = {
        scale = { hp = 0.4, speed = 0.875 },
        offset = {
            melee_dice = 9,
            melee_sides = 5,
            melee_damage = { { type = "stab", amount = 7 } },
            vision_day = -20,
            armor = { cut = 22, stab = 30, acid = 3, bullet = 30 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sona",
    name = ccb.content.plural_text("skeletal fona", "skeletal fona"),
    copy_from = "mon_sescelosaurus",
    description = ccb.content.text("Monstrous columns of dense bone covering feathers and clawed arms, cracks dripping black goo."),
    volume = "50 L",
    mass = "50 kg",
    speed = 75,
    attack_cost = 75,
    hp = 60,
    melee_dice = 1,
    upgrade = { half_life = 60, monster = "mon_sona_brute" },
}

ccb.content.define_monster {
    id = "mon_sescelosaurus",
    name = ccb.content.plural_text("skeletal thescelosaurus", "skeletal thescelosaurus"),
    copy_from = "mon_sallimimus",
    description = ccb.content.text("Monstrous columns of dense bone covering beak, feathers, and strong arms, cracks dripping black goo."),
    volume = "250 L",
    mass = "250 kg",
    speed = 118,
    attack_cost = 118,
    hp = 60,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 7,
    melee_damage = { { type = "bash", amount = 6 } },
    upgrade = { half_life = 60, monster = "mon_sescelosaurus_brute" },
}
