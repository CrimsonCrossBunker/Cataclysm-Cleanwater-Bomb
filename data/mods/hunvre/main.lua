require("region_settings")

require("dimensions")

local ccb = require("ccb")
local content = ccb.content

local definition = content.Blacklist {
    kind = "monster",
    whitelist = true,
    exclusive = true,
}
definition:species("EUZHVIL")
content.add(definition)

require("flags")

require("vitamins")

require("snippets")

require("weather_generators")

require("weather_types")

require("scenario_filters")

require("overmap_locations")

require("item_groups")

require("generic_items")

require("inherited_items")

require("effect_types")

require("terrain_transforms")

require("monster_groups")
