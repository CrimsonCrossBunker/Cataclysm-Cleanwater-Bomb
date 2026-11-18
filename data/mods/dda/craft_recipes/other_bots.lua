local content = require("ccb").content

local LIGHT_EXERCISE = 2
local BRISK_EXERCISE = 6

content.add(content.Recipe {
    id = "bot_grenade_hack",
    result = "bot_grenade_hack",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("grenade", 1)
    :component("ai_module_basic", 1)
    :component("RAM", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("sensor_module", 1)
    :component("identification_module", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

content.add(content.Recipe {
    id = "bot_gasbomb_hack",
    result = "bot_gasbomb_hack",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("gasbomb", 1)
    :component("ai_module_basic", 1)
    :component("RAM", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("sensor_module", 1)
    :component("identification_module", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

content.add(content.Recipe {
    id = "bot_EMP_hack",
    result = "bot_EMP_hack",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("grenade_emp", 1)
    :component("ai_module_basic", 1)
    :component("RAM", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("sensor_module", 1)
    :component("identification_module", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

content.add(content.Recipe {
    id = "bot_flashbang_hack",
    result = "bot_flashbang_hack",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("flashbang", 1)
    :component("ai_module_basic", 1)
    :component("RAM", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("sensor_module", 1)
    :component("identification_module", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

content.add(content.Recipe {
    id = "bot_c4_hack",
    result = "bot_c4_hack",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 150000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("c4", 1)
    :component("ai_module_basic", 1)
    :component("RAM", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("sensor_module", 1)
    :component("identification_module", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 6)
    :book("textbook_robots", 7)
)

-- 200cm weld
content.add(content.Recipe {
    id = "bot_turret",
    result = "bot_turret",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 2160000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 7,
}
    :component("ai_module", 1)
    :component("identification_module", 1)
    :component("targeting_module", 1)
    :component("gun_module", 1)
    :component_any({
            { id = "camera", count = 1 },
            { id = "camera_pro", count = 1 },
            { id = "omnicamera", count = 1 },
            { id = "sensor_module", count = 1 }
        })
    :component("small_storage_battery", 1)
    :component("power_supply", 1)
    :component("robot_controls", 1)
    :component("hk_mp5", 1)
    :component("mp5mag", 1)
    :component("sheet_metal", 2)
    :component("pipe", 4)
    :component("spring", 2)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("steel_standard", 1)
    :requirement("welding_standard", 200)
    :requirement("soldering_standard", 14)
    :requires_skill("mechanics", 6)
    :requires_skill("computer", 6)
    :requires_skill("fabrication", 6)
    :learn_by_disassembly("electronics", 8)
    :book("recipe_lab_elec", 7)
    :book("textbook_robots", 9)
)

content.add(content.Recipe {
    id = "bot_rifleturret",
    result = "bot_rifleturret",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("ai_module", 1)
    :component("gun_module", 1)
    :component("targeting_module", 1)
    :component("identification_module", 1)
    :component("sensor_module", 1)
    :component("m249", 1)
    :component("small_storage_battery", 1)
    :component("power_supply", 1)
    :component("robot_controls", 1)
    :component("turret_chassis", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 14)
    :requires_skill("mechanics", 6)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 8)
    :book("recipe_lab_elec", 7)
    :book("textbook_robots", 9)
)

content.add(content.Recipe {
    id = "bot_crows_m240",
    result = "bot_crows_m240",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("ai_module", 1)
    :component("gun_module", 1)
    :component("targeting_module", 1)
    :component("identification_module", 1)
    :component("sensor_module", 1)
    :component("m240", 1)
    :component("small_storage_battery", 1)
    :component("power_supply", 1)
    :component("robot_controls", 1)
    :component("turret_chassis", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 14)
    :requires_skill("mechanics", 6)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 8)
    :book("recipe_lab_elec", 7)
    :book("textbook_robots", 9)
)

-- 200cm welding
content.add(content.Recipe {
    id = "bot_nursebot",
    result = "bot_nursebot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 720000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("ai_module_advanced", 1)
    :component("self_monitoring_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("android_legs", 1)
    :component("android_chassis", 1)
    :component("android_arms", 2)
    :component("medium_storage_battery", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_nursebot", 7)
)

-- 200cm welding
content.add(content.Recipe {
    id = "bot_grocerybot",
    result = "bot_grocerybot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 120000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("ai_module", 1)
    :component("self_monitoring_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("android_legs", 1)
    :component("android_chassis", 1)
    :component("android_arms", 1)
    :component("medium_storage_battery", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_grocerybot", 7)
)

-- 200cm weld
content.add(content.Recipe {
    id = "bot_dispatch",
    result = "bot_dispatch",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("tank_tread", 1)
    :component("copbot_chassis", 1)
    :component("targeting_module", 1)
    :component("power_supply", 3)
    :component("plut_cell", 1)
    :component("broken_manhack", 4)
    :component("omnicamera", 1)
    :component("storage_battery", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("steel_standard", 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 7)
    :learn_by_disassembly("electronics", 9)
    :book("schematics_dispatch", 8)
)

-- 200cm weld
content.add(content.Recipe {
    id = "bot_dispatch_military",
    result = "bot_dispatch_military",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 1080000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 8,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("tank_tread", 1)
    :component("copbot_chassis", 1)
    :component("targeting_module", 1)
    :component("power_supply", 3)
    :component("plut_cell", 1)
    :component("broken_manhack", 4)
    :component("omnicamera", 1)
    :component("storage_battery", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :quality("SAW_M", 1, 1)
    :quality("SAW_M_FINE", 1, 1)
    :requirement("steel_standard", 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 7)
    :learn_by_disassembly("electronics", 9)
    :book("schematics_dispatch_military", 8)
)

-- 100cm weld
content.add(content.Recipe {
    id = "bot_hazmatbot",
    result = "bot_hazmatbot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 300000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("self_monitoring_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("omni_wheel", 1)
    :component("medium_storage_battery", 1)
    :component("steel_chunk_any", 6, true)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 100)
    :requires_skill("mechanics", 5)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_hazmatbot", 7)
)

-- 200cm weld
content.add(content.Recipe {
    id = "bot_secubot",
    result = "bot_secubot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 840000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("omni_wheel", 1)
    :component("copbot_chassis", 1)
    :component("gun_module", 1)
    :component("power_supply", 4)
    :component("solar_cell", 2)
    :component("modular_m16a4", 1)
    :component("canister_empty", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_secubot", 7)
)

-- 200cm weld
content.add(content.Recipe {
    id = "bot_talon_m202a1",
    result = "bot_talon_m202a1",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 240000,
    activity_level = BRISK_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("ai_module", 1)
    :component("sensor_module", 1)
    :component("memory_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("omni_wheel", 1)
    :component("copbot_chassis", 1)
    :component("gun_module", 1)
    :component("power_supply", 4)
    :component("solar_cell", 2)
    :component("m202_flash", 1)
    :component("canister_empty", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requirement("welding_standard", 200)
    :requires_skill("mechanics", 7)
    :requires_skill("computer", 6)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_secubot", 7)
)

content.add(content.Recipe {
    id = "bot_skitterbot",
    result = "bot_skitterbot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 180000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("ai_module", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("spidery_legs_small", 1)
    :component("sensor_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("power_supply", 1)
    :component("tazer", 2)
    :component("scrap", 4)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 6)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 5)
    :book("schematics_skitterbot", 7)
)

content.add(content.Recipe {
    id = "bot_science_bot",
    result = "bot_science_bot",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 360000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("ai_module", 1)
    :component("memory_module", 1)
    :component("medium_storage_battery", 1)
    :component("spidery_legs_small", 1)
    :component("sensor_module", 1)
    :component("pathfinding_module", 1)
    :component("identification_module", 1)
    :component("power_supply", 3)
    :component("geiger_off", 1)
    :component("tazer", 2)
    :component("scrap", 6)
    :component("plut_cell", 1)
    :component("steel_chunk_any", 6, true)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 20)
    :requires_skill("mechanics", 6)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 8)
    :book("schematics_sciencebot", 7)
)

content.add(content.Recipe {
    id = "bot_antimateriel",
    result = "bot_antimateriel",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 5,
}
    :component("ai_module", 1)
    :component("identification_module", 1)
    :component("sensor_module", 1)
    :component("gun_module", 1)
    :component("targeting_module", 1)
    :component("m2browning", 1)
    :component("small_storage_battery", 1)
    :component("robot_controls", 1)
    :component("power_supply", 1)
    :component("turret_chassis", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 6)
    :requires_skill("computer", 5)
    :learn_by_disassembly("electronics", 5)
    :book("schematics_antimateriel", 7)
)

content.add(content.Recipe {
    id = "bot_turret_searchlight",
    result = "bot_turret_searchlight",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 450000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 3,
}
    :component("ai_module_basic", 1)
    :component("identification_module", 1)
    :component("sensor_module", 1)
    :component("targeting_module", 1)
    :component("medium_storage_battery", 3)
    :component("power_supply", 1)
    :component("floodlight", 1)
    :component("turret_chassis", 1)
    :quality("SCREW", 1, 1)
    :quality("SCREW_FINE", 1, 1)
    :quality("WRENCH", 2, 1)
    :quality("WRENCH_FINE", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 4)
    :requires_skill("computer", 2)
    :learn_by_disassembly("electronics", 5)
    :book("schematics_searchlight", 7)
)

content.add(content.Recipe {
    id = "bot_tazer_hack",
    result = "bot_tazer_hack",
    category = "CC_*",
    subcategory = "CSC_*_NESTED",
    duration_moves = 300000,
    activity_level = LIGHT_EXERCISE,
    autolearn = false,
    reversible = true,
    skill = "electronics",
    difficulty = 6,
}
    :component("tazer", 1)
    :component("ai_module_basic", 1)
    :component("RAM", 1)
    :component("small_storage_battery", 1)
    :component("scrap", 1)
    :component("quad_rotors", 1)
    :component("sensor_module", 1)
    :component("identification_module", 1)
    :quality("SCREW", 1, 1)
    :requirement("soldering_standard", 10)
    :requires_skill("mechanics", 4)
    :requires_skill("computer", 4)
    :learn_by_disassembly("electronics", 7)
    :book("recipe_lab_elec", 5)
    :book("textbook_robots", 6)
)
