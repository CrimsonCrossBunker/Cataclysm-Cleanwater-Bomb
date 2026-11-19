local ccb = require("ccb")

ccb.content.define_item {
    id = "badge_zebra",
    copy_from = "badge_abstract",
    name = ccb.content.text("zebra badge"),
    description = ccb.content.text("A white piece of plastic with a picture of an agent and a barcode underneath.  The lack of other details on badges like it led to them being called 'Zebra Badges'.  It might grant basic access to some Xedra areas."),
    flags = { "SCIENCE_CARD_SECURITY_YELLOW" },
    armor = {},
    inheritance = { scale = { price = 2 } },
}
