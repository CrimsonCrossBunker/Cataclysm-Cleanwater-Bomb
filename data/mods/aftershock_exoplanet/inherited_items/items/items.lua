local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nanomaterial",
        copy_from = "nanomaterial",
        looks_like = "nanomaterial",
        price_cents = 5500,
        price_postapoc_cents = 5500,
        name = ccb.content.plural_text("nanomaterial canister", "nanomaterial canisters"),
        description = ccb.content.text("A steel canister containing carbon, iron, titanium, copper, and other elements in specifically engineered atomic-scale configurations.  Feedstock for most modern industrial processes, a nanofabricator can assemble them into usable items."),
    }
    content.replace(item)
end
