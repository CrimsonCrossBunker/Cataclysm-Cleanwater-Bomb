local content = require("ccb").content

do
    local group = content.ItemGroup { id = "backrooms_strange_object_group", kind = "distribution" }
    group:item("backrooms_strange_object")
    content.add(group)
end

do
    -- Any kind of raw forage, to mostly be found in ash and rubble.
    local group = content.ItemGroup { id = "forage_broad", kind = "distribution" }
    group:group("forage_spring")
    group:group("forage_summer", 50)
    group:group("forage_autumn", 25)
    group:group("farming_seeds", 5)
    group:group("oa_ig_ash_pile", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vending_mutagens", kind = "collection" }
    group:entry { item = "syringe", count = { 1, 10 } }
    group:group("mutagen_kits")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vending_bionics", kind = "collection" }
    group:entry { item = "anesthetic_kit", count = { 1, 2 } }
    group:entry { item = "scalpel", count = { 1, 4 } }
    group:entry { group = "bionics_common", count = { 1, 10 }, probability = 33 }
    group:entry { group = "bionics_mil", count = { 1, 8 }, probability = 20 }
    group:entry { group = "bionics", count = { 1, 6 }, probability = 15 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "almond_water_sealed", kind = "distribution" }
    group:entry { item = "almond_water", count = { 1, 1 }, container = "bottle_almond_water", probability = 1 }
    content.add(group)
end

do
    -- These crates are packed full of all kinds of supplies, but mostly hardware, tools, electronics, chems, and rarely, weapons. Books, food, meds, and clothes are usually found elsewhere.
    local group = content.ItemGroup { id = "backrooms_crate", kind = "distribution", with_ammo = 70, with_magazine = 100 }
    group:group("crate_stack", 75)
    group:group("mischw")
    group:group("tools_general", 50)
    group:group("hardware_plumbing", 75)
    group:group("mechanics", 75)
    group:group("home_hw", 150)
    group:group("chem_home", 50)
    group:group("home_display_case", 20)
    group:group("cleaning", 50)
    group:group("homeguns", 5)
    group:group("hospital_bed", 10)
    group:group("museum_melee", 2)
    group:group("museum_primitive", 2)
    group:group("museum_guns", 2)
    group:group("mine_equipment", 10)
    group:group("everyday_corpse", 5)
    group:group("ambulance_equipment", 10)
    group:group("lab_dorm", 10)
    group:group("SUS_welding_gear", 5)
    group:group("electronics", 25)
    group:group("tools_home", 75)
    group:group("hand_tools", 50)
    group:group("power_tools", 20)
    group:group("tools_gunsmith", 10)
    group:group("tools_science", 15)
    group:group("tools_hunting", 15)
    group:group("consumer_electronics", 75)
    group:group("weapons", 10)
    group:group("robots", 10)
    group:group("ammo_parts", 10)
    group:group("pawn", 10)
    content.add(group)
end

do
    -- A rarer crate with more valuable materials, including guns, ammo, and bionics.
    local group = content.ItemGroup { id = "backrooms_crate_rare", kind = "distribution", with_ammo = 70, with_magazine = 100 }
    group:group("vault", 50)
    group:group("weapons", 50)
    group:group("grenades", 5)
    group:group("cop_armory", 20)
    group:group("bionics_common", 25)
    group:group("bionics", 20)
    group:group("bionics_mil", 10)
    group:group("robots", 50)
    group:group("ammo_common_boxed", 300)
    group:group("mags_common", 130)
    group:group("guns_pistol_common", 35)
    group:group("guns_smg_improvised", 10)
    group:group("guns_rifle_common", 5)
    group:group("guns_rifle_improvised", 10)
    group:group("guns_shotgun_common", 5)
    group:group("guns_shotgun_improvised", 20)
    group:group("museum_melee", 2)
    group:group("museum_guns", 20)
    group:group("mutagen_kits", 1)
    group:group("science", 20)
    group:group("surgery", 40)
    group:group("ammo_parts", 50)
    group:group("antique_ammo", 50)
    group:group("mut_lab", 20)
    group:group("backrooms_artifacts", 1)
    content.add(group)
end

do
    -- Common supplies distributed in cardboard boxes, including household supplies, food, and sometimes meds.
    local group = content.ItemGroup { id = "backrooms_supplies", kind = "distribution" }
    group:group("magazines", 50)
    group:group("manuals_school", 50)
    group:group("pantry_liquids", 75)
    group:group("pasta_ingredients", 60)
    group:group("cannedfood")
    group:group("big_canned_food", 80)
    group:group("dry_goods")
    group:group("preserved_food")
    group:group("drugs_heal_simple", 50)
    group:group("softdrugs", 40)
    group:group("harddrugs", 10)
    group:group("cleaning", 50)
    group:group("condiments", 50)
    group:group("snacks", 75)
    group:group("alcohol", 25)
    group:item("water_clean")
    group:group("misc_smoking", 20)
    group:group("SUS_office_supplies", 15)
    group:group("car_misc", 5)
    group:group("SUS_office_filing_cabinet", 15)
    group:group("chem_home", 20)
    group:group("supplies_electronics", 25)
    group:group("dollar_food")
    group:group("hospital_lab", 50)
    group:group("shelter", 50)
    content.add(group)
end

do
    -- Firearms and ammo found in lockers.
    local group = content.ItemGroup {
        id = "backrooms_weaponslocker_rare",
        kind = "distribution",
        with_ammo = 70,
        with_magazine = 100,
    }
    group:group("ammo_common_boxed", 300)
    group:group("guns_pistol_common", 120)
    group:group("guns_rifle_common")
    group:group("guns_shotgun_common", 85)
    group:group("mags_common", 435)
    group:group("mags_milspec")
    group:group("ammo_launcher_grenade", 20)
    group:group("archery", 25)
    content.add(group)
end

do
    -- Firearms and ammo found in lockers.
    local group = content.ItemGroup { id = "backrooms_weaponslocker", kind = "distribution", with_ammo = 70, with_magazine = 100 }
    group:group("ammo_common_boxed", 300)
    group:group("guns_pistol_common", 90)
    group:group("guns_smg_improvised", 30)
    group:group("guns_rifle_common", 15)
    group:group("guns_rifle_improvised", 25)
    group:group("guns_shotgun_common", 20)
    group:group("guns_shotgun_improvised", 40)
    group:group("weapons", 20)
    group:group("grenades", 5)
    group:group("swat_gear", 5)
    group:group("ammo_parts", 60)
    group:group("mags_common")
    group:group("archery", 5)
    group:group("antique_ammo", 15)
    group:group("archery_ammo", 10)
    content.add(group)
end

do
    -- Protective gear, personal items, and tools found in lockers.
    local group = content.ItemGroup { id = "backrooms_equipmentlocker_rare", kind = "distribution" }
    group:group("swat_gear", 50)
    group:group("rad_gear", 25)
    group:group("fireman_gear", 50)
    group:group("gear_survival", 25)
    group:group("gear_medical", 20)
    group:group("hardware_clothing")
    group:group("museum_armor", 25)
    group:group("survivorzed_extra", 15)
    content.add(group)
end

do
    -- Protective gear, personal items, and tools found in lockers.
    local group = content.ItemGroup { id = "backrooms_equipmentlocker", kind = "distribution" }
    group:group("accesories_personal_unisex")
    group:group("everyday_gear")
    group:group("clothing_work_set")
    group:group("hardware_clothing")
    group:group("museum_armor", 10)
    group:group("traveler", 25)
    group:group("rad_gear", 15)
    group:group("fireman_gear", 25)
    group:group("gear_survival", 5)
    group:group("gear_medical", 15)
    group:group("oa_ig_rd_lockers", 10)
    content.add(group)
end

do
    -- The best of the best stuff you'll find.
    local group = content.ItemGroup { id = "backrooms_treasure_rare", kind = "distribution", with_ammo = 70, with_magazine = 100 }
    group:group("guns_pistol_milspec")
    group:group("guns_smg_milspec", 75)
    group:group("guns_rifle_milspec", 80)
    group:group("guns_shotgun_milspec")
    group:group("bionics_mil", 25)
    group:group("bionics", 50)
    group:group("mutagenic_field_kit", 25)
    group:group("guns_energy", 15)
    group:group("guns_launcher_milspec", 25)
    group:group("vault", 75)
    content.add(group)
end

do
    -- Top grade stuff you'll find almost exclusively in safes.
    local group = content.ItemGroup { id = "backrooms_treasure", kind = "distribution", with_ammo = 70, with_magazine = 100 }
    group:group("ammo_common_boxed", 300)
    group:group("guns_pistol_milspec", 25)
    group:group("guns_smg_milspec", 15)
    group:group("guns_rifle_milspec", 20)
    group:group("guns_shotgun_milspec", 25)
    group:group("bionics_mil", 15)
    group:group("bionics", 50)
    group:group("mutagenic_field_kit", 10)
    group:group("mutagen_kits", 1)
    group:group("guns_energy", 5)
    group:group("science")
    group:group("guns_launcher_milspec", 5)
    group:group("vault", 50)
    group:group("backrooms_artifacts", 5)
    content.add(group)
end

do
    -- Mostly chems, liquids, and containers.
    local group = content.ItemGroup { id = "backrooms_shelf_chems", kind = "distribution" }
    group:group("chem_home")
    group:group("cleaning")
    group:group("SUS_janitors_closet", 25)
    group:group("chem_school")
    group:group("SUS_kitchen_sink", 25)
    group:group("ammo_parts", 20)
    group:group("ambulance_equipment", 25)
    group:group("hospital_lab", 20)
    group:group("mut_lab", 5)
    content.add(group)
end

do
    -- Mostly tools, heavy or industrial supplies, raw resources, etc.
    local group = content.ItemGroup { id = "backrooms_shelf_tools", kind = "distribution" }
    group:group("mischw")
    group:group("tools_plumbing")
    group:group("mechanics")
    group:group("home_hw", 50)
    group:group("SUS_janitors_closet", 25)
    group:group("museum_primitive", 10)
    group:group("mine_equipment", 20)
    group:group("tools_gunsmith", 25)
    group:group("tools_general", 50)
    group:group("tools_robotics", 25)
    group:group("hand_tools", 50)
    group:group("power_tools", 50)
    group:group("tools_medical", 25)
    group:group("tools_home")
    group:group("electronics", 50)
    group:group("paint", 10)
    group:group("rug", 10)
    group:group("dollar_tools", 50)
    group:group("farming_tools", 15)
    content.add(group)
end

do
    -- Bulk supplies, mostly.
    local group = content.ItemGroup { id = "backrooms_shelf_supplies", kind = "distribution" }
    group:group("hardware_bulk")
    group:group("plumbing_bulk", 50)
    group:group("wood_workshop", 50)
    group:group("supplies_hardware")
    group:group("supplies_reagents_lab", 20)
    group:group("supplies_fuel", 20)
    group:group("supplies_mechanics", 50)
    group:group("supplies_plumbing", 50)
    group:group("supplies_metal", 50)
    group:group("supplies_farming", 10)
    group:group("farm_supply_soil_and_sand", 15)
    group:group("farm_supply_rocks", 5)
    group:group("metal_workshop", 50)
    group:group("steel_mill_mill", 50)
    group:group("recycle_paper", 20)
    group:group("recycle_electronic", 20)
    group:group("recycle_plastic", 25)
    group:group("recycle_glass", 10)
    group:group("recycle_aluminum", 5)
    group:group("recycle_copper", 10)
    group:group("recycle_battery", 20)
    group:group("recycle_steel", 50)
    content.add(group)
end

do
    -- Anything left over goes here. Assorted junk and supplies.
    local group = content.ItemGroup { id = "backrooms_shelf_misc", kind = "distribution" }
    group:group("home_display_case", 20)
    group:group("bedroom", 50)
    group:group("SUS_junk_drawer")
    group:group("accesories_personal_unisex", 50)
    group:group("lab_dorm", 20)
    group:group("everyday_corpse", 10)
    group:group("tools_science", 10)
    group:group("consumer_electronics", 50)
    group:group("electronics", 50)
    group:group("car_kit", 50)
    group:group("monparts", 5)
    group:group("pawn", 10)
    group:group("dollar_tools", 10)
    group:group("subway", 25)
    group:group("road", 10)
    group:group("archery_ammo", 10)
    group:group("crate_stack", 25)
    content.add(group)
end

do
    -- Stuff you might find in a kitchen drawer.
    local group = content.ItemGroup { id = "backrooms_kitchen_drawers", kind = "collection" }
    group:group("SUS_utensils", 75)
    group:group("SUS_knife_drawer", 75)
    group:group("SUS_junk_drawer", 75)
    group:group("SUS_appliances_cupboard", 75)
    group:group("SUS_cookware", 40)
    content.add(group)
end

do
    -- Books you might expect to find on a normal shelf.
    local group = content.ItemGroup { id = "backrooms_books_common", kind = "distribution" }
    group:group("ranch_homebooks")
    group:group("book_school", 75)
    group:group("textbooks", 50)
    group:group("book_survival", 25)
    group:group("religious_books", 20)
    group:group("manuals", 15)
    content.add(group)
end

do
    -- Books you'd only really read for fun.
    local group = content.ItemGroup { id = "backrooms_books_fluff", kind = "distribution" }
    group:group("novels")
    group:group("literature", 50)
    group:group("kids_books", 25)
    content.add(group)
end

do
    -- Military instructions and weapon manuals.
    local group = content.ItemGroup { id = "backrooms_books_military", kind = "distribution" }
    group:group("book_military")
    group:group("book_gunref", 10)
    content.add(group)
end

do
    -- Rarer science reading materials.
    local group = content.ItemGroup { id = "backrooms_books_experimental", kind = "distribution" }
    group:group("doctors_books")
    group:group("lab_bookshelves", 50)
    group:group("backrooms_recipes_mutagen", 5)
    content.add(group)
end

do
    -- Books about fighting.
    local group = content.ItemGroup { id = "backrooms_books_combat", kind = "distribution" }
    group:group("dojo_manuals", 160)
    group:item("manual_boxing", 12)
    content.add(group)
end

do
    -- Books about fighting.
    local group = content.ItemGroup { id = "backrooms_recipes_mutagen", kind = "distribution" }
    group:item("recipe_alpha")
    group:item("recipe_animal", 150)
    group:item("recipe_chimera")
    group:item("recipe_creepy")
    group:item("recipe_elfa")
    group:item("recipe_labchem", 200)
    group:item("recipe_maiar")
    group:item("recipe_medicalmut")
    group:item("recipe_raptor")
    group:item("recipe_serum", 200)
    content.add(group)
end

do
    -- Just tools.
    local group = content.ItemGroup { id = "backrooms_tools", kind = "distribution" }
    group:group("tools_home", 150)
    group:group("hand_tools")
    group:group("power_tools", 50)
    group:group("tools_general")
    group:group("mechanics", 75)
    content.add(group)
end

do
    -- Any generic breakroom/kitchen fridge.
    local group = content.ItemGroup { id = "backrooms_master_fridge", kind = "distribution" }
    group:group("SUS_fridge")
    group:entry { group = "monparts", count = { 1, 4 }, probability = 2 }
    group:group("SUS_pantry", 25)
    group:group("SUS_breakfast_cupboard", 20)
    group:entry { group = "baked_goods", count = { 1, 3 }, probability = 10 }
    group:entry { group = "groce_condiment", count = { 1, 3 }, probability = 50 }
    group:item("almond_water", 1)
    content.add(group)
end

do
    -- Any generic breakroom/kitchen cupboards, from non-fridge foods to junk drawers.
    local group = content.ItemGroup { id = "backrooms_master_cupboards", kind = "distribution" }
    group:group("backrooms_kitchen_drawers")
    group:group("SUS_appliances_cupboard", 50)
    group:entry {
        collection = {
            { group = "SUS_breakfast_cupboard" },
            { group = "SUS_coffee_cupboard", probability = 80 },
        },
        probability = 50,
    }
    group:group("SUS_cookware", 50)
    group:group("SUS_pantry", 50)
    group:entry { group = "dry_goods", count = { 1, 3 }, probability = 50 }
    group:entry { group = "preserved_food", count = { 1, 4 }, probability = 50 }
    content.add(group)
end

do
    -- Any generic breakroom/kitchen countertop, for food and appliances.
    local group = content.ItemGroup { id = "backrooms_master_countertop_kitchen", kind = "distribution" }
    group:group("kitchen_counters", 50)
    group:group("SUS_junk_drawer", 15)
    group:group("SUS_pantry", 15)
    group:entry { group = "groce_condiment", count = { 2, 3 }, probability = 25 }
    group:group("SUS_spice_collection", 25)
    group:group("SUS_coffee_cupboard", 25)
    group:group("SUS_breakfast_cupboard", 10)
    group:entry { group = "preserved_food", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    -- Any generic kitchen sink, for chems and supplies.
    local group = content.ItemGroup { id = "backrooms_master_sink1", kind = "collection" }
    group:group("SUS_kitchen_sink")
    group:group("SUS_dishes", 50)
    group:group("SUS_silverware", 75)
    content.add(group)
end

do
    -- Any generic bathroom countertop, for chems and possibly drugs.
    local group = content.ItemGroup { id = "backrooms_master_countertops_bathroom", kind = "distribution" }
    group:group("SUS_hair_drawer", 50)
    group:group("SUS_bathroom_cabinet")
    group:entry { group = "softdrugs", count = { 1, 2 }, probability = 25 }
    group:group("harddrugs", 10)
    group:group("SUS_toilet", 35)
    content.add(group)
end

do
    -- Any generic bathroom sink, for chems and possibly drugs.
    local group = content.ItemGroup { id = "backrooms_master_sink2", kind = "distribution" }
    group:group("SUS_bathroom_sink")
    group:group("SUS_bathroom_medicine", 75)
    group:entry { group = "softdrugs", count = { 1, 2 }, probability = 50 }
    group:group("harddrugs", 5)
    content.add(group)
end

do
    -- Any generic kitchen table, mostly food and dishwear.
    local group = content.ItemGroup { id = "backrooms_master_table_kitchen", kind = "distribution" }
    group:entry { group = "dishes_dining", count = { 1, 3 }, probability = 50 }
    group:entry { group = "tea_dishes", count = { 1, 3 }, probability = 50 }
    group:group("baked_goods", 25)
    group:entry { group = "groce_condiment", count = { 1, 2 }, probability = 25 }
    group:entry { group = "dining", count = { 1, 2 }, probability = 35 }
    content.add(group)
end

do
    -- Any generic breakroom coffee table, for magazines, personal items, recreation, electronics.
    local group = content.ItemGroup { id = "backrooms_master_table_coffee", kind = "distribution" }
    group:group("consumer_electronics", 25)
    group:entry { group = "table_livingroom", count = { 1, 2 } }
    group:group("toy_box", 50)
    group:group("a_television", 25)
    content.add(group)
end

do
    -- Any generic breakroom table, for reading material, dishwear, food, personal items, and recreation.
    local group = content.ItemGroup { id = "backrooms_master_table_breakroom", kind = "distribution" }
    group:entry { group = "table_card", count = { 1, 3 } }
    group:entry { group = "table_livingroom", count = { 1, 3 } }
    group:group("ic_merch", 35)
    group:entry { group = "magazines", count = { 1, 2 }, probability = 125 }
    group:entry { group = "waitingroom", count = { 1, 2 }, probability = 50 }
    group:group("toy_box")
    group:group("consumer_electronics", 40)
    group:group("homebooks", 25)
    group:entry { group = "book_mag_gen", count = { 1, 2 }, probability = 50 }
    group:entry { group = "newspaper", count = { 1, 2 }, probability = 50 }
    content.add(group)
end

do
    -- Any generic office table, mostly for files and supplies.
    local group = content.ItemGroup { id = "backrooms_master_table_office", kind = "distribution" }
    group:entry { group = "cubical_office", count = { 1, 6 } }
    group:group("SUS_office_desk")
    group:entry { group = "SUS_office_mess", count = { 1, 2 }, probability = 35 }
    content.add(group)
end

do
    -- Any generic office desk, for personal effects and office supplies.
    local group = content.ItemGroup { id = "backrooms_master_desk", kind = "distribution" }
    group:entry { group = "cubical_office", count = { 1, 6 }, probability = 250 }
    group:group("SUS_office_desk", 250)
    group:entry { group = "bedroom", count = { 1, 3 }, probability = 25 }
    group:group("npc_hacker", 50)
    group:entry { group = "school", count = { 1, 4 } }
    group:group("backrooms_artifacts", 1)
    content.add(group)
end

do
    -- Any generic trashcan. For trash.
    local group = content.ItemGroup { id = "backrooms_master_trash", kind = "distribution" }
    group:entry { group = "SUS_trash_trashcan", count = { 1, 5 }, probability = 1000 }
    group:entry { group = "SUS_trash_forest_manmade", count = { 1, 4 } }
    group:group("backrooms_artifacts", 1)
    content.add(group)
end

do
    -- Any generic filing cabinet, mostly for papers and files.
    local group = content.ItemGroup { id = "backrooms_master_filing", kind = "distribution" }
    group:group("SUS_office_filing_cabinet")
    group:entry { group = "SUS_office_supplies", count = { 2, 10 }, probability = 25 }
    group:entry { group = "stash_drugs", count = { 1, 3 }, probability = 5 }
    content.add(group)
end

do
    -- Any generic coat rack, for coats and hats.
    local group = content.ItemGroup { id = "backrooms_master_coat_rack", kind = "distribution" }
    group:group("unisex_coat_rack")
    content.add(group)
end

do
    -- Any generic pile of debris, mostly for hidden plant matter.
    local group = content.ItemGroup { id = "backrooms_master_rubble", kind = "distribution" }
    group:entry { group = "forage_broad", count = { 1, 2 } }
    group:entry { group = "SUS_trash_metal", count = { 1, 3 }, probability = 50 }
    group:entry { group = "SUS_trash_hardware", count = { 1, 3 }, probability = 10 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "vending_ammo", kind = "collection" }
    group:entry { group = "ammo_common_boxed", count = { 1, 10 } }
    content.add(group)
end

do
    -- Any generic vending machine, for food, drinks, or rarely other things.
    local group = content.ItemGroup { id = "backrooms_master_vending", kind = "distribution" }
    group:group("vending_drink", 70)
    group:group("vending_food", 50)
    group:group("vending_ammo", 5)
    group:group("vending_bionics", 2)
    group:group("vending_mutagens", 2)
    content.add(group)
end

do
    -- Any generic cardboard box, holding mostly personal supplies, food, and meds.
    local group = content.ItemGroup { id = "backrooms_master_cardboard", kind = "distribution" }
    group:entry { group = "backrooms_supplies", count = { 1, 6 }, probability = 50 }
    group:group("backrooms_master_trash", 8)
    content.add(group)
end

do
    -- Any generic crate, holding a broad variety of bulkier items.
    local group = content.ItemGroup { id = "backrooms_master_crate", kind = "distribution" }
    group:entry { group = "backrooms_crate", count = { 1, 6 } }
    group:entry { group = "backrooms_crate_rare", count = { 1, 2 }, probability = 5 }
    content.add(group)
end

do
    -- Any generic locker, holding equipment, weapons, or gear.
    local group = content.ItemGroup { id = "backrooms_master_locker", kind = "distribution" }
    group:entry { group = "backrooms_weaponslocker", count = { 1, 3 }, probability = 50 }
    group:entry { group = "backrooms_weaponslocker_rare", count = { 1, 2 }, probability = 3 }
    group:entry { group = "backrooms_equipmentlocker", count = { 1, 3 } }
    group:entry { group = "backrooms_equipmentlocker_rare", count = { 1, 2 }, probability = 5 }
    content.add(group)
end

do
    -- Any generic locker, holding equipment, weapons, or gear.
    local group = content.ItemGroup { id = "backrooms_master_locker_rare", kind = "distribution" }
    group:entry { group = "backrooms_weaponslocker_rare", count = { 1, 2 } }
    group:entry { group = "backrooms_equipmentlocker_rare", count = { 1, 2 }, probability = 120 }
    content.add(group)
end

do
    -- Any generic safe, holding rare goodies.
    local group = content.ItemGroup { id = "backrooms_master_safe", kind = "distribution" }
    group:entry { group = "backrooms_treasure", count = { 1, 2 } }
    group:entry { group = "backrooms_treasure_rare", count = { 1, 2 }, probability = 5 }
    content.add(group)
end

do
    -- Any generic utility shelf, holding primarily tools or chems.
    local group = content.ItemGroup { id = "backrooms_master_shelf1", kind = "distribution" }
    group:entry { group = "backrooms_shelf_chems", count = { 1, 4 }, probability = 40 }
    group:entry { group = "backrooms_tools", count = { 1, 3 }, probability = 40 }
    group:entry { group = "backrooms_shelf_tools", count = { 1, 3 }, probability = 30 }
    content.add(group)
end

do
    -- Any generic warehouse shelf, holding bulk materials or absolutely random crap.
    local group = content.ItemGroup { id = "backrooms_master_shelf2", kind = "distribution" }
    group:entry { group = "backrooms_shelf_supplies", count = { 1, 4 }, probability = 50 }
    group:entry { group = "backrooms_shelf_misc", count = { 1, 6 }, probability = 20 }
    content.add(group)
end

do
    -- Any generic warehouse shelf, holding bulk materials or absolutely random crap.
    local group = content.ItemGroup { id = "backrooms_master_workbench", kind = "collection" }
    group:entry { group = "backrooms_tools", count = { 1, 2 } }
    group:entry { group = "backrooms_shelf_supplies", count = { 1, 2 }, probability = 50 }
    content.add(group)
end

do
    -- Any bookshelf, preferring common books but rarely featuring more military or experimental fare.
    local group = content.ItemGroup { id = "backrooms_master_bookshelf", kind = "distribution" }
    group:entry { group = "backrooms_books_common", count = { 2, 6 } }
    group:entry { group = "backrooms_books_fluff", count = { 2, 6 } }
    group:entry { group = "backrooms_books_military", count = { 2, 6 }, probability = 5 }
    group:entry { group = "backrooms_books_experimental", count = { 2, 6 }, probability = 5 }
    group:entry { group = "backrooms_books_combat", count = { 2, 6 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "npc_hacker", kind = "distribution" }
    group:item("energy_drink", 55)
    group:item("energy_drink_atomic", 12)
    group:item("mag_computer", 45)
    group:item("mag_electronics", 25)
    group:item("colamdew", 50)
    group:item("adderall", 10)
    group:item("fries", 10)
    group:item("cheese_fries", 10)
    group:item("onion_rings", 10)
    group:item("mintpatties", 20)
    group:entry { item = "electrohack", charges = { 0, 100 }, probability = 3 }
    group:group("civilian_usb_drives", 5)
    group:group("box_of_batteries_random", 50)
    group:item("file", 10)
    group:item("manual_computer", 20)
    group:item("hackerman_computer", 10)
    group:item("textbook_computer", 8)
    group:item("textbook_anarch", 4)
    group:item("computer_science", 7)
    group:item("mask_skull", 5, "guy_fawkes")
    group:item("solar_cell", 5)
    group:item("SICP", 3)
    group:item("recipe_serum", 2)
    group:item("recipe_chimera", 1)
    group:item("recipe_labchem", 1)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 70 }
    group:group("solder_wire_spool_part", 70)
    group:item("textbook_weapwest", 2)
    group:item("textbook_weparabic", 2)
    group:item("textbook_weapeast", 2)
    group:item("textbook_armwest", 2)
    group:item("textbook_armeast", 2)
    group:item("textbook_armschina", 2)
    group:item("textbook_mesoam", 2)
    group:item("ballista_book", 2)
    group:item("bronze_book", 2)
    group:item("bronze_mag", 2)
    group:item("radio_book", 22)
    group:group("toy_radio_car", 1)
    group:group("toy_makerspace_kit", 1)
    group:group("toy_robot_kit", 1)
    group:group("toy_engine_kit", 1)
    group:entry { item = "radiocontrol", charges = { 0, 100 }, probability = 5 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "a_waystone", kind = "collection" }
    group:item("waystone")
    content.add(group)
end
