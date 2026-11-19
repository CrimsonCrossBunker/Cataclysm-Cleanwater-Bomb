local ccb = require("ccb")

ccb.content.define_item {
    id = "spear_knife",
    copy_from = "spear_knife",
    name = ccb.content.plural_text("simple knife spear", "simple knife spears"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item {
    id = "spear_spike",
    copy_from = "spear_spike",
    name = ccb.content.plural_text("spike on a stick", "spikes on sticks"),
    inheritance = { add = { flags = { "WOODEN_WEAPON" } } },
}

ccb.content.define_item { id = "stick", copy_from = "stick", inheritance = { add = { flags = { "WOODEN_WEAPON" } } } }
