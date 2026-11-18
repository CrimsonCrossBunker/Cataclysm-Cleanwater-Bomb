local ccb = require("ccb")
local content = ccb.content

do
    -- migrated, do not use and remove later
    local item = content.Item {
        id = "memory_card_unread",
        copy_from = "memory_card",
        looks_like = "memory_card",
        name = ccb.content.plural_text("memory card", "memory cards"),
    }
    content.add(item)
end

do
    local item = content.Item {
        id = "memory_card_science",
        copy_from = "memory_card",
        looks_like = "memory_card",
        name = ccb.content.plural_text("memory card (XEDRA)", "memory cards (XEDRA)"),
        description = ccb.content.text("A memory card, can be used to store data.  This one has a label on which is written 'XEDRA' followed by a long string of numbers."),
    }
    content.add(item)
end
