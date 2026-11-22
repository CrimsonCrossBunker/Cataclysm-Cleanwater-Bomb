require("item_migrations")

require("region_settings")

local ccb = require("ccb")
local content = ccb.content

local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
definition:category("MAN_MADE")
content.add(definition)

require("requirements")

require("portal_storm_scenario")

require("portal_storm_strength")

require("xp_progression")

require("scenario_filters")

require("construction_groups")

require("disassembly")

require("food_recipes")

require("stepped_recipes")

require("retired_recipes")

require("crafting_recipes")

require("weapon_recipes")

require("armor_recipes")

require("craft_recipes")

require("practice_recipes")

require("item_groups")

require("item_group_changes")

require("generic_items")

require("map_weights")

require("migrations")
require("materials")
require("mission_goals")

ccb.runtime.handler("deliver_tinder_1_items", function(context)
    ccb.services.inventory.consume_by_type(context.character, ccb.services.types.id("item", "tinder"), 1, 0)
end)

ccb.runtime.handler("prepare_80_cattail_stalks", function(context)
    local services = ccb.services
    services.inventory.consume_by_type(context.giver or context.character,
        services.types.id("item", "cattail_stalk"), 80, 0)
end)

ccb.runtime.handler("teach_cattail_jelly", function(context)
    ccb.services.recipes.learn(context.character, ccb.services.types.id("recipe", "cattail_jelly"))
end)
require("dialogue_handlers")
require("eoc_runtime")
