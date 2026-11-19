local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local definition = content.Blacklist {
    kind = "monster",
    whitelist = false,
}
definition:entry("mon_beaver_mutant_huge")
definition:entry("mon_beaver_mutant_avian")
definition:entry("mon_mutant_experimental")
definition:entry("mon_crow_mutant_small")
definition:entry("mon_zhark")
definition:entry("mon_ocean_zhark")
content.add(definition)

local function checked(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

ccb.runtime.handler("initialize_character", function()
    local avatar = services.characters.avatar()
    local mutations = services.mutations
    local function mutation(id)
        return services.types.id("mutation", id)
    end

    checked(services.variables.set(avatar, "timer_XedraWood_RandEnc", services.time_snapshot().turn,
        { include_before = false }))
    checked(mutations.replace(avatar, mutation("XEDRA_WOOD_COMPUTER_ILLITERATE")))
    if not checked(mutations.has_id_text(avatar, "WISE_LITERATE")) then
        checked(mutations.replace(avatar, mutation("ILLITERATE")))
    end
    if checked(mutations.has_id_text(avatar, "LIZARDFOLK_BUILD")) then
        checked(mutations.mutate_towards(avatar, mutation("LIZARDFOLK_NO_HAIR"), nil, false))
    end
end, 1)
ccb.runtime.on("game:game_start", "initialize_character")

require("flags")

require("tool_qualities")

require("requirements")

require("effect_enchantments")
require("effects.psi_effects")

require("mutation_enchantments")

require("inline_enchantment_conditions")

require("inline_enchantment_values")

require("overlay_enchantments")

require("inline_special_vision")

require("progression_enchantments")

require("thermal_overlay_enchantments")

require("bionic_enchantments")

require("item_enchantments")

require("weather_generators")

require("overmap_locations")

require("field_emissions")

require("disassembly")

require("food_recipes")

require("stepped_recipes")

require("retired_recipes")

require("armor_recipes")

require("craft_recipes")

require("practice_recipes")

require("hedge_research")

require("anima_meditation")
require("forest_rituals")
require("mi_go_reflexes")

require("item_groups")

require("item_group_changes")

require("book_items")

require("generic_items")

require("inherited_items")

require("effect_types")

require("terrain_transforms")

require("monster_groups")
