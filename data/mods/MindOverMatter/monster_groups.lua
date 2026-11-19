local ccb = require("ccb")
local content = ccb.content
local duration = ccb.services.time.duration

content.add(content.MonsterGroup { id = "GROUP_PARK_SCENIC", load_mode = "append" }
    :monster("mon_feral_human_bio", 2, 2, 1, 1)
    :monster("mon_feral_human_clair", 3, 1, 1, 1)
    :monster("mon_feral_human_electrokin", 2, 2, 1, 1)
    :monster("mon_feral_human_photokin", 2, 1, 1, 1)
    :monster("mon_feral_human_pyrokin", 1, 3, 1, 1)
    :monster("mon_feral_human_telekin", 2, 2, 1, 1)
    :monster("mon_feral_human_teep", 3, 1, 1, 1)
    :monster("mon_feral_human_porter", 1, 1, 1, 1)
    :monster("mon_feral_human_vita", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PARK_DOG", load_mode = "append" }
    :monster("mon_feral_human_bio", 2, 2, 1, 1)
    :monster("mon_feral_human_clair", 3, 1, 1, 1)
    :monster("mon_feral_human_electrokin", 2, 2, 1, 1)
    :monster("mon_feral_human_photokin", 3, 1, 1, 1)
    :monster("mon_feral_human_pyrokin", 1, 3, 1, 1)
    :monster("mon_feral_human_telekin", 2, 2, 1, 1)
    :monster("mon_feral_human_teep", 3, 1, 1, 1)
    :monster("mon_feral_human_porter", 1, 1, 1, 1)
    :monster("mon_feral_human_vita", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE", load_mode = "append" }
    :monster("mon_feral_human_bio", 1, 4, 1, 1)
    :monster("mon_feral_human_clair", 1, 3, 1, 1)
    :monster("mon_feral_human_electrokin", 1, 5, 1, 1)
    :monster("mon_feral_human_photokin", 1, 4, 1, 1)
    :monster("mon_feral_human_pyrokin", 1, 5, 1, 1)
    :monster("mon_feral_human_telekin", 1, 4, 1, 1)
    :monster("mon_feral_human_teep", 1, 3, 1, 1)
    :monster("mon_feral_human_porter", 1, 3, 1, 1)
    :monster("mon_feral_human_vita", 1, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PREPPER_HOUSE", load_mode = "append" }
    :monster("mon_feral_human_bio", 10, 2, 1, 1)
    :monster("mon_feral_human_clair", 15, 1, 1, 1)
    :monster("mon_feral_human_electrokin", 10, 2, 1, 1)
    :monster("mon_feral_human_photokin", 15, 1, 1, 1)
    :monster("mon_feral_human_pyrokin", 5, 3, 1, 1)
    :monster("mon_feral_human_telekin", 10, 2, 1, 1)
    :monster("mon_feral_human_teep", 15, 1, 1, 1)
    :monster("mon_feral_human_porter", 5, 1, 1, 1)
    :monster("mon_feral_human_vita", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CHURCH_ZOMBIE", load_mode = "append" }
    :monster("mon_feral_human_clair", 15, 2, 1, 1)
    :monster("mon_feral_human_vita", 15, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MANSION_START", load_mode = "append" }
    :monster("mon_feral_human_clair", 40, 1, 1, 1)
    :monster("mon_feral_human_teep", 40, 1, 1, 1))

content.add(content.MonsterGroup { id = "FERAL_HUMANS", load_mode = "append" }
    :monster("mon_feral_human_bio", 1, 4, 1, 1)
    :monster("mon_feral_human_clair", 1, 3, 1, 1)
    :monster("mon_feral_human_electrokin", 2, 5, 1, 1)
    :monster("mon_feral_human_photokin", 1, 4, 1, 1)
    :monster("mon_feral_human_pyrokin", 1, 6, 1, 1)
    :monster("mon_feral_human_telekin", 1, 5, 1, 1)
    :monster("mon_feral_human_teep", 1, 4, 1, 1)
    :monster("mon_feral_human_porter", 1, 3, 1, 1)
    :monster("mon_feral_human_vita", 1, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB", load_mode = "append" }
    :monster("mon_feral_scientist_psychic", 15, 10, 1, 1)
    :monster("mon_feral_security_psychic", 12, 4, 1, 1)
    :monster("mon_feral_security_captain_psychic", 6, 10, 1, 1)
    :monster("mon_zombie_scientist_phavian", 50, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 20, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_LAB_SURFACE", load_mode = "append" }
    :monster("mon_feral_scientist_psychic", 10, 10, 1, 1)
    :monster("mon_feral_security_psychic", 12, 4, 1, 1)
    :monster("mon_feral_security_captain_psychic", 6, 10, 1, 1)
    :monster("mon_zombie_scientist_phavian", 50, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 20, 1, 1, 3))

content.add(content.MonsterGroup { id = "GROUP_MICROLAB", load_mode = "append" }
    :monster("mon_feral_scientist_psychic", 2, 10, 1, 1)
    :monster("mon_feral_security_psychic", 12, 4, 1, 1)
    :monster("mon_feral_security_captain_psychic", 6, 10, 1, 1)
    :monster("mon_zombie_scientist_phavian", 60, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 5, 1, 1, 3)
    :group("GROUP_FERAL_CLAIRSENTIENT", 6, 3, 1, 1)
    :group("GROUP_FERAL_TELEPORTER", 10, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SERUM_LAB", load_mode = "append" }
    :monster("mon_feral_scientist_psychic", 1, 20, 1, 1)
    :monster("mon_feral_security_psychic", 8, 4, 1, 1)
    :monster("mon_feral_security_captain_psychic", 4, 10, 1, 1)
    :monster("mon_zombie_scientist_phavian", 30, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 3, 1, 1, 3)
    :group("GROUP_FERAL_BIOKINETIC_VITAKINETIC", 15, 3, 1, 1)
    :group("GROUP_FERAL_TELEPATH", 5, 3, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_BASIC_SECURITY", load_mode = "append" }
    :monster("mon_feral_security_psychic", 5, 4, 1, 1)
    :monster("mon_feral_security_captain_psychic", 2, 10, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DISTORTED_MICROLAB", load_mode = "append" }
    :monster("mon_feral_scientist_psychic", 20, 1, 1, 1)
    :monster("mon_feral_human_porter3", 35, 1, 1, 1)
    :monster("mon_nether_eater", 60, 1, 1, 1)
    :monster("mon_nether_silent_one_passive", 30, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_LAB_RESEARCHERS", load_mode = "append" }
    :monster("mon_feral_scientist_psychic", 10, 5, 1, 1)
    :monster("mon_zombie_scientist_phavian", 150, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 5, 1, 1, 2))

content.add(content.MonsterGroup { id = "GROUP_MEATLAB", load_mode = "append" }
    :monster("mon_amalgamation_photokinetic_flashbanger", 5, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_photokinetic_flashbanger", 10, 1, 1, 1, { starts = duration(224, "day") })
    :monster("mon_amalgamation_telepathic_distractor", 10, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_telepathic_distractor", 15, 1, 1, 1, { starts = duration(224, "day") })
    :monster("mon_amalgamation_telekinetic_shielder", 5, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_telekinetic_shielder", 10, 1, 1, 1, { starts = duration(224, "day") })
    :monster("mon_amalgamation_vitakinetic_debuffer", 10, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_vitakinetic_debuffer", 20, 1, 1, 1, { starts = duration(224, "day") }))

content.add(content.MonsterGroup { id = "GROUP_AMALGAMATION_SMALL", load_mode = "append" }
    :monster("mon_amalgamation_photokinetic_flashbanger", 5, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_photokinetic_flashbanger", 10, 1, 1, 1, { starts = duration(224, "day") })
    :monster("mon_amalgamation_telepathic_distractor", 10, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_telepathic_distractor", 15, 1, 1, 1, { starts = duration(224, "day") })
    :monster("mon_amalgamation_telekinetic_shielder", 5, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_telekinetic_shielder", 10, 1, 1, 1, { starts = duration(224, "day") })
    :monster("mon_amalgamation_vitakinetic_debuffer", 10, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_vitakinetic_debuffer", 20, 1, 1, 1, { starts = duration(224, "day") }))

content.add(content.MonsterGroup { id = "GROUP_AMALGAMATION_MED", load_mode = "append" }
    :monster("mon_amalgamation_photokinetic_irradiator", 5, 1, 1, 1, { starts = duration(112, "day") })
    :monster("mon_amalgamation_photokinetic_irradiator", 5, 1, 1, 1, { starts = duration(224, "day") }))

content.add(content.MonsterGroup { id = "GROUP_NETHER_REALITY_TEAR_FIELD", load_mode = "append" }
    :monster("mon_nether_eater", 100, 0, 1, 1)
    :monster("mon_nether_silent_one_passive", 100, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER", load_mode = "append" }
    :monster("mon_nether_eater", 120, 0, 1, 1)
    :monster("mon_nether_silent_one_passive", 50, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_NETHER_PORTAL", load_mode = "append" }
    :monster("mon_nether_eater", 200, 0, 1, 1)
    :monster("mon_nether_silent_one_passive", 200, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CIVILIANS_STANDARD", load_mode = "append" }
    :group("GROUP_CIVILIANS_PSYCHIC_FERAL", 10, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_BEARS", load_mode = "append" }
    :monster("mon_bandersnatch", 20, 5, 1, 1, { starts = duration(8, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_RABBIT_WILD",
    load_mode = "append",
    default_monster = "mon_wild_rabbit",
}
    :monster("mon_wild_rabbit_blinker", 10, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_DEERS", load_mode = "append" }
    :monster("mon_fear_deer", 20, 2, 1, 1, { starts = duration(8, "day") })
    :monster("mon_fear_deer_fawn", 5, 2, 1, 1)
    :monster("mon_fear_deer_fawn", 10, 2, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_CAVE", load_mode = "append" }
    :monster("mon_hidebehind", 10, 5, 1, 1, { starts = duration(8, "day") }))

content.add(content.MonsterGroup { id = "GROUP_WILDERNESS_FOREST_MAMMAL_WINTER", load_mode = "append" }
    :monster("mon_hidebehind", 1, 10, 1, 1, { starts = duration(8, "day") })
    :monster("mon_psi_gremlin", 1, 10, 1, 1, { starts = duration(8, "day") }))

content.add(content.MonsterGroup { id = "GROUP_COWS", load_mode = "append" }
    :monster("mon_hodag_calf", 10, 5, 1, 1, { starts = duration(28, "day") })
    :monster("mon_hodag", 10, 8, 1, 1, { starts = duration(720, "day") }))

content.add(content.MonsterGroup { id = "GROUP_COWS_DAIRY", load_mode = "append" }
    :monster("mon_cow_biokinetic", 10, 5, 1, 1, { starts = duration(8, "day") })
    :monster("mon_hodag_calf", 10, 5, 1, 1, { starts = duration(28, "day") })
    :monster("mon_hodag", 10, 20, 1, 1, { starts = duration(720, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_FOREST",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :group("GROUP_ANIMAL_PSIONS", 15, 5, 1, 1)
    :group("GROUP_ANIMAL_PSIONS", 15, 5, 1, 1, { starts = duration(56, "day") })
    :group("GROUP_ANIMAL_PSIONS", 15, 5, 1, 1, { starts = duration(112, "day") })
    :group("GROUP_ANIMAL_PSIONS", 15, 5, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_WILDERNESS_FOREST_MAMMAL_MUTANT",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_hodag", 1, 10, 1, 1, { starts = duration(720, "day") })
    :monster("mon_cockatrice", 5, 10, 3, 5, { starts = duration(84, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_ROOF_ANIMAL",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_cockatrice", 2, 2, 1, 1, { starts = duration(84, "day") })
    :monster("mon_cockatrice", 10, 10, 3, 5, { starts = duration(84, "day") })
    :monster("mon_pigeon_passenger", 2, 2, 1, 1, { starts = duration(84, "day") })
    :monster("mon_pigeon_passenger", 10, 10, 3, 5, { starts = duration(84, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_SAFE",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_cockatrice", 2, 1, 1, 1, { starts = duration(84, "day") })
    :monster("mon_psi_gremlin", 2, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_PET_DOGS", load_mode = "append", default_monster = "mon_dog" }
    :monster("mon_hellhound", 5, 0, 1, 1)
    :monster("mon_hellhound", 25, 0, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GROUP_STRAY_DOGS", load_mode = "append", default_monster = "mon_dog" }
    :monster("mon_hellhound", 3, 0, 1, 1)
    :monster("mon_hellhound", 15, 0, 1, 1, { starts = duration(360, "day") })
    :monster("mon_dire_hound", 1, 0, 1, 1, { starts = duration(232, "day") }))

content.add(content.MonsterGroup {
    id = "GROUP_MUTANT_PET_DOGS",
    load_mode = "append",
    default_monster = "mon_dog_mutant_mongrel",
}
    :monster("mon_dire_hound", 1, 0, 1, 1, { starts = duration(232, "day") }))

content.add(content.MonsterGroup { id = "GROUP_ANIMALPOUND_DOGS", load_mode = "append" }
    :monster("mon_hellhound", 5, 0, 1, 1)
    :monster("mon_hellhound", 15, 0, 1, 1, { starts = duration(360, "day") }))

content.add(content.MonsterGroup { id = "GO_CAMP_OM", load_mode = "append" }
    :monster("mon_mi_go_telepath", 50, 20, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_photokinetic", 50, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_biokinetic", 20, 70, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_COMMON", load_mode = "append" }
    :monster("mon_mi_go_telepath", 50, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_photokinetic", 50, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_biokinetic", 15, 8, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_CAPTORS", load_mode = "append" }
    :monster("mon_mi_go_telepath", 300, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_photokinetic", 300, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_biokinetic", 50, 8, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_BASE_BOSS", load_mode = "append" }
    :monster("mon_mi_go_telepath", 200, 2, 1, 1)
    :monster("mon_mi_go_telepath", 50, 5, 2, 3)
    :monster("mon_mi_go_photokinetic", 200, 2, 1, 1)
    :monster("mon_mi_go_photokinetic", 50, 5, 2, 3)
    :monster("mon_mi_go_biokinetic", 200, 5, 1, 1)
    :monster("mon_mi_go_biokinetic", 50, 20, 2, 3))

content.add(content.MonsterGroup { id = "GROUP_TRIFFID", load_mode = "append", default_monster = "mon_triffid" }
    :group("GROUP_TRIFFID_PSIONS", 25, 5, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_OUTER",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :group("GROUP_TRIFFID_PSIONS", 50, 2, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_TRIFFID_HEARTGUARDS",
    load_mode = "append",
    default_monster = "mon_triffid",
}
    :group("GROUP_TRIFFID_PSIONS", 150, 2, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ANIMAL_PSIONS",
    load_mode = "append",
    default_monster = "mon_null",
    is_animal = true,
}
    :monster("mon_hidebehind", 20, 1, 1, 1)
    :monster("mon_psi_gremlin", 100, 1, 1, 1)
    :monster("mon_psi_gremlin", 15, 1, 2, 3)
    :monster("mon_cockatrice", 75, 1, 1, 1, { starts = duration(84, "day") })
    :monster("mon_cockatrice", 10, 1, 3, 5, { starts = duration(84, "day") })
    :monster("mon_hodag", 10, 1, 1, 1, { starts = duration(720, "day") })
    :monster("mon_bandersnatch", 5, 1, 1, 1)
    :monster("mon_fear_hawk", 10, 1, 1, 1)
    :monster("mon_hellhound", 75, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_PSYCHIC", load_mode = "append" }
    :monster("mon_feral_human_bio", 1, 2, 1, 1)
    :monster("mon_feral_human_clair", 1, 1, 1, 1)
    :monster("mon_feral_human_electrokin", 1, 2, 1, 1)
    :monster("mon_feral_human_photokin", 1, 1, 1, 1)
    :monster("mon_feral_human_pyrokin", 1, 3, 1, 1)
    :monster("mon_feral_human_telekin", 1, 2, 1, 1)
    :monster("mon_feral_human_teep", 1, 1, 1, 1)
    :monster("mon_feral_human_porter", 1, 1, 1, 1)
    :monster("mon_feral_human_vita", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_BIOKINETIC", load_mode = "append" }
    :monster("mon_feral_human_bio", 25, 1, 1, 1)
    :monster("mon_feral_human_bio2", 8, 1, 1, 1)
    :monster("mon_feral_human_bio3", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_CLAIRSENTIENT", load_mode = "append" }
    :monster("mon_feral_human_clair", 25, 1, 1, 1)
    :monster("mon_feral_human_clair2", 8, 1, 1, 1)
    :monster("mon_feral_human_clair3", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_CLAIRSENTIENT_TELEPATH", load_mode = "append" }
    :monster("mon_feral_human_clair", 25, 1, 1, 1)
    :monster("mon_feral_human_teep", 25, 1, 1, 1)
    :monster("mon_feral_human_clair2", 8, 1, 1, 1)
    :monster("mon_feral_human_teep2", 8, 1, 1, 1)
    :monster("mon_feral_human_clair3", 1, 1, 1, 1)
    :monster("mon_feral_human_teep3", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_BIOKINETIC_VITAKINETIC", load_mode = "append" }
    :monster("mon_feral_human_bio", 25, 1, 1, 1)
    :monster("mon_feral_human_vita", 25, 1, 1, 1)
    :monster("mon_feral_human_bio2", 8, 1, 1, 1)
    :monster("mon_feral_human_vita2", 8, 1, 1, 1)
    :monster("mon_feral_human_bio3", 1, 1, 1, 1)
    :monster("mon_feral_human_vita3", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_TELEPATH", load_mode = "append" }
    :monster("mon_feral_human_teep", 25, 1, 1, 1)
    :monster("mon_feral_human_teep2", 8, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FERAL_TELEPORTER", load_mode = "append" }
    :monster("mon_feral_human_porter", 25, 1, 1, 1)
    :monster("mon_feral_human_porter2", 8, 1, 1, 1)
    :monster("mon_feral_human_porter3", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CRYSTAL_FIELD", load_mode = "append" }
    :monster("mon_feral_human_bio", 60, 2, 1, 1)
    :monster("mon_feral_human_clair", 60, 1, 1, 1)
    :monster("mon_feral_human_electrokin", 60, 2, 1, 1)
    :monster("mon_feral_human_photokin", 60, 1, 1, 1)
    :monster("mon_feral_human_pyrokin", 60, 3, 1, 1)
    :monster("mon_feral_human_telekin", 60, 2, 1, 1)
    :monster("mon_feral_human_teep", 60, 1, 1, 1)
    :monster("mon_feral_human_porter", 60, 1, 1, 1)
    :monster("mon_feral_human_vita", 60, 1, 1, 1)
    :monster("mon_gelatin", 40, 1, 1, 1)
    :monster("mon_darkman", 15, 0, 1, 1)
    :monster("mon_gozu", 60, 0, 1, 1)
    :monster("mon_flying_polyp", 60, 0, 1, 1)
    :monster("mon_hunting_horror", 60, 0, 1, 1)
    :monster("mon_unseen_hunter", 60, 2, 1, 1)
    :monster("mon_star_vampire", 10, 0, 1, 1)
    :monster("mon_star_vampire_coiling", 10, 0, 1, 1)
    :monster("mon_flaming_eye", 25, 10, 1, 1)
    :monster("mon_kreck", 60, 5, 1, 1)
    :monster("mon_gracke", 100, 1, 1, 1)
    :monster("mon_mi_go", 60, 1, 1, 1)
    :monster("mon_mi_go_slaver", 50, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_myrmidon", 10, 4, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_telepath", 7, 4, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_biokinetic", 2, 8, 1, 1, { starts = duration(35, "day") })
    :monster("mon_nether_eater", 60, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_FEAR_HAWKS", load_mode = "append" }
    :monster("mon_fear_hawk", 1000, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CRYSTAL_FIELD_PSYCHOACTIVE", load_mode = "append" }
    :monster("mon_swarm_structure", 60, 2, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MI-GO_PSIONS", load_mode = "append" }
    :monster("mon_mi_go_telepath", 50, 20, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_photokinetic", 50, 2, 1, 1, { starts = duration(35, "day") })
    :monster("mon_mi_go_biokinetic", 20, 70, 1, 1, { starts = duration(35, "day") }))

content.add(content.MonsterGroup { id = "GROUP_TRIFFID_PSIONS", load_mode = "append" }
    :monster("mon_triffid_clairsentient", 400, 1, 1, 1)
    :monster("mon_triffid_pyrokinetic", 400, 1, 1, 1)
    :monster("mon_triffid_teleporter", 200, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_LAB_SECURITY_PHAVIAN",
    load_mode = "append",
    default_monster = "mon_zombie_labsecurity",
}
    :monster("mon_feral_labsecurity_9mm", 250, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 150, 2, 1, 1)
    :monster("mon_feral_security_captain_psychic", 8, 10, 1, 1)
    :monster("mon_feral_security_psychic", 25, 5, 1, 1)
    :monster("mon_zombie_labsecurity", 100, 2, 1, 3))

content.add(content.MonsterGroup {
    id = "GROUP_LAB_RESEARCH",
    load_mode = "append",
    default_monster = "mon_zombie_scientist_phavian",
}
    :monster("mon_feral_labsecurity_9mm", 18, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 0, 1, 1)
    :monster("mon_feral_scientist_psychic", 5, 5, 1, 1)
    :monster("mon_feral_security_captain_psychic", 8, 10, 1, 1)
    :monster("mon_feral_security_psychic", 25, 5, 1, 1)
    :group("GROUP_FERAL_PSYCHIC", 25, 3, 1, 1)
    :monster("mon_zombie_labsecurity", 400, 2, 1, 3)
    :monster("mon_zombie_scientist", 100, 1, 1, 1)
    :monster("mon_zombie_scientist", 40, 1, 1, 5)
    :monster("mon_zombie_scientist_phavian", 300, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 150, 1, 1, 5)
    :monster("mon_zombie_technician", 100, 2, 1, 1)
    :monster("mon_feral_human_tool", 25, 1, 1, 1)
    :monster("mon_zombie_hazmat", 200, 1, 1, 1)
    :monster("mon_zombie_necro", 15, 5, 1, 1)
    :monster("mon_zombie_electric", 50, 2, 1, 1)
    :monster("mon_science_bot", 80, 5, 1, 1)
    :monster("mon_secubot", 1, 5, 1, 1)
    :monster("mon_zombie", 100, 1, 1, 3)
    :monster("mon_zombie_fat", 20, 1, 1, 3)
    :monster("mon_zombie_tough", 40, 2, 1, 3)
    :monster("mon_zombie_brute", 10, 5, 1, 1)
    :monster("mon_zombie_crawler", 50, 1, 1, 1)
    :monster("mon_manhack", 200, 1, 1, 1)
    :monster("mon_manhack", 45, 1, 2, 3)
    :monster("mon_mutant_experimental", 3, 1, 1, 1)
    :monster("mon_skitterbot", 85, 1, 1, 1)
    :monster("mon_skitterbot", 85, 1, 2, 3)
    :monster("mon_skitterbot", 10, 1, 8, 12)
    :monster("mon_blob_small", 10, 1, 1, 4)
    :monster("mon_zombie_armored", 5, 5, 1, 1)
    :monster("mon_zombie_brute_shocker", 5, 5, 1, 1)
    :monster("mon_lab_rat", 50, 20, 4, 8))

content.add(content.MonsterGroup {
    id = "GROUP_PHAVIAN_OFFICE",
    load_mode = "append",
    default_monster = "mon_zombie_scientist_phavian",
}
    :monster("mon_feral_labsecurity_9mm", 18, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 18, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 20, 0, 1, 1)
    :monster("mon_feral_scientist_psychic", 5, 5, 1, 1)
    :monster("mon_feral_security_captain_psychic", 8, 8, 1, 1)
    :monster("mon_feral_security_psychic", 25, 5, 1, 1)
    :group("GROUP_FERAL_PSYCHIC", 25, 3, 1, 1)
    :monster("mon_zombie_labsecurity", 400, 2, 1, 3)
    :monster("mon_zombie_scientist_phavian", 300, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 150, 1, 1, 5)
    :monster("mon_zombie_technician", 100, 2, 1, 1)
    :monster("mon_zombie_hazmat", 50, 1, 1, 1)
    :monster("mon_zombie_necro", 5, 5, 1, 1)
    :monster("mon_zombie_electric", 50, 2, 1, 1)
    :monster("mon_zombie", 100, 1, 1, 3)
    :monster("mon_zombie_fat", 20, 1, 1, 3)
    :monster("mon_zombie_tough", 40, 2, 1, 3)
    :monster("mon_zombie_brute", 10, 5, 1, 1)
    :monster("mon_zombie_crawler", 50, 1, 1, 1)
    :monster("mon_lab_rat", 50, 20, 4, 8))

content.add(content.MonsterGroup {
    id = "GROUP_PHAVIAN_SKYSCRAPER_LAB",
    load_mode = "append",
    default_monster = "mon_zombie_scientist_phavian",
}
    :monster("mon_feral_labsecurity_9mm", 25, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 25, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 35, 0, 1, 1)
    :monster("mon_feral_scientist_psychic", 5, 5, 1, 1)
    :monster("mon_feral_security_captain_psychic", 12, 8, 1, 1)
    :monster("mon_feral_security_psychic", 30, 5, 1, 1)
    :group("GROUP_FERAL_CLAIRSENTIENT_TELEPATH", 20, 3, 1, 1)
    :group("GROUP_FERAL_PSYCHIC", 1, 8, 1, 1)
    :monster("mon_zombie_labsecurity", 400, 2, 1, 3)
    :monster("mon_zombie_scientist_phavian", 350, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 175, 1, 1, 5)
    :monster("mon_zombie_technician", 75, 2, 1, 1)
    :monster("mon_zombie_hazmat", 25, 1, 1, 1)
    :monster("mon_zombie_necro", 5, 5, 1, 1)
    :monster("mon_zombie_electric", 20, 2, 1, 1)
    :monster("mon_zombie", 100, 1, 1, 3)
    :monster("mon_zombie_fat", 20, 1, 1, 3)
    :monster("mon_zombie_tough", 40, 2, 1, 3)
    :monster("mon_zombie_brute", 15, 5, 1, 1)
    :monster("mon_zombie_crawler", 50, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_PHAVIAN_CITY_HOSPITAL_LAB",
    load_mode = "append",
    default_monster = "mon_zombie_scientist_phavian",
}
    :monster("mon_feral_labsecurity_9mm", 25, 8, 1, 1)
    :monster("mon_feral_labsecurity_flashlight", 25, 2, 1, 1)
    :monster("mon_feral_scientist_scalpel", 35, 0, 1, 1)
    :monster("mon_feral_security_captain_psychic", 12, 8, 1, 1)
    :monster("mon_feral_security_psychic", 45, 5, 1, 1)
    :group("GROUP_FERAL_BIOKINETIC_VITAKINETIC", 20, 3, 1, 1)
    :group("GROUP_FERAL_PSYCHIC", 1, 8, 1, 1)
    :monster("mon_zombie_labsecurity", 400, 2, 1, 3)
    :monster("mon_zombie_scientist_phavian", 350, 1, 1, 1)
    :monster("mon_zombie_scientist_phavian", 175, 1, 1, 5)
    :monster("mon_zombie_medical", 150, 1, 1, 1)
    :monster("mon_zombie_medical", 50, 1, 1, 3)
    :monster("mon_zombie_technician", 75, 2, 1, 1)
    :monster("mon_zombie_hazmat", 25, 1, 1, 1)
    :monster("mon_zombie_necro", 5, 5, 1, 1)
    :monster("mon_zombie_electric", 20, 2, 1, 1)
    :monster("mon_zombie", 100, 1, 1, 3)
    :monster("mon_zombie_fat", 20, 1, 1, 3)
    :monster("mon_zombie_tough", 40, 2, 1, 3)
    :monster("mon_zombie_brute", 15, 5, 1, 1)
    :monster("mon_zombie_crawler", 50, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_CIVILIANS_PSYCHIC_FERAL", load_mode = "append" }
    :monster("mon_civilian_biokinetic", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_clairsentient", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_electrokinetic", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_photokinetic", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_pyrokinetic", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_telekinetic", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_telepath", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_teleporter", 1, 0, 1, 1, { ends = duration(12, "day") })
    :monster("mon_civilian_vitakinetic", 1, 0, 1, 1, { ends = duration(12, "day") }))

-- Weights slightly adjusted from base Nether group, additional things added
content.add(content.MonsterGroup { id = "GROUP_NETHER_BREACH", load_mode = "append" }
    :monster("mon_blank", 135, 0, 1, 1)
    :monster("mon_flying_polyp", 80, 0, 1, 1)
    :monster("mon_hunting_horror", 150, 0, 1, 1)
    :monster("mon_gracke", 150, 0, 1, 1)
    :monster("mon_unseen_hunter", 80, 0, 1, 1)
    :monster("mon_yugg", 50, 0, 1, 1)
    :monster("mon_gelatin", 120, 0, 1, 1)
    :monster("mon_breather_hub", 40, 0, 1, 1)
    :monster("mon_nether_leech", 80, 0, 1, 1)
    :monster("mon_flaming_eye", 120, 0, 1, 1)
    :monster("mon_kreck", 210, 0, 1, 1)
    :monster("mon_nether_eater", 120, 0, 1, 1)
    :monster("mon_hanging_roper", 60, 0, 1, 1)
    :monster("mon_star_vampire", 25, 0, 1, 1)
    :monster("mon_star_vampire_coiling", 25, 0, 1, 1)
    :monster("mon_gozu", 120, 0, 1, 1)
    :monster("mon_nether_silent_one_aggressive", 15, 0, 1, 1)
    :monster("mon_darkman", 15, 0, 1, 1)
    :monster("mon_shoggoth", 5, 0, 1, 1))

-- same as above except in the SCIENCE faction, which sadly requires new monsters
content.add(content.MonsterGroup { id = "GROUP_NETHER_LAB_DEVOURER_BREACH", load_mode = "append" }
    :monster("mon_blank_lab_devourer", 135, 0, 1, 1)
    :monster("mon_flying_polyp_lab_devourer", 80, 0, 1, 1)
    :monster("mon_hunting_horror_lab_devourer", 150, 0, 1, 1)
    :monster("mon_gracke_lab_devourer", 150, 0, 1, 1)
    :monster("mon_unseen_hunter_lab_devourer", 80, 0, 1, 1)
    :monster("mon_yugg_lab_devourer", 50, 0, 1, 1)
    :monster("mon_nether_leech_lab_devourer", 80, 0, 1, 1)
    :monster("mon_flaming_eye_lab_devourer", 120, 0, 1, 1)
    :monster("mon_kreck_lab_devourer", 210, 0, 1, 1)
    :monster("mon_nether_eater_lab_devourer", 120, 0, 1, 1)
    :monster("mon_hanging_roper_lab_devourer", 60, 0, 1, 1)
    :monster("mon_star_vampire_lab_devourer", 25, 0, 1, 1)
    :monster("mon_star_vampire_coiling_lab_devourer", 25, 0, 1, 1)
    :monster("mon_gozu_lab_devourer", 120, 0, 1, 1)
    :monster("mon_darkman_lab_devourer", 15, 0, 1, 1)
    :monster("mon_shoggoth_lab_devourer", 5, 0, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_SPAWN_PSI_RAPTOR", load_mode = "append" }
    :monster("mon_spawn_raptor_teke_push", 2, 1, 1, 1)
    :monster("mon_spawn_raptor_pyro_hot_air", 1, 1, 1, 1)
    :monster("mon_spawn_raptor_teleport_blink", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_REPRODUCTION_COW_MUTANT_BABIES", load_mode = "append" }
    :monster("mon_cow_calf", 95, 1, 1, 1)
    :monster("mon_hodag_calf", 95, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_REPRODUCTION_COW_PRE_HODAG_MUTANT_BABIES", load_mode = "append" }
    :monster("mon_cow_calf", 75, 1, 1, 1)
    :monster("mon_hodag_calf", 25, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_REPRODUCTION_DOG_HELLHOUND_BABIES", load_mode = "append" }
    :monster("mon_dog_pup", 80, 1, 1, 1)
    :monster("mon_hellhound_pup", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_REPRODUCTION_FEAR_DEER_BABIES", load_mode = "append" }
    :monster("mon_deer_fawn", 80, 1, 1, 1)
    :monster("mon_fear_deer_fawn", 20, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_REPRODUCTION_WILD_RABBIT_BLINKER_BABIES", load_mode = "append" }
    :monster("mon_wild_rabbit_baby", 65, 1, 1, 1)
    :monster("mon_wild_rabbit_blinker_baby", 35, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_COCKATRICE", load_mode = "append" }
    :monster("mon_cockatrice_chick", 100, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_CHICKEN", load_mode = "append" }
    :monster("mon_cockatrice_chick", 5, 1, 1, 1)
    :monster("mon_chicken_chick", 95, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_EGG_PIGEON", load_mode = "append" }
    :monster("mon_pigeon_passenger_chick", 5, 1, 1, 1)
    :monster("mon_pigeon_chick", 95, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_ZOMBIE_UPGRADE", load_mode = "append" }
    :monster("mon_zombie_blank", 30, 1, 1, 1))

content.add(content.MonsterGroup {
    id = "GROUP_ZOMBIE_BLANK_UPGRADE",
    load_mode = "append",
    default_monster = "mon_zombie_blank",
}
    :monster("mon_zombie_blank", 450, 1, 1, 1)
    :monster("mon_zombie_nullpsi", 225, 1, 1, 1)
    :monster("mon_zombie_pupating_psi", 150, 1, 1, 1)
    :monster("mon_zombie_concentration_ender", 200, 1, 1, 1)
    :monster("mon_zombie_psi_void", 100, 1, 1, 1)
    :monster("mon_zombie_master", 25, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE", load_mode = "append" }
    :group("GROUP_ZOMBIE_UPGRADE", 95, 1, 1, 1)
    :monster("mon_feral_human_bio", 1, 1, 1, 1)
    :monster("mon_feral_human_clair", 1, 1, 1, 1)
    :monster("mon_feral_human_electrokin", 1, 1, 1, 1)
    :monster("mon_feral_human_photokin", 1, 1, 1, 1)
    :monster("mon_feral_human_pyrokin", 1, 1, 1, 1)
    :monster("mon_feral_human_telekin", 1, 1, 1, 1)
    :monster("mon_feral_human_teep", 1, 1, 1, 1)
    :monster("mon_feral_human_porter", 1, 1, 1, 1)
    :monster("mon_feral_human_vita", 1, 1, 1, 1))

content.add(content.MonsterGroup { id = "GROUP_MOM_FERAL_ZOMBIE_UPGRADE_HIGHER_ODDS", load_mode = "append" }
    :group("GROUP_ZOMBIE_UPGRADE", 45, 1, 1, 1)
    :monster("mon_feral_human_bio", 1, 1, 1, 1)
    :monster("mon_feral_human_clair", 1, 1, 1, 1)
    :monster("mon_feral_human_electrokin", 1, 1, 1, 1)
    :monster("mon_feral_human_photokin", 1, 1, 1, 1)
    :monster("mon_feral_human_pyrokin", 1, 1, 1, 1)
    :monster("mon_feral_human_telekin", 1, 1, 1, 1)
    :monster("mon_feral_human_teep", 1, 1, 1, 1)
    :monster("mon_feral_human_porter", 1, 1, 1, 1)
    :monster("mon_feral_human_vita", 1, 1, 1, 1))
