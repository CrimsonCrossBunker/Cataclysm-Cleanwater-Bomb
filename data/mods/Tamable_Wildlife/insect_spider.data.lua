local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_plague_nymph",
    copy_from = "mon_plague_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_skittering_plague",
    copy_from = "mon_skittering_plague",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_plague_vector",
    copy_from = "mon_plague_vector",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_giant_cockroach_nymph",
    copy_from = "mon_giant_cockroach_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_giant_cockroach",
    copy_from = "mon_giant_cockroach",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_pregnant_giant_cockroach",
    copy_from = "mon_pregnant_giant_cockroach",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_silverfish_nymph",
    copy_from = "mon_silverfish_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_silverfish",
    copy_from = "mon_silverfish",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_moth_fly_larva",
    copy_from = "mon_moth_fly_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It crawls around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s crawls around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_moth_fly",
    copy_from = "mon_moth_fly",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_centipede_house_larva",
    copy_from = "mon_centipede_house_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_centipede_house",
    copy_from = "mon_centipede_house",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_dragonfly_naiad_friendly",
    copy_from = "mon_dragonfly_naiad",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } }, remove = { anger_triggers = { "PLAYER_CLOSE" } } },
}

ccb.content.define_monster {
    id = "mon_dragonfly_giant",
    copy_from = "mon_dragonfly_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_dragonfly_mega",
    copy_from = "mon_dragonfly_mega",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_wasp_larva",
    copy_from = "mon_wasp_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It crawls around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s crawls around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_dermatik_larva",
    copy_from = "mon_dermatik_larva",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_ant_acid_larva",
    copy_from = "mon_ant_acid_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It crawls around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s crawls around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_ant_acid",
    copy_from = "mon_ant_acid",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_ant_acid_soldier",
    copy_from = "mon_ant_acid_soldier",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_ant_larva",
    copy_from = "mon_ant_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It crawls around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s crawls around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster { id = "mon_ant", copy_from = "mon_ant", inheritance = { add = { flags = { "CANPLAY" } } } }

ccb.content.define_monster {
    id = "mon_ant_soldier",
    copy_from = "mon_ant_soldier",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_ant_soldier_mega",
    copy_from = "mon_ant_soldier_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_locust_nymph",
    copy_from = "mon_locust_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster { id = "mon_locust", copy_from = "mon_locust", inheritance = { add = { flags = { "CANPLAY" } } } }

ccb.content.define_monster {
    id = "mon_locust_mega",
    copy_from = "mon_locust_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_aphid_small",
    copy_from = "mon_aphid_small",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster { id = "mon_aphid", copy_from = "mon_aphid", inheritance = { add = { flags = { "CANPLAY" } } } }

ccb.content.define_monster {
    id = "mon_mantis_nymph_friendly",
    copy_from = "mon_mantis_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } }, remove = { anger_triggers = { "PLAYER_CLOSE" } } },
}

ccb.content.define_monster {
    id = "mon_mantis_giant",
    copy_from = "mon_mantis_giant",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_mantis_mega",
    copy_from = "mon_mantis_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_mole_cricket",
    copy_from = "mon_mole_cricket",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_mole_cricket_nymph",
    copy_from = "mon_mole_cricket_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_lady_bug_giant",
    copy_from = "mon_lady_bug_giant",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_lady_bug_larva_friendly",
    copy_from = "mon_lady_bug_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It crawls around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s crawls around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_grasshopper_nymph",
    copy_from = "mon_grasshopper_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_grasshopper_giant",
    copy_from = "mon_grasshopper_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_stag_beetle_larva",
    copy_from = "mon_stag_beetle_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It crawls around you and seems friendly."),
        pet_message = ccb.content.text("The %s crawls around you."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_antlion_larva_friendly",
    copy_from = "mon_antlion_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It crawls around you and seems friendly."),
        pet_message = ccb.content.text("The %s crawls around you."),
    },
    inheritance = {
        add = { flags = { "CANPLAY" } },
        remove = { anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE" } },
    },
}

ccb.content.define_monster {
    id = "mon_antlion_giant",
    copy_from = "mon_antlion_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_strider_nymph",
    copy_from = "mon_strider_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_strider_giant",
    copy_from = "mon_strider_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_cicada_nymph_friendly",
    copy_from = "mon_cicada_nymph",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } }, remove = { anger_triggers = { "PLAYER_CLOSE" } } },
}

ccb.content.define_monster { id = "mon_cicada", copy_from = "mon_cicada", inheritance = { add = { flags = { "CANPLAY" } } } }

ccb.content.define_monster {
    id = "mon_woodlouse_manca",
    copy_from = "mon_woodlouse_manca",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_woodlouse",
    copy_from = "mon_woodlouse",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_diving_larva_friendly",
    copy_from = "mon_diving_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It swims around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s swims around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } }, remove = { anger_triggers = { "PLAYER_CLOSE" } } },
}

ccb.content.define_monster {
    id = "mon_diving_beetle_small",
    copy_from = "mon_diving_beetle_small",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_water_scorpion_larva_friendly",
    copy_from = "mon_water_scorpion_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It swims around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s swims around your feet."),
    },
    inheritance = {
        add = { flags = { "CANPLAY" } },
        remove = { anger_triggers = { "PLAYER_WEAK", "PLAYER_CLOSE" } },
    },
}

ccb.content.define_monster {
    id = "mon_water_scorpion",
    copy_from = "mon_water_scorpion",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_jumping_giant",
    copy_from = "mon_spider_jumping_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_jumping_mega",
    copy_from = "mon_spider_jumping_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_spider_jumping_giant_s",
    copy_from = "mon_spider_jumping_giant_s",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant spider could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s looks at you with its large eyes and skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_cellar_giant_s",
    copy_from = "mon_spider_cellar_giant_s",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant spider could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_cellar_giant",
    copy_from = "mon_spider_cellar_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_cellar_mom",
    copy_from = "mon_spider_cellar_mom",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_cellar_mega",
    copy_from = "mon_spider_cellar_mega",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_trapdoor_giant",
    copy_from = "mon_spider_trapdoor_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_trapdoor_s",
    copy_from = "mon_spider_trapdoor_s",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant spider could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s looks at you with its large eyes and skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_trapdoor_mega",
    copy_from = "mon_spider_trapdoor_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_spider_web",
    copy_from = "mon_spider_web",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_web_s",
    copy_from = "mon_spider_web_s",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant spider could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_web_mega",
    copy_from = "mon_spider_web_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_spider_widow_giant",
    copy_from = "mon_spider_widow_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_widow_giant_s",
    copy_from = "mon_spider_widow_giant_s",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant spider could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_widow_mega",
    copy_from = "mon_spider_widow_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_spider_wolf_giant",
    copy_from = "mon_spider_wolf_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_wolf_giant_s",
    copy_from = "mon_spider_wolf_giant_s",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant spider could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_spider_wolf_mega",
    copy_from = "mon_spider_wolf_mega",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_centipede_giant",
    copy_from = "mon_centipede_giant",
    inheritance = { add = { flags = { "CANPLAY" } } },
}

ccb.content.define_monster {
    id = "mon_centipede_larva_friendly",
    copy_from = "mon_centipede_larva",
    pet = {
        food = { "BUGFOOD" },
        feed_message = ccb.content.text("The %s seems to… uhh, like you?  Well, as certainly as you could tell a giant bug could like you.  It skitters around your legs and seems friendly."),
        pet_message = ccb.content.text("The %s skitters around your feet."),
    },
    inheritance = { add = { flags = { "CANPLAY" } }, remove = { anger_triggers = { "PLAYER_CLOSE" } } },
}

ccb.content.define_monster {
    id = "mon_centipede_mom",
    copy_from = "mon_centipede_mom",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_centipede_mega",
    copy_from = "mon_centipede_mega",
    mountable_weight_ratio = 0.4,
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}
