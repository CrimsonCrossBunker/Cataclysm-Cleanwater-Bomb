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
