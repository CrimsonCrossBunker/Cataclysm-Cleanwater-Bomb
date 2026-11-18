local content = require("ccb").content

do
    -- Drugs not contained within any other category
    local group = content.ItemGroup { id = "drugs_misc", kind = "distribution" }
    group:group("bfipowder_bottle_plastic_5_60")
    group:group("any_cough_syrup_in_bottle")
    group:entry { item = "flu_shot", count = { 1, 10 }, container = "null", probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "harddrugs", kind = "distribution" }
    group:group("harddrugs_residential", 133)
    group:item("flu_shot", 5)
    content.add(group)
end

do
    -- Rare and/or valuable drugs excluding painkillers
    local group = content.ItemGroup { id = "drugs_rare", kind = "distribution" }
    group:group("adderall_dr_group", 10)
    group:group("antibiotics_dr_group", 10)
    group:group("strong_antibiotics_dr_group", 10)
    group:group("antifungal_dr_group", 10)
    group:group("antiparasitic_dr_group", 10)
    group:group("diazepam_dr_group", 10)
    group:group("iron_dr_group", 10)
    group:group("prozac_dr_group", 10)
    group:group("thorazine_dr_group", 10)
    group:group("xanax_dr_group", 10)
    content.add(group)
end

do
    local group = content.ItemGroup {
        id = "birth_control",
        kind = "distribution",
        container = "blister_pack_small",
        container_variant = "blister_pack_bc",
    }
    group:entry {
        collection = {
            { item = "birth_control", count = { 0, 21 } },
            { item = "homeopathic_pills", count = { 7, 7 }, variant = "sugar_pill" },
        },
        probability = 40,
    }
    group:entry { item = "homeopathic_pills", count = { 0, 6 }, variant = "sugar_pill", probability = 5 }
    group:entry { item = "birth_control", count = { 0, 28 }, probability = 40 }
    content.add(group)
end
