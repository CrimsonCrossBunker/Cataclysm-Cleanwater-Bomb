local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "dreamer_coin_artifact",
        category = "container",
        name = ccb.content.plural_text("wallet", "wallets"),
        looks_like = "wallet",
        description = ccb.content.text("A small, flat case used to carry currency.  Each time you open it, it reveals new pockets, but all of them hold the same one coin, which you can't remove."),
        volume_ml = 200,
        mass_milligrams = 60000,
        price_cents = 1,
        price_postapoc_cents = 10,
        symbol = ")",
        color = "dark_gray",
        repair_like = "backpack",
    }
    item:material("plastic", 1)
    content.add(item)
end
