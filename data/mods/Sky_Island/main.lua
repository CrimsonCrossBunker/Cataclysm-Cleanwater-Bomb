require("flags")

require("requirements")

require("effect_enchantments")

require("inline_enchantment_conditions")

require("weather_generators")

require("portal_storm_cycle")

require("raid_obelisk")

require("raid_return")

require("raid_rewards")

require("recipes")

if require("ccb").content.is_mod_active("magiclysm") then
    require("recipes_magiclysm")
end
