local ccb = require("ccb")
local content = ccb.content
local services = ccb.services

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function predicted_messages()
    return {
        ccb.services.translate("You draw the hollow circle card, just as you knew you would.  You look at it for a moment and put it back in the deck."),
        ccb.services.translate("You draw the three wavy lines card, just as you knew you would.  You look at it for a moment and put it back in the deck."),
        ccb.services.translate("You draw the hollow square card, just as you knew you would.  You look at it for a moment and put it back in the deck."),
        ccb.services.translate("You draw the five-pointed star card, just as you knew you would.  You look at it for a moment and put it back in the deck."),
        ccb.services.translate("You draw the plus symbol card, just as you knew you would.  You look at it for a moment and put it back in the deck."),
    }
end

local function unpredicted_messages()
    return {
        ccb.services.translate("You draw the hollow circle card, look at it for a moment, and put it back in the deck."),
        ccb.services.translate("You draw the three wavy lines card, look at it for a moment, and put it back in the deck."),
        ccb.services.translate("You draw the hollow square card, look at it for a moment, and put it back in the deck."),
        ccb.services.translate("You draw the five-pointed star card, look at it for a moment, and put it back in the deck."),
        ccb.services.translate("You draw the plus symbol card, look at it for a moment, and put it back in the deck."),
    }
end

ccb.runtime.handler("draw_zener_card", function(ctx)
    local character = ctx.character
    local school = services.types.id("mutation", "CLAIRSENTIENT")
    local predicted = character and value(services.mutations.has(character, school))
        and value(services.spells.school_level(character, school)) >= 10
    local draw = services.random.native_int(0, 4) + 1
    if character and character.subtype == "avatar" then
        local messages = predicted and predicted_messages() or unpredicted_messages()
        ctx:message(ctx:expand_text(messages[draw]))
    end
    return 0
end)

do
    local item = content.Item {
        id = "cards_zener",
        category = "other",
        name = ccb.content.plural_text("deck of Zener cards", "decks of Zener cards"),
        description = ccb.content.text("A deck of Zener cards, used pre-Cataclysm to test for psychic ability."),
        mass_milligrams = 23000,
        volume_ml = 29,
        price_cents = 1314,
        price_postapoc_cents = 2,
        symbol = ",",
        color = "magenta",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:on_use("draw_zener_card", ccb.content.text("Activate"), ccb.content.text("Pick a card.  Any card."))
    content.add(item)
end
