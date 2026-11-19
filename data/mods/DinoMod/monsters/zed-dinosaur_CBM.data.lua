local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_zyrannosaurus_bio_op",
    name = ccb.content.plural_text("tyrannosaurus zombie bio-operator", "tyrannosaurus zombie bio-operators"),
    copy_from = "mon_zyrannosaurus",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    grab_strength = 100,
    attacks = {
        { id = "bite_grab", cooldown = 7 },
        { reference = "scratch", cooldown = 10 },
        { id = "teeth_zino_max", cooldown = 5 },
        { id = "bio_op_takedown", cooldown = 20 },
        { spell = { id = "CBM_TRex_recording" }, cooldown = 1600, kind = "spell" },
    },
    description = ccb.content.text("The shuffling corpse of a bipedal dinosaur dotted with crackling bionics, tattered feathers, and black putrid liquid with glowing curved claws."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zedcolbertia_bio_op",
    name = ccb.content.plural_text("nedcolbertia zombie bio-operator", "nedcolbertia zombie bio-operators"),
    copy_from = "mon_zedcolbertia",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = { { id = "bio_op_takedown", cooldown = 20 } },
    description = ccb.content.text("The shuffling corpse of a bipedal dinosaur dotted with crackling bionics, tattered feathers, and black putrid liquid with glowing curved claws."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zallimimus_bio_op",
    name = ccb.content.plural_text("gallimimus zombie bio-operator", "gallimimus zombie bio-operators"),
    copy_from = "mon_zallimimus",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = { { id = "bio_op_takedown", cooldown = 20 } },
    description = ccb.content.text("The shuffling corpse of a bipedal beaked dinosaur dotted with crackling bionics, tattered feathers, and black putrid liquid with glowing curved claws."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_ztruthiomimus_bio_op",
    name = ccb.content.plural_text("struthiomimus zombie bio-operator", "struthiomimus zombie bio-operators"),
    copy_from = "mon_ztruthiomimus",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = { { id = "bio_op_takedown", cooldown = 20 } },
    description = ccb.content.text("The shuffling corpse of a bipedal beaked dinosaur dotted with crackling bionics, tattered feathers, and black putrid liquid with glowing curved claws."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zornithomimus_bio_op",
    name = ccb.content.plural_text("ornithomimus zombie bio-operator", "ornithomimus zombie bio-operators"),
    copy_from = "mon_zornithomimus",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = { { id = "bio_op_takedown", cooldown = 20 } },
    description = ccb.content.text("The shuffling corpse of a bipedal beaked dinosaur dotted with crackling bionics, tattered feathers, and black putrid liquid with glowing curved claws."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zeinonychus_bio_op",
    name = ccb.content.plural_text("deinonychus zombie bio-operator", "deinonychus zombie bio-operators"),
    copy_from = "mon_zeinonychus",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = {
        { cooldown = 5, maximum_range = 5, allow_no_target = true, kind = "leap" },
        { id = "bio_op_takedown", cooldown = 20 },
    },
    description = ccb.content.text("A bipedal dinosaur covered with tattered feathers, black goo, and crackling bionics.  Each foot has a large glowing sickle-like claw."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zamargasaurus_bio_op",
    name = ccb.content.plural_text("amargasaurus zombie bio-operator", "amargasaurus zombie bio-operators"),
    copy_from = "mon_zamargasaurus",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = {
        { id = "bio_op_takedown", cooldown = 20 },
        { id = "slam", cooldown = 10, damage = { { type = "bash", amount = 12 } } },
        { reference = "tailsmash_DinoMod", cooldown = 30 },
    },
    description = ccb.content.text("The massive shuffling corpse of a four legged dinosaur with a long neck and tail.  The body is dotted with crackling bionics and has two rows of tall glowing spines down the neck and back."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zachycephalosaurus_bio_op",
    name = ccb.content.plural_text("pachycephalosaurus zombie bio-operator", "pachycephalosaurus zombie bio-operators"),
    copy_from = "mon_zachycephalosaurus",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = { { id = "bio_op_takedown", cooldown = 20 } },
    description = ccb.content.text("The shuffling corpse of a bipedal dinosaur with a round hard-looking domed head.  The body is dotted with crackling bionics, tattered feathers, and black putrid liquid and carries glowing, curved claws."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}

ccb.content.define_monster {
    id = "mon_zriceratops_bio_op",
    name = ccb.content.plural_text("triceratops zombie bio-operator", "triceratops zombie bio-operators"),
    copy_from = "mon_zriceratops",
    difficulty_adjustment = 5,
    melee_damage = { { type = "electric", amount = 4 } },
    vision_day = 50,
    luminance = 4,
    attacks = { { id = "bio_op_takedown", cooldown = 20 } },
    description = ccb.content.text("A massive shambling rhino-like dinosaur corpse dotted with crackling bionics with a bony crest and three wicked looking glowing horns.  Its black eyes ooze like tears."),
    defense = { id = "ZAPBACK", chance = 75 },
    upgrade = false,
    dissect = "dissect_CBM_DINO",
    inheritance = {
        add = { flags = { "ACIDPROOF", "ELECTRIC" } },
        scale = { hp = 1.2, speed = 1.15 },
        offset = { melee_skill = 2, melee_dice = 1, dodge = 2, armor = { bash = 3, cut = 3, bullet = 3 } },
    },
}
