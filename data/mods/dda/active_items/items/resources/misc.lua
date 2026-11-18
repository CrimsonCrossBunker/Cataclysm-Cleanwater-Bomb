local ccb = require("ccb")
local content = ccb.content

do
    -- 48 hours
    local item = content.Item {
        id = "discharging_battery",
        name = ccb.content.plural_text("discharging lithium-ion battery", "discharging lithium-ion batteries"),
        symbol = "=",
        color = "dark_gray",
        description = ccb.content.text("A lithium-ion battery that is soaking in saltwater.  After about a day, it should have short-circuited and discharged its energy, leaving it safe to handle… ideally."),
        mass_milligrams = 1350000,
        volume_ml = 500,
        category = "other",
    }
    item:material("plastic", 1)
    item:material("steel", 1)
    item:clear_use_actions()
    item:transform_on_use {
        result = { target = "discharged_storage_battery" },
        message = ccb.content.text("You dump the colorful saltwater and dry the battery."),
        moves = 1000,
        minimum_age_turns = 172800,
        not_ready_message = ccb.content.text("The battery is still discharging."),
    }
    content.add(item)
end
