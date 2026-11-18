require("flags")

require("requirements")

require("items")

require("deployable_furniture")

require("map_tiles")

require("upgrade_items")

require("item_groups")

require("npc_merchants.definitions")

require("npc_merchants.dialogue")

require("constructions")

require("effect_enchantments")

require("inline_enchantment_conditions")

require("effects")

require("mutations")

require("monster_groups")

require("expedition_timer")

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

require("island_overmap")

require("island_regions")

require("island_dimensions")

require("island_generation")

require("exodii_crash_mapgen")

require("island_start")

if require("ccb").content.is_mod_active("xedra_evolved") then
    require("mod_interactions.xedra_evolved.character_start")
end

require("island_legacy_load")

require("island_heart")

require("island_construction_repairs")

require("raid_upgrades")

require("island_upgrades")

require("expedition_missions")

require("island_climate")
