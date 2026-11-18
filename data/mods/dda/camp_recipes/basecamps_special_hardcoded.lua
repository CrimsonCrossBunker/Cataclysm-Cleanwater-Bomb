local content = require("ccb").content

local NO_EXERCISE = 1

-- This file contains a special NPC-only basecamp which doesn't place anything, equivalent to the barebones
-- camp. It is placed during mapgen, and should not show up as a valid player option in regular gameplay. The
-- entire purpose is to provide 'water_well' so NPCs don't dehydrate to death.
-- Has hardcoded references in place (overmap.cpp) and overmap::migrate_camps.
content.add(content.Recipe {
    id = "faction_base_bare_bones_NPC_camp_0",
    result = "faction_base_bare_bones_NPC_camp_0",
    category = "CC_BUILDING",
    subcategory = "CSC_BUILDING_BASES",
    duration_moves = 360000,
    activity_level = NO_EXERCISE,
    autolearn = false,
    skill = "fabrication",
    never_learn = true,
    description = content.text("NPC-only.  If you see this it's a bug."),
}
    :camp_blueprint {
        update = "fbbb",
        name = content.text("NPC-only.  If you see this it's a bug."),
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
            { id = "water_well" },
            { id = "patrolling" },
        },
        requires = {
            { id = "not_an_upgrade" },
        },
        check_needs = false,
    }
)
