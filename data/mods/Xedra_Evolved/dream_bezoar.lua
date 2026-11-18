local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function advance_dreaming(character)
    local proficiencies = services.proficiencies
    local dreaming = id("proficiency", "prof_lucid_dreaming")
    local total = proficiencies.definition(dreaming).time_to_learn.turns
    local practiced = value(proficiencies.get(character, dreaming)).practiced.turns
    -- Match the two truncations in the native percentage read and assignment.
    local percent = practiced * 100.0 / total + 5
    local scaled_turns = math.modf(total * percent)
    local progress = services.time.duration_from_turns(scaled_turns / 100)
    value(proficiencies.set_practiced_time(character, dreaming, progress))
end

local function message(ctx, text, severity)
    if ctx.character.subtype == "avatar" then
        ctx:message(ctx:expand_text(text), severity)
    end
end

ccb.runtime.handler("swallow_dream_bezoar", function(ctx)
    local character = ctx.character
    if not character then
        return 1
    end
    local consumed = id("effect", "effect_consumed_bezoar")
    if value(services.effects.has(character, consumed, nil, -1)) then
        message(ctx, ccb.services.translate("Having already consumed a bezoar you cannot consume another"), "bad")
        value(services.morale.remove(character, id("morale", "morale_vomited")))
        value(services.characters.cast_spell(character, id("spell", "bezoar_vomit"), { hit_self = true }))
    else
        advance_dreaming(character)
        message(ctx, ccb.services.translate("You swallow it down painfully."), "good")
        value(services.effects.add(character, consumed, services.time.duration_from_turns(1), { permanent = true }))
    end
    return value(services.inventory.contains(character, ctx.item)) and 1 or 0
end)

do
    local item = content.Item {
        id = "dream_bezoar",
        name = ccb.content.plural_text("dream bezoar", "dream bezoar"),
        copy_from = "pebble",
        looks_like = "pebble",
        mass_milligrams = 150000,
        volume_ml = 250,
        description = ccb.content.text("An iridescent and oily stone that came from the belly of a goat and was treated with mugwort and lotus blossum.  Consuming one is said to increase one's skill to dream lucidly."),
    }
    item:clear_flags()
    item:flag("SINGLE_USE")
    item:flag("SLING_PROJECTILE")
    item:clear_use_actions()
    item:on_use("swallow_dream_bezoar", ccb.content.text("Swallow the dream bezoar"), ccb.content.text("Consuming one will increase your proficiency at lucid dreaming.  Consuming further dream bezoards will result in a horrendous mess."))
    content.add(item)
end
