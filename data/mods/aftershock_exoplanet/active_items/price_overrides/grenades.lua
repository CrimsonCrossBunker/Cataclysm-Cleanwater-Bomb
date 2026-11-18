local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "smokebomb",
        name = ccb.content.plural_text("smoke bomb", "smoke bombs"),
        copy_from = "smokebomb",
        looks_like = "smokebomb",
        price_cents = 15000,
        price_postapoc_cents = 15000,
    }
    content.replace(item)
end
