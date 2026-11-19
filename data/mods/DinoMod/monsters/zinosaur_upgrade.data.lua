local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zallosaurus_hulk",
    name = ccb.content.plural_text("allosaurus hulk", "allosaurus hulks"),
    copy_from = "mon_zallosaurus_brute",
    looks_like = "mon_zallosaurus",
    description = ccb.content.text("A hideously swollen zombified allosaurid theropod body towering into the sky.  Its massive body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 5,
    color = "white_magenta",
    bleed_rate = 0,
    attacks = { { reference = "SMASH", cooldown = 20 } },
    upgrade = false,
    inheritance = {
        scale = { hp = 4, speed = 1.25 },
        offset = {
            melee_dice = 1,
            melee_damage = { type = "cut", amount = -4 },
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zyrannosaurus_hulk",
    name = ccb.content.plural_text("Goliath Rex", "Goliath Rexes"),
    copy_from = "mon_zyrannosaurus_brute",
    looks_like = "mon_zyrannosaurus",
    description = ccb.content.text("A hideously swollen zombified tyrannosaurid theropod body towering into the sky.  Its massive body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 5,
    color = "white_magenta",
    bleed_rate = 0,
    attacks = { { reference = "SMASH", cooldown = 20 } },
    upgrade = false,
    inheritance = {
        scale = { hp = 4, speed = 1.25 },
        offset = {
            melee_dice = 1,
            melee_damage = { type = "cut", amount = -4 },
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zapatosaurus_hulk",
    name = ccb.content.plural_text("sauropod hulk", "sauropod hulks"),
    copy_from = "mon_zapatosaurus_brute",
    looks_like = "mon_zapatosaurus",
    description = ccb.content.text("A hideously swollen zombified sauropod body towering into the sky even more than usual.  Its massive body bulges with distended muscles and swollen, festering wounds."),
    difficulty_adjustment = 5,
    color = "white_magenta",
    bleed_rate = 0,
    attacks = { { reference = "SMASH", cooldown = 20 } },
    upgrade = false,
    inheritance = {
        scale = { hp = 4, speed = 1.25 },
        offset = {
            melee_dice = 1,
            melee_damage = { type = "bash", amount = -4 },
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zankylosaurus_hulk",
    name = ccb.content.plural_text("ankylosaurid hulk", "ankylosaurid hulks"),
    copy_from = "mon_zankylosaurus_brute",
    looks_like = "mon_ankylosaurus",
    description = ccb.content.text("A hideously swollen zombified ankylosaurid body towering into the sky.  Its massive body bulges with distended muscles and enormous bony armor."),
    difficulty_adjustment = 5,
    color = "white_magenta",
    bleed_rate = 0,
    attacks = { { reference = "SMASH", cooldown = 20 } },
    upgrade = false,
    inheritance = {
        scale = { hp = 4, speed = 1.25 },
        offset = {
            melee_dice = 1,
            melee_damage = { type = "stab", amount = -4 },
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zriceratops_hulk",
    name = ccb.content.plural_text("ceratopsian hulk", "ceratopsian hulks"),
    copy_from = "mon_zriceratops_brute",
    looks_like = "mon_zriceratops",
    description = ccb.content.text("A hideously swollen zombified ceratopsian body towering into the sky.  Its massive body bulges with distended muscles and swollen, festering wound."),
    difficulty_adjustment = 5,
    color = "white_magenta",
    bleed_rate = 0,
    attacks = { { reference = "SMASH", cooldown = 20 } },
    upgrade = false,
    inheritance = {
        scale = { hp = 4, speed = 1.25 },
        offset = {
            melee_dice = 1,
            melee_damage = { type = "stab", amount = -4 },
            armor = { bash = 4, cut = 6, bullet = 5 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_silophosaurus_brute",
    name = ccb.content.plural_text("skeletal neotheropod brute", "skeletal neotheropod brutes"),
    copy_from = "mon_silophosaurus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotten flesh, especially two large crests on the head.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_silophosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

-- When large volumes are fixed this should be 3500 L
ccb.content.define_monster {
    id = "mon_silophosaurus_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_silophosaurus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisted pointed teeth suggest some kind of predator dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "1000 L",
    mass = "4000 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_skinosaurus_brute",
    name = ccb.content.plural_text("skeletal spinosaurus brute", "skeletal spinosaurus brutes"),
    copy_from = "mon_skinosaurus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotten flesh and back sail.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_skinosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_skinosaurus_hulk",
    name = ccb.content.plural_text("skeletal spinosaurus juggernaut", "skeletal spinosaurus juggernauts"),
    copy_from = "mon_skinosaurus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The twisted back sail means it must have been a spinosaurus once."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sorvosaurus_brute",
    name = ccb.content.plural_text("skeletal torvosaurus brute", "skeletal torvosaurus brutes"),
    copy_from = "mon_sorvosaurus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotten flesh and long toothy jaws.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sorvosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sorvosaurus_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_sorvosaurus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisted pointed teeth suggest some kind of predator dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sallosaurus_brute",
    name = ccb.content.plural_text("skeletal allosaurid brute", "skeletal allosaurid brutes"),
    copy_from = "mon_sallosaurus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotten flesh and toothy jaws.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sallosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sallosaurus_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_sallosaurus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisted pointed teeth suggest some kind of predator dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_syrannosaurus_brute",
    name = ccb.content.plural_text("skeletal tyrannosauroid brute", "skeletal tyrannosauroid brutes"),
    copy_from = "mon_syrannosaurus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotten flesh and massive toothy jaws.  Joints and cracks around its body ooze with black goo."),
    melee_dice = 4,
    melee_sides = 5,
    melee_damage = { { type = "cut", amount = 30 } },
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_syrannosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = { vision_day = 35, vision_night = 3, armor = { bash = 12, cut = 15, bullet = 6 } },
    },
}

ccb.content.define_monster {
    id = "mon_syrannosaurus_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_syrannosaurus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisted pointed teeth suggest some kind of predator dinosaur."),
    difficulty_adjustment = 5,
    melee_dice = 5,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 35 } },
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    inheritance = { scale = { hp = 2.5 }, offset = { armor = { bash = 8, cut = 15, bullet = 6 } } },
}

ccb.content.define_monster {
    id = "mon_sallimimus_brute",
    name = ccb.content.plural_text("skeletal ornithomimid brute", "skeletal ornithomimid brutes"),
    copy_from = "mon_sallimimus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's beak and feathers.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sallimimus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "bash", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

-- When large volumes are fixed this should be 3850 L
ccb.content.define_monster {
    id = "mon_sallimimus_hulk",
    name = ccb.content.plural_text("skeletal beaked juggernaut", "skeletal beaked juggernauts"),
    copy_from = "mon_sallimimus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisting pointed beak suggest some kind of beaked, two legged dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "1000 L",
    mass = "4400 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "stab", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_salcarius_brute",
    name = ccb.content.plural_text("skeletal falcarius brute", "skeletal falcarius brutes"),
    copy_from = "mon_salcarius",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotting flesh, long neck and claws.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_salcarius_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_salcarius_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_salcarius_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisting clawed arms suggest some kind of two legged dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "875 L",
    mass = "1000 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_serizinosaurus_brute",
    name = ccb.content.plural_text("skeletal therizinosaurus brute", "skeletal therizinosaurus brutes"),
    copy_from = "mon_serizinosaurus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotting flesh, long neck and claws.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_serizinosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

-- When large volumes are fixed this should be 35000 L
ccb.content.define_monster {
    id = "mon_serizinosaurus_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_serizinosaurus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisting clawed arms suggest some kind of two legged dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "1000 L",
    mass = "40000 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sothronychus_brute",
    name = ccb.content.plural_text("skeletal nothronychus brute", "skeletal nothronychus brutes"),
    copy_from = "mon_sothronychus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotting flesh, long neck and claws.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sothronychus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

-- When large volumes are fixed this should be 7000 L
ccb.content.define_monster {
    id = "mon_sothronychus_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_sallimimus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisting clawed arms suggest some kind of two legged dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "1000 L",
    mass = "8000 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sanzu_brute",
    name = ccb.content.plural_text("skeletal anzu brute", "skeletal anzu brutes"),
    copy_from = "mon_sanzu",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotting flesh, long neck and beak.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sanzu_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

-- When large volumes are fixed this should be 2200 L
ccb.content.define_monster {
    id = "mon_sanzu_hulk",
    name = ccb.content.plural_text("skeletal beaked juggernaut", "skeletal beaked juggernauts"),
    copy_from = "mon_sanzu_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisting beak suggest some kind of two legged beaked dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "1000 L",
    mass = "2500 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sutahraptor_brute",
    name = ccb.content.plural_text("skeletal dromaeosaurid brute", "skeletal dromaeosaurid brutes"),
    copy_from = "mon_sutahraptor",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's rotting flesh, claws, and sharp teeth.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sutahraptor_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "cut", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

-- When large volumes are fixed this should be 4400 L
ccb.content.define_monster {
    id = "mon_sutahraptor_hulk",
    name = ccb.content.plural_text("skeletal theropod juggernaut", "skeletal theropod juggernauts"),
    copy_from = "mon_sutahraptor_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisting claws and sharp teeth suggest some kind of two legged dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "1000 L",
    mass = "5000 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "cut", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sona_brute",
    name = ccb.content.plural_text("skeletal fona brute", "skeletal fona brutes"),
    copy_from = "mon_sona",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's feathers and long tail.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sescelosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "bash", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_sescelosaurus_brute",
    name = ccb.content.plural_text("skeletal thescelosaurus brute", "skeletal thescelosaurus brutes"),
    copy_from = "mon_sescelosaurus",
    description = ccb.content.text("Distorted outgrowths of calcified bone plates cover this dinosaur's beak and feathers.  Joints and cracks around its body ooze with black goo."),
    bleed_rate = 0,
    upgrade = { half_life = 48, monster = "mon_sescelosaurus_hulk" },
    attacks = {
        { id = "smash", throw_strength = 56, cooldown = 45 },
        { id = "scratch", damage = { { type = "cut", amount = 15, armor_multiplier = 0.6 } } },
    },
    inheritance = {
        scale = { hp = 5 },
        offset = {
            melee_dice = -1,
            melee_sides = 2,
            melee_damage = { { type = "bash", amount = 6 } },
            vision_day = 35,
            vision_night = 3,
            armor = { bash = 12, cut = 15, bullet = 6 },
        },
    },
}

-- When large volumes are fixed this should be 2200 L
ccb.content.define_monster {
    id = "mon_sescelosaurus_hulk",
    name = ccb.content.plural_text("skeletal beaked juggernaut", "skeletal beaked juggernauts"),
    copy_from = "mon_sescelosaurus_brute",
    description = ccb.content.text("This hideous colossus of plated bones and misshapen flesh drags its heavy, pointed limbs behind it.  Already strong and dangerous, bones grew around its form to protect it - only, they kept growing.  The shape and twisting pointed beak suggest some kind of beaked, two legged dinosaur."),
    difficulty_adjustment = 5,
    bleed_rate = 0,
    attacks = {
        { id = "smash", throw_strength = 54 },
        { id = "stretch_attack" },
        { id = "longswipe" },
        { id = "cut_throat" },
        { id = "scratch", damage = { { type = "cut", amount = 23, armor_multiplier = 0.8 } } },
    },
    volume = "1000 L",
    mass = "2500 kg",
    inheritance = {
        scale = { hp = 2.5 },
        offset = {
            melee_dice = 1,
            melee_damage = { { type = "stab", amount = 5 } },
            armor = { bash = 8, cut = 15, bullet = 6 },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zilophosaurus_acid",
    name = ccb.content.plural_text("acid dilophosaurus", "acid dilophosaurus"),
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    difficulty_adjustment = 5,
    color = "light_gray_yellow",
    body_type = "ostrich",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    attacks = { { reference = "ACID_BARF", cooldown = 10 } },
    vision_night = 3,
    harvest = "zed_dino_feather_acid",
    categories = { "DINOSAUR" },
    looks_like = "mon_dilophosaurus",
    volume = "400 L",
    mass = "400 kg",
    speed = 85,
    attack_cost = 85,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 3,
    melee_damage = { { type = "cut", amount = 2 } },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_biochemistry",
    },
    weakpoint_sets = { "wps_dinosaur_body" },
    hp = 100,
    description = ccb.content.text("The shuffling corpse of a dinosaur with sharp teeth and two prominent bony crests on its head, with ragged strips of ripped flesh hanging down like a frill.  Sticky yellow fluid oozes out from sores in the scales."),
    burn_into = "mon_zilophosaurus_scorched",
    fungalize_into = "mon_zilophosaurus_fungus",
    flags = {
        "SEES", "HEARS", "BASHES", "GROUP_BASH", "POISON", "STUMBLES", "ACIDPROOF", "ACID_BLOOD",
        "NO_BREATHE", "REVIVES", "FILTHY", "PUSH_MON", "WARM", "RANGED_ATTACKER",
    },
    armor = { bash = 4, cut = 4, bullet = 2 },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}

ccb.content.define_monster {
    id = "mon_zeratosaurus_acid",
    name = ccb.content.plural_text("acid ceratosaurus", "acid ceratosaurus"),
    species = { "ZOMBIE" },
    default_faction = "zombie",
    symbol = "Z",
    difficulty_adjustment = 5,
    color = "light_gray_yellow",
    body_type = "ostrich",
    materials = { "flesh" },
    aggression = 100,
    morale = 100,
    attacks = { { reference = "ACID_BARF", cooldown = 10 } },
    vision_night = 3,
    harvest = "zed_dino_feather_acid",
    dissect = "dissect_dino_large_pred",
    categories = { "DINOSAUR" },
    looks_like = "mon_zyrannosaurus",
    volume = "540 L",
    mass = "540 kg",
    hp = 120,
    speed = 80,
    attack_cost = 80,
    melee_skill = 3,
    melee_dice = 2,
    melee_sides = 2,
    melee_damage = { { type = "cut", amount = 2 } },
    families = {
        "prof_gross_anatomy",
        "prof_intro_biology",
        "prof_physiology",
        "prof_wp_zombie",
        "prof_biochemistry",
    },
    weakpoint_sets = { "wps_dinosaur_body" },
    description = ccb.content.text("This zombie is enormous, scaly, and studded with bony spikes.  Sticky yellow fluid oozes out from sores in the scales."),
    burn_into = "mon_zeratosaurus_scorched",
    fungalize_into = "mon_zeratosaurus_fungus",
    flags = {
        "SEES", "HEARS", "BASHES", "GROUP_BASH", "POISON", "STUMBLES", "ACIDPROOF", "ACID_BLOOD",
        "NO_BREATHE", "REVIVES", "FILTHY", "PUSH_MON", "WARM", "SWIMS", "RANGED_ATTACKER",
    },
    armor = { bash = 4, cut = 5, bullet = 2 },
    death = {
        outcome = {
            message = ccb.content.text("The %s's body leaks acid."),
            spell = { id = "death_acid", hit_self = true },
        },
    },
}
