local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "fbmh_2_tent_room_1_1",
    result = "fbmh_2_tent_room_1_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need some shelter, so set up a tent on the northeast side of the camp."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_NE",
        name = content.text("northeast tent"),
        provides = {
            { id = "fbmh_2_room_NE", amount = 4 },
            { id = "fbmh_2_tent_NE" },
        },
        requires = {
            { id = "fbmh_2" },
        },
        excludes = {
            { id = "fbmh_2_room_NE" },
            { id = "fmbh_2_tent_NE" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_room_2",
    result = "fbmh_2_tent_room_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a tent immediately south of the previous shelter, though you'll probably want to replace the tent wall for the central building later."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_ENE",
        name = content.text("east north east tent"),
        provides = {
            { id = "fbmh_2_room_ENE", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_NE", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_ENE" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_room_3",
    result = "fbmh_2_tent_room_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a tent south of the center of the east side of the camp."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_ESE",
        name = content.text("east south east tent"),
        provides = {
            { id = "fbmh_2_room_ESE", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_center_east" },
        },
        excludes = {
            { id = "fbmh_2_room_ESE" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_room_4",
    result = "fbmh_2_tent_room_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a tent on the southeast side of the camp."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_SE",
        name = content.text("southeast tent"),
        provides = {
            { id = "fbmh_2_room_SE", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_ESE", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_SE" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_room_5",
    result = "fbmh_2_tent_room_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a tent on the southwest side of the camp."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_SW",
        name = content.text("southwest tent"),
        provides = {
            { id = "fbmh_2_room_SW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_WSW", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_SW" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_room_6",
    result = "fbmh_2_tent_room_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a tent south of the center of the west side of the camp."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_WSW",
        name = content.text("west south west tent"),
        provides = {
            { id = "fbmh_2_room_WSW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_center_west" },
        },
        excludes = {
            { id = "fbmh_2_room_WSW" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_room_7",
    result = "fbmh_2_tent_room_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a tent north of the center of the west side of the camp."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_WNW",
        name = content.text("west north west tent"),
        provides = {
            { id = "fbmh_2_room_WNW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_center_west" },
        },
        excludes = {
            { id = "fbmh_2_room_WNW" },
        },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmh_2_tent_room_8",
    result = "fbmh_2_tent_room_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 1080000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should expand our housing by adding a tent on the northwest side of the camp."),
}
    :component_any({
            { id = "large_tent_kit", count = 1 },
            { id = "broketent", count = 4 },
            { id = "tent_kit", count = 3 },
            { id = "shelter_kit", count = 4 }
        })
    :camp_blueprint {
        update = "fbmh_2_tent_room_NW",
        name = content.text("northwest tent"),
        provides = {
            { id = "fbmh_2_room_NW", amount = 4 },
        },
        requires = {
            { id = "fbmh_2_room_WNW", amount = 4 },
        },
        excludes = {
            { id = "fbmh_2_room_NW" },
        },
        check_needs = false,
    }
)
