local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "tanning_hide_active",
        category = "spare_parts",
        name = ccb.content.plural_text("tanning leather hide", "tanning leather hides"),
        description = ccb.content.text("A treated animal hide that is undergoing the chemical processes required to become leather.  The process takes about 8 hours."),
        mass_milligrams = 600000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "brown",
        countdown_turns = 28800,
    }
    item:material("flesh", 1)
    item:material("leather", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "tanned_hide" }
    item:tool()
    content.add(item)
end

do
    local item = content.Item {
        id = "tanning_pelt_active",
        category = "spare_parts",
        name = ccb.content.plural_text("tanning fur pelt", "tanning fur pelts"),
        description = ccb.content.text("A treated animal pelt that is undergoing the chemical processes required to become fur.  The process takes about 8 hours."),
        mass_milligrams = 684000,
        volume_ml = 1000,
        price_cents = 0,
        price_postapoc_cents = 0,
        symbol = ",",
        color = "brown",
        countdown_turns = 28800,
    }
    item:material("fur", 1)
    item:material("flesh", 1)
    item:clear_flags()
    item:flag("NO_SALVAGE")
    item:flag("SPAWN_ACTIVE")
    item:transform_into { target = "tanned_pelt" }
    item:tool()
    content.add(item)
end
