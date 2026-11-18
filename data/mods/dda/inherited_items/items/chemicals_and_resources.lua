local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "nanomaterial",
        category = "tool_magazine",
        price_cents = 5000,
        price_postapoc_cents = 10,
        name = ccb.content.plural_text("nanomaterial canister", "nanomaterial canisters"),
        symbol = "=",
        color = "light_gray",
        description = ccb.content.text("A steel canister containing carbon, iron, titanium, copper, and other elements in specifically engineered atomic-scale configurations.  A nanofabricator can assemble them into usable items."),
        volume_ml = 300,
        mass_milligrams = 250000,
        stackable = true,
    }
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:material("steel", 1)
    content.add(item)
end
