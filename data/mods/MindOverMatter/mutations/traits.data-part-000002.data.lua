local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PSI_EXTENDED_CHANNELING_active",
    name = ccb.content.text_without_extraction("Extended Channeling Active"),
    points = 0,
    description = ccb.content.text_without_extraction("The active trait for Extended Channeling.  It's a bug if you can see it."),
    valid = false,
    player_display = false,
}
