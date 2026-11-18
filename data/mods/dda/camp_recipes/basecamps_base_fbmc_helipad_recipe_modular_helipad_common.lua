local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_helipad_0",
    result = "faction_base_helipad_0",
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
        update = "fbmc_helipad_0",
        name = content.text("basic survey"),
        provides = {
            { id = "gathering" },
            { id = "firewood" },
            { id = "sorting" },
            { id = "logging" },
            { id = "foraging" },
            { id = "kitchen" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "primitive_camp_recipes_1" },
            { id = "fbmc_helipad_0" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "oven", "water_purifier" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_helipad_barricade_wood",
    result = "faction_base_helipad_barricade_wood",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need to barricade the front windows, let's build wooden walls over them."),
}
    :camp_blueprint {
        update = "fbmc_helipad_barricade_wood",
        name = content.text("wooden barricades"),
        provides = {
            { id = "fbmc_helipad_barricade" },
        },
        requires = {
            { id = "fbmc_helipad_0" },
        },
        excludes = {
            { id = "fbmc_helipad_barricade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_helipad_migo_resin",
    result = "faction_base_helipad_migo_resin",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We need to barricade the front windows, let's build mi-go resin walls over them."),
}
    :camp_blueprint {
        update = "fbmc_helipad_barricade_migo_resin",
        name = content.text("mi-go resin barricades"),
        provides = {
            { id = "fbmc_helipad_barricade" },
        },
        requires = {
            { id = "fbmc_helipad_0" },
        },
        excludes = {
            { id = "fbmc_helipad_barricade" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_helipad_root_cellar",
    result = "faction_base_helipad_root_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will allow us to preserve any small game that we trap."),
}
    :camp_blueprint {
        update = "fbmc_helipad_root_cellar",
        name = content.text("root cellar"),
        provides = {
            { id = "fbmc_helipad_root_cellar" },
            { id = "pantry" },
            { id = "trapping" },
        },
        requires = {
            { id = "fbmc_helipad_barricade" },
        },
        excludes = {
            { id = "fbmc_helipad_root_cellar" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_helipad_butchery_rack",
    result = "faction_base_helipad_butchery_rack",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We could build a butchery rack to start hunting larger animals."),
}
    :camp_blueprint {
        update = "fbmc_helipad_butchery_rack",
        name = content.text("butchery rack"),
        provides = {
            { id = "fbmc_helipad_butchery_rack" },
            { id = "hunting" },
        },
        requires = {
            { id = "fbmc_helipad_root_cellar" },
        },
        excludes = {
            { id = "fbmc_helipad_butchery_rack" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_helipad_reinforce_doors",
    result = "faction_base_helipad_reinforce_doors",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should reinforce the front doors to make this base safer."),
}
    :camp_blueprint {
        update = "fbmc_helipad_reinforce_doors",
        name = content.text("reinforce doors"),
        provides = {
            { id = "fbmc_helipad_reinforce_doors" },
            { id = "relaying" },
            { id = "walls" },
        },
        requires = {
            { id = "fbmc_helipad_barricade" },
        },
        excludes = {
            { id = "fbmc_helipad_reinforce_doors" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_helipad_radio",
    result = "faction_base_helipad_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts."),
}
    :camp_blueprint {
        update = "fbmc_helipad_radio",
        name = content.text("radio tower"),
        provides = {
            { id = "fbmc_helipad_radio" },
            { id = "radio" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patroling" },
        },
        requires = {
            { id = "fbmc_helipad_reinforce_doors" },
            { id = "fbmc_helipad_root_cellar" },
        },
        excludes = {
            { id = "fbmc_helipad_radio" },
        },
    }
)
