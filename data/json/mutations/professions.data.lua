local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PROF_POLICE",
    name = ccb.content.text("Police Officer"),
    description = ccb.content.text("You are a duly sworn law enforcement officer, with jurisdiction throughout the New England region thanks to interstate agreements.  Whether that means anything now is another question."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_PD_DET",
    name = ccb.content.text("Police Detective"),
    description = ccb.content.text("You are a duly sworn law enforcement investigator, with jurisdiction throughout the New England region thanks to interstate agreements.  Whether your shield means anything now is another question."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_SWAT",
    name = ccb.content.text("SWAT Officer"),
    description = ccb.content.text("You are a duly sworn law enforcement officer, with jurisdiction throughout the New England region thanks to interstate agreements.  Whether that means anything now is another question."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_FED",
    name = ccb.content.text("US Marshal"),
    description = ccb.content.text("You are a duly sworn Federal marshal, with nationwide jurisdiction and the authority of the United States of America."),
    cancels = { "PROF_HUB01_ANCILLIARY" },
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

-- In the US, a medical 'residency' is essentially an extended post-graduate, on-the-job medical training.  The idea here is that hospital computer systems would recognize the PC as a valid user and grant access.
ccb.content.define_mutation {
    id = "PROF_MED",
    name = ccb.content.text("MD"),
    description = ccb.content.text("You trained as a medical professional in a clinic or hospital.  You can put \"Dr.\" in front of your name and everything."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_SKATER",
    name = ccb.content.text("Skater"),
    description = ccb.content.text("You are skilled in maneuvering on skates.  You suffer lower penalties to dodging and are less likely to fall down if hit in melee combat while you're wearing rollerskates or rollerblades."),
    points = 1,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_DICEMASTER",
    name = ccb.content.text("Dungeon Master"),
    description = ccb.content.text("Weeks spent picking through manuals and researching topics you aren't versed in has taught you to find what you need to know more quickly.  You read slightly faster, and suffer no reading time penalty for books too complex for you to easily understand."),
    cancels = { "ILLITERATE" },
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
    enchantments = { "INLINE_ENCH_PROF_DICEMASTER_0" },
}

ccb.content.define_mutation {
    id = "PROF_HUB01_ANCILLIARY",
    name = ccb.content.text("Hub 01 Ancillary"),
    description = ccb.content.text("You are known to be a capable and resourceful mercenary at the employ of Hub 01."),
    cancels = { "PROF_FED" },
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_FOODP",
    name = ccb.content.text("True Foodperson"),
    description = ccb.content.text("You are the true Foodperson, some might think Foodperson is just a mascot, but you know better.  You are Foodperson, the mask has become your face; you are real, and the only thing standing between this world and oblivion is you."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_CHURL",
    name = ccb.content.text("Churl"),
    description = ccb.content.text("Thou art a lewede man, a lowly cowherd, though where thi catel been thou hast not ynn certain."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "PROF_BOXER",
    name = ccb.content.text("Pugilist"),
    description = ccb.content.text("You are experienced in the Sweet Science of boxing.  You could've had a shot at a local boxing tournament, if the Cataclysm hadn't screwed that up."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
    initial_martial_arts = { "style_boxing" },
}

ccb.content.define_mutation {
    id = "PROF_KICKBOXER",
    name = ccb.content.text("Kickboxer"),
    description = ccb.content.text("You have some training in the art of kickboxing.  It's just boxing with kicks, right?"),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
    initial_martial_arts = { "style_kickboxing" },
}

ccb.content.define_mutation {
    id = "PROF_MA_ORANGE",
    name = ccb.content.text("Martial Artist"),
    description = ccb.content.text("You were shaping up to be a pretty decent student of the martial arts before the Cataclysm struck.  Time to see just how good you really are."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
    initial_martial_arts = {
        "style_aikido", "style_capoeira", "style_crane", "style_dragon", "style_judo", "style_karate",
        "style_krav_maga", "style_leopard", "style_muay_thai", "style_ninjutsu", "style_pankration",
        "style_snake", "style_taekwondo", "style_tai_chi", "style_tiger", "style_wingchun",
        "style_zui_quan",
    },
}

ccb.content.define_mutation {
    id = "PROF_MA_BLACK",
    name = ccb.content.text("Black Belt"),
    description = ccb.content.text("You were competitive at national levels, and had considered teaching your art.  Defending against the entire town may still be a challenge, though."),
    points = 0,
    profession = true,
    purifiable = false,
    valid = false,
    initial_martial_arts = {
        "style_aikido", "style_capoeira", "style_crane", "style_dragon", "style_judo", "style_karate",
        "style_krav_maga", "style_leopard", "style_muay_thai", "style_ninjutsu", "style_pankration",
        "style_snake", "style_taekwondo", "style_tai_chi", "style_tiger", "style_wingchun",
        "style_zui_quan",
    },
}

ccb.content.define_mutation {
    id = "MARTIAL_ARTS",
    name = ccb.content.text("Martial Arts Training"),
    description = ccb.content.text("You have received some martial arts training at a local dojo.  You start with your choice of Karate, Judo, Aikido, Tai Chi, Taekwondo, or Pankration."),
    points = 2,
    player_display = false,
    valid = false,
    initial_martial_arts = {
        "style_karate",
        "style_judo",
        "style_aikido",
        "style_tai_chi",
        "style_taekwondo",
        "style_pankration",
    },
}

ccb.content.define_mutation {
    id = "MARTIAL_ARTS2",
    name = ccb.content.text("Self-Defense Classes"),
    description = ccb.content.text("You have taken some self-defense classes at a nearby gym.  You start with your choice of Boxing, Kickboxing, Capoeira, Krav Maga, Muay Thai, Ninjutsu, Wing Chun, or Zui Quan."),
    points = 2,
    player_display = false,
    valid = false,
    initial_martial_arts = {
        "style_krav_maga", "style_muay_thai", "style_ninjutsu", "style_capoeira", "style_zui_quan",
        "style_wingchun", "style_kickboxing", "style_boxing",
    },
}

ccb.content.define_mutation {
    id = "MARTIAL_ARTS3",
    name = ccb.content.text("Shaolin Adept"),
    description = ccb.content.text("You have studied the arts of the Shaolin monks.  You start with one of the five animal fighting styles: Tiger, Crane, Leopard, Snake, or Dragon."),
    points = 2,
    player_display = false,
    valid = false,
    initial_martial_arts = { "style_tiger", "style_crane", "style_leopard", "style_snake", "style_dragon" },
}

ccb.content.define_mutation {
    id = "MARTIAL_ARTS5",
    name = ccb.content.text("Melee Weapon Training"),
    description = ccb.content.text("You have practiced fighting with weapons.  You start with your choice of Barbaran Montante, Bōjutsu, Eskrima, Fencing, Fior Di Battaglia, Medieval Swordsmanship, Niten Ichi-Ryu, Pencak Silat, or Sōjutsu."),
    points = 3,
    player_display = false,
    valid = false,
    initial_martial_arts = {
        "style_bojutsu", "style_barbaran", "style_eskrima", "style_fencing", "style_silat",
        "style_niten", "style_sojutsu", "style_swordsmanship", "style_medievalpole",
    },
}

ccb.content.define_mutation {
    id = "MARTIAL_FENCING",
    name = ccb.content.text("Competitive Fencer"),
    description = ccb.content.text("You were an avid fencer, starting with foil and moving onto saber, then épée.  You competed nationally and dabbled with some of the historical fencing weapons afforded by HEMA's popularity."),
    points = 0,
    valid = false,
    initial_martial_arts = { "style_fencing" },
}
