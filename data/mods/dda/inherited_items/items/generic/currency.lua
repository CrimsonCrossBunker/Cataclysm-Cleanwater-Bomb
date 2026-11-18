local ccb = require("ccb")
local content = ccb.content

do
    -- Low carat gold alloy for hardness, but it's still the best part of an ounce of gold.  Yes, the weight is correct for the volume.
    local item = content.Item {
        id = "RobofacCoin",
        category = "currency",
        name = ccb.content.plural_text("Hub 01 Gold Coin", "Hub 01 Gold Coins"),
        description = ccb.content.text("A small but surprisingly heavy gold coin.  One side is etched with circuitry and the other side reads 'Hub 01 exchange currency'."),
        price_cents = 90000,
        price_postapoc_cents = 5000,
        mass_milligrams = 28000,
        volume_ml = 2,
        color = "yellow",
        symbol = "$",
    }
    item:clear_flags()
    item:flag("COIN_SHAPED")
    item:material("gold", 1)
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end

do
    local item = content.Item {
        id = "coin_half_dollar",
        category = "currency",
        name = ccb.content.plural_text("half-dollar coin", "half-dollar coins"),
        description = ccb.content.text("A fifty-cent coin, featuring a portrait of John F Kennedy.  You could flip it."),
        mass_milligrams = 11000,
        volume_ml = 1,
        price_cents = 50,
        price_postapoc_cents = 1,
        symbol = "o",
        color = "light_gray",
    }
    item:material("copper", 1)
    item:material("copper_nickel", 1)
    item:clear_flags()
    item:flag("OLD_CURRENCY")
    item:flag("COIN_SHAPED")
    item:clear_use_actions()
    item:native_use("COIN_FLIP")
    content.add(item)
end
