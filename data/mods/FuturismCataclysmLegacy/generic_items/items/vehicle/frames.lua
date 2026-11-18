local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "fcl_superalloy_frame",
        copy_from = "hdframe",
        looks_like = "hdframe",
        name = ccb.content.plural_text("superalloy frame", "superalloy frames"),
        description = ccb.content.text("A large, reinforced superalloy frame, used in advanced vehicle construction.  Other vehicle components can be mounted on it, and it can be attached to other frames to increase the vehicle's size.  Its performance is exceptionally high for its low weight."),
        mass_milligrams = 36800000,
        price_cents = 1500000,
        price_postapoc_cents = 22500,
    }
    item:material("superalloy", 1)
    content.add(item)
end
