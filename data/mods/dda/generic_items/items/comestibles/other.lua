local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "wax",
        name = ccb.content.plural_text("chunk of beeswax", "chunks of beeswax"),
        category = "spare_parts",
        mass_milligrams = 235000,
        color = "white",
        symbol = "%",
        description = ccb.content.text("A large chunk of beeswax.  Despite being used in some cooking recipes, beeswax in itself is indigestible to humans."),
        price_cents = 1300,
        price_postapoc_cents = 10,
        volume_ml = 250,
        stackable = true,
    }
    item:material("beeswax", 1)
    item:clear_flags()
    item:flag("UNRECOVERABLE")
    content.add(item)
end

do
    -- Calculated from cocktail napkins with roughly average (13lb/500sheets) thickness. 100in^2 * 13lb / 864in^2 = 1.5lb => 1.5lb / 500 = 0.003lb per napkin.
    -- Based on https://www.sizes.com/home/napkins.htm
    local item = content.Item {
        id = "napkin",
        name = ccb.content.plural_text("napkin", "napkins"),
        category = "spare_parts",
        mass_milligrams = 1360,
        color = "white",
        symbol = "`",
        description = ccb.content.text("A napkin.  Can be used for fires."),
        price_cents = 0,
        price_postapoc_cents = 0,
        volume_ml = 3,
        stackable = true,
    }
    item:material("paper", 1)
    item:clear_flags()
    item:flag("TINDER")
    content.add(item)
end

do
    local item = content.Item {
        id = "cardboard",
        name = ccb.content.plural_text("piece of cardboard", "pieces of cardboard"),
        looks_like = "paper",
        category = "spare_parts",
        mass_milligrams = 10000,
        color = "brown",
        symbol = "`",
        description = ccb.content.text("A piece of cardboard."),
        price_cents = 0,
        price_postapoc_cents = 0,
        volume_ml = 25,
        stackable = true,
    }
    item:material("cardboard", 1)
    content.add(item)
end
