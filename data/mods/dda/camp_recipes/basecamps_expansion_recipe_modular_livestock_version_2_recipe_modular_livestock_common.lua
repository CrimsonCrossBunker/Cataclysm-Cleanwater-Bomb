local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_livestock_2_0",
    result = "faction_base_livestock_2_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Survey land for a livestock area."),
}
    :camp_blueprint {
        update = "faction_base_livestock_2_0",
        name = content.text("livestock survey"),
        provides = {
            { id = "fbml_2" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_coop_yard",
    result = "fbml_2_coop_yard",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a fence to contain our chicken and other birds, so build a chickenwire fence to finish the chicken coop area."),
}
    :camp_blueprint {
        update = "fbml_2_coop_yard",
        name = content.text("chicken coop yard"),
        provides = {
            { id = "fbml_2_coop_yard" },
        },
        requires = {
            { id = "fbml_2_coop" },
        },
        excludes = {
            { id = "fbml_2_coop_yard" },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_remote_fence",
    result = "fbml_2_remote_fence",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a paddock for the stable, so build a split-rail fence on the remote side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_2_remote_fence",
        name = content.text("remote paddock fence"),
        provides = {
            { id = "fbml_2_remote_fence" },
        },
        requires = {
            { id = "fbml_2_stall_5" },
            { id = "fbml_2_coop" },
        },
        excludes = {
            { id = "fbml_2_remote_fence" },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_side_fence",
    result = "fbml_2_side_fence",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a paddock for the stable, so build a split-rail fence on side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_2_side_fence",
        name = content.text("side paddock fence"),
        provides = {
            { id = "fbml_2_side_fence" },
        },
        requires = {
            { id = "fbml_2_coop_yard" },
            { id = "fbml_2_shack" },
        },
        excludes = {
            { id = "fbml_2_side_fence" },
        },
    }
)

content.add(content.Recipe {
    id = "fbml_2_near_fence",
    result = "fbml_2_near_fence",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("We could use a paddock for the stable, so build a split-rail fence on near side of the livestock field."),
}
    :camp_blueprint {
        update = "fbml_2_near_fence",
        name = content.text("near paddock fence"),
        provides = {
            { id = "fbml_2_near_fence" },
        },
        requires = {
            { id = "fbml_2_stall_1" },
            { id = "fbml_2_shack" },
        },
        excludes = {
            { id = "fbml_2_near_fence" },
        },
    }
)
