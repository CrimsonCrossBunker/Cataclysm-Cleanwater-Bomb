local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_firestation_0",
    result = "faction_base_firestation_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should survey the base site and set up a bulletin board."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_0",
        name = content.text("basic survey"),
        provides = {
            { id = "gathering" },
            { id = "fbmc_firestation_recipes_1" },
            { id = "fbmc_firestation1_0" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "sorting" },
            { id = "logging" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_kitchen1",
    result = "faction_base_modular_firestation1_kitchen1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should reorganize that dining area into our kitchen."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_kitchen1_cleared",
        name = content.text("prepare the kitchen area"),
        provides = {
            { id = "fbmc_firestation1_kitchen" },
            { id = "tool_storage" },
        },
        requires = {
            { id = "fbmc_firestation1_0" },
        },
        excludes = {
            { id = "fbmc_firestation1_kitchen" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_well",
    result = "faction_base_modular_firestation1_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a well, put it near that winch.  This will make our future here more secure."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_well",
        name = content.text("build a well"),
        provides = {
            { id = "fbmc_firestation1_well" },
            { id = "relaying" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmc_firestation1_0" },
        },
        excludes = {
            { id = "fbmc_firestation1_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_radio",
    result = "faction_base_modular_firestation1_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts, we'll repurpose that terminal for it."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_radio_console",
        name = content.text("build a radio tower and console"),
        provides = {
            { id = "fbmc_firestation1_radio" },
            { id = "recruiting" },
            { id = "radio" },
        },
        requires = {
            { id = "fbmc_firestation1_well" },
        },
        excludes = {
            { id = "fbmc_firestation1_radio" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_kitchen2_pantry",
    result = "faction_base_modular_firestation1_kitchen2_pantry",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should add some storage and a root cellar in our kitchen area."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_kitchen2_storage",
        name = content.text("add storage and root cellar"),
        provides = {
            { id = "fbmc_firestation1_kitchen" },
            { id = "pantry" },
            { id = "sorting" },
        },
        requires = {
            { id = "fbmc_firestation1_kitchen" },
        },
        excludes = {
            { id = "fbmc_firestation1_kitchen", amount = 2 },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_farm",
    result = "faction_base_modular_firestation1_farm",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 8640000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's break up some pavement so we can farm."),
}
    :component("pickaxe", 1)
    :quality("DIG", 1, 1)
    :camp_blueprint {
        update = "fbmc_firestation1_farm",
        name = content.text("break up driveway"),
        provides = {
            { id = "fbmc_firestation1_farm" },
            { id = "farming" },
            { id = "reseeding" },
            { id = "fbmc_firestation_farm_recipes_1" },
        },
        requires = {
            { id = "fbmc_firestation1_kitchen", amount = 2 },
        },
        excludes = {
            { id = "fbmc_firestation1_farm" },
        },
        resources = { "pickaxe" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_fence",
    result = "faction_base_modular_firestation1_fence",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's build a privacy fence around the garden."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_garden_fence1",
        name = content.text("build a privacy fence"),
        provides = {
            { id = "fbmc_firestation1_fence" },
        },
        requires = {
            { id = "fbmc_firestation1_farm" },
        },
        excludes = {
            { id = "fbmc_firestation1_fence" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation_fireplace",
    result = "faction_base_modular_firestation_fireplace",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Now that we have some cover, we should build a fireplace and throw a pot over it to cook with.  Let's put it in that dining area."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_firestation1_fireplace",
        name = content.text("build a fireplace"),
        provides = {
            { id = "fbmc_firestation1_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_firestation_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_firestation1_kitchen", amount = 1 },
        },
        excludes = {
            { id = "fbmc_firestation1_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_brazier",
    result = "faction_base_modular_firestation1_brazier",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 30000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Now that we have some cover, we should set up a brazier and throw a pot over it to cook with.  Let's put it in that dining area."),
}
    :component("brazier", 1)
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_firestation1_brazier",
        name = content.text("build a brazier"),
        provides = {
            { id = "fbmc_firestation1_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_firestation_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_firestation1_kitchen", amount = 1 },
        },
        excludes = {
            { id = "fbmc_firestation1_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_stove",
    result = "faction_base_modular_firestation1_stove",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Now that we have some cover, we should build a stove and throw a pot over it to cook with.  Let's put it in that dining area."),
}
    :component_any({
            { id = "pot", count = 1 },
            { id = "pot_copper", count = 1 },
            { id = "clay_pot", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_firestation1_stove",
        name = content.text("build a wood stove"),
        provides = {
            { id = "fbmc_firestation1_fire" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "fbmc_firestation_cooking_recipes_1" },
        },
        requires = {
            { id = "fbmc_firestation1_kitchen", amount = 1 },
        },
        excludes = {
            { id = "fbmc_firestation1_fire" },
        },
        resources = { "fake_fireplace", "pot" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_smoking",
    result = "faction_base_modular_firestation1_smoking",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build some smokers and a charcoal kiln for food preservation."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_smoking_kiln",
        name = content.text("build smoking racks and charcoal kiln"),
        provides = {
            { id = "fbmc_firestation1_smoking" },
            { id = "fbmc_firestation_cooking_recipes_2" },
        },
        requires = {
            { id = "fbmc_firestation1_fire" },
        },
        excludes = {
            { id = "fbmc_firestation1_smoking" },
        },
        resources = { "fake_char_smoker", "fake_char_kiln" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_butchery",
    result = "faction_base_modular_firestation1_butchery",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's make a butchery area."),
}
    :component_any({
            { id = "knife_huge", count = 1 },
            { id = "knife_small", count = 1 },
            { id = "knife_large", count = 2 }
        })
    :camp_blueprint {
        update = "fbmc_firestation1_butchery_rack",
        name = content.text("build butchery area"),
        provides = {
            { id = "fbmc_firestation1_butchery" },
            { id = "fbmc_firestation_cooking_recipes_3" },
            { id = "trapping" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmc_firestation1_smoking" },
        },
        excludes = {
            { id = "fbmc_firestation1_butchery" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_vat",
    result = "faction_base_modular_firestation1_vat",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's add a vat for fermenting."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_fermenting_vat",
        name = content.text("build fermenting vats"),
        provides = {
            { id = "fbmc_firestation1_vat" },
            { id = "fermenting" },
        },
        requires = {
            { id = "fbmc_firestation1_butchery" },
        },
        excludes = {
            { id = "fbmc_firestation1_vat" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_garage1.",
    result = "faction_base_modular_firestation1_garage1.",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's gather some tools so we can work on cars."),
}
    :component("wrench", 1)
    :component("hacksaw", 1)
    :component("pliers", 1)
    :component("hammer", 1)
    :component("screwdriver", 1)
    :component("manual_mechanics", 1)
    :camp_blueprint {
        update = "fbmc_firestation1_garage_area",
        name = content.text("add tools for garage"),
        provides = {
            { id = "fbmc_firestation1_garage" },
            { id = "dismantling" },
        },
        requires = {
            { id = "fbmc_firestation1_0" },
        },
        excludes = {
            { id = "fbmc_firestation1_garage" },
        },
        resources = { "wrench", "hacksaw", "pliers", "hammer", "screwdriver" },
        needs = {
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_living_area2",
    result = "faction_base_modular_firestation1_living_area2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southwest bedroom."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_bedroom_sw",
        name = content.text("furnish the SW bedroom"),
        provides = {
            { id = "fbmc_firestation1_bedroom_sw" },
        },
        requires = {
            { id = "fbmc_firestation1_quarters" },
        },
        excludes = {
            { id = "fbmc_firestation1_bedroom_sw" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_living_area3",
    result = "faction_base_modular_firestation1_living_area3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the northwest bedroom."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_bedroom_nw",
        name = content.text("furnish the NW bedroom"),
        provides = {
            { id = "fbmc_firestation1_bedroom_nw" },
        },
        requires = {
            { id = "fbmc_firestation1_quarters" },
        },
        excludes = {
            { id = "fbmc_firestation1_bedroom_nw" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_living_area4",
    result = "faction_base_modular_firestation1_living_area4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the southeast bedroom."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_bedroom_se",
        name = content.text("furnish the SE bedroom"),
        provides = {
            { id = "fbmc_firestation1_bedroom_se" },
        },
        requires = {
            { id = "fbmc_firestation1_quarters" },
        },
        excludes = {
            { id = "fbmc_firestation1_bedroom_se" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_living_area5",
    result = "faction_base_modular_firestation1_living_area5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the northeast bedroom."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_bedroom_ne",
        name = content.text("furnish the NE bedroom"),
        provides = {
            { id = "fbmc_firestation1_bedroom_ne" },
        },
        requires = {
            { id = "fbmc_firestation1_quarters" },
        },
        excludes = {
            { id = "fbmc_firestation1_bedroom_ne" },
        },
        parameter_labels = {
            ["fbmc_bed_palette"] = {
                ["fbmc_straw_bed_palette"] = content.text("Straw bed"),
                ["fbmc_makeshift_bed_palette"] = content.text("Makeshift bed"),
                ["fbmc_bed_palette"] = content.text("Bed"),
            },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_living_area6",
    result = "faction_base_modular_firestation1_living_area6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's furnish the common area."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_quarters_common",
        name = content.text("furnish the common area furniture"),
        provides = {
            { id = "fbmc_firestation1_quarters_common" },
        },
        requires = {
            { id = "fbmc_firestation1_quarters" },
        },
        excludes = {
            { id = "fbmc_firestation1_quarters_common" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_forge",
    result = "faction_base_modular_firestation1_forge",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build a fabrication workshop."),
}
    :component("hammer", 1)
    :camp_blueprint {
        update = "fbmc_firestation1_forge",
        name = content.text("build a metalworking forge"),
        provides = {
            { id = "fbmc_firestation1_forge" },
            { id = "fbmc_firestation_blacksmith_recipes_1" },
        },
        requires = {
            { id = "fbmc_firestation1_smoking" },
        },
        excludes = {
            { id = "fbmc_firestation1_forge" },
        },
        resources = { "fake_forge", "hammer" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_anvil",
    result = "faction_base_modular_firestation1_anvil",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build an anvil and crucible to increase our crafting options."),
}
    :component("anvil_crude", 1)
    :component_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_firestation1_forge2",
        name = content.text("add an anvil and crucible"),
        provides = {
            { id = "fbmc_firestation1_anvil" },
            { id = "fbmc_firestation_blacksmith_recipes_2" },
        },
        requires = {
            { id = "fbmc_firestation1_forge" },
        },
        excludes = {
            { id = "fbmc_firestation1_anvil" },
        },
        resources = { "anvil_crude", "crucible" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_pottery",
    result = "faction_base_modular_firestation1_pottery",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build pottery kiln and get the tools we'll need for glassworking."),
}
    :component("glassblowing_book", 1)
    :component_any({
            { id = "glasses_safety", count = 1 },
            { id = "goggles_chem", count = 1 }
        })
    :component("chemistry_set", 1)
    :component("pipe", 1)
    :camp_blueprint {
        update = "fbmc_firestation1_forge3",
        name = content.text("build a pottery kiln"),
        provides = {
            { id = "fbmc_firestation1_pottery" },
            { id = "fbmc_firestation_blacksmith_recipes_3" },
        },
        requires = {
            { id = "fbmc_firestation1_anvil" },
        },
        excludes = {
            { id = "fbmc_firestation1_pottery" },
        },
        resources = { "anvil_crude", "crucible" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_forgetools",
    result = "faction_base_modular_firestation1_forgetools",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 120000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We need some tools for metal working."),
}
    :component("metalworking_tongs", 1)
    :component("chisel", 1)
    :component("swage", 1)
    :camp_blueprint {
        update = "fbmc_firestation1_forge4",
        name = content.text("place advanced tools"),
        provides = {
            { id = "fbmc_firestation1_tools" },
            { id = "fbmc_firestation_blacksmith_recipes_4" },
        },
        requires = {
            { id = "fbmc_firestation1_pottery" },
        },
        excludes = {
            { id = "fbmc_firestation1_tools" },
        },
        resources = { "metalworking_tongs", "chisel", "hammer", "swage" },
        needs = {
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_workbench",
    result = "faction_base_modular_firestation1_workbench",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's get a nice workbench built to improve our work.  Place it next to the anvil."),
}
    :camp_blueprint {
        update = "fbmc_firestation1_workbench",
        name = content.text("build a workbench"),
        provides = {
            { id = "fbmc_firestation1_workbench" },
            { id = "fbmc_firestation_blacksmith_recipes_5" },
        },
        requires = {
            { id = "fbmc_firestation1_tools" },
        },
        excludes = {
            { id = "fbmc_firestation1_workbench" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_bellows",
    result = "faction_base_modular_firestation1_bellows",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's add a bellows and barrel for quenching the steel, we'll need more tools too."),
}
    :component("hammer_sledge", 1)
    :component("30gal_drum", 1)
    :component_any({
            { id = "knife_combat", count = 1 },
            { id = "copper_knife", count = 1 }
        })
    :camp_blueprint {
        update = "fbmc_firestation1_bellows",
        name = content.text("build a bellows and barrel"),
        provides = {
            { id = "fbmc_firestation1_bellows" },
            { id = "fbmc_firestation_blacksmith_recipes_6" },
        },
        requires = {
            { id = "fbmc_firestation1_workbench" },
        },
        excludes = {
            { id = "fbmc_firestation1_bellows" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_firestation1_drophammer",
    result = "faction_base_modular_firestation1_drophammer",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Let's build a drop hammer for some mass production."),
}
    :component("wrench", 1)
    :component("pliers", 1)
    :camp_blueprint {
        update = "fbmc_firestation1_drophammer",
        name = content.text("build a drop hammer."),
        provides = {
            { id = "fbmc_firestation1_drophammer" },
            { id = "fbmc_firestation_blacksmith_recipes_7" },
        },
        requires = {
            { id = "fbmc_firestation1_bellows" },
        },
        excludes = {
            { id = "fbmc_firestation1_drophammer" },
        },
        resources = { "wrench", "pliers", "fake_drop_hammer" },
    }
)
