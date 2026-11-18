local content = require("ccb").content

do
    local group = content.ItemGroup { id = "coffee_shop", kind = "distribution" }
    group:group("candy_chocolate", 530)
    group:group("licorice_bag_plastic_4", 15)
    group:group("soda_in_small_container", 470)
    group:group("snacks", 560)
    group:item("coffee_raw", 70)
    group:item("water_clean", 90)
    group:item("water_mineral", 10)
    group:item("almond_milk", 20)
    group:item("oat_milk", 20)
    group:item("soy_milk", 20)
    group:item("juice", 20)
    group:item("sandwich_t", 30)
    group:item("sandwich_pb", 30)
    group:item("sandwich_pbj", 30)
    group:item("sandwich_pbh", 30)
    group:item("sandwich_pbm", 30)
    group:item("pizza_veggy", 8)
    group:item("pizza_cheese", 8)
    group:item("pizza_meat", 8)
    group:item("hamburger", 40)
    group:item("fish_fried", 8)
    group:item("fish_sandwich", 8)
    group:item("cheeseburger", 40)
    group:item("sloppyjoe", 8)
    group:item("hotdogs_frozen", 12)
    group:item("hotdogs_cooked", 35)
    group:item("corndogs_frozen", 30)
    group:item("blt", 40)
    group:item("salted_fish", 15)
    group:item("pie", 20)
    group:item("pie_meat", 20)
    group:item("pie_veggy", 20)
    group:item("pie_maple", 10)
    group:item("cinnamon", 15)
    group:item("coffee_bean", 20)
    group:item("roasted_coffee_bean", 50)
    group:item("restaurantmap", 5)
    group:item("touristmap", 2)
    group:item("brioche", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_display", kind = "distribution" }
    group:group("salty_snacks", 121)
    group:item("sandwich_t", 22)
    group:group("tea_raw_bag_plastic_33", 50)
    group:group("tea_green_raw_bag_plastic_33", 25)
    group:item("cookies", 25)
    group:item("brownie", 25)
    group:item("coffee_raw", 90)
    group:item("ceramic_cup", 10)
    group:item("ceramic_plate", 10)
    group:item("choco_coffee_beans", 60)
    group:item("coffee_syrup", 25)
    group:item("coffee_raw", 25)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "coffee_table", kind = "distribution" }
    group:item("pretzels", 40)
    group:item("chocpretzels", 45)
    group:item("candy", 30)
    group:item("chips", 30)
    group:item("cookies", 45)
    group:item("brownie", 45)
    group:item("restaurantmap", 5)
    group:item("touristmap", 5)
    group:item("fried_seeds", 5)
    group:group("seasoning_salt_various", 20)
    group:group("pepper_various", 20)
    group:item("cinnamon", 10)
    group:item("cup_plastic", 10)
    group:item("ceramic_cup", 80)
    group:item("ceramic_plate", 60)
    group:item("choco_coffee_beans", 40)
    group:item("cig", 39)
    group:item("rolling_paper", 15)
    group:item("wrapper", 25)
    group:item("wrapper_foil", 2)
    group:item("mag_news", 40)
    group:item("news_regional", 35)
    group:item("coffee", 55)
    group:item("atomic_coffee", 10)
    group:item("tea", 35)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bookstore_misc", kind = "distribution" }
    group:entry { item = "paper", count = { 10, 30 }, probability = 150 }
    group:item("wrapper", 25)
    group:item("wrapper_foil", 1)
    group:item("bubblewrap", 25)
    group:item("scissors", 25)
    group:group("roadmap_stock", 10)
    group:item("trailmap", 20)
    group:item("touristmap", 5)
    group:item("restaurantmap", 5)
    group:item("godco_flier", 1)
    group:item("magnifying_glass", 25)
    group:item("glasses_reading", 50)
    group:item("string_6", 25)
    group:entry { item = "candle", charges = { 0, 100 }, probability = 20 }
    group:entry { item = "reading_light", charges = { 0, 100 }, probability = 25 }
    group:item("survnote", 1)
    group:group("writing_utensils", 30)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "arcade_prizes", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("candy_chocolate", 320)
    group:group("soda_in_small_container", 244)
    group:item("bbgun", 30)
    group:item("bb", 30)
    group:item("air_launcher", 5)
    group:item("portable_game", 60)
    group:item("game_watch", 15)
    group:group("decks_of_cards", 25)
    group:item("folded_inflatable_boat", 10)
    group:item("hand_pump", 15)
    group:group("toastem_box_small_8", 135)
    group:group("cookies_box_snack_4", 45)
    group:item("bat", 15)
    group:item("backpack_small", 20)
    group:item("backpack", 10)
    group:item("backpack_denim", 10)
    group:item("hairpin", 10)
    group:item("fc_hairpin", 4)
    group:item("wristwatch", 15)
    group:item("umbrella", 10)
    group:item("teleumbrella", 4)
    group:group("kids_books", 215)
    group:item("novel_pulp", 30)
    group:item("folded_bicycle", 3)
    group:item("sunglasses", 25)
    group:item("cowboy_hat", 25)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 35 }
    group:item("fursuit", 5)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 20 }
    group:item("fursuit", 5, "wolfsuit")
    group:item("fursuit", 5, "dinosuit")
    group:group("chewing_gum_full", 10)
    group:entry { item = "talking_doll", charges = { 0, 100 }, probability = 11 }
    group:item("marble", 15)
    group:item("creepy_doll", 1)
    group:item("jedi_cloak", 5)
    group:entry { item = "glowstick", charges = { 1400, 1400 }, probability = 15 }
    group:item("clown_suit", 5)
    group:item("clownshoes", 5)
    group:entry { item = "inflatable_dragon", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "inflatable_ghost", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "fog_machine", charges = { 0, 56 }, probability = 1 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "bikeshop_tools", kind = "distribution" }
    group:item("wheel_bicycle")
    group:item("tire_bicycle", 70)
    group:item("wheel_rim_bicycle", 80)
    group:item("tire_bicycle_or", 65)
    group:item("deflated_wheel_bicycle", 80)
    group:item("hand_pump")
    group:item("wheel_bicycle", 80)
    group:item("horn_bicycle", 80)
    group:item("foot_crank", 80)
    group:item("saddle", 80)
    group:item("chain", 30)
    group:item("wrench", 30)
    group:item("wrench_small", 10)
    group:item("socket_wrench_set", 20)
    group:item("screwdriver", 40)
    group:item("screwdriver_set", 20)
    group:item("socket_screwdriver_set", 10)
    group:group("glue_weak_professional", 25)
    group:group("glue_strong_professional", 20)
    group:item("hacksaw", 17)
    group:item("pliers", 40)
    group:item("gloves_leather", 45)
    group:item("gloves_work", 45)
    group:item("mask_dust", 15)
    group:item("manual_mechanics", 35)
    group:item("manual_driving", 10)
    group:item("manual_fabrication", 20)
    group:group("duct_tape_roll_part", 70)
    group:item("misc_repairkit", 15)
    group:group("tools_toolbox", 2)
    content.add(group)
end

do
    -- for cs_car_dealership
    local group = content.ItemGroup { id = "oa_ig_cd_lockers", kind = "distribution" }
    group:group("box_of_batteries_random", 10)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 10 }
    group:item("cotton_patchwork", 30)
    group:item("jack", 20)
    group:item("jack_small", 30)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:item("jumper_cable", 20)
    group:item("jumper_cable_heavy", 10)
    group:item("pliers", 10)
    group:item("battery_motorbike", 10)
    group:item("battery_car", 10)
    group:item("stereo", 10)
    group:item("wrench", 10)
    group:item("socket_wrench_set", 5)
    group:item("socket_screwdriver_set", 5)
    group:item("gloves_work", 10)
    group:item("glasses_safety", 10)
    group:item("solar_cell", 10)
    group:item("screwdriver", 15)
    group:group("glue_weak_professional", 5)
    group:group("glue_strong_professional", 5)
    group:item("hand_controls", 1)
    group:entry { item = "polisher", charges = { 0, 100 }, probability = 15 }
    group:item("solar_panel", 15)
    content.add(group)
end

do
    -- for cs_tire_shop
    local group = content.ItemGroup { id = "oa_ig_ts_lockers", kind = "distribution" }
    group:group("box_of_batteries_random", 10)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 10 }
    group:item("cotton_patchwork", 30)
    group:item("jack", 20)
    group:item("jack_small", 30)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:item("jumper_cable", 20)
    group:item("jumper_cable_heavy", 10)
    group:item("pliers", 10)
    group:item("tin_snips", 10)
    group:item("battery_motorbike", 10)
    group:item("battery_car", 10)
    group:item("stereo", 10)
    group:item("wrench", 10)
    group:item("gloves_work", 10)
    group:item("glasses_safety", 10)
    group:item("solar_cell", 10)
    group:item("screwdriver", 15)
    group:group("glue_weak_professional", 5)
    group:group("glue_strong_professional", 5)
    group:entry { item = "polisher", charges = { 0, 100 }, probability = 15 }
    group:item("solar_panel", 15)
    group:item("spare_tire_carrier", 10)
    group:item("mounted_spare_tire", 10)
    content.add(group)
end

do
    -- for cs_tire_shop
    local group = content.ItemGroup { id = "oa_ig_ts_crates", kind = "distribution" }
    group:group("box_of_batteries_unopened", 10)
    group:group("ammo_heavy_batteries_full", 10)
    group:entry { item = "radio", charges = { 0, 100 }, probability = 10 }
    group:item("cotton_patchwork", 30)
    group:item("jack", 20)
    group:item("jack_small", 30)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:item("jumper_cable", 20)
    group:item("jumper_cable_heavy", 10)
    group:item("pliers", 10)
    group:item("tin_snips", 10)
    group:item("battery_motorbike", 10)
    group:item("battery_car", 10)
    group:item("stereo", 10)
    group:item("wrench", 10)
    group:item("gloves_work", 10)
    group:item("glasses_safety", 10)
    group:item("solar_cell", 10)
    group:item("screwdriver", 15)
    group:group("glue_weak_professional", 5)
    group:group("glue_strong_professional", 5)
    group:entry { item = "polisher", charges = { 0, 100 }, probability = 15 }
    group:item("solar_panel", 15)
    group:item("spare_tire_carrier", 10)
    group:item("mounted_spare_tire", 10)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_lights", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:entry { item = "flashlight", charges = { 300, 300 }, probability = 95 }
    group:entry { item = "wearable_light", charges = { 100, 100 }, probability = 65 }
    group:item("floodlight", 10)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_pcs", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:group("new_laptops", 75)
    group:group("new_eink_tablet_pcs", 60)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_persele", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:entry { item = "portable_game", charges = { 100, 100 }, probability = 65 }
    group:group("new_phones", 11)
    group:item("waterproof_smart_phone_case", 40)
    group:entry { item = "mp3", charges = { 100, 100 }, probability = 45 }
    group:group("toy_radio_car", 35)
    group:group("toy_makerspace_kit", 25)
    group:group("toy_robot_kit", 25)
    group:group("toy_engine_kit", 25)
    group:group("sex_accessories_domestic", 10)
    group:item("electric_lighter", 20)
    group:entry { item = "ar_glasses_basic", charges = { 150, 150 }, probability = 20 }
    group:entry { item = "ar_glasses_advanced", charges = { 150, 150 }, probability = 10 }
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_homapl", kind = "distribution" }
    group:item("food_processor", 70)
    group:item("microwave", 65)
    group:item("toaster", 65)
    group:item("mess_kit", 25)
    group:item("hotplate", 30)
    group:item("power_station_portable", 40)
    group:item("hotplate_induction", 3)
    group:item("multi_cooker", 15)
    group:item("coffeemaker", 45)
    group:item("water_purifier", 15)
    group:item("dehydrator", 30)
    group:item("vac_sealer", 45)
    group:item("waffleiron", 45)
    group:item("forge", 5)
    content.add(group)
end

do
    -- For s_electronics shops
    local group = content.ItemGroup { id = "elecsto_displ", kind = "distribution", with_ammo = 75, with_magazine = 100 }
    group:item("television", 50)
    group:group("new_eink_tablet_pcs", 50)
    group:item("stereo", 30)
    group:item("microwave", 40)
    content.add(group)
end
