require("flags")

require("requirements")

require("effect_enchantments")

require("inline_enchantment_conditions")

require("weather_generators")

require("portal_storm_cycle")

require("raid_obelisk")

require("raid_return")

require("raid_rewards")

require("raid_warp")

require("raid_consumables")

require("raid_services")

require("raid_information")

require("raid_death")

require("island_defenses")

require("dimension_returns")

require("recipes")

if require("ccb").content.is_mod_active("magiclysm") then
    require("recipes_magiclysm")
end

require("island_start")

require("island_legacy_load")

require("island_heart")

require("island_construction_repairs")

require("raid_upgrades")

require("island_upgrades")

require("expedition_missions")
