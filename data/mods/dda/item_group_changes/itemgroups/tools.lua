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
