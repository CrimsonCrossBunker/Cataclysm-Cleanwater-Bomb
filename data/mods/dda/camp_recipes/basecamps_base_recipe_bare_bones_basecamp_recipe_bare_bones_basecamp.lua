local content = require("ccb").content

local MODERATE_EXERCISE = 4

content.add(content.Recipe {
    id = "faction_base_bare_bones_basecamp_0",
    result = "faction_base_bare_bones_basecamp_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = MODERATE_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("We should survey the base site.  Note that we'll later have to manually construct a bulletin board anywhere within the camp to actually be able to use the camp."),
}
    :camp_blueprint {
        update = "fbbb",
        name = content.text("bare bones basecamp survey"),
        provides = {
            { id = "gathering" },
            { id = "fbbb_crafting_recipes_basic" },
            { id = "fbbb_crafting_recipes_cooking" },
            { id = "fbbb_crafting_recipes_crafting" },
            { id = "fbbb_crafting_recipes_custom" },
            { id = "fbbb" },
            { id = "firewood" },
            { id = "foraging" },
            { id = "sorting" },
            { id = "logging" },
            { id = "trapping" },
            { id = "hunting" },
            { id = "kitchen" },
            { id = "relaying" },
            { id = "walls" },
            { id = "recruiting" },
            { id = "scouting" },
            { id = "patrolling" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)
