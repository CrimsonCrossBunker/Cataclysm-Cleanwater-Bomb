local content = require("ccb").content

do
    local group = content.ItemGroup { id = "dist_matrix_crystal_artifacts", kind = "distribution" }
    group:group("biokinetic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_meditation_books_begin", kind = "distribution" }
    group:item("manual_meditation", 3, "manual_meditation_1")
    group:item("manual_meditation", 3, "manual_meditation_2")
    group:item("manual_meditation", 3, "manual_meditation_3")
    group:item("manual_meditation", 3, "manual_meditation_4")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_meditation_books_int", kind = "distribution" }
    group:item("manual_meditation_int", 1, "manual_meditation_int_1")
    group:item("manual_meditation_int", 1, "manual_meditation_int_2")
    group:item("manual_meditation_int", 1, "manual_meditation_int_3")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_maps", kind = "distribution" }
    group:item("satellitemap", 3)
    group:item("roadmap", 2)
    group:item("subwaystationmap", 1)
    group:item("militarymap", 2)
    group:item("sewermap", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_mathematician_alpha_five_seven_death_drops", kind = "collection" }
    group:entry { item = "pipe", damage = { 0, 2 } }
    group:group("default_zombie_clothes")
    group:entry { group = "wallets_phavian", damage = { 1, 4 } }
    group:group("clothing_watch", 5)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:entry {
        distribution = {
            { group = "biokinetic_crystal_awakening_artifact_procgen", probability = 2 },
            { group = "biokinetic_crystal_artifact_procgen", probability = 1 },
        },
        probability = 60,
    }
    group:group("psi_lab", 80)
    group:item("matrix_crystal_telekinesis", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "wallets_phavian", kind = "distribution" }
    group:group("wallet_phavian_leather_full", 50)
    group:group("wallet_phavian_full", 25)
    group:group("wallet_phavian_stylish_full", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dining_hall_utensils", kind = "collection" }
    group:item("spoon")
    group:item("spoon")
    group:item("knife_butter")
    group:item("glass")
    group:item("mess_tray")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_bio", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_bio", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_clair", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_clair", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_electro", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_electro", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_photo", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:entry { item = "heavy_flashlight", charges = { 12, 74 }, probability = 80 }
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_photo", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_pyro", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:entry { item = "lighter", count = { 1, 3 }, charges = { 12, 74 }, probability = 80 }
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_pyro", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_telekin", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:entry { item = "rock", count = { 1, 3 }, probability = 80 }
    group:group("homebooks", 5)
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_telekin", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_teep", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "tools_common_small", count = { 1, 2 }, probability = 10 }
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_teep", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_porter", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "tools_common_small", count = { 1, 2 }, probability = 10 }
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_porter", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_death_drops_vita", kind = "collection" }
    group:group("default_zombie_clothes")
    group:group("wallets", 80)
    group:group("homebooks", 5)
    group:group("default_zombie_items_bags_small", 50)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:group("feral_humans_crystal_drops_vita", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_bio", kind = "distribution" }
    group:item("matrix_crystal_drained", 85)
    group:group("biokinetic_crystal_awakening_artifact_procgen", 30)
    group:group("biokinetic_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_clair", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:group("clairsentient_crystal_awakening_artifact_procgen", 30)
    group:group("clairsentient_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_electro", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:group("electrokinetic_crystal_awakening_artifact_procgen", 30)
    group:group("electrokinetic_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_photo", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:group("photokinetic_crystal_awakening_artifact_procgen", 30)
    group:group("photokinetic_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_pyro", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:group("pyrokinetic_crystal_awakening_artifact_procgen", 30)
    group:group("pyrokinetic_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_telekin", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:group("telekinetic_crystal_awakening_artifact_procgen", 30)
    group:group("telekinetic_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_teep", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:group("telepathic_crystal_awakening_artifact_procgen", 30)
    group:group("telepathic_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_porter", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:group("teleportation_crystal_awakening_artifact_procgen", 30)
    group:group("teleportation_crystal_artifact_procgen", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_humans_crystal_drops_vita", kind = "distribution" }
    group:item("matrix_crystal_drained", 70)
    group:item("matrix_crystal_vitakinesis", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_scientists_death_drops_psychic", kind = "collection" }
    group:entry { item = "scalpel", damage = { 1, 3 } }
    group:entry { item = "psionic_serum_base", container = "flask_glass", probability = 40 }
    group:entry { group = "lab_shoes", damage = { 1, 4 } }
    group:entry { group = "lab_torso", damage = { 1, 4 } }
    group:entry { group = "lab_pants", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry { group = "wallets", damage = { 1, 4 } }
    group:entry {
        collection = {
            { group = "harddrugs", probability = 25 },
            { group = "psi_lab", probability = 65 },
            { item = "lab_postit_psi", probability = 15 },
            { item = "phavian_psionic_telepathic_mental_engineering_book", probability = 8 },
            { group = "electronics", probability = 40 },
            { item = "radio", probability = 15 },
            { group = "textbooks", probability = 25 },
            { group = "feral_humans_crystal_drops_telekin", probability = 50 },
            { group = "feral_humans_crystal_drops_teep", probability = 50 },
            { group = "collection_force_field_and_note", probability = 2 },
            { group = "everyday_gear_lab", probability = 50 },
        },
    }
    group:entry { group = "wallets_phavian", damage = { 1, 4 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "feral_security_death_drops_psychic",
        kind = "collection",
        with_ammo = 20,
        with_magazine = 100,
    }
    group:entry { item = "heavy_flashlight", damage = { 2, 4 }, probability = 75 }
    group:entry { item = "tazer", damage = { 2, 4 }, probability = 50 }
    group:item("grenade_inferno", 2)
    group:entry { group = "cop_gloves", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "security_pants", damage = { 1, 4 } }
    group:entry { group = "security_shoes", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "security_torso", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "wallets_phavian", damage = { 1, 4 } }
    group:group("feral_humans_crystal_drops_bio", 25)
    group:group("feral_humans_crystal_drops_clair", 25)
    group:group("feral_humans_crystal_drops_vita", 25)
    group:entry {
        distribution = {
            { item = "grenade_anti_psi", probability = 50 },
            { item = "grenade_anti_psi_expended", probability = 50 },
        },
        probability = 25,
    }
    group:entry {
        distribution = {
            { group = "dist_shield_belts", damage = { 1, 5 }, probability = 50 },
            { group = "dist_shield_belts", damage = { 3, 5 }, probability = 50 },
        },
        probability = 25,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "feral_security_captain_death_drops_psychic", kind = "collection" }
    group:item("grenade_inferno", 2)
    group:entry { group = "cop_gloves", damage = { 1, 4 }, probability = 30 }
    group:entry { group = "security_pants", damage = { 1, 4 } }
    group:entry { group = "security_shoes", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "security_torso", damage = { 1, 4 }, probability = 70 }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:group("clothing_glasses", 5)
    group:group("clothing_watch", 5)
    group:entry { group = "wallets_phavian", damage = { 1, 4 } }
    group:group("feral_humans_crystal_drops_bio", 40)
    group:group("feral_humans_crystal_drops_clair", 40)
    group:group("feral_humans_crystal_drops_vita", 25)
    group:item("phavian_psionic_martial_power_book", 8)
    group:entry {
        distribution = {
            { group = "dist_psionic_shield_belts", damage = { 1, 5 }, probability = 50 },
            { group = "dist_psionic_shield_belts", damage = { 3, 5 }, probability = 50 },
        },
        probability = 50,
    }
    group:entry {
        distribution = {
            { item = "grenade_anti_psi", probability = 50 },
            { item = "grenade_anti_psi_expended", probability = 50 },
        },
        probability = 25,
    }
    group:entry { item = "psionic_mindsight_glasses", damage = { 1, 4 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_mutant_biokinetic_alpha_death_drops", kind = "collection" }
    group:entry { item = "pipe", damage = { 0, 2 } }
    group:group("default_zombie_clothes")
    group:entry { group = "wallets_phavian", damage = { 1, 4 } }
    group:group("clothing_watch", 5)
    group:entry { group = "default_zombie_items_pockets", count = { 1, 2 }, probability = 50 }
    group:item("matrix_crystal_biokinesis", 45)
    group:group("psi_lab", 80)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lab_files_psi", kind = "distribution" }
    group:item("lab_postit_portal", 3)
    group:item("lab_postit_psi", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_lab_file_phavian_memo", kind = "distribution" }
    group:item("lab_file_phavian_memo_item", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_lab_file_matrix_research", kind = "distribution" }
    group:item("lab_file_matrix_research_item", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_lab_file_phavian_skyscraper_lab", kind = "distribution" }
    group:item("lab_file_clairsentience_item", 1)
    group:item("lab_file_telepathy_item", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_lab_file_phavian_internal", kind = "distribution" }
    group:item("lab_file_phavian_memo_item", 4)
    group:item("lab_file_private_correspondence", 1)
    group:item("lab_file_matrix_research_item", 6)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_lab_file_phavian_psi_research_any", kind = "distribution" }
    group:item("lab_file_biokinesis_item", 1)
    group:item("lab_file_clairsentience_item", 1)
    group:item("lab_file_electrokinesis_item", 1)
    group:item("lab_file_photokinesis_item", 1)
    group:item("lab_file_pyrokinesis_item", 1)
    group:item("lab_file_telekinesis_item", 1)
    group:item("lab_file_telepathy_item", 1)
    group:item("lab_file_teleportation_item", 1)
    group:item("lab_file_vitakinesis_item", 1)
    group:item("lab_file_matrix_research_item", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_matrix_crystals", kind = "distribution" }
    group:group("biokinetic_matrix_crystals_group", 10)
    group:group("clairsentient_matrix_crystals_group", 10)
    group:group("electrokinetic_matrix_crystals_group", 10)
    group:group("photokinetic_matrix_crystals_group", 10)
    group:group("pyrokinetic_matrix_crystals_group", 10)
    group:group("telekinetic_matrix_crystals_group", 10)
    group:group("telepathic_matrix_crystals_group", 10)
    group:group("teleportation_matrix_crystals_group", 10)
    group:group("vitakinetic_matrix_crystals_group", 10)
    group:item("matrix_crystal_coruscating", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_matrix_crystals_rare", kind = "distribution" }
    group:item("null")
    group:group("biokinetic_matrix_crystals_group", 10)
    group:group("clairsentient_matrix_crystals_group", 10)
    group:group("electrokinetic_matrix_crystals_group", 10)
    group:group("photokinetic_matrix_crystals_group", 10)
    group:group("pyrokinetic_matrix_crystals_group", 10)
    group:group("telekinetic_matrix_crystals_group", 10)
    group:group("telepathic_matrix_crystals_group", 10)
    group:group("teleportation_matrix_crystals_group", 10)
    group:group("vitakinetic_matrix_crystals_group", 10)
    group:item("matrix_crystal_coruscating", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_matrix_crystals_50_50", kind = "distribution" }
    group:item("matrix_crystal_drained", 9)
    group:group("biokinetic_matrix_crystals_group", 1)
    group:group("clairsentient_matrix_crystals_group", 1)
    group:group("electrokinetic_matrix_crystals_group", 1)
    group:group("photokinetic_matrix_crystals_group", 1)
    group:group("pyrokinetic_matrix_crystals_group", 1)
    group:group("telekinetic_matrix_crystals_group", 1)
    group:group("telepathic_matrix_crystals_group", 1)
    group:group("teleportation_matrix_crystals_group", 1)
    group:group("vitakinetic_matrix_crystals_group", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "collection_matrix_dust", kind = "collection" }
    group:entry { item = "matrix_crystal_biokin_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_clair_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_electrokin_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_photokin_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_pyrokin_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_telekin_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_telepath_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_teleport_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_vitakin_dust", container = "test_tube", probability = 30 }
    group:entry { item = "matrix_crystal_drained_dust", container = "test_tube", probability = 80 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "distribution_matrix_dust", kind = "distribution" }
    group:entry { item = "matrix_crystal_biokin_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_clair_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_electrokin_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_photokin_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_pyrokin_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_telekin_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_telepath_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_teleport_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_vitakin_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_drained_dust", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "distribution_matrix_dust_survivor",
        kind = "distribution",
        container = "bottle_glass",
    }
    group:entry { item = "matrix_crystal_biokin_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_clair_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_electrokin_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_photokin_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_pyrokin_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_telekin_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_telepath_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_teleport_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_vitakin_dust", count = { 4, 12 }, probability = 1 }
    group:entry { item = "matrix_crystal_drained_dust", count = { 4, 12 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_biokin_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_biokin_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_biokin_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biokinetic_matrix_crystals_group", kind = "distribution" }
    group:group("biokinetic_crystal_awakening_artifact_procgen", 1)
    group:group("biokinetic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clairsentient_matrix_crystals_group", kind = "distribution" }
    group:group("clairsentient_crystal_awakening_artifact_procgen", 1)
    group:group("clairsentient_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "electrokinetic_matrix_crystals_group", kind = "distribution" }
    group:group("electrokinetic_crystal_awakening_artifact_procgen", 1)
    group:group("electrokinetic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "photokinetic_matrix_crystals_group", kind = "distribution" }
    group:group("photokinetic_crystal_awakening_artifact_procgen", 1)
    group:group("photokinetic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pyrokinetic_matrix_crystals_group", kind = "distribution" }
    group:group("pyrokinetic_crystal_awakening_artifact_procgen", 1)
    group:group("pyrokinetic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "telekinetic_matrix_crystals_group", kind = "distribution" }
    group:group("telekinetic_crystal_awakening_artifact_procgen", 1)
    group:group("telekinetic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "telepathic_matrix_crystals_group", kind = "distribution" }
    group:group("telepathic_crystal_awakening_artifact_procgen", 1)
    group:group("telepathic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teleportation_matrix_crystals_group", kind = "distribution" }
    group:group("teleportation_crystal_awakening_artifact_procgen", 1)
    group:group("teleportation_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vitakinetic_matrix_crystals_group", kind = "distribution" }
    group:group("vitakinetic_crystal_awakening_artifact_procgen", 1)
    group:group("vitakinetic_crystal_artifact_procgen", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_clair_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_clair_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_clair_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_electrokin_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_electrokin_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_electrokin_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_photokin_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_photokin_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_photokin_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_pyrokin_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_pyrokin_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_pyrokin_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_telekin_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_telekin_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_telekin_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_telepath_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_telepath_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_telepath_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_teleport_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_teleport_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_teleport_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_vitakin_dust_group", kind = "distribution" }
    group:entry { item = "matrix_crystal_vitakin_dust", container = "test_tube", probability = 3 }
    group:entry { item = "matrix_crystal_vitakin_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_drained_dust", kind = "distribution" }
    group:entry { item = "matrix_crystal_drained_dust", container = "test_tube", probability = 1 }
    group:entry { item = "matrix_crystal_drained_dust_refined", container = "test_tube", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_crystal_drained_group", kind = "distribution" }
    group:item("matrix_crystal_drained", 50)
    group:item("null", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_matrix_crystal_skyscraper_lab_group", kind = "distribution" }
    group:group("clairsentient_matrix_crystals_group", 1)
    group:item("matrix_crystal_drained", 4)
    group:item("matrix_crystal_telepathy", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_matrix_crystal_hospital_lab_group", kind = "distribution" }
    group:group("biokinetic_matrix_crystals_group", 1)
    group:item("matrix_crystal_drained", 4)
    group:group("vitakinetic_matrix_crystals_group", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "matrix_shard_group", kind = "distribution" }
    group:item("matrix_shard", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "concentrated_matrix_elixirs", kind = "distribution" }
    group:item("recipe_survivor_matrix_crystal_ground", 1)
    group:entry { item = "matrix_crystal_biokin_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_clair_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_electrokin_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_photokin_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_pyrokin_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_telekin_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_telepath_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_teleport_dust_potion", container = "bottle_plastic", probability = 2 }
    group:entry { item = "matrix_crystal_vitakin_dust_potion", container = "bottle_plastic", probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_matrix_tools", kind = "distribution" }
    group:item("matrix_channeling_tool", 25)
    group:item("matrix_aligning_tool", 10)
    group:item("telepathic_focusing_tool", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_pulse_rifles_heavy_prototype", kind = "distribution" }
    group:item("mom_pulse_rifle", 1)
    group:item("mom_pulse_rifle_prototype", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_psionic_shield_belts", kind = "distribution" }
    group:group("dist_fire_shield_belts", 1)
    group:group("dist_shield_belts", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "collection_force_field_and_note", kind = "collection" }
    group:item("force_field_generator")
    group:item("lab_file_OS647_P_item")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_matrix_translocation_items", kind = "distribution" }
    group:item("psionic_transporter_remote", 5)
    group:item("psionic_transporter_beacon", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_electronoetic_batteries", kind = "distribution" }
    group:entry { item = "light_battery_electronoetic", count = { 1, 4 }, charges = { 48, 48 }, probability = 160 }
    group:entry { item = "light_battery_electronoetic_refined", count = { 1, 2 }, charges = { 128, 128 }, probability = 16 }
    group:entry { item = "medium_battery_electronoetic", count = { 1, 4 }, charges = { 168, 168 }, probability = 80 }
    group:entry { item = "medium_battery_electronoetic_refined", count = { 1, 2 }, charges = { 448, 448 }, probability = 8 }
    group:entry { item = "heavy_battery_electronoetic", count = { 1, 2 }, charges = { 777, 777 }, probability = 20 }
    group:entry { item = "heavy_battery_electronoetic_refined", charges = { 2072, 2072 }, probability = 2 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psi_testing_materials", kind = "distribution" }
    group:item("cards_zener", 30)
    group:item("phavian_noetic_resonance_detector_instructions", 8)
    group:item("file", 50)
    group:item("deck_of_cards", 30)
    group:item("pen", 30)
    group:item("blue_pen", 20)
    group:item("green_pen", 20)
    group:item("red_pen", 30)
    group:item("envelope", 30)
    group:item("paper", 40)
    group:item("blindfold", 20)
    group:item("coin_quarter", 5)
    group:item("coin_dime", 2)
    group:item("coin_penny", 3)
    group:entry { item = "camera", charges = { 0, 150 }, probability = 2 }
    group:entry { item = "camera", charges = { 0, 150 }, container = "camera_bag", probability = 1 }
    group:entry { item = "camera_pro", charges = { 0, 150 }, probability = 1 }
    group:entry { item = "camera_pro", charges = { 0, 150 }, container = "camera_bag", probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psi_lab_recipes_rare", kind = "distribution" }
    group:group("psi_lab", 1)
    group:group("psi_lab_no_recipes", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clairsentience_telepathy_matrix_technology", kind = "distribution" }
    group:group("collection_mindsight_and_note", 4)
    group:item("psionic_telepathic_dampener", 4)
    group:item("schematics_telepathic_focusing_tool", 4)
    group:item("telepathic_focusing_tool", 4)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mutagenic_alpha_kit", kind = "collection", container = "box_small_plastic" }
    group:entry { item = "iv_mutagen_alpha", count = { 2, 2 } }
    group:entry { item = "iv_mutagen", count = { 1, 1 } }
    group:entry { item = "syringe", count = { 3, 3 } }
    group:entry { item = "bubblewrap", count = { 2, 5 } }
    group:item("lab_file_mutagen_guide")
    group:item("lab_file_mutation_testing")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "phavian_lab_security", kind = "distribution" }
    group:item("grenade_anti_psi", 50)
    group:entry { item = "grenade_anti_psi", count = { 2, 3 }, probability = 5 }
    group:group("dist_shield_belts", 10)
    group:entry { item = "tazer", charges = { 0, 500 }, probability = 25 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psionic_recipes_beginner", kind = "distribution" }
    group:item("schematics_matrix_crystal_ground", 3)
    group:item("manual_psionic_ritual", 2)
    group:item("schematics_reactant_liquid_base", 3)
    group:item("schematics_matrix_channeling", 2)
    group:item("schematics_matrix_aligning", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psionic_recipes_advanced", kind = "distribution" }
    group:item("phavian_report_psionic_drain", 15)
    group:item("schematics_noetic_resilience", 8)
    group:item("schematics_instability_remover", 5)
    group:item("schematics_transporters", 3)
    group:item("schematics_psionic_purifier", 1)
    group:item("schematics_panaceus", 1)
    group:item("schematics_telepathic_focusing_tool", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psionic_recipes_powers", kind = "distribution" }
    group:item("phavian_psionic_martial_power_book", 1)
    group:item("phavian_psionic_telepathic_mental_engineering_book", 1)
    group:item("phavian_psionic_teleportation_combat_book", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psionic_recipes_weapons", kind = "distribution" }
    group:item("schematics_grenade_inferno", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psionic_recipes_armor", kind = "distribution" }
    group:item("schematics_anchoring_crown", 1)
    group:item("schematics_telepathic_dampener", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psionic_recipes_tools", kind = "distribution" }
    group:item("schematics_everglow_lamp", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "psionic_recipes_medicine", kind = "distribution" }
    group:item("schematics_instability_remover", 5)
    group:item("schematics_noetic_resilience", 3)
    group:item("schematics_psionic_purifier", 1)
    group:item("schematics_panaceus", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "survivor_matrix_crystal_recipes", kind = "distribution" }
    group:item("recipe_survivor_matrix_crystal_ground", 1)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_zombie_scientist_phavian_death_drops", kind = "collection" }
    group:entry { group = "lab_shoes", damage = { 1, 4 } }
    group:entry { group = "lab_torso", damage = { 1, 4 } }
    group:entry { group = "lab_pants", damage = { 1, 4 } }
    group:entry { group = "underwear", damage = { 1, 4 } }
    group:entry {
        collection = {
            { group = "dissection", probability = 25 },
            { group = "electronics", probability = 40 },
            { item = "radio", probability = 15 },
            { group = "psi_lab", probability = 60 },
            { group = "textbooks", probability = 25 },
            { item = "lab_postit_psi", probability = 15 },
            { group = "everyday_gear_lab", probability = 50 },
        },
    }
    group:entry { group = "wallets_phavian", damage = { 1, 4 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biokinetic_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "biokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "biokinetic_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "biokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "biokinetic_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "biokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "biokinetic_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "biokinetic_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "biokinetic_crystal_artifact_item",
        artifact = {
            preset = "biokinetic_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "biokinetic_crystal_artifact_item",
        artifact = {
            preset = "biokinetic_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "biokinetic_crystal_artifact_item",
        artifact = {
            preset = "biokinetic_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clairsentient_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "clairsentient_crystal_awakening_artifact_item",
        artifact = {
            preset = "clairsentient_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "clairsentient_crystal_awakening_artifact_item",
        artifact = {
            preset = "clairsentient_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "clairsentient_crystal_awakening_artifact_item",
        artifact = {
            preset = "clairsentient_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "clairsentient_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "clairsentient_crystal_artifact_item",
        artifact = {
            preset = "clairsentient_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "clairsentient_crystal_artifact_item",
        artifact = {
            preset = "clairsentient_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "clairsentient_crystal_artifact_item",
        artifact = {
            preset = "clairsentient_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "electrokinetic_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "electrokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "electrokinetic_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "electrokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "electrokinetic_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "electrokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "electrokinetic_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "electrokinetic_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "electrokinetic_crystal_artifact_item",
        artifact = {
            preset = "electrokinetic_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "electrokinetic_crystal_artifact_item",
        artifact = {
            preset = "electrokinetic_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "electrokinetic_crystal_artifact_item",
        artifact = {
            preset = "electrokinetic_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "photokinetic_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "photokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "photokinetic_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "photokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "photokinetic_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "photokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "photokinetic_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "photokinetic_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "photokinetic_crystal_artifact_item",
        artifact = {
            preset = "photokinetic_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "photokinetic_crystal_artifact_item",
        artifact = {
            preset = "photokinetic_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "photokinetic_crystal_artifact_item",
        artifact = {
            preset = "photokinetic_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pyrokinetic_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "pyrokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "pyrokinetic_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "pyrokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "pyrokinetic_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "pyrokinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "pyrokinetic_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "pyrokinetic_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "pyrokinetic_crystal_artifact_item",
        artifact = {
            preset = "pyrokinetic_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "pyrokinetic_crystal_artifact_item",
        artifact = {
            preset = "pyrokinetic_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "pyrokinetic_crystal_artifact_item",
        artifact = {
            preset = "pyrokinetic_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "telekinetic_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "telekinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "telekinetic_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "telekinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "telekinetic_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "telekinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "telekinetic_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "telekinetic_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "telekinetic_crystal_artifact_item",
        artifact = {
            preset = "telekinetic_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "telekinetic_crystal_artifact_item",
        artifact = {
            preset = "telekinetic_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "telekinetic_crystal_artifact_item",
        artifact = {
            preset = "telekinetic_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "telepathic_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "telepathic_crystal_awakening_artifact_item",
        artifact = {
            preset = "telepathic_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "telepathic_crystal_awakening_artifact_item",
        artifact = {
            preset = "telepathic_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "telepathic_crystal_awakening_artifact_item",
        artifact = {
            preset = "telepathic_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "telepathic_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "telepathic_crystal_artifact_item",
        artifact = {
            preset = "telepathic_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "telepathic_crystal_artifact_item",
        artifact = {
            preset = "telepathic_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "telepathic_crystal_artifact_item",
        artifact = {
            preset = "telepathic_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teleportation_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "teleportation_crystal_awakening_artifact_item",
        artifact = {
            preset = "teleportation_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "teleportation_crystal_awakening_artifact_item",
        artifact = {
            preset = "teleportation_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "teleportation_crystal_awakening_artifact_item",
        artifact = {
            preset = "teleportation_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "teleportation_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "teleportation_crystal_artifact_item",
        artifact = {
            preset = "teleportation_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "teleportation_crystal_artifact_item",
        artifact = {
            preset = "teleportation_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "teleportation_crystal_artifact_item",
        artifact = {
            preset = "teleportation_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vitakinetic_crystal_awakening_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "vitakinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "vitakinetic_matrix_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "vitakinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "vitakinetic_matrix_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "vitakinetic_crystal_awakening_artifact_item",
        artifact = {
            preset = "vitakinetic_matrix_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vitakinetic_crystal_artifact_procgen", kind = "distribution" }
    group:entry {
        group = "vitakinetic_crystal_artifact_item",
        artifact = {
            preset = "vitakinetic_crystal_procgen",
            power_level = 1250,
            max_attributes = 4,
            max_negative_power = -1000,
            resonant = true,
        },
    }
    group:entry {
        group = "vitakinetic_crystal_artifact_item",
        artifact = {
            preset = "vitakinetic_crystal_procgen",
            power_level = 2500,
            max_attributes = 6,
            max_negative_power = -1500,
            resonant = true,
        },
        probability = 10,
    }
    group:entry {
        group = "vitakinetic_crystal_artifact_item",
        artifact = {
            preset = "vitakinetic_crystal_procgen",
            power_level = 5000,
            max_attributes = 8,
            max_negative_power = -2500,
            resonant = true,
        },
        probability = 1,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mom_texopapalotl_crew_shed_weapon", kind = "collection" }
    group:entry {
        item = "mom_lightning_rifle",
        charges = { 85, 120 },
        damage = { 0, 2 },
        variant = "mom_lightning_rifle_non_fifth_sun",
        ammo = { item = "mom_lightning_rifle_ammo" },
        probability = 70,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mom_texopapalotl_crew_shed_gear", kind = "collection" }
    group:entry {
        item = "itzcuauhtli_wrist_computer",
        charges = { 6500, 8500 },
        damage = { 0, 2 },
        variant = "itzcuauhtli_wrist_computer_non_fifth_sun",
    }
    group:entry {
        item = "itzcuauhtli_tunic_jaguar",
        damage = { 1, 3 },
        variant = "itzcuauhtli_tunic_jaguar_non_fifth_sun",
        probability = 90,
    }
    group:entry {
        item = "itzcuauhtli_pants",
        damage = { 1, 3 },
        variant = "itzcuauhtli_pants_non_fifth_sun",
        probability = 90,
    }
    group:entry {
        item = "bio_dangersight_eyes_non_fifth_sun",
        damage = { 1, 3 },
        flags = {
            "NO_STERILE",
            "NO_PACKED",
            "FILTHY",
        },
        probability = 70,
    }
    group:entry {
        item = "mom_fifth_sun_standard_body_armor_non_fifth_sun",
        charges = { 350, 650 },
        damage = { 1, 3 },
        probability = 70,
    }
    group:entry { item = "itzcuauhtli_boots", damage = { 0, 2 }, variant = "itzcuauhtli_boots_standard_non_fifth_sun" }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_shield_belts", kind = "distribution" }
    group:entry {
        item = "medium_battery_electronoetic_refined",
        charges = { 100, 448 },
        container = "psionic_shield_belt",
        ammo = { item = "battery" },
        probability = 1,
    }
    group:entry {
        item = "medium_battery_electronoetic",
        charges = { 20, 168 },
        container = "psionic_shield_belt",
        ammo = { item = "battery" },
        probability = 4,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "dist_fire_shield_belts", kind = "distribution" }
    group:entry {
        item = "medium_battery_electronoetic_refined",
        charges = { 100, 448 },
        container = "psionic_fire_shield_belt",
        ammo = { item = "battery" },
        probability = 1,
    }
    group:entry {
        item = "medium_battery_electronoetic",
        charges = { 20, 168 },
        container = "psionic_fire_shield_belt",
        ammo = { item = "battery" },
        probability = 4,
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "collection_mindsight_and_note", kind = "collection" }
    group:entry {
        distribution = {
            {
                item = "light_battery_electronoetic",
                charges = { 20, 48 },
                container = "psionic_mindsight_glasses",
                ammo = { item = "battery" },
                probability = 80,
            },
            {
                item = "light_battery_electronoetic_refined",
                charges = { 60, 128 },
                container = "psionic_mindsight_glasses",
                ammo = { item = "battery" },
                probability = 20,
            },
        },
    }
    group:item("lab_file_QD944_P_item")
    content.add(group)
end
