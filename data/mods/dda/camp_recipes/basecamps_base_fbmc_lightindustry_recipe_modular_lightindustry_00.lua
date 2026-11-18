local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_lightindustry_0",
    result = "faction_base_lightindustry_0",
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
        update = "fbmc_lightindustry_00",
        name = content.text("basic survey"),
        provides = {
            { id = "gathering" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "primitive_camp_recipes_1" },
            { id = "kitchen_recipes_1" },
            { id = "fbmc_lightindustry_00" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "oven" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "fbmc_lightindustry_00_barricades_wood",
    result = "fbmc_lightindustry_00_barricades_wood",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We must barricade the windows, let's use wooden walls."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_barricades_wood",
        name = content.text("wooden barricades"),
        provides = {
            { id = "fbmc_lightindustry_00_barricades" },
            { id = "sorting" },
            { id = "logging" },
            { id = "fbmc_lightindustry_00_barricades" },
        },
        requires = {
            { id = "fbmc_lightindustry_00" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_barricades" },
        },
    }
)

content.add(content.Recipe {
    id = "fbmc_lightindustry_00_barricades_migo",
    result = "fbmc_lightindustry_00_barricades_migo",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We must barricade the windows, let's use mi-go resin walls."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_barricades_migo",
        name = content.text("resin barricades"),
        provides = {
            { id = "fbmc_lightindustry_00_barricades" },
            { id = "sorting" },
            { id = "logging" },
            { id = "fbmc_lightindustry_00_barricades" },
        },
        requires = {
            { id = "fbmc_lightindustry_00" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_barricades" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_lightindustry_00_root_cellar",
    result = "faction_base_lightindustry_00_root_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will allow us to preserve any small game that we trap."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_root_cellar",
        name = content.text("root cellar"),
        provides = {
            { id = "fbmc_lightindustry_00_root_cellar" },
            { id = "pantry" },
            { id = "trapping" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_barricades" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_root_cellar" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_lightindustry_00_butchery_rack",
    result = "faction_base_lightindustry_00_butchery_rack",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Building a butchery rack will allow us to hunt bigger animals."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_butchery_rack",
        name = content.text("butchery rack"),
        provides = {
            { id = "fbmc_lightindustry_00_butchery_rack" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_root_cellar" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_butchery_rack" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_lightindustry_00_water_well",
    result = "faction_base_lightindustry_00_water_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a well will give us easy access to water and allow us to send out combat patrols or scouts."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_water_well",
        name = content.text("water well"),
        provides = {
            { id = "fbmc_lightindustry_00_water_well" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_barricades" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_water_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_lightindustry_00_radio",
    result = "faction_base_lightindustry_00_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_radio",
        name = content.text("radio tower"),
        provides = {
            { id = "fbmc_lightindustry_00_radio" },
            { id = "radio" },
            { id = "recruiting" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_barricades" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_radio" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_lightindustry_00_reinforce_doors",
    result = "faction_base_lightindustry_00_reinforce_doors",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should reinforce the doors to further secure our base."),
}
    :camp_blueprint {
        update = "fbmc_lightindustry_00_reinforce_doors",
        name = content.text("reinforce doors"),
        provides = {
            { id = "fbmc_lightindustry_00_doors" },
            { id = "relaying" },
            { id = "walls" },
        },
        requires = {
            { id = "fbmc_lightindustry_00_barricades" },
        },
        excludes = {
            { id = "fbmc_lightindustry_00_doors" },
        },
    }
)
