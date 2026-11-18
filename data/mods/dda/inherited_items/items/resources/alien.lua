local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "alien_pod_resin",
        category = "spare_parts",
        name = ccb.content.plural_text("alien resin pod", "alien resin pods"),
        description = ccb.content.text("A large pod the size of a beer keg, filled with gooey alien resin.  Squeezing it firmly causes resin to squirt from the broken stalk at the end, hardening within a few seconds of being exposed to the air."),
        mass_milligrams = 70000000,
        volume_ml = 22000,
        price_cents = 10000,
        price_postapoc_cents = 500,
        symbol = "0",
        color = "light_blue",
    }
    item:material("alien_resin", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:tool()
    content.add(item)
end
