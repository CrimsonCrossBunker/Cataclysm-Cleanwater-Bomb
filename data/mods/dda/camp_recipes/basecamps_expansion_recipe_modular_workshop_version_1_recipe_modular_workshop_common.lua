local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_workshop_0",
    result = "faction_base_workshop_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("Survey land for a workshop."),
}
    :camp_blueprint {
        update = "faction_base_workshop_0",
        name = content.text("workshop survey"),
        provides = {
            { id = "fbmw_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room1_common_northeast",
    result = "faction_base_modular_workshop_room1_common_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's install a metal working forge and a charcoal kiln.  We'll need a few tools too, so we'll include some storage space."),
}
    :component_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :component_any({
            { id = "primitive_hammer", count = 1 },
            { id = "makeshift_hammer", count = 1 }
        })
    :camp_blueprint {
        update = "fbmw_room1_common_northeast",
        name = content.text("forge and kiln"),
        provides = {
            { id = "fbmw_northeast" },
            { id = "blacksmith" },
            { id = "blacksmith_recipes_1" },
        },
        requires = {
            { id = "fbmw_northeast" },
        },
        excludes = {
            { id = "fbmw_northeast", amount = 2 },
        },
        resources = { "fake_forge", "fake_char_kiln", "crucible", "makeshift_hammer" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room2_common_northeast",
    result = "faction_base_modular_workshop_room2_common_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's install an anvil, some quenching containers and a workbench."),
}
    :component("55gal_drum", 1)
    :component("30gal_drum", 1)
    :camp_blueprint {
        update = "fbmw_room2_common_northeast",
        name = content.text("anvil and workbench"),
        provides = {
            { id = "fbmw_northeast" },
            { id = "blacksmith_recipes_2" },
        },
        requires = {
            { id = "fbmw_northeast", amount = 2 },
        },
        excludes = {
            { id = "fbmw_northeast", amount = 3 },
        },
        resources = { "anvil_crude" },
    }
)

content.add(content.Recipe {
    id = "faction_base_modular_workshop_room10_common_northeast",
    result = "faction_base_modular_workshop_room10_common_northeast",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's install a bellows for our forge and add some more tools."),
}
    :component("hammer_sledge", 1)
    :component_any({
            { id = "knife_combat", count = 1 },
            { id = "copper_knife", count = 1 }
        })
    :camp_blueprint {
        update = "fbmw_room10_common_northeast",
        name = content.text("bellows"),
        provides = {
            { id = "fbmw_northeast" },
            { id = "blacksmith_recipes_6" },
        },
        requires = {
            { id = "fbmw_northeast", amount = 3 },
            { id = "fbmw_northwest" },
        },
        excludes = {
            { id = "fbmw_northeast", amount = 4 },
        },
        resources = { "hammer_sledge", "copper_knife" },
    }
)
