local content = require("ccb").content

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- Each locker contains by spec one jacket, one blanket, one gas mask, a flashlight, a whistle, a plastic bowl and utensils, a lighter, and two bottles of water.  Not every locker is fully stocked.
    local group = content.ItemGroup { id = "SUS_evac_shelter_locker", kind = "collection" }
    group:item("evac_pamphlet", 99)
    group:item("jacket_evac", 75)
    group:item("emer_blanket", 75)
    group:group("gasmask_bag_full", 2)
    group:item("flashlight", 50)
    group:entry { item = "medium_battery_cell", charges = { 56, 56 }, probability = 10 }
    group:entry { item = "lighter", charges = { 60, 100 }, probability = 20 }
    group:item("whistle", 70)
    group:entry { item = "water_clean", count = { 1, 2 }, probability = 80 }
    group:entry { item = "protein_bar_evac", count = { 2, 3 } }
    group:entry {
        collection = {
            { item = "plastic_spoon", probability = 90 },
            { item = "plastic_knife", probability = 90 },
            { item = "plastic_fork", probability = 90 },
            { item = "bowl_plastic", probability = 90 },
        },
        probability = 90,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- This locker has been picked through by an evacuee already. Not everyone wants the jacket, plenty leave the blanket or the gas mask, but the useful stuff is usually gone.  Some people left junk behind.
    local group = content.ItemGroup { id = "SUS_evac_shelter_locker_used", kind = "collection" }
    group:item("evac_pamphlet", 95)
    group:item("jacket_evac", 15)
    group:item("emer_blanket", 45)
    group:group("gasmask_bag_full", 1)
    group:item("flashlight", 10)
    group:item("wrapper", 50)
    group:item("wrapper_foil", 2)
    group:item("survnote", 5)
    group:item("plastic_shopping_bag", 5)
    group:item("box_small", 5)
    group:item("bag_plastic", 5)
    group:item("bowl_plastic", 5)
    group:item("can_food", 5)
    group:item("can_opener", 3)
    group:entry { item = "bottle_plastic", count = { 1, 2 }, probability = 50 }
    group:entry { item = "protein_bar_evac", count = { 2, 3 }, probability = 70 }
    group:entry {
        collection = {
            { item = "plastic_spoon", probability = 70 },
            { item = "plastic_knife", probability = 70 },
            { item = "plastic_fork", probability = 70 },
            { item = "bowl_plastic", probability = 50 },
        },
        probability = 90,
    }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- The cabinets contain a stock of delicious evac protein bars, and may contain clean water, cans of food, and spare blankets.
    local group = content.ItemGroup { id = "SUS_evac_shelter_cabinet", kind = "collection" }
    group:entry {
        distribution = {
            {
                collection = {
                    { item = "emer_blanket", count = { 5, 10 }, probability = 80 },
                    { item = "jacket_evac", count = { 5, 10 }, probability = 80 },
                },
                probability = 30,
            },
            { item = "water_clean", count = { 6, 12 }, probability = 20 },
            { group = "full_box_of_evacuation_protein_bar", probability = 60 },
            {
                collection = {
                    { item = "extinguisher", charges = { 100, 100 }, probability = 70 },
                    { group = "full_1st_aid", count = { 1, 3 }, probability = 65 },
                    { item = "two_way_radio", probability = 65 },
                    { item = "medium_battery_cell", count = { 2, 4 }, charges = { 56, 56 }, probability = 65 },
                    { item = "electric_lantern", probability = 35 },
                    { item = "barometer", probability = 8 },
                },
                probability = 10,
            },
            {
                collection = {
                    { group = "detergent_small_box_part", probability = 15 },
                    { group = "borax_box_part", probability = 15 },
                    { item = "brush", probability = 85 },
                    { group = "bleach_jug_part", probability = 45 },
                    { item = "chem_washing_soda", probability = 10 },
                    { group = "ammonia_hydroxide_bottle_twoliter_part", probability = 15 },
                    { item = "vinegar", probability = 10 },
                    { group = "bag_garbage_box", probability = 35 },
                },
                probability = 15,
            },
            {
                collection = {
                    { group = "beans_in_can", count = { 8, 12 }, probability = 50 },
                    { group = "tomatoes_in_can", count = { 8, 12 }, probability = 40 },
                    { item = "soup_chicken", count = { 8, 12 }, probability = 20 },
                    { item = "can_opener", probability = 90 },
                },
                probability = 5,
            },
        },
    }
    group:item("evac_pamphlet", 15)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    local group = content.ItemGroup { id = "SUS_evac_shelter_sink", kind = "collection" }
    group:entry { item = "soap", count = { 1, 2 } }
    group:item("brush", 90)
    group:group("bleach_jug_part", 45)
    group:group("ammonia_hydroxide_bottle_twoliter_part", 25)
    group:item("chem_washing_soda", 20)
    group:item("mirror", 12)
    group:group("full_1st_aid", 60)
    group:entry { item = "paper", count = { 1, 3 } }
    group:item("evac_pamphlet", 10)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These items have been picked over by a previous flood of evacuees, but plenty of good stuff could still be left.
    local group = content.ItemGroup { id = "SUS_evac_shelter_sink_used", kind = "collection" }
    group:entry { item = "soap", count = { 1, 2 }, probability = 50 }
    group:item("brush", 45)
    group:group("bleach_jug_part", 20)
    group:group("ammonia_hydroxide_bottle_twoliter_part", 10)
    group:item("mirror", 5)
    group:group("used_1st_aid", 40)
    group:entry { item = "paper", count = { 1, 3 }, probability = 50 }
    group:item("evac_pamphlet", 10)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These shelves contain miscellaneous extra supplies.
    local group = content.ItemGroup { id = "SUS_evac_shelter_supply_closet", kind = "collection" }
    group:entry { group = "games_basic", count = { 1, 3 }, probability = 75 }
    group:item("two_way_radio", 25)
    group:item("electric_lantern", 5)
    group:item("flashlight", 50)
    group:entry { item = "medium_battery_cell", charges = { 56, 56 }, probability = 10 }
    group:item("jacket_evac", 75)
    group:item("emer_blanket", 75)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These shelves contain miscellaneous extra supplies.
    -- These items have been picked over by a previous flood of evacuees, but plenty of good stuff could still be left.
    local group = content.ItemGroup { id = "SUS_evac_shelter_supply_closet_used", kind = "collection" }
    group:entry { group = "games_basic", count = { 1, 2 }, probability = 25 }
    group:item("two_way_radio", 10)
    group:item("electric_lantern", 2)
    group:item("flashlight", 25)
    group:entry { item = "medium_battery_cell", charges = { 56, 56 }, probability = 5 }
    group:item("jacket_evac", 30)
    group:item("emer_blanket", 30)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These tables contain miscellaneous items to occupy people's time while waiting in the shelter.
    local group = content.ItemGroup { id = "SUS_evac_shelter_table", kind = "collection" }
    group:item("evac_pamphlet", 15)
    group:entry { group = "games_basic", count = { 1, 2 }, probability = 15 }
    group:entry { item = "paper", count = { 1, 3 }, probability = 20 }
    group:entry { item = "pencil", count = { 1, 5 }, probability = 20 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These tables contain miscellaneous items to occupy people's time while waiting in the shelter.
    -- These items have been picked over by a previous flood of evacuees, but plenty of good stuff could still be left.
    local group = content.ItemGroup { id = "SUS_evac_shelter_table_used", kind = "collection" }
    group:item("evac_pamphlet", 15)
    group:group("games_basic", 8)
    group:entry { item = "paper", count = { 1, 2 }, probability = 10 }
    group:entry { item = "pencil", count = { 1, 2 }, probability = 10 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These counters contain bathroom items found next to sinks.
    local group = content.ItemGroup { id = "SUS_evac_shelter_bathroom_counter", kind = "collection" }
    group:item("soap_holder", 50)
    group:item("soap", 75)
    group:item("mirror", 20)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These counters contain bathroom items found next to sinks.
    -- These items have been picked over by a previous flood of evacuees, but plenty of good stuff could still be left.
    local group = content.ItemGroup { id = "SUS_evac_shelter_bathroom_counter_used", kind = "collection" }
    group:item("soap_holder", 50)
    group:item("soap", 15)
    group:item("mirror", 5)
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These shelves contain spare bathroom supplies.
    local group = content.ItemGroup { id = "SUS_evac_shelter_bathroom_supplies", kind = "collection" }
    group:entry { item = "soap", count = { 1, 2 } }
    group:group("bleach_jug", 45)
    group:group("ammonia_hydroxide_bottle_twoliter_part", 25)
    group:entry { item = "toilet_paper", count = { 3, 6 } }
    group:item("plunger_toilet", 70)
    group:item("plunger_futuristic", 70)
    group:item("brush_toilet", 50)
    group:entry { item = "towel", count = { 1, 3 }, probability = 50 }
    content.add(group)
end

do
    -- SUS item groups are collections that contain a reasonable realistic distribution of items that might spawn in a given storage furniture.
    -- These shelves contain spare bathroom supplies.
    -- These items have been picked over by a previous flood of evacuees, but plenty of good stuff could still be left.
    local group = content.ItemGroup { id = "SUS_evac_shelter_bathroom_supplies_used", kind = "collection" }
    group:item("soap", 50)
    group:group("bleach_jug_part", 20)
    group:group("ammonia_hydroxide_bottle_twoliter_part", 10)
    group:entry { item = "toilet_paper", count = { 1, 2 }, probability = 50 }
    group:item("plunger_toilet", 40)
    group:item("plunger_futuristic", 40)
    group:item("brush_toilet", 30)
    group:entry { item = "towel", count = { 1, 2 }, probability = 20 }
    content.add(group)
end
