local ccb = require("ccb")

ccb.content.define_item {
    id = "art_staff",
    copy_from = "i_staff",
    name = ccb.content.plural_text("ancient staff", "ancient staffs"),
    description = ccb.content.text("A well-balanced stick of treated wood with metal caps.  A red stone is embedded in the handle.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}

ccb.content.define_item {
    id = "art_sword",
    copy_from = "longsword",
    name = ccb.content.plural_text("ancient sword", "ancient swords"),
    description = ccb.content.text("A sword made out of a striking black metal.  It is the only one of its kind.\nIt may have unknown powers; try activating them."),
    tool = {},
}
