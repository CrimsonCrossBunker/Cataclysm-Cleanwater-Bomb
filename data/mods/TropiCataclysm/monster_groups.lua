local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup {
    id = "GROUP_EGG_CONSTRICTOR",
    load_mode = "append",
    default_monster = "mon_anaconda",
}
    :monster("mon_anaconda", 2, 1, 1, 1)
    :monster("mon_boa", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_IGUANA", load_mode = "append" }
    :monster("mon_iguana", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_TURTLE", load_mode = "append" }
    :monster("mon_turtle", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_TORTOISE", load_mode = "append" }
    :monster("mon_tortoise", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_TRIFFID", load_mode = "append" }
    :monster("mon_triffid_podling", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_FUNGUS", load_mode = "append" }
    :monster("mon_fungaloid_saproling", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_TADFISH", load_mode = "append" }
    :monster("mon_tadpole_small", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_LUNGFISH", load_mode = "append" }
    :monster("mon_fry_lungfish", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_EEL_ELECTRIC", load_mode = "append" }
    :monster("mon_fry_eel_electric", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_PACU", load_mode = "append" }
    :monster("mon_fry_pacu", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_TAMBAQUI", load_mode = "append" }
    :monster("mon_fry_tambaqui", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_PIRANHA", load_mode = "append" }
    :monster("mon_fry_piranha", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_AROWANA", load_mode = "append" }
    :monster("mon_fry_arowana", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_ARAPAIMA", load_mode = "append" }
    :monster("mon_fry_arapaima", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_PIRAIBA", load_mode = "append" }
    :monster("mon_fry_piraiba", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_PLECO", load_mode = "append" }
    :monster("mon_fry_pleco", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_GAR", load_mode = "append" }
    :monster("mon_fry_gar", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_TUCUNARE", load_mode = "append" }
    :monster("mon_fry_tucunare", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_DISCUS", load_mode = "append" }
    :monster("mon_fry_discus", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_ANGELFISH", load_mode = "append" }
    :monster("mon_fry_angelfish", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_KOI", load_mode = "append" }
    :monster("mon_fry_koi", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_TILAPIA", load_mode = "append" }
    :monster("mon_fry_tilapia", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_SABALO", load_mode = "append" }
    :monster("mon_fry_sabalo", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_OSCAR", load_mode = "append" }
    :monster("mon_fry_oscar", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_GUAPOTE", load_mode = "append" }
    :monster("mon_fry_guapote", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_MAYAHEROS", load_mode = "append" }
    :monster("mon_fry_mayaheros", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI", load_mode = "append", default_monster = "mon_spore" }
    :monster("mon_fungaloid_lasher", 50, 0, 1, 1)
    :monster("mon_fungaloid_thorny", 50, 0, 1, 1)
    :monster("mon_fungaloid_slimy", 50, 0, 1, 1)
    :monster("mon_fungaloid_breather", 50, 0, 1, 1)
    :monster("mon_fungaloid_cultivator", 25, 0, 1, 1)
    :monster("mon_bushelephant_fungal", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_TOWER", load_mode = "append" }
    :monster("mon_fungaloid_lasher", 50, 0, 1, 1)
    :monster("mon_fungaloid_thorny", 50, 0, 1, 1)
    :monster("mon_fungaloid_slimy", 50, 0, 1, 1)
    :monster("mon_fungaloid_breather", 50, 0, 1, 1)
    :monster("mon_fungaloid_cultivator", 25, 0, 1, 1)
    :monster("mon_bushelephant_fungal", 10, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FUNGI_FLOWERS", load_mode = "append" }
    :monster("mon_fungaloid_lasher", 50, 0, 1, 1)
    :monster("mon_fungaloid_thorny", 50, 0, 1, 1)
    :monster("mon_fungaloid_slimy", 50, 0, 1, 1)
    :monster("mon_fungaloid_breather", 50, 0, 1, 1)
    :monster("mon_fungaloid_cultivator", 25, 0, 1, 1)
    :monster("mon_bushelephant_fungal", 10, 0, 1, 1))

-- Group for fungal caretakers to evolve
content.add(content.MonsterGroup {
    id = "GROUP_FUNGAL_CARETAKER",
    load_mode = "append",
    default_monster = "mon_fungaloid",
}
    :monster("mon_fungaloid", 30, 0, 1, 1)
    :monster("mon_fungaloid_shambler", 20, 0, 1, 1)
    :monster("mon_fungaloid_young", 20, 0, 1, 1)
    :monster("mon_fungaloid_lasher", 20, 0, 1, 1)
    :monster("mon_fungaloid_thorny", 20, 0, 1, 1)
    :monster("mon_fungaloid_slimy", 20, 0, 1, 1)
    :monster("mon_fungaloid_breather", 20, 0, 1, 1)
    :monster("mon_fungaloid_cultivator", 10, 0, 1, 1)
    :monster("mon_fungaloid_ganglion", 10, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_FUNGI_URBAN",
    load_mode = "append",
    default_monster = "mon_fungaloid",
}
    :monster("mon_fungaloid_caretaker", 300, 0, 2, 4)
    :monster("mon_fungaloid", 80, 0, 1, 1)
    :monster("mon_fungaloid", 100, 2, 2, 3)
    :monster("mon_fungaloid_shambler", 160, 0, 1, 1)
    :monster("mon_fungaloid_lasher", 160, 0, 1, 1)
    :monster("mon_fungaloid_thorny", 160, 0, 1, 1)
    :monster("mon_fungaloid_slimy", 160, 0, 1, 3)
    :monster("mon_fungaloid_breather", 160, 0, 1, 3)
    :monster("mon_fungaloid_cultivator", 100, 0, 1, 1)
    :monster("mon_zombie_fungus", 100, 0, 1, 3)
    :monster("mon_zombie_child_fungus", 100, 0, 2, 4)
    :monster("mon_boomer_fungus", 60, 0, 1, 1)
    :monster("mon_skeleton_fungus", 60, 0, 1, 1)
    :monster("mon_zombie_smoker_fungus", 60, 0, 1, 1)
    :monster("mon_skeleton_brute_fungus", 60, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_DOMESTIC",
    load_mode = "append",
    default_monster = "mon_dog",
    is_animal = true,
}
    :monster("mon_camel", 50, 25, 1, 4)
    :monster("mon_guinea_pig", 10, 25, 1, 6))

content.add(content.MonsterGroup { id = "GROUP_SAFE", load_mode = "append", is_animal = true, is_safe = true }
    :monster("mon_tapir", 10, 1, 1, 1)
    :monster("mon_capybara", 10, 1, 1, 1)
    :monster("mon_guinea_pig", 10, 1, 1, 1)
    :monster("mon_bushdog", 10, 1, 1, 1)
    :monster("mon_camel", 10, 1, 1, 1)
    :monster("mon_boa", 10, 1, 1, 1)
    :monster("mon_anaconda", 10, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_SUBWAY",
    load_mode = "append",
    default_monster = "mon_spider_cellar_giant",
}
    :monster("mon_caecilian", 180, 1, 1, 1, { ends = duration(30, "day") })
    :monster("mon_caecilian_small", 180, 1, 1, 1, { starts = duration(30, "day"), ends = duration(60, "day") })
    :monster("mon_minhocao", 180, 1, 1, 1, { starts = duration(60, "day") })
    :group("GROUP_ONICOPHORE", 180, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ALIEN_REEF",
    load_mode = "append",
    default_monster = "mon_shrimp_flying",
}
    :monster("mon_shrimp_flying", 250, 0, 1, 1)
    :monster("mon_seastar_alien", 250, 0, 1, 1)
    :monster("mon_urchin_alien", 250, 0, 1, 1)
    :monster("mon_jellyfish_flying", 250, 0, 1, 1)
    :monster("mon_snail_alien", 250, 0, 1, 1)
    :monster("mon_squid_flying", 250, 0, 1, 1)
    :monster("mon_jellyfish_box", 200, 0, 1, 1)
    :monster("mon_cucumber_alien", 200, 0, 1, 1)
    :monster("mon_conch_alien", 200, 0, 1, 1)
    :monster("mon_ammonoid_flying", 200, 0, 1, 1)
    :monster("mon_crab_alien", 200, 0, 1, 1)
    :monster("mon_fish_paperkite", 200, 0, 1, 1)
    :monster("mon_fish_finwing", 200, 0, 1, 1)
    :monster("mon_fish_cloudscale", 200, 0, 1, 1)
    :monster("mon_fish_flagtail", 150, 0, 1, 1)
    :monster("mon_fish_balloondrift", 150, 0, 1, 1)
    :monster("mon_fish_angelfin", 150, 0, 1, 1)
    :monster("mon_fish_wingmane", 100, 0, 1, 1)
    :monster("mon_fish_mosaicus", 100, 0, 1, 1)
    :monster("mon_fish_cometbass", 100, 0, 1, 1)
    :monster("mon_fish_aeroctinus", 75, 0, 1, 1)
    :monster("mon_fish_boreasbanner", 75, 0, 1, 1)
    :monster("mon_fish_macawfin", 75, 0, 1, 1)
    :monster("mon_jellyfish_giant", 75, 0, 1, 1)
    :monster("mon_orthoceras_flying", 75, 0, 1, 1)
    :monster("mon_lobster_alien", 75, 0, 1, 1)
    :monster("mon_fish_astrolaspis", 50, 0, 1, 1)
    :monster("mon_fish_eolocanth", 50, 0, 1, 1)
    :monster("mon_fish_cosmoserpent", 50, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TRIFFID", load_mode = "append", default_monster = "mon_triffid" }
    :monster("mon_triffid_biter", 160, 10, 1, 1)
    :monster("mon_triffid_acid", 160, 10, 1, 1)
    :monster("mon_triffid_gas", 100, 2, 1, 3)
    :monster("mon_triffid_lasher", 100, 2, 1, 3)
    :monster("mon_triffid_lifegiver", 100, 4, 1, 1))

-- Group for triffids + plant zeds on special urban locations
content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_URBAN",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid_gardenling", 300, 0, 2, 4)
    :monster("mon_fungal_fighter", 100, 1, 1, 1)
    :monster("mon_triffid", 80, 1, 1, 1)
    :monster("mon_triffid", 100, 2, 2, 3)
    :monster("mon_vinebeast", 160, 10, 1, 1)
    :monster("mon_triffid_biter", 160, 10, 1, 1)
    :monster("mon_triffid_acid", 160, 10, 1, 1)
    :monster("mon_triffid_queen", 60, 20, 1, 1)
    :monster("mon_biollante_sprig", 100, 0, 3, 5)
    :monster("mon_biollante_sprout", 100, 0, 1, 3)
    :monster("mon_biollante", 100, 2, 1, 3)
    :monster("mon_triffid_gas", 100, 2, 1, 3)
    :monster("mon_triffid_lasher", 100, 2, 1, 3)
    :monster("mon_triffid_lifegiver", 100, 4, 1, 1)
    :monster("mon_triffid_flower", 100, 4, 1, 1)
    :monster("mon_zombie_garden", 100, 0, 1, 3)
    :monster("mon_zombie_seedling", 100, 0, 2, 4)
    :monster("mon_boomer_moss", 60, 0, 1, 1)
    :monster("mon_swimmer_swamped", 60, 0, 1, 1)
    :monster("mon_shrieker_vines", 60, 0, 1, 1)
    :monster("mon_brute_thorns", 60, 0, 1, 1))

-- Group for triffids gardenlings to evolve
content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_GARDENLING",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid", 30, 1, 1, 1)
    :monster("mon_fungal_fighter", 20, 1, 1, 1)
    :monster("mon_vinebeast", 20, 1, 1, 1)
    :monster("mon_triffid_biter", 20, 1, 1, 1)
    :monster("mon_triffid_acid", 20, 1, 1, 1)
    :monster("mon_triffid_queen", 10, 1, 1, 1)
    :monster("mon_biollante_sprig", 20, 0, 3, 5)
    :monster("mon_biollante_sprout", 20, 0, 1, 3)
    :monster("mon_biollante", 20, 1, 1, 1)
    :monster("mon_triffid_gas", 20, 1, 1, 1)
    :monster("mon_triffid_lasher", 20, 1, 1, 1)
    :monster("mon_triffid_lifegiver", 10, 1, 1, 1)
    :monster("mon_triffid_flower", 10, 1, 1, 1))

-- Group for plant zeds
content.add(content.MonsterGroup {
    id = "GROUP_PLANT_ZEDS",
    load_mode = "append",
    default_monster = "mon_zombie_garden",
}
    :monster("mon_zombie_garden", 70, 0, 1, 1)
    :monster("mon_zombie_seedling", 70, 0, 1, 1)
    :monster("mon_boomer_moss", 30, 0, 1, 1)
    :monster("mon_swimmer_swamped", 30, 0, 1, 1)
    :monster("mon_brute_thorns", 30, 0, 1, 1)
    :monster("mon_shrieker_vines", 30, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_OUTER",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid_biter", 160, 10, 1, 1)
    :monster("mon_triffid_acid", 160, 10, 1, 1)
    :monster("mon_triffid_gas", 50, 2, 1, 1)
    :monster("mon_triffid_lasher", 50, 2, 1, 1)
    :monster("mon_triffid_lifegiver", 25, 4, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_HEARTGUARDS",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :monster("mon_triffid_biter", 260, 2, 1, 1)
    :monster("mon_triffid_acid", 260, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TERMITES", load_mode = "append", is_animal = true }
    :monster("mon_termite_nymph", 4, 0, 1, 1)
    :monster("mon_termite_alate", 4, 0, 1, 1)
    :monster("mon_termite_soldier", 9, 5, 1, 1)
    :monster("mon_termite_shooter", 9, 5, 1, 1)
    :monster("mon_termite_worker", 87, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_TERMITE_SURFACE", load_mode = "append", is_animal = true }
    :monster("mon_termite_soldier", 90, 5, 1, 1)
    :monster("mon_termite_shooter", 90, 5, 1, 1)
    :monster("mon_termite_alate", 3, 10, 1, 1)
    :monster("mon_termite_worker", 852, 0, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TERMITE_ALATE",
    load_mode = "append",
    default_monster = "mon_termite_queen",
}
    :monster("mon_termite_king", 1, 1, 1, 1)
    :monster("mon_termite_queen", 1, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TERMITE",
    load_mode = "append",
    default_monster = "mon_termite_soldier",
}
    :monster("mon_termite_soldier", 35, 1, 1, 1)
    :monster("mon_termite_shooter", 35, 1, 1, 1)
    :monster("mon_termite_alate", 30, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SCORPION", load_mode = "append" }
    :monster("mon_large_scorpion", 1, 1, 1, 1, { ends = duration(180, "day") })
    :monster("mon_scorpion_giant", 1, 1, 1, 1, { starts = duration(120, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ONICOPHORE", load_mode = "append" }
    :monster("mon_onicophore_small", 5, 1, 1, 1, { ends = duration(180, "day") })
    :monster("mon_onicophore", 5, 1, 1, 1, { starts = duration(120, "day") })
    :monster("mon_onicophore_giant", 2, 1, 1, 1, { starts = duration(288, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_CAVE",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_jaguar", 100, 20, 1, 2)
    :monster("mon_bear_andean", 100, 10, 1, 3)
    :group("GROUP_SCORPION", 100, 3, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_FOREST",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_ocelot", 7, 2, 1, 1)
    :monster("mon_ocelot", 12, 2, 1, 1, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_bear_andean", 1, 10, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN", "WINTER" } })
    :monster("mon_bushdog", 1, 2, 2, 5)
    :monster("mon_coati", 5, 2, 2, 5)
    :monster("mon_tapir", 3, 10, 1, 1)
    :monster("mon_jaguar", 1, 3, 1, 1)
    :monster("mon_jaguar", 2, 3, 1, 1, { conditions = { "DAWN", "DUSK" } })
    :monster("mon_peccari", 15, 2, 1, 4)
    :group("GROUP_SCORPION", 3, 1, 1, 1)
    :group("GROUP_ONICOPHORE", 3, 1, 1, 1)
    :monster("mon_bushelephant", 1, 3, 1, 1)
    :monster("mon_hippo", 1, 3, 1, 1)
    :monster("mon_guinea_pig", 12, 2, 1, 6)
    :monster("mon_rhea", 12, 2, 1, 10)
    :monster("mon_kangaroo_wallaby", 12, 2, 1, 10)
    :monster("mon_iguana", 15, 10, 1, 1)
    :monster("mon_basiliscus", 15, 10, 1, 1)
    :monster("mon_anole", 15, 10, 1, 1)
    :monster("mon_gecko", 15, 10, 1, 1)
    :monster("mon_skink", 15, 10, 1, 1)
    :monster("mon_tortoise", 15, 10, 1, 1)
    :monster("mon_caecilian", 15, 10, 1, 1)
    :monster("mon_boa", 15, 10, 1, 1)
    :monster("mon_anaconda", 15, 10, 1, 1)
    :monster("mon_tortoise_small", 3, 1, 1, 3, { starts = duration(40, "day") })
    :monster("mon_tortoise_giant", 3, 1, 1, 3, { starts = duration(80, "day") })
    :monster("mon_parrot", 5, 0, 1, 14)
    :monster("mon_finch_saffron", 5, 0, 1, 3)
    :monster("mon_great_kiskadee", 5, 0, 1, 2)
    :monster("mon_rufous_hornero", 5, 0, 1, 3)
    :monster("mon_toucan", 2, 0, 1, 10)
    :monster("mon_macaw", 3, 0, 1, 8)
    :monster("mon_seriema", 15, 10, 1, 1)
    :monster("mon_tinamou", 12, 2, 1, 6)
    :monster("mon_chachalaca", 9, 2, 1, 18)
    :monster("mon_guan", 15, 0, 1, 7)
    :monster("mon_curassow", 12, 2, 1, 10))

content.add(content.MonsterGroup {
    id = "GROUP_RIVER",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_coypus", 15, 10, 1, 3)
    :monster("mon_turtle", 15, 10, 1, 3)
    :monster("mon_capybara", 15, 5, 1, 4)
    :monster("mon_caiman", 10, 5, 1, 1)
    :monster("mon_crocodile", 10, 5, 1, 1)
    :monster("mon_anaconda", 10, 5, 1, 1)
    :monster("mon_hippo", 5, 10, 1, 3)
    :monster("mon_caecilian", 5, 10, 1, 1)
    :monster("mon_basiliscus", 5, 10, 1, 1)
    :monster("mon_tadpole_small", 5, 10, 1, 1)
    :monster("mon_tadpole_small", 30, 3, 1, 3, { starts = duration(28, "day") })
    :monster("mon_shark", 3, 15, 1, 1)
    :monster("mon_shark_pup", 6, 3, 1, 3)
    :monster("mon_fish_lungfish", 6, 3, 1, 3)
    :monster("mon_fish_eel_electric", 5, 10, 1, 3)
    :monster("mon_fish_pacu", 6, 8, 1, 4)
    :monster("mon_fish_pacu_giant", 6, 8, 1, 4)
    :monster("mon_fish_piranha", 6, 8, 1, 3)
    :monster("mon_fish_arowana", 6, 8, 1, 3)
    :monster("mon_fish_arapaima", 6, 8, 1, 3)
    :monster("mon_fish_gar", 6, 8, 1, 3)
    :monster("mon_fish_piraiba", 6, 8, 1, 3)
    :monster("mon_fish_pleco", 6, 3, 1, 3)
    :monster("mon_fish_stingray", 6, 3, 1, 3)
    :monster("mon_fish_tucunare", 6, 8, 1, 3)
    :monster("mon_fish_discus", 6, 3, 1, 3)
    :monster("mon_fish_angelfish", 6, 3, 1, 3)
    :monster("mon_fish_goldfish", 6, 3, 1, 3)
    :monster("mon_fish_koi", 6, 8, 1, 3)
    :monster("mon_fish_tilapia", 6, 3, 1, 3)
    :monster("mon_fish_sabalo", 6, 8, 1, 3)
    :monster("mon_fish_oscar", 6, 3, 1, 3)
    :monster("mon_fish_guapote", 6, 3, 1, 3)
    :monster("mon_fish_mayaheros", 6, 3, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_SWAMP",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_crocodile", 40, 2, 1, 1)
    :monster("mon_anaconda", 50, 2, 1, 1)
    :monster("mon_caiman", 50, 2, 1, 1)
    :monster("mon_turtle", 60, 2, 1, 1)
    :monster("mon_caecilian", 30, 2, 1, 1)
    :monster("mon_basiliscus", 30, 2, 1, 1)
    :monster("mon_capybara", 60, 2, 1, 3)
    :monster("mon_fish_crab", 10, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } })
    :monster("mon_fish_pancora", 10, 1, 1, 1, { conditions = { "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup { id = "GROUP_PARK_ANIMAL", load_mode = "append", is_animal = true }
    :monster("mon_parrot", 25, 0, 1, 1)
    :monster("mon_finch_saffron", 25, 0, 1, 1)
    :monster("mon_great_kiskadee", 25, 0, 1, 1)
    :monster("mon_rufous_hornero", 25, 0, 1, 1)
    :monster("mon_iguana", 25, 0, 1, 1)
    :monster("mon_macaw", 15, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ROOF_ANIMAL", load_mode = "append", is_animal = true }
    :monster("mon_parrot", 25, 0, 1, 1)
    :monster("mon_finch_saffron", 25, 0, 1, 1)
    :monster("mon_great_kiskadee", 20, 0, 1, 1)
    :monster("mon_rufous_hornero", 20, 0, 1, 1)
    :monster("mon_boa", 25, 0, 1, 1)
    :monster("mon_gecko", 25, 0, 1, 1)
    :monster("mon_macaw", 10, 0, 1, 1)
    :monster("mon_coati", 25, 0, 1, 3, { conditions = { "DAWN", "DUSK", "NIGHT", "SPRING", "SUMMER", "AUTUMN" } }))

content.add(content.MonsterGroup {
    id = "GROUP_POND_ANIMAL",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_coypus", 50, 0, 1, 3)
    :monster("mon_turtle", 50, 0, 1, 3)
    :monster("mon_tadpole_small", 30, 0, 1, 3)
    :monster("mon_caecilian", 30, 0, 1, 1)
    :monster("mon_basiliscus", 30, 0, 1, 1)
    :monster("mon_capybara", 50, 0, 1, 3)
    :monster("mon_caiman", 40, 0, 1, 1)
    :monster("mon_anaconda", 40, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BIRDFEEDER", load_mode = "append", is_animal = true }
    :monster("mon_parrot", 35, 0, 1, 1)
    :monster("mon_finch_saffron", 20, 0, 1, 1)
    :monster("mon_great_kiskadee", 15, 0, 1, 1)
    :monster("mon_rufous_hornero", 15, 0, 1, 1))

-- Upgrades for the Thorny Boomer.
content.add(content.MonsterGroup {
    id = "GROUP_MOSSY_BOOMER_UPGRADE",
    load_mode = "append",
    default_monster = "mon_boomer_moss",
}
    :monster("mon_boomer_moss", 1, 1, 1, 1)
    :monster("mon_boomer_sap", 250, 1, 1, 1)
    :monster("mon_boomer_pollen", 250, 1, 1, 1))

-- Upgrades for the Thorny Shambler.
content.add(content.MonsterGroup {
    id = "GROUP_GARDEN_ZOMBIE_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_garden",
}
    :monster("mon_zombie_garden", 1, 1, 1, 1)
    :monster("mon_brute_thorns", 15, 1, 1, 1)
    :monster("mon_swimmer_swamped", 30, 1, 1, 1)
    :monster("mon_shrieker_vines", 15, 1, 1, 1)
    :monster("mon_boomer_moss", 30, 1, 1, 1))
