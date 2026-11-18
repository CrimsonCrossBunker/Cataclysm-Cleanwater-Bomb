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
