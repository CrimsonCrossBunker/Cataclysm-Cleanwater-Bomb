require("region_settings")

require("mutation_enchantments")

require("portal_storm")

require("scenario_filters")
require("scenarios")

require("item_groups")

require("item_group_changes")

require("generic_items")

require("monster_groups")

require("species")
require("jmath")

require("monster_attack_predicates")

if require("ccb").content.is_mod_active("bombastic_perks") then
    require("mod_interactions.bombastic_perks.runtime_interaction")
end
require("dialogue_handlers")
