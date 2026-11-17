local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

-- edited from no_wildlife
local definition = content.Blacklist {
    kind = "monster",
    whitelist = true,
    exclusive = true,
}
definition:category("WILDLIFE")
definition:category("MUTANT")
definition:species("MOXIE")
definition:species("ROBOT")
content.add(definition)

ccb.runtime.handler("initialize_shield_display", function()
    local result = services.variables.set(services.characters.avatar(), "shield_ratio", -1,
        { include_before = false })
    if not result.ok then
        error(result.error.message)
    end
end, 1)
ccb.runtime.on("game:game_start", "initialize_shield_display")

require("nested_recipes")

require("flags")
require("monster_flags")

require("speech")

require("ammunition_types")

require("ammo_effects")

require("tool_qualities")

require("vitamins")

require("snippets")

require("requirements")

require("conditional_enchantments")

require("enchantments")

require("enchantment_variables")
