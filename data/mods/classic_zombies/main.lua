require("item_migrations")

require("item_blacklists")

require("region_settings")

local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

-- The computer still lists this mission, but this world has no refugee center.
local refugee_center = content.Mission {
    id = "MISSION_REACH_REFUGEE_CENTER",
    name = ccb.content.text("Reach Refugee Center"),
    goal = "MGOAL_NULL",
    difficulty = 0,
    value = 0,
}
refugee_center:deadline(1)
content.replace(refugee_center)

local definition = content.Blacklist {
    kind = "monster",
    whitelist = true,
    exclusive = true,
}
definition:category("CLASSIC")
definition:category("WILDLIFE")
content.add(definition)

-- The native dialogue still reads this key from the character's save.
ccb.runtime.handler("initialize_dialogue_flag", function()
    local character = services.characters.avatar()
    local current = services.variables.get_string(character, "flag_modded")
    if not current.ok or current.value.value == "ddotd" then
        return
    end

    -- The old variable action always drew from the shared RNG, even for one value.
    services.random.native_int(0, 0)
    local write = services.variables.set(character, "flag_modded", "ddotd", { include_before = false })
    if write.ok then
        services.native_events.emit("u_var_changed", { "flag_modded", "ddotd" })
    end
end, 1)
ccb.runtime.on("game:game_begin", "initialize_dialogue_flag")

require("speech")

require("snippets")

require("weather_generators")

require("portal_storm_cycle")

require("scenario_filters")

require("construction_groups")

require("retired_recipes")

require("craft_recipes")

require("item_group_changes")

require("contagion.effect_types")
require("effect_types")
