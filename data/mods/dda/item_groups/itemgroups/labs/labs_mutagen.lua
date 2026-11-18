local content = require("ccb").content

do
    -- common mutation recipe books.
    local group = content.ItemGroup { id = "common_mutation_books", kind = "distribution" }
    group:item("recipe_maiar", 50)
    group:item("recipe_creepy", 30)
    group:item("recipe_animal", 200)
    group:item("recipe_labchem")
    content.add(group)
end

do
    -- rare mutation recipe books.
    local group = content.ItemGroup { id = "rare_mutation_books", kind = "distribution" }
    group:item("recipe_labchem")
    group:item("recipe_medicalmut", 50)
    group:item("recipe_alpha", 50)
    group:item("recipe_elfa", 25)
    group:item("recipe_chimera", 200)
    group:item("recipe_raptor", 200)
    content.add(group)
end

do
    -- Tools for mutation recipes.
    local group = content.ItemGroup { id = "tools_mutation", kind = "distribution" }
    group:item("hotplate", 200)
    group:item("esbit_stove", 50)
    group:item("chemistry_set", 300)
    group:item("still_lab")
    group:item("microcentrifuge")
    group:item("rotovap")
    group:item("funnel_separation", 200)
    group:item("analytical_set_basic", 200)
    content.add(group)
end

do
    -- Lower security tier badges for mutagen lab.
    local group = content.ItemGroup { id = "low_level_badges_mutagen", kind = "distribution" }
    group:item("id_science_visitor_1", 200)
    group:item("id_science_maintenance_green", 150)
    group:item("id_science_transport_1", 200)
    group:item("id_science_security_yellow", 25)
    group:item("id_science_medical_red", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "lanyard_YS_badge", kind = "collection", container = "lanyard" }
    group:item("id_science_security_yellow")
    content.add(group)
end

do
    -- 撤销 PR #86581 — 恢复僵尸尸体的实用性
    local group = content.ItemGroup { id = "lab_mutagen_ingredients", kind = "collection" }
    group:entry { group = "bleach_jug_part", charges = { 1, -1 }, probability = 40 }
    group:entry { item = "ammonia_liquid", charges = { 6, -1 }, container = "pressure_tank", probability = 40 }
    group:entry {
        distribution = {
            { item = "honey_glassed", count = { 1, -1 }, probability = 20 },
            { item = "honey_bottled", charges = { 1, -1 }, probability = 80 },
        },
        probability = 30,
    }
    group:entry { item = "can_clams", count = { 1, 3 }, probability = 30 }
    group:group("lye_powder_bottle_part", 30)
    group:item("honeycomb", 30)
    group:group("iodine_bottle_plastic_pill_supplement_10", 30)
    group:item("disinfectant", 30)
    group:group("protein_powder_bottle_plastic_small_9", 30)
    group:item("bee_sting", 20)
    group:item("slime_scrap", 20)
    group:item("datura_seed", 20)
    group:item("chitin_piece", 20)
    group:group("oxy_powder_bottle_part", 30)
    group:group("heroin_bag_zipper_4", 10)
    group:entry { item = "lsd", count = { 5, 5 }, probability = 10 }
    group:group("oxycodone_bottle_plastic_pill_prescription_10", 10)
    group:group("tramadol_bottle_plastic_pill_prescription_10", 10)
    group:group("codeine_bottle_plastic_pill_painkiller_10", 10)
    group:group("thorazine_bottle_plastic_pill_prescription_10", 10)
    group:group("pills_sleep_bottle_plastic_pill_prescription_10", 20)
    group:group("vitamins_bottle_plastic_pill_supplement_20", 30)
    content.add(group)
end
