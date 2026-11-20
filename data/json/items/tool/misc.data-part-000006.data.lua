local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_item {
    id = "tear_gas_payload_act",
    category = "weapons",
    name = ccb.content.text_without_extraction("active tear gas payload"),
    description = ccb.content.text_without_extraction("This is a dummy item used by tear gas hacks that just so happens to be counting down.  You should never see it outside of debug."),
    symbol = "*",
    color = "dark_gray",
    flags = { "TRADER_AVOID", "ZERO_WEIGHT", "SPAWN_ACTIVE" },
    tool = {},
    countdown_action = {
        kind = "explosion",
        field = "fd_tear_gas",
        field_radius = 3,
        field_minimum = 1,
        field_maximum = 3,
    },
}
