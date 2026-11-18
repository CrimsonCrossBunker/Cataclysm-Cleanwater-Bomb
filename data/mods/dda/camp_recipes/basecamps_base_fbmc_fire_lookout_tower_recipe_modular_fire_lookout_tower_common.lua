local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_fire_lookout_tower_0",
    result = "faction_base_fire_lookout_tower_0",
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
        update = "fbmc_fire_lookout_tower_0",
        name = content.text("basic survey"),
        provides = {
            { id = "fbmc_fire_lookout_tower_0" },
            { id = "primitive_camp_recipes_1" },
            { id = "kitchen_recipes_1" },
            { id = "kitchen_recipes_2" },
            { id = "kitchen" },
            { id = "tool_storage" },
            { id = "gathering" },
            { id = "firewood" },
            { id = "sorting" },
            { id = "logging" },
            { id = "relaying" },
            { id = "foraging" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        resources = { "fake_woodstove" },
        check_needs = false,
    }
)

content.add(content.Recipe {
    id = "faction_base_fire_lookout_tower_root_cellar",
    result = "faction_base_fire_lookout_tower_root_cellar",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a root cellar will allow us to preserve any small game that we trap."),
}
    :camp_blueprint {
        update = "fbmc_fire_lookout_tower_root_cellar",
        name = content.text("root cellar"),
        provides = {
            { id = "fbmc_fire_lookout_tower_root_cellar" },
            { id = "pantry" },
            { id = "trapping" },
        },
        requires = {
            { id = "fbmc_fire_lookout_tower_0" },
            { id = "fbmc_fire_lookout_tower_beds_0" },
            { id = "fbmc_fire_lookout_tower_beds_1" },
        },
        excludes = {
            { id = "fbmc_fire_lookout_tower_root_cellar" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_fire_lookout_tower_water_well",
    result = "faction_base_fire_lookout_tower_water_well",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Digging a well will give us easy access to water and allow us to send out combat patrols or scouts."),
}
    :camp_blueprint {
        update = "fbmc_fire_lookout_tower_water_well",
        name = content.text("water well"),
        provides = {
            { id = "fbmc_fire_lookout_tower_water_well" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "fbmc_fire_lookout_tower_0" },
            { id = "fbmc_fire_lookout_tower_beds_0" },
            { id = "fbmc_fire_lookout_tower_beds_1" },
        },
        excludes = {
            { id = "fbmc_fire_lookout_tower_water_well" },
        },
    }
)

content.add(content.Recipe {
    id = "faction_base_fire_lookout_tower_radio",
    result = "faction_base_fire_lookout_tower_radio",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("Let's set up a radio tower to improve our recruitment efforts."),
}
    :camp_blueprint {
        update = "fbmc_fire_lookout_tower_radio",
        name = content.text("radio tower"),
        provides = {
            { id = "fbmc_fire_lookout_tower_radio" },
            { id = "radio" },
            { id = "recruiting" },
        },
        requires = {
            { id = "fbmc_fire_lookout_tower_0" },
            { id = "fbmc_fire_lookout_tower_beds_0" },
            { id = "fbmc_fire_lookout_tower_beds_1" },
        },
        excludes = {
            { id = "fbmc_fire_lookout_tower_radio" },
        },
    }
)
