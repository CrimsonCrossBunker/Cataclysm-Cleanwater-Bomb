local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_fire_lookout_tower_beds_0",
    result = "faction_base_fire_lookout_tower_beds_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a pair of beds in the northern shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_fire_lookout_tower_beds_0",
        name = content.text("pair of beds in the northern shack"),
        provides = {
            { id = "fbmc_fire_lookout_tower_beds_0" },
        },
        requires = {
            { id = "fbmc_fire_lookout_tower_shack_0" },
        },
        excludes = {
            { id = "fbmc_fire_lookout_tower_beds_0" },
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
    id = "faction_base_fire_lookout_tower_beds_1",
    result = "faction_base_fire_lookout_tower_beds_1",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 0,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    never_learn = true,
    description = content.text("We should build a pair of beds in the southern shack for our survivors."),
}
    :camp_blueprint {
        update = "fbmc_fire_lookout_tower_beds_1",
        name = content.text("pair of beds in the southern shack"),
        provides = {
            { id = "fbmc_fire_lookout_tower_beds_1" },
        },
        requires = {
            { id = "fbmc_fire_lookout_tower_shack_1" },
        },
        excludes = {
            { id = "fbmc_fire_lookout_tower_beds_1" },
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
