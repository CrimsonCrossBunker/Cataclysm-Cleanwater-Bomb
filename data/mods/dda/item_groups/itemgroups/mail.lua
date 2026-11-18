local content = require("ccb").content

do
    local group = content.ItemGroup { id = "mail", kind = "distribution" }
    group:group("greeting-cards_with_gifts", 10)
    group:entry { item = "letter", container = "envelope", probability = 20 }
    group:item("postcard", 20)
    group:group("magazines", 10)
    group:group("newspaper_recent", 60)
    group:group("brochures", 15)
    group:group("pamphlets", 5)
    group:entry { item = "flyer", count = { 0, 2 }, probability = 30 }
    group:item("flyer_evac", 40)
    group:item("survnote", 3)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "mail_postal", kind = "collection" }
    group:group("greeting-cards_with_gifts", 25)
    group:entry { item = "letter", container = "envelope", probability = 50 }
    group:item("postcard", 50)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "packaging_postal", kind = "collection" }
    group:group("duct_tape_roll_part", 25)
    group:item("bubblewrap", 33)
    group:entry { item = "cardboard", count = { 10, 40 }, probability = 33 }
    group:entry { item = "box_small", count = { 1, 2 }, probability = 50 }
    group:entry { item = "postcard", count = { 1, 5 }, probability = 85 }
    group:entry { item = "envelope", count = { 2, 6 }, probability = 85 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "greeting-cards_with_gifts", kind = "distribution", container = "envelope" }
    group:item("greeting_card", 4, "generic_greeting_card")
    group:item("greeting_card", 1, "baby_shower_greeting_card")
    group:item("greeting_card", 1, "farewell_greeting_card")
    group:item("greeting_card", 1, "get_well_greeting_card")
    group:item("greeting_card", 1, "sympathy_greeting_card")
    group:entry {
        collection = {
            { item = "greeting_card", variant = "thank_you_greeting_card" },
            { item = "gift_card", probability = 33 },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            { item = "greeting_card", variant = "retirement_greeting_card" },
            { item = "gift_card", probability = 50 },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            { item = "greeting_card", variant = "congratulations_greeting_card" },
            { group = "banknotes", count = { 1, 10 }, probability = 66 },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            { item = "greeting_card", variant = "birthday_greeting_card" },
            { group = "banknotes", count = { 1, 5 }, probability = 66 },
            { item = "gift_card", probability = 50 },
        },
        probability = 1,
    }
    group:entry {
        collection = {
            { item = "greeting_card", variant = "friendship_greeting_card" },
            { item = "bracelet_friendship", probability = 50 },
        },
        probability = 1,
    }
    content.add(group)
end
