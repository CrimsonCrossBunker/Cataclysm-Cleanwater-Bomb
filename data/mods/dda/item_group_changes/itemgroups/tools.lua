local content = require("ccb").content

do
    -- Common household tools that are small enough to fit in a bag
    local group = content.ItemGroup { id = "tools_common_small", kind = "collection" }
    group:item("hacksaw", 50)
    group:item("hammer", 80)
    group:entry {
        distribution = {
            { item = "pliers", probability = 60 },
            { item = "pliers_locking", probability = 20 },
            { item = "big_pliers", probability = 2 },
        },
        probability = 40,
    }
    group:entry {
        distribution = {
            { item = "screwdriver", probability = 80 },
            { item = "screwdriver_set", probability = 50 },
            { item = "socket_screwdriver_set", probability = 10 },
        },
        probability = 80,
    }
    group:entry {
        distribution = {
            { group = "duct_tape_roll_part", probability = 10 },
            { group = "glue_weak_domestic", probability = 5 },
            { group = "glue_strong_domestic", probability = 5 },
        },
        probability = 10,
    }
    group:item("tin_snips", 10)
    group:entry {
        distribution = {
            { item = "wrench", probability = 20 },
            { item = "wrench_small", probability = 20 },
            { item = "socket_wrench_set", probability = 20 },
        },
        probability = 20,
    }
    group:item("hand_pump", 10)
    group:item("xacto", 40)
    group:entry {
        distribution = {
            { item = "jumper_cable", probability = 5 },
            { item = "extension_cable", probability = 15 },
            { item = "jumper_cable_heavy", probability = 2 },
        },
        probability = 15,
    }
    group:item("hd_tow_cable", 5)
    group:entry {
        distribution = {
            { item = "claw_bar", probability = 5 },
            { item = "crowbar", probability = 15 },
        },
        probability = 15,
    }
    group:item("thermometer", 5)
    group:item("multitool", 10)
    group:item("recharge_station", 10)
    group:group("graphite_small_bottle_part", 10)
    group:item("metal_file", 10)
    group:item("clamp", 10)
    group:item("sandpaper", 80)
    group:group("writing_utensils", 5)
    group:group("soldering_supplies", 50)
    group:item("tape_measure", 40)
    content.add(group)
end

do
    -- Gear that hunters take on hunting trips.
    local group = content.ItemGroup { id = "tools_hunting", kind = "collection" }
    group:item("binoculars", 15)
    group:item("canteen", 25)
    group:item("e_tool", 20)
    group:entry {
        distribution = {
            { item = "flashlight", charges = { 0, 300 }, probability = 20 },
            { item = "heavy_flashlight", charges = { 0, 300 }, probability = 15 },
        },
        probability = 20,
    }
    group:entry {
        distribution = {
            { item = "goggles_nv", charges = { 0, 100 }, probability = 5 },
            { item = "goggles_ir", charges = { 0, 100 }, probability = 2 },
        },
        probability = 2,
    }
    group:entry {
        distribution = {
            { item = "gaiter_boot", probability = 5 },
            { item = "gaiter_boot_heavy", probability = 5 },
        },
        probability = 5,
    }
    group:item("hand_crank_charger", 15)
    group:entry { item = "handflare", charges = { 300, 300 }, probability = 20 }
    group:item("hatchet", 10)
    group:item("tourist_table", 1)
    group:item("storage_line", 5)
    group:entry {
        distribution = {
            { item = "knife_hunting", probability = 10 },
            { group = "knife_rambo_cont", probability = 10 },
        },
        probability = 25,
    }
    group:item("mess_kit", 20)
    group:item("multitool", 10)
    group:entry {
        distribution = {
            { item = "pockknife", probability = 30 },
            { item = "knife_folding", probability = 25 },
            { item = "utility_knife_folding", probability = 2 },
            { item = "knife_swissarmy", probability = 10 },
        },
        probability = 25,
    }
    group:group("pur_tablets_bottle_plastic_small_1_50", 10)
    group:entry {
        distribution = {
            { item = "ref_lighter", charges = { 0, 50 }, probability = 20 },
            { item = "flint_steel", probability = 10 },
            { item = "tinderbox", charges = { 0, 100 }, probability = 5 },
        },
        probability = 30,
    }
    group:item("rope_30", 20)
    group:item("lifestraw", 4)
    group:item("chem_hexamine", 10)
    group:item("light_snare_kit", 8)
    group:entry { item = "esbit_stove", charges = { 0, 50 }, probability = 15 }
    group:entry { item = "teargas_sprayer", charges = { 10, 10 }, probability = 15 }
    group:group("book_mag_surv", 10)
    group:group("vfw_books", 20)
    group:item("camping_multitool", 2)
    content.add(group)
end

do
    -- Portable medical equipment for doctors and paramedics (excludes consumables)
    local group = content.ItemGroup { id = "tools_medical", kind = "collection" }
    group:item("scalpel", 50)
    group:item("scissors_medical")
    group:item("stethoscope", 50)
    group:item("syringe", 50)
    group:item("thermometer", 50)
    group:item("vacutainer", 50)
    content.add(group)
end

do
    -- tools and equipment you might find on robotics laboratories, like LIXA or Hub01
    local group = content.ItemGroup { id = "tools_robotics", kind = "collection" }
    group:item("recipe_lab_elec", 4)
    group:entry { item = "UPS_OFF", charges = { 0, 1000 }, probability = 6 }
    group:item("file", 10)
    group:entry { item = "smart_lamp", charges = { 0, 100 }, probability = 2 }
    group:item("bot_grenade_hack", 2)
    group:entry {
        group = "used_laptops",
        contents = {
            { group = "efiles_science" },
        },
        probability = 4,
    }
    group:entry { item = "plut_cell", charges = { 1, 5 }, probability = 4 }
    group:group("glue_weak_domestic", 15)
    group:group("glue_strong_domestic", 15)
    group:group("graphite_small_bottle_part", 30)
    group:item("pliers", 10)
    group:item("tin_snips", 10)
    group:entry { item = "matches", charges = { 1, 20 }, probability = 10 }
    group:item("glasses_safety", 20)
    group:item("vac_mold", 10)
    group:item("polycarbonate_sheet", 50)
    group:group("duct_tape_roll_part", 8)
    group:item("misc_repairkit", 15)
    group:item("welder", 10)
    group:group("papr_kit", 5)
    group:item("welding_papr_helmet", 5)
    group:entry { item = "welding_blanket", count = { 0, 1 }, probability = 10 }
    group:entry {
        distribution = {
            {
                item = "welding_rod_steel",
                charges = { 1000, 1600 },
                wrapper = "tube_welding_rod",
                probability = 10,
            },
            {
                item = "welding_rod_alloy",
                charges = { 1000, 1600 },
                wrapper = "tube_welding_rod",
                probability = 5,
            },
            {
                item = "welding_wire_steel",
                charges = { 1000, 1600 },
                wrapper = "spool_welding",
                probability = 20,
            },
            {
                item = "welding_wire_alloy",
                charges = { 1000, 1600 },
                wrapper = "spool_welding",
                probability = 20,
            },
            {
                item = "brazing_rod_bronze",
                charges = { 500, 1500 },
                wrapper = "tube_welding_rod",
                probability = 3,
            },
            {
                item = "brazing_rod_alloy",
                charges = { 400, 1200 },
                wrapper = "tube_welding_rod",
                probability = 2,
            },
        },
    }
    group:item("soldering_iron", 8)
    group:entry { item = "soldering_iron_portable", charges = { 0, 50 }, probability = 8 }
    group:entry { item = "extinguisher", charges = { 100, 100 }, probability = 10 }
    group:item("magnifying_glass", 10)
    group:item("multitool", 20)
    group:item("vac_mold", 2)
    group:item("screwdriver_set", 20)
    group:item("dremel", 40)
    group:item("socket_screwdriver_set", 20)
    group:entry { item = "flashlight", charges = { 0, 300 }, probability = 20 }
    group:item("memory_card_science", 40)
    group:entry {
        distribution = {
            { item = "camera_pro", charges = { 0, 150 }, probability = 1 },
            { item = "camera_pro", charges = { 0, 150 }, container = "camera_bag", probability = 1 },
        },
        probability = 1,
    }
    group:item("element", 5)
    group:group("batteries")
    group:item("goggles_welding", 20)
    group:entry { item = "sm_extinguisher", charges = { 10, 10 }, probability = 10 }
    group:group("tools_toolbox", 5)
    group:item("tool_belt", 10)
    group:item("clamp", 10)
    group:item("wrench", 10)
    group:item("socket_wrench_set", 10)
    group:item("bench_vise", 15)
    group:group("writing_utensils", 5)
    content.add(group)
end
