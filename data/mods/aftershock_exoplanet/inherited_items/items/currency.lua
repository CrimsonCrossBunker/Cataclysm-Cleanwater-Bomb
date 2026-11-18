local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "UICA_1d",
        category = "currency",
        name = ccb.content.plural_text("$1 chit", "$1 chits"),
        description = ccb.content.text("UICA's normally digital currency, rendered physical for use in the frontier.  Worth exactly 1 United Solar Denomination."),
        price_cents = 100,
        price_postapoc_cents = 100,
        mass_milligrams = 5000,
        volume_ml = 2,
        melee_to_hit = -3,
        color = "red",
        symbol = "$",
    }
    item:clear_flags()
    item:flag("COIN_SHAPED")
    item:flag("NO_UNLOAD")
    item:flag("NO_RELOAD")
    item:flag("OLD_CURRENCY")
    item:material("steel", 1)
    content.add(item)
end

do
    local item = content.Item {
        id = "gold_small",
        copy_from = "gold_small",
        looks_like = "gold_small",
        name = ccb.content.plural_text("gold", "gold"),
        description = ccb.content.text("Soft, shiny metal.  Near universally valuable across human cultures, and often kept aboard ships as emergency currency."),
        price_cents = 3000000,
        price_postapoc_cents = 3000000,
    }
    content.replace(item)
end
