local ccb = require("ccb")

ccb.content.define_item {
    id = "escape_stone",
    name = ccb.content.plural_text("portable portal", "portable portal"),
    description = "This defies easy description, it feels solid but the surface is yielding.  Looking at it you have a strange desire to call it a shelter.",
    symbol = "@",
    color = "magenta",
    mass = "10 g",
    volume = "250 ml",
    flags = { "SINGLE_USE" },
    tool = {},
}

ccb.content.define_item {
    id = "unstable_rift",
    copy_from = "escape_stone",
    name = ccb.content.plural_text("unstable rift", "unstable rift"),
    description = "This defies easy description, it feels solid but the surface is yielding.  Looking at it you have a strange desire to call it a door.",
    color = "red",
    tool = {},
}
