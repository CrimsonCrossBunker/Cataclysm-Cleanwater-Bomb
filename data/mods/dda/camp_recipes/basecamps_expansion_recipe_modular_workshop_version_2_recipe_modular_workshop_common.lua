local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_workshop_2_0",
    result = "faction_base_workshop_2_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Survey land for a workshop area."),
}
    :camp_blueprint {
        update = "faction_base_workshop_2_0",
        name = content.text("workshop survey"),
        provides = {
            { id = "fbmw_2" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_1",
    result = "fbmw_2_common_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install a metal working forge in the smithy.  We'll need a few tools too, so we'll include some storage space.  This will provide us with a first couple of primitive crafting recipes."),
}
    :component_any({
            { id = "primitive_hammer", count = 1 },
            { id = "makeshift_hammer", count = 1 },
            { id = "hammer", count = 1 }
        })
    :camp_blueprint {
        update = "fbmw_2_common_smithy_1",
        name = content.text("forge"),
        provides = {
            { id = "fbmw_2_common_smithy_1" },
            { id = "blacksmith" },
            { id = "fbmw_2_blacksmith_recipes_1" },
        },
        requires = {
            { id = "fbmw_2_smithy_1" },
        },
        excludes = {
            { id = "fbmw_2_common_smithy_1" },
        },
        resources = { "fake_forge", "fake_fireplace", "makeshift_hammer" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_smithy_2",
    result = "fbmw_2_common_smithy_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install a couple of charcoal kilns outside of the smithy.  We'll add a crucible as well.  This will allow us to produce a few additional things."),
}
    :component_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :camp_blueprint {
        update = "fbmw_2_common_smithy_2",
        name = content.text("forge"),
        provides = {
            { id = "fbmw_2_common_smithy_2" },
            { id = "fbmw_2_blacksmith_recipes_2" },
        },
        requires = {
            { id = "fbmw_2_smithy_2" },
            { id = "fbmw_2_common_smithy_1" },
        },
        excludes = {
            { id = "fbmw_2_common_smithy_2" },
        },
        resources = { "fake_char_kiln", "fake_char_kiln", "crucible" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_smithy_3",
    result = "fbmw_2_common_smithy_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install an anvil in the smithy, some quenching containers and a workbench.  This will allow us to produce a few additional things."),
}
    :component("55gal_drum", 1)
    :component("30gal_drum", 1)
    :camp_blueprint {
        update = "fbmw_2_common_smithy_3",
        name = content.text("anvil and workbench"),
        provides = {
            { id = "fbmw_2_common_smithy_3" },
            { id = "fbmw_2_blacksmith_recipes_3" },
        },
        requires = {
            { id = "fbmw_2_common_smithy_2" },
        },
        excludes = {
            { id = "fbmw_2_common_smithy_3" },
        },
        resources = { "anvil_crude" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_smithy_4",
    result = "fbmw_2_common_smithy_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's add furniture and some more tools to the smithy.  This will allow us to produce a few additional things."),
}
    :component("metalworking_tongs", 1)
    :component("chisel", 1)
    :component("hammer", 1)
    :component("swage", 1)
    :camp_blueprint {
        update = "fbmw_2_common_smithy_4",
        name = content.text("smithing tools"),
        provides = {
            { id = "fbmw_2_common_smithy_4" },
            { id = "fbmw_2_blacksmith_recipes_4" },
        },
        requires = {
            { id = "fbmw_2_common_smithy_3" },
            { id = "fbmw_2_smithy_3" },
        },
        excludes = {
            { id = "fbmw_2_common_smithy_4" },
        },
        resources = { "metalworking_tongs", "chisel", "hammer", "swage" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_smithy_5",
    result = "fbmw_2_common_smithy_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's install a bellows for our forge and add some more tools.  This will extend our recipe repertoire."),
}
    :component("hammer_sledge", 1)
    :component_any({
            { id = "knife_combat", count = 1 },
            { id = "copper_knife", count = 1 }
        })
    :camp_blueprint {
        update = "fbmw_2_common_smithy_5",
        name = content.text("bellows"),
        provides = {
            { id = "fbmw_2_common_smithy_5" },
            { id = "fbmw_2_blacksmith_recipes_5" },
        },
        requires = {
            { id = "fbmw_2_common_smithy_4" },
        },
        excludes = {
            { id = "fbmw_2_common_smithy_5" },
        },
        resources = { "hammer_sledge", "copper_knife" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_smithy_6",
    result = "fbmw_2_common_smithy_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's add a drop hammer to the smithy for productivity and add some more tools.  This will allow us to reach our smithing potential."),
}
    :component("wrench", 1)
    :component("pliers", 1)
    :camp_blueprint {
        update = "fbmw_2_common_smithy_6",
        name = content.text("drop hammer"),
        provides = {
            { id = "fbmw_2_common_smithy_6" },
            { id = "fbmw_2_blacksmith_recipes_6" },
        },
        requires = {
            { id = "fbmw_2_common_smithy_5" },
        },
        excludes = {
            { id = "fbmw_2_common_smithy_6" },
        },
        resources = { "wrench", "pliers", "fake_drop_hammer" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_pottery",
    result = "fbmw_2_common_pottery",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's build a kiln in the pottery to allow us to make a clay crucible."),
}
    :camp_blueprint {
        update = "fbmw_2_common_pottery",
        name = content.text("pottery kiln"),
        provides = {
            { id = "fbmw_2_common_pottery" },
            { id = "blacksmith" },
            { id = "fbmw_2_potter_recipes_0" },
        },
        requires = {
            { id = "fbmw_2_pottery" },
        },
        excludes = {
            { id = "fbmw_2_common_pottery" },
        },
        resources = { "fake_clay_kiln" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_pottery_1",
    result = "fbmw_2_common_pottery_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's furnish the pottery."),
}
    :camp_blueprint {
        update = "fbmw_2_common_pottery_1",
        name = content.text("pottery furniture"),
        provides = {
            { id = "fbmw_2_common_pottery_1" },
            { id = "fbmw_2_potter_recipes_1" },
        },
        requires = {
            { id = "fbmw_2_common_pottery" },
        },
        excludes = {
            { id = "fbmw_2_common_pottery_1" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_glassblower",
    result = "fbmw_2_common_glassblower",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's furnish the glassblower's cottage."),
}
    :component("chisel", 1)
    :component("metalworking_tongs", 1)
    :component_any({
            { id = "crucible", count = 1 },
            { id = "crucible_clay", count = 1 }
        })
    :camp_blueprint {
        update = "fbmw_2_common_glassblower",
        name = content.text("glassblower furniture"),
        provides = {
            { id = "fbmw_2_common_glassblower" },
            { id = "blacksmith" },
            { id = "fbmw_2_glassblower_recipes_1" },
        },
        requires = {
            { id = "fbmw_2_glassblower" },
        },
        excludes = {
            { id = "fbmw_2_common_glassblower" },
        },
        resources = { "fake_forge", "chisel", "metalworking_tongs", "crucible" },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_tanner",
    result = "fbmw_2_common_tanner",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's furnish the tannery."),
}
    :camp_blueprint {
        update = "fbmw_2_common_tanner",
        name = content.text("tanner furniture"),
        provides = {
            { id = "fbmw_2_common_tanner" },
            { id = "blacksmith" },
            { id = "fbmw_2_recipes_salt_water" },
        },
        requires = {
            { id = "fbmw_2_tanner" },
        },
        excludes = {
            { id = "fbmw_2_common_tanner" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_common_recreation",
    result = "fbmw_2_common_recreation",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Let's add a bench and a fire barrel outside the pottery for recreation."),
}
    :component("55gal_drum", 1)
    :camp_blueprint {
        update = "fbmw_2_common_recreation",
        name = content.text("recreation area"),
        provides = {
            { id = "fbmw_2_common_recreation" },
        },
        requires = {
            { id = "fbmw_2_pottery" },
        },
        excludes = {
            { id = "fbmw_2_common_recreation" },
        },
    }
)
