local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fold_orichalcum_frame",
        name = ccb.content.plural_text("foldable orichalcum frame", "foldable orichalcum frames"),
        copy_from = "foldframe",
        looks_like = "foldframe",
        description = ccb.content.text("A folding frame made of orichalcum pipes.  Not as light as aluminum, but significantly sturdier."),
        mass_milligrams = 10000000,
        color = "yellow",
        price_cents = 10000,
    }
    item:material("orichalcum_metal", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "orichalcum_frame",
        name = ccb.content.plural_text("orichalcum frame", "orichalcum frames"),
        symbol = "]",
        description = ccb.content.text("A frame made of orichalcum.  Significantly sturdier than steel, but also much more expensive."),
        volume_ml = 20000,
        mass_milligrams = 100000000,
        color = "yellow",
        price_cents = 80000,
    }
    item:material("orichalcum_metal", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "light_orichalcum_frame",
        name = ccb.content.plural_text("light orichalcum frame", "light orichalcum frames"),
        copy_from = "orichalcum_frame",
        looks_like = "orichalcum_frame",
        description = ccb.content.text("A frame made of orichalcum.  Partially torn down in order to reduce weight at the cost of durability."),
        mass_milligrams = 40000000,
        price_cents = 30000,
    }
    content.add(item)
end
