local ccb = require("ccb")

ccb.content.define_monster { id = "mon_large_cockroach", copy_from = "mon_large_cockroach", upgrade = false }

ccb.content.define_monster { id = "mon_worm_small", copy_from = "mon_worm_small", upgrade = false }

ccb.content.define_monster { id = "mon_silverfish_small", copy_from = "mon_silverfish_small", upgrade = false }

ccb.content.define_monster { id = "mon_bee", copy_from = "mon_bee", upgrade = false }

ccb.content.define_monster { id = "mon_centipede_small", copy_from = "mon_centipede_small", upgrade = false }

ccb.content.define_monster { id = "mon_centipede_house_small", copy_from = "mon_centipede_house_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_dragonfly_giant",
    copy_from = "mon_dragonfly_giant",
    aggression = 0,
    aggressive_to_characters = false,
    upgrade = false,
}

ccb.content.define_monster { id = "mon_fly", copy_from = "mon_fly", upgrade = false }

ccb.content.define_monster { id = "mon_mosquito_small", copy_from = "mon_mosquito_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_mosquito_larva",
    copy_from = "mon_mosquito_larva",
    upgrade = { grow_at_age = 30, monster = "mon_mosquito_small" },
}

ccb.content.define_monster { id = "mon_spider_cellar_small", copy_from = "mon_spider_cellar_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_spider_cellar_giant_s",
    copy_from = "mon_spider_cellar_giant_s",
    upgrade = { grow_at_age = 30, monster = "mon_spider_cellar_small" },
}

ccb.content.define_monster { id = "mon_spider_jumping_small", copy_from = "mon_spider_jumping_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_spider_jumping_giant_s",
    copy_from = "mon_spider_jumping_giant_s",
    upgrade = { grow_at_age = 30, monster = "mon_spider_jumping_small" },
}

ccb.content.define_monster { id = "mon_spider_trapdoor_small", copy_from = "mon_spider_trapdoor_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_spider_trapdoor_s",
    copy_from = "mon_spider_jumping_giant_s",
    upgrade = { grow_at_age = 30, monster = "mon_spider_trapdoor_small" },
}

ccb.content.define_monster { id = "mon_spider_web_small", copy_from = "mon_spider_web_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_spider_web_s",
    copy_from = "mon_spider_jumping_giant_s",
    upgrade = { grow_at_age = 30, monster = "mon_spider_web_small" },
}

ccb.content.define_monster { id = "mon_spider_widow_small", copy_from = "mon_spider_widow_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_spider_widow_giant_s",
    copy_from = "mon_spider_widow_giant_s",
    upgrade = { grow_at_age = 30, monster = "mon_spider_widow_small" },
}

ccb.content.define_monster { id = "mon_spider_wolf_small", copy_from = "mon_spider_wolf_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_spider_wolf_giant_s",
    copy_from = "mon_spider_wolf_giant_s",
    upgrade = { grow_at_age = 30, monster = "mon_spider_wolf_small" },
}

ccb.content.define_monster { id = "mon_wasp_small", copy_from = "mon_wasp_small", upgrade = false }

ccb.content.define_monster { id = "mon_wasp_small_guard", copy_from = "mon_wasp_small_guard", upgrade = false }

ccb.content.define_monster { id = "mon_ant_small", copy_from = "mon_ant_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_ant_larva",
    copy_from = "mon_ant_larva",
    upgrade = { grow_at_age = 30, monster = "mon_ant_small" },
}

ccb.content.define_monster { id = "mon_ant_soldier", copy_from = "mon_ant_soldier", upgrade = false }

ccb.content.define_monster { id = "mon_ant_acid_small", copy_from = "mon_ant_acid_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_ant_acid_larva",
    copy_from = "mon_ant_acid_larva",
    upgrade = { grow_at_age = 30, monster = "mon_ant_acid_small" },
}

ccb.content.define_monster { id = "mon_ant_acid_soldier", copy_from = "mon_ant_acid_soldier", upgrade = false }

ccb.content.define_monster { id = "mon_locust_small", copy_from = "mon_locust_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_locust_nymph",
    copy_from = "mon_locust_nymph",
    upgrade = { grow_at_age = 30, monster = "mon_locust_small" },
}

ccb.content.define_monster { id = "mon_aphid_small", copy_from = "mon_aphid_small", upgrade = false }

ccb.content.define_monster { id = "mon_mantis_small", copy_from = "mon_mantis_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_mantis_nymph",
    copy_from = "mon_mantis_nymph",
    upgrade = { grow_at_age = 30, monster = "mon_mantis_small" },
}

ccb.content.define_monster { id = "mon_lady_bug", copy_from = "mon_lady_bug", upgrade = false }

ccb.content.define_monster {
    id = "mon_lady_bug_larva",
    copy_from = "mon_lady_bug_larva",
    upgrade = { grow_at_age = 30, monster = "mon_lady_bug" },
}

ccb.content.define_monster { id = "mon_grasshopper_small", copy_from = "mon_grasshopper_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_grasshopper_nymph",
    copy_from = "mon_grasshopper_nymph",
    upgrade = { grow_at_age = 30, monster = "mon_grasshopper_small" },
}

ccb.content.define_monster { id = "mon_stag_beetle_small", copy_from = "mon_stag_beetle_small", upgrade = false }

ccb.content.define_monster { id = "mon_antlion_giant", copy_from = "mon_antlion_giant", upgrade = false }

ccb.content.define_monster { id = "mon_strider_small", copy_from = "mon_strider_small", upgrade = false }

ccb.content.define_monster {
    id = "mon_strider_nymph",
    copy_from = "mon_strider_nymph",
    upgrade = { grow_at_age = 30, monster = "mon_strider_small" },
}

ccb.content.define_monster { id = "mon_butterfly", copy_from = "mon_butterfly", upgrade = false }

ccb.content.define_monster { id = "mon_moth", copy_from = "mon_moth", upgrade = false }

ccb.content.define_monster {
    id = "mon_butterfly_cocoon",
    copy_from = "mon_butterfly_cocoon",
    upgrade = { grow_at_age = 30, monster = "mon_butterfly" },
}

ccb.content.define_monster {
    id = "mon_moth_cocoon",
    copy_from = "mon_moth_cocoon",
    upgrade = { grow_at_age = 30, monster = "mon_moth" },
}
