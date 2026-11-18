local content = require("ccb").content

do
    local group = content.ItemGroup { id = "structural_spur_drops", kind = "collection" }
    group:entry { item = "rock", count = { 10, 22 } }
    group:entry { item = "scrap", count = { 10, 12 } }
    group:entry { item = "rebar", count = { 3, 8 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "shrapnel_swarm_drops", kind = "collection" }
    group:entry { item = "shrapnel", count = { 3, 7 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "nether_huntsman_drops", kind = "collection" }
    group:entry { item = "nether_huntsman_javelin", count = { 3, 7 } }
    group:entry { item = "nether_huntsman_statuette", count = { 0, 1 }, probability = 15 }
    group:entry { item = "nether_grub", count = { 0, 3 }, probability = 30 }
    group:entry { item = "yrax_trinket", count = { 0, 1 }, probability = 1 }
    group:entry { item = "ephemeral_gem", count = { 0, 1 }, probability = 2 }
    group:entry { item = "necklace_teeth", count = { 0, 1 }, probability = 10 }
    group:entry { item = "sinew", count = { 0, 10 }, charges = { 1, 20 }, probability = 20 }
    group:entry { item = "leech_flower", count = { 0, 3 }, probability = 5 }
    group:entry { item = "meat_bark", count = { 0, 3 }, probability = 5 }
    group:entry { item = "ruined_chunks", count = { 0, 2 }, probability = 30 }
    group:entry { item = "mutant_bug_organs", count = { 0, 2 }, probability = 30 }
    group:entry { item = "copper", count = { 0, 4 }, probability = 20 }
    group:entry { item = "gold_small", count = { 0, 20 }, probability = 25 }
    group:entry { item = "bismuth", count = { 0, 60 }, probability = 40 }
    group:entry { item = "scrap", count = { 0, 2 }, probability = 35 }
    group:entry { item = "marble", count = { 0, 1 }, charges = { 0, 5 }, probability = 25 }
    group:entry { item = "glass_shard", count = { 0, 3 }, probability = 30 }
    group:entry { item = "chunk_sulfur", count = { 0, 2 }, probability = 10 }
    group:entry { item = "material_zincite", count = { 0, 2 }, probability = 10 }
    group:entry { item = "copper_rod", count = { 0, 1 }, probability = 10 }
    group:entry { item = "mc_wire", count = { 0, 1 }, probability = 8 }
    group:entry { item = "pearl", count = { 0, 1 }, probability = 8 }
    group:entry { item = "stick_fiber", count = { 0, 1 }, probability = 30 }
    group:entry { item = "etched_skull", count = { 0, 1 }, probability = 4 }
    group:entry { item = "skewer_bone", count = { 0, 5 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "interstice_mutant_zombie_death_drops", kind = "collection" }
    group:entry { item = "footrags", damage = { 0, 4 }, probability = 70 }
    group:entry { item = "tunic_rag", damage = { 0, 4 }, probability = 70 }
    group:group("default_zombie_items_pockets", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "inner_cabins_grue_drops", kind = "collection" }
    group:group("SUS_book_nonf_soft_occult", 20)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mon_fleshborg_2_3_string_dimension_drops", kind = "collection" }
    group:item("ls_sd_passcode")
    content.add(group)
end
