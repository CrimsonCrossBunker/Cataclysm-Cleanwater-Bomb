require("nested_recipes")
require("base_effect_overrides")

require("snippets")

require("enchantments")

require("mutation_enchantments")

require("overlay_enchantments")

require("item_enchantments")

require("sub_body_parts")

require("body_parts")

require("craft_recipes")

require("item_group_changes")

require("effect_types")

require("attack_vectors")
require("bionics")
require("limb_traits")
require("limb_changing")

if require("ccb").content.is_mod_active("mindovermatter") then
    require("mod_interactions.mindovermatter.runtime_interaction")
end
