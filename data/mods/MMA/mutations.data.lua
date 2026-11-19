local ccb = require("ccb")

ccb.content.define_mutation {
    id = "MARTIAL_ARTS4",
    name = ccb.content.text("Venom Mob Protege"),
    points = 2,
    description = ccb.content.text("You are a pupil of the Venom Clan.  You start with one of the five deadly venoms: Centipede, Viper, Scorpion, Lizard, or Toad."),
    starting_trait = true,
    initial_martial_arts = { "style_centipede", "style_venom_snake", "style_scorpion", "style_lizard", "style_toad" },
    valid = false,
}

ccb.content.define_mutation {
    id = "MMA_MARTIAL_ARTS_PANZER",
    name = ccb.content.text("Künstler"),
    points = 2,
    description = ccb.content.text("You have lingering memories of training to fight cyborgs and war machines in zero gravity using the obscure Panzer Kunst."),
    starting_trait = true,
    initial_martial_arts = { "style_mma_panzer" },
    valid = false,
}

ccb.content.define_mutation {
    id = "DRUNKEN",
    name = ccb.content.text("Drunken Master"),
    points = 1,
    description = ccb.content.text("The ancient arts of drunken brawling come naturally to you!  While under the influence of alcohol, your melee skill will rise considerably, especially unarmed combat."),
    starting_trait = true,
    valid = false,
    cancels = { "LIGHTWEIGHT" },
    enchantments = { "DRUNKEN_ARMED", "DRUNKEN_UNARMED" },
}

ccb.content.define_mutation {
    id = "MMA_MARTIAL_ARTS_HYLIAN",
    name = ccb.content.text("Hero's Spirit"),
    points = 3,
    description = ccb.content.text("You have studied the deeds and legends of ancient heroes.  From your research, you have learned an ancient form of combat called Hylian Swordsmanship."),
    starting_trait = true,
    initial_martial_arts = { "style_mma_hylian" },
    valid = false,
}

ccb.content.define_mutation {
    id = "KI_STRIKE",
    name = ccb.content.text("Ki Strike"),
    points = 2,
    description = ccb.content.text("Who needs weapons?  You deal more melee damage while your hands are empty.  This damage improves as your unarmed skill increases."),
    starting_trait = true,
    valid = false,
    enchantments = { "KI_STRIKE" },
}

ccb.content.define_mutation { id = "LIGHTWEIGHT", copy_from = "LIGHTWEIGHT", add = { cancels = { "DRUNKEN" } } }

ccb.content.define_mutation {
    id = "MMA_MARTIAL_ARTS_JEDI",
    name = ccb.content.text("Jedi Training"),
    points = 2,
    description = ccb.content.text("You are trained in the ways of the Jedi.  Your knowledge allows you to utilize a form of lightsaber combat."),
    starting_trait = true,
    initial_martial_arts = { "style_mma_shii_cho" },
    valid = false,
}

ccb.content.define_mutation {
    id = "MMA_MARTIAL_ARTS_POKKEN",
    name = ccb.content.text("Pokken Master"),
    points = 2,
    description = ccb.content.text("You are well versed in the monstrous Pocket Fist martial art.  Train well, because it is your destiny to be a master."),
    starting_trait = true,
    initial_martial_arts = { "style_mma_pokken" },
    valid = false,
}

ccb.content.define_mutation {
    id = "MMA_MARTIAL_ARTS_SUBLIME",
    name = ccb.content.text("Martial Adept"),
    points = 3,
    description = ccb.content.text("You are a martial adept and learned one of the martial disciplines of the Sublime Way.  You start with your choice of Desert Wind, Diamond Mind, Iron Heart, Setting Sun, Stone Dragon, or Tiger Claw."),
    starting_trait = true,
    initial_martial_arts = {
        "style_mma_desert_wind", "style_mma_diamond_mind", "style_mma_iron_heart",
        "style_mma_setting_sun", "style_mma_stone_dragon", "style_mma_tiger_claw",
    },
    valid = false,
}
