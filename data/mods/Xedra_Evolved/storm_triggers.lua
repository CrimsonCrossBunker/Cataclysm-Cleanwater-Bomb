local ccb = require("ccb")
local services = ccb.services
local content = ccb.content
local id = services.types.id

local function checked(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function message(character, text, severity)
    if character.subtype == "avatar" then services.messages.add(text, severity) end
end

ccb.runtime.handler("stormwrought_blood_complete", function(payload)
    local character = payload.character
    for _ = 1, payload.batch do
        local position = checked(services.creatures.snapshot(character)).position
        local found = services.world.find_location(position, { kind = "field", id = id("field", "fd_fatigue") },
            { target_max_radius = 5 })
        local target = found.position or services.coords.tripoint_abs_ms(0, 0, 0)
        if services.gameplay.environment.field_exists(target, "fd_fatigue") then
            checked(services.inventory.receive_item(character, id("item", "stormwrought_blood_itert"), 1))
            message(character, services.translate("The ritual harnesses the energies of the tear to infuse some blood with it, leaving behind a small ball of almost-solid blood.  It only needs to bath in the energies of the storms until it is fully charged and it will be ready to use."), "good")
            ccb.runtime.call_character("portal_storm_begin_early", character)
        else
            message(character, services.translate("Without the proximity of a tear in reality, the ritual fails to harness any energy and the blood boils away."), "bad")
        end
    end
end)

local ritual = content.Recipe {
    id = "stormwrought_blood", name = content.text("stormwrought blood"),
    description = content.text("Attempt to create one unit of inert stormwrought blood.  Will only work if you stand close enough to a tear in reality."),
    category = "CC_XEDRA", subcategory = "CSC_XEDRA_MISC", skill = "deduction", difficulty = 2,
    duration_moves = 90000, activity_level = 2, autolearn = false, flags = { "SECRET" },
}
ritual:component_any {
    { id = "blood", count = 100 }, { id = "demihuman_blood", count = 100 },
    { id = "mutant_human_blood", count = 100 }, { id = "fae_blood", count = 100 },
}
content.add(ritual:on_complete("stormwrought_blood_complete"))

ccb.runtime.handler("inventor_smoother_portal_storm", function(payload)
    -- The native spell acted on each impact's victim, including an absent victim.
    ccb.runtime.call_creature("portal_storm_start", payload.target_creature)
end)
content.add(content.Spell {
    id = "inventor_portal_closer_spell_portal_storm",
    name = "Netherium-Reality Smooth - Portal Spell",
    description = "Having this spell is a bug.  Causes a strong portal storm.",
    shape = "blast", valid_targets = { "ground", "self" },
    flags = { "NO_FAIL", "NO_HANDS", "NO_LEGS", "NON_MAGICAL", "IGNORE_WALLS" },
}:lua_impact("inventor_smoother_portal_storm"))
