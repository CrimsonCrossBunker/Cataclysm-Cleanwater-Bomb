local content = require("ccb").content

do
    local group = content.ItemGroup { id = "new_laptops", kind = "distribution" }
    group:entry { item = "laptop", charges = { 200, 200 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "used_laptops", kind = "distribution" }
    group:entry { item = "laptop", charges = { 0, -1 } }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "civilian_laptops", kind = "distribution" }
    group:entry {
        item = "laptop",
        charges = { 0, -1 },
        contents = {
            { group = "civilian_laptop_efiles" },
        },
    }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "electronics", kind = "distribution" }
    group:item("breadboard", 60)
    group:item("voltmeter", 30)
    group:entry { item = "multimeter", charges = { 0, 100 }, probability = 30 }
    group:item("jumper_cable_heavy", 10)
    group:group("glue_weak_domestic", 15)
    group:group("glue_strong_domestic", 15)
    group:entry { item = "electrohack", charges = { 0, 100 }, probability = 3 }
    group:item("processor", 15)
    group:item("RAM", 22)
    group:item("power_supply", 16)
    group:item("amplifier", 8)
    group:item("transponder", 5)
    group:item("receiver", 10)
    group:item("antenna", 18)
    group:item("solar_cell", 5)
    group:item("compressor", 5)
    group:item("screwdriver", 40)
    group:item("dremel", 40)
    group:item("screwdriver_set", 40)
    group:item("mask_dust", 65)
    group:item("glasses_safety", 40)
    group:item("goggles_welding", 70)
    group:group("box_of_batteries_random", 30)
    group:group("ammo_heavy_batteries_full", 20)
    group:item("manual_electronics", 20)
    group:item("textbook_electronics", 6)
    group:item("radio_book", 16)
    group:item("advanced_electronics", 6)
    group:item("ic_reference_electronics", 2)
    group:item("small_lcd_screen", 20)
    group:item("laptop_hard_case", 5)
    group:item("polycarbonate_sheet", 39)
    group:item("battery_ups", 15)
    group:group("new_phones", 31)
    group:item("waterproof_smart_phone_case", 11)
    group:group("new_eink_tablet_pcs", 8)
    group:group("new_laptops", 20)
    group:group("new_memory_cards", 20)
    group:entry { item = "smart_lamp", charges = { 0, 100 }, probability = 5 }
    group:entry { item = "camera", charges = { 0, 150 }, probability = 5 }
    group:entry { item = "camera_pro", charges = { 0, 150 }, probability = 2 }
    group:group("cable_roll", 30)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 70 }
    group:item("soldering_iron", 70)
    group:group("solder_wire_spool_part", 70)
    group:item("hotplate", 10)
    group:item("hotplate_induction", 3)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 5 }
    group:group("new_usb_drives", 15)
    group:entry {
        group = "used_usb_drives",
        contents = {
            { item = "software_useless" },
        },
        probability = 10,
    }
    group:item("vac_sealer", 10)
    group:group("toy_radio_car", 3)
    group:group("toy_makerspace_kit", 1)
    group:group("toy_robot_kit", 1)
    group:group("toy_engine_kit", 1)
    group:entry { item = "radiocontrol", charges = { 0, 50 }, probability = 25 }
    group:item("omnicamera", 7)
    group:item("chem_nitric_acid", 1)
    group:item("folding_solar_panel_v2", 10)
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "consumer_electronics", kind = "distribution", with_ammo = 25, with_magazine = 100 }
    group:item("extension_cable", 95)
    group:item("long_extension_cable", 75)
    group:item("amplifier", 8)
    group:item("mag_electronics", 15)
    group:item("antenna", 18)
    group:group("box_of_batteries_random", 50)
    group:item("breadboard", 50)
    group:item("laptop_hard_case", 5)
    group:item("voltmeter", 10)
    group:entry { item = "multimeter", charges = { 0, 100 }, probability = 10 }
    group:item("soldering_iron", 70)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 70 }
    group:group("solder_wire_spool_part", 70)
    group:item("solar_cell", 5)
    group:item("screwdriver", 40)
    group:item("screwdriver_set", 40)
    group:item("processor", 15)
    group:item("RAM", 22)
    group:entry { item = "mp3", charges = { 0, 100 }, probability = 6 }
    group:entry { item = "portable_game", charges = { 0, 100 }, probability = 12 }
    group:entry { item = "game_watch", charges = { 0, 50 }, probability = 3 }
    group:group("sex_accessories_domestic", 10)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 40 }
    group:entry { item = "heavy_flashlight", charges = { 0, 300 }, probability = 10 }
    group:entry { item = "radio", charges = { 0, 100 }, probability = 20 }
    group:item("mess_kit", 5)
    group:item("hotplate", 10)
    group:item("hotplate_induction", 4)
    group:item("coffeemaker", 10)
    group:item("receiver", 10)
    group:item("transponder", 5)
    group:entry { item = "tazer", charges = { 0, 500 }, probability = 3 }
    group:item("manual_electronics", 20)
    group:item("recipe_augs", 4)
    group:group("cable_roll", 60)
    group:item("vac_sealer", 10)
    group:group("new_phones", 50)
    group:group("new_eink_tablet_pcs", 15)
    group:group("new_laptops", 30)
    group:group("new_usb_drives", 5)
    group:group("new_memory_cards", 40)
    group:entry { item = "smart_lamp", charges = { 0, 100 }, probability = 10 }
    group:entry { item = "camera", charges = { 0, 150 }, probability = 15 }
    group:entry { item = "camera_pro", charges = { 0, 150 }, probability = 5 }
    group:item("wristwatch", 15)
    group:group("toy_radio_car", 3)
    group:group("toy_makerspace_kit", 1)
    group:group("toy_robot_kit", 1)
    group:group("toy_engine_kit", 1)
    group:entry { item = "radiocontrol", charges = { 0, 100 }, probability = 15 }
    group:item("magnifying_glass", 4)
    group:item("omnicamera", 2)
    group:entry { item = "mobile_weather_station", charges = { 0, 1000 }, probability = 2 }
    group:entry { item = "reading_light", charges = { 0, 100 }, probability = 6 }
    group:entry { item = "inflatable_dragon", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "inflatable_ghost", charges = { 0, 56 }, probability = 1 }
    group:entry { item = "fog_machine", charges = { 0, 56 }, probability = 1 }
    content.upsert_item_group(group)
end

do
    local group = content.ItemGroup { id = "box_of_batteries_random", kind = "distribution", container = "box_paper_small" }
    group:entry { item = "light_minus_battery_cell", count = { 2, 8 }, charges = { 1000, 1000 }, probability = 3 }
    group:entry { item = "light_minus_disposable_cell", count = { 2, 8 }, charges = { 1000, 1000 }, probability = 30 }
    group:entry { item = "light_battery_cell", count = { 0, 8 }, charges = { 1000, 1000 }, probability = 160 }
    group:entry { item = "light_battery_cell", count = { 0, 16 }, charges = { 1000, 1000 }, probability = 16 }
    group:entry { item = "light_cell_rechargeable", count = { 0, 8 }, charges = { 1000, 1000 }, probability = 16 }
    group:entry { item = "light_cell_rechargeable", count = { 0, 12 }, charges = { 1000, 1000 }, probability = 1 }
    group:entry { item = "medium_battery_cell", count = { 0, 4 }, charges = { 1000, 1000 }, probability = 15 }
    content.upsert_item_group(group)
end
