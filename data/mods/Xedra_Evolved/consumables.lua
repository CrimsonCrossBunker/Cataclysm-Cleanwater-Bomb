local ccb = require("ccb")
local services = ccb.services

local function value(result)
    if not result.ok then
        error(result.error.message)
    end
    return result.value
end

local function has_effect(character, id)
    return value(services.effects.has(character, services.types.id("effect", id)))
end

local function apply_effect(character, id, duration, unit)
    value(services.effects.add(character, services.types.id("effect", id),
        services.time.duration(duration, unit)))
end

local function drink_cold_remedy(character)
    if has_effect(character, "pre_common_cold") or has_effect(character, "common_cold") then
        apply_effect(character, "effect_hedge_cure_cold_or_flu", 10, "day")
    end
    -- This roll precedes the flu check and uses the same shared RNG as the native effect.
    if services.random.native_float(0, 1) <= 0.9
        and (has_effect(character, "flu") or has_effect(character, "pre_flu")) then
        apply_effect(character, "effect_hedge_cure_cold_or_flu", 10, "day")
    end
end

local function take_mutagen(character)
    if value(services.mutations.has_id_text(character, "HOMULLUS_EXPANDED_MUTATIONS")) then
        value(services.mutations.grant(character, services.types.id("mutation", "HOMULLUS_NO_DOLL_MUTATIONS")))
    end
end

local on_consumed = {
    water_thirsttrouncer = function(character)
        apply_effect(character, "xe_hydrating_gout", 8400 + services.random.native_int(0, 8400), "turn")
    end,
    item_hedge_cure_cold_or_flu = drink_cold_remedy,
    iv_mutagen = take_mutagen,
    mutagen = take_mutagen,
}

ccb.runtime.handler("apply_consumable_effect", function(event)
    local apply = on_consumed[event.data.itype]
    if apply then
        apply(event.actors.character or services.characters.avatar())
    end
end, 1)
ccb.runtime.on("game:character_consumes_item", "apply_consumable_effect")
