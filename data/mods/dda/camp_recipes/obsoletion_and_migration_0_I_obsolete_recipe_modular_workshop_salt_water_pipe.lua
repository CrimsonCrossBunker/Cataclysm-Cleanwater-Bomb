local content = require("ccb").content

local MODERATE_EXERCISE = 4

-- OBSOLETION NOTE: when this file is deleted, C++ faction camp code from #55026 that generates pipelines can
-- also be deleted.
-- The blueprint is a template that will be rotated and mirrored to match its placement. Note that this does
-- NOT
-- have anything to do with the flags provided: they serve a different purpose. Also note that the name is
-- hard
-- coded to be picked up by code specific to this functionality. Also note that the non orthogonal
-- orientations
-- use the blueprint faction_expansion_salt_water_pipe_swamp_NE instead.
-- 1 salt water well, 4 pits, and filling up 3 pits (the last one is for the well). 6 h, 40 m * 3, 30 m * 4,
-- 150 m * 4
-- Abuse of the flags. Since the referenced blueprint isn't actually used, they don't have any actual effect
-- on it, but they're used to tell the code specific to this pipe functionality which overmap tile the pipe
-- should end at, with N(orth) being the default assumption. The pipe then connects to expansion tile at
-- index
-- 12 (the index being X or Y depending on the rotation). This allows for an expansion blueprint to connect
-- at
-- 11 or 12, which you can get with mirroring and rotation of those indices.
content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_swamp",
    result = "fbmw_2_salt_water_pipe_swamp",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_ROTATE_90_IF_NE", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Construct a pipe to bring salt water from a nearby swamp to the Workshop, which will become available once a pump is built to connect to it.  This job just adds the first bit (in a swamp)."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_swamp_N",
        name = content.text("salt water pipe construction"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_swamp" },
        },
        requires = {
            { id = "nonexistent_id_to_hide_construction" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_swamp" },
        },
        check_needs = false,
        needs = {
            duration_moves = 7200000,
            skills = { ["fabrication"] = 4, ["survival"] = 4 },
            qualities = {
                { { id = "HAMMER", level = 2, count = 1 } },
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "rock", count = 40 } },
                { { id = "2x4", count = 4 } },
                { { id = "nail", count = 8 } },
                { { id = "pipe", count = 6 } },
                { { id = "pipe_fittings", count = 6 } },
            },
        },
    }
)

-- The blueprint is a template that will be rotated and mirrored to match its placement. Also note that the
-- name is hard coded to be picked up by code specific to this functionality. For diagonal pipes the hard
-- blueprint faction_expansion_salt_water_pipe_NE is used as a base for rotation/mirroring.
-- The second requires token above is added by code that determines how many construction segments are needed
-- to construct the pipe. Thus, this id is hard coded.
-- 24 pits dug and filled up again. 40 m * 24, 30 m * 24, 150 m * 24
content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_1",
    result = "fbmw_2_salt_water_pipe_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The first continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 1"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_1" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_1_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_1" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
            -- We'll ignore that we'd need longer pipes when the line is diagonal.
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_2",
    result = "fbmw_2_salt_water_pipe_2",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The second continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 2"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_2" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_2_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_2" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_3",
    result = "fbmw_2_salt_water_pipe_3",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The third continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 3"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_3" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_3_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_3" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_4",
    result = "fbmw_2_salt_water_pipe_4",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The fourth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 4"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_4" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_4_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_4" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_5",
    result = "fbmw_2_salt_water_pipe_5",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The fifth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 5"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_5" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_5_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_5" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_6",
    result = "fbmw_2_salt_water_pipe_6",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The sixth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 6"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_6" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_6_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_6" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_7",
    result = "fbmw_2_salt_water_pipe_7",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The seventh continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 7"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_7" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_7_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_7" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_8",
    result = "fbmw_2_salt_water_pipe_8",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The eighth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 8"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_8" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_8_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_8" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_9",
    result = "fbmw_2_salt_water_pipe_9",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The ninth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 9"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_9" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_9_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_9" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_10",
    result = "fbmw_2_salt_water_pipe_10",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The tenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 10"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_10" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_10_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_10" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_11",
    result = "fbmw_2_salt_water_pipe_11",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The eleventh continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 11"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_11" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_11_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_11" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_12",
    result = "fbmw_2_salt_water_pipe_12",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The twelfth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 12"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_12" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_12_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_12" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_13",
    result = "fbmw_2_salt_water_pipe_13",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The thirteenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 13"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_13" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_13_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_13" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_14",
    result = "fbmw_2_salt_water_pipe_14",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The fourteenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 14"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_14" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_14_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_14" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_15",
    result = "fbmw_2_salt_water_pipe_15",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The fifteenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 15"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_15" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_15_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_15" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_16",
    result = "fbmw_2_salt_water_pipe_16",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The sixteenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 16"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_16" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_16_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_16" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_17",
    result = "fbmw_2_salt_water_pipe_17",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The seventeenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 17"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_17" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_17_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_17" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_18",
    result = "fbmw_2_salt_water_pipe_18",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The eighteenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 18"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_18" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_18_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_18" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

content.add(content.Recipe {
    id = "fbmw_2_salt_water_pipe_19",
    result = "fbmw_2_salt_water_pipe_19",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("The nineteenth continuation section of the salt water pipe."),
}
    :camp_blueprint {
        update = "faction_expansion_salt_water_pipe_N",
        name = content.text("salt water pipe continuation 19"),
        provides = {
            { id = "fbmw_2_salt_water_pipe_19" },
        },
        requires = {
            { id = "fbmw_2" },
            { id = "salt_water_pipe_19_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pipe_19" },
        },
        check_needs = false,
        needs = {
            duration_moves = 31680000,
            skills = { ["fabrication"] = 1, ["survival"] = 1 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
            },
            components = {
                { { id = "pipe", count = 48 } },
                { { id = "pipe_fittings", count = 48 } },
            },
        },
    }
)

-- Have to use hard coded requires condition as the result of the swamp
-- construction has to be set as provided to block the recipe from
-- reappearing when it fails because the geography doesn't allow it
-- (salt) water pump + 2 deep pits + 2 filled pits
content.add(content.Recipe {
    id = "fbmw_2_salt_water_pump",
    result = "fbmw_2_salt_water_pump",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    flags = { "MAP_MIRROR_HORIZONTAL_IF_N", "MAP_ROTATE_90_IF_NE", "MAP_MIRROR_HORIZONTAL_IF_E", "MAP_ROTATE_90_IF_E", "MAP_ROTATE_180_IF_SE", "MAP_MIRROR_HORIZONTAL_IF_S", "MAP_ROTATE_180_IF_S", "MAP_ROTATE_270_IF_SW", "MAP_MIRROR_HORIZONTAL_IF_W", "MAP_ROTATE_270_IF_W" },
    never_learn = true,
    description = content.text("Construct a pump and connect it to the salt water pipe.  You have to add the pump to a storage zone to access the salt water for camp crafting!"),
}
    :camp_blueprint {
        update = "fbmw_2_salt_water_pump",
        name = content.text("construct a salt water pump"),
        provides = {
            { id = "fbmw_2_salt_water_pump" },
        },
        requires = {
            { id = "salt_water_pipe_0_scheduled" },
        },
        excludes = {
            { id = "fbmw_2_salt_water_pump" },
        },
        check_needs = false,
        needs = {
            duration_moves = 8760000,
            skills = { ["fabrication"] = 4, ["survival"] = 4, ["mechanics"] = 2 },
            qualities = {
                { { id = "DIG", level = 2, count = 1 } },
                { { id = "HAMMER", level = 2, count = 1 } },
                { { id = "WRENCH", level = 1, count = 1 } },
            },
            components = {
                { { id = "rock", count = 40 } },
                { { id = "2x4", count = 4 } },
                { { id = "nail", count = 8 } },
                { { id = "well_pump", count = 1 } },
                { { id = "pipe", count = 28 } },
                { { id = "pipe_fittings", count = 28 } },
            },
        },
    }
)
