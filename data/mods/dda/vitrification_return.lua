local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local id = services.types.id

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function number(character, key)
    return value(services.variables.get_number(character, key, { strict = true })).value or 0
end

local body_parts = { "head", "torso", "arm_l", "arm_r", "leg_l", "leg_r" }

ccb.runtime.handler("return_from_vitrification_due", function(payload)
    local character = payload.character

    value(services.effects.remove(character, id("effect", "VITRIFYING")))
    value(services.mutations.replace(character, id("mutation", "NOT_GLASS")))

    local current = value(services.creatures.snapshot(character)).position
    local destination = services.coords.tripoint_abs_ms(current.x, current.y, current.z - 6)
    value(services.variables.set(character, "vitrifaction_exit", destination, { include_before = false }))
    local returned = value(services.relocation.teleport_character(character, destination, { force = true }))
    if not returned.accepted and character.subtype == "avatar" then
        services.messages.add(ccb.services.translate("Oops!"))
    end

    value(services.inventory.remove_type(character, id("item", "imperfect_doll_complete")))
    value(services.inventory.remove_type(character, id("item", "black_glass_shard")))
    value(services.world.reschedule_events("vitrified_farm_escape_key", services.time.duration_from_turns(0)))

    for _, part in ipairs(body_parts) do
        local hp = math.modf(number(character, "glass_health_" .. part))
        value(services.characters.set_hp(character, id("body_part", part), hp, true))
    end
    local sleepiness = math.modf(number(character, "glass_sleepiness"))
    value(services.needs.set(character, { sleepiness = sleepiness }))
    value(services.morale.remove(character, id("morale", "morale_vitri_placid")))

    if character.subtype == "avatar" then
        local item_id = payload.data and payload.data.item_id
        local text = value(services.text.expand_for(ccb.services.translate("You suck in a deep, ragged draught of air that burns in your chest.  Have you been holding your breath?  You must have been.  All you can hear for a moment is your heart hammering in your ears.  It takes a while to settle down."),
            character, nil, nil, { id = item_id }, true))
        ccb.presentation.notice(text)
        services.activities.offer_interruption("")
        services.messages.add(text, "good")
    end
end)

ccb.runtime.handler("hug_imperfect_doll", function(ctx)
    local character = ctx.character
    if character and number(character, "back_from_vitri_glass") < 1 then
        ccb.tasks.after_character_turn(character, 1, "return_from_vitrification_due", { item_id = ctx.item_id })
        value(services.variables.set(character, "back_from_vitri_glass", 1, { include_before = false }))
    end
    return 0
end)

do
    local item = content.Item {
        id = "imperfect_doll_complete",
        name = ccb.content.plural_text("imperfect doll", "imperfect dolls"),
        description = ccb.content.text("Its legs are mismatched, its arms misshapen, its eyes more crooked than its smile.  Everywhere, it sparkles with the golden thread that has put it back together.  It's beautiful."),
        category = "other",
        price_cents = 0,
        price_postapoc_cents = 10000000,
        symbol = "@",
        color = "white",
        looks_like = "talking_doll",
    }
    item:material("cotton", 1)
    item:clear_flags()
    item:flag("SLEEP_AID")
    item:flag("NO_SALVAGE")
    item:flag("INTEGRATED")
    item:flag("ZERO_WEIGHT")
    item:flag("TRADER_AVOID")
    item:flag("MISSION_ITEM")
    item:on_use("hug_imperfect_doll", ccb.content.text("Activate"), ccb.content.text("Hug the imperfect doll."))
    content.add(item)
end
