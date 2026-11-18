local ccb = require("ccb")
local content = ccb.content
local services = ccb.services
local variables = services.variables
local card_keys = { "card_1", "card_2", "card_3" }

local function value(result)
    if not result.ok then error(result.error.message) end
    return result.value
end

local function expand_and_store(ctx, character, key, text)
    -- The original single-value selection takes a native RNG draw before expanding tags.
    services.random.native_int(0, 0)
    local expanded = ctx:expand_text(text)
    value(variables.set(character, key, expanded, { include_before = false }))
    return expanded
end

local function draw_spread(ctx, character, deck)
    local cards = {}
    for i, key in ipairs(card_keys) do
        cards[i] = expand_and_store(ctx, character, key, deck)
    end
    return cards
end

ccb.runtime.handler("draw_tarot_spread", function(ctx)
    local character = ctx.character
    if not character then
        return 0
    end
    local title = ctx:expand_text(ccb.services.translate("Select an option."))
    local choice = services.interaction.choose({
        { id = "<card_tarot_any>", label = ctx:expand_text(ccb.services.translate("Pull from the full deck")) },
        { id = "<card_major_arcana>", label = ctx:expand_text(ccb.services.translate("Pull from the major arcanas")) },
    }, {
        title = title,
        allow_cancel = false,
    })
    if not choice.accepted then
        return 0
    end
    local cards = draw_spread(ctx, character, choice.id)
    for _ = 1, 100 do
        if cards[1] ~= cards[2] and cards[1] ~= cards[3] and cards[2] ~= cards[3] then
            break
        end
        cards = draw_spread(ctx, character, choice.id)
    end
    expand_and_store(ctx, character, "result",
        "You pull <u_val:card_1><card_orientation>, <u_val:card_2><card_orientation> and <u_val:card_3><card_orientation>.")
    if character.subtype == "avatar" then
        ctx:message(ctx:expand_text("<u_val:result>"))
    end
    return 0
end)

do
    -- copy name and description from item
    local item = content.Item {
        id = "deck_of_cards",
        category = "other",
        name = ccb.content.plural_text("deck of cards", "decks of cards"),
        description = ccb.content.text("A fairly new, glossy deck of 52 playing cards."),
        mass_milligrams = 50000,
        volume_ml = 100,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = ",",
        color = "red",
    }
    item:material("cardboard", 1)
    item:clear_flags()
    item:flag("NO_REPAIR")
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    item:variants {
        { id = "generic_deck_of_cards", weight = 30 },
        { id = "deck_of_cards_worn", name = ccb.content.plural_text("worn deck of cards", "worn decks of cards"), description = ccb.content.text("A deck of 52 playing cards.  Judging by the bent, frayed edges and faded prints, it saw its share of games."), weight = 6 },
        { id = "uno", name = ccb.content.plural_text("deck of Uno cards", "decks of Uno cards"), description = ccb.content.text("A set of Uno cards meant to play a game of Uno with your companions.  Just don't yell Uno too loud to avoid attracting the undead."), weight = 4 },
        { id = "onirim", name = ccb.content.plural_text("deck of Shadowcaser cards", "decks of Shadowcaser cards"), description = ccb.content.text("A set of cards used in the solo or two-player cooperative card game called Shadowcaser.  The deck consists of 76 unique cards.  Shadowcaser is a immersive card game set in a dream world where players find themselves trapped in a mysterious labyrinthine dream.  The objective of the game is for players to escape this dream world by unlocking eight doors before they run out of time or succumb to the nightmares haunting them."), weight = 1 },
        { id = "cards_magic", name = ccb.content.plural_text("deck of Sorcery cards", "decks of Sorcery cards"), description = ccb.content.text("A set of cards meant to play the game \"Sorcery.\"  Each card has a fun picture of a different monster."), weight = 2 },
        { id = "deck_of_cards_makeshift", name = ccb.content.plural_text("makeshift deck of cards", "makeshift decks of cards"), description = ccb.content.text("A deck of 52 makeshift cards, made out of cardboard rectangles with simple designs drawn on them."), weight = 0 },
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "deck_of_tarot_cards",
        copy_from = "deck_of_cards",
        looks_like = "deck_of_cards",
        category = "other",
        name = ccb.content.plural_text("deck of tarot cards", "decks of tarot cards"),
        description = ccb.content.text("A fairly new, glossy deck of tarot cards, commonly used for the practice of divination.  Each card has a unique and highly symbolic picture."),
    }
    item:variants {
        { id = "generic", description = ccb.content.text("A fairly new, glossy deck of tarot cards, commonly used for the practice of divination.  Each card has a unique and highly symbolic picture.") },
        { id = "makeshift", name = ccb.content.plural_text("makeshift deck of tarot cards", "makeshift decks of tarot cards"), description = ccb.content.text("A deck of tarot cards made out of cardboard rectangles with simple designs drawn on them, its makeshift nature doesn't affect its divinatory properties."), weight = 0 },
    }
    item:clear_use_actions()
    item:native_use("PLAY_GAME")
    item:on_use("draw_tarot_spread", ccb.content.text("Pull a spread"))
    content.add(item)
end
