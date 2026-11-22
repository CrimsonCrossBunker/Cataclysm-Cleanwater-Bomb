local ccb = require("ccb")

ccb.content.define_item {
    id = "translation_stone",
    name = ccb.content.plural_text("crystallized motion", "crystallized motion"),
    description = "This defies easy description, it feels solid but the surface is yielding.  Its edges blur when you look at it, but it feels perfectly still when you hold it.",
    symbol = "@",
    color = "magenta",
    mass = "10 g",
    volume = "250 ml",
    flags = { "SINGLE_USE" },
    tool = {},
}

ccb.content.define_item {
    id = "abjuration_stone",
    name = ccb.content.plural_text("inverted barrier", "inverted barrier"),
    description = "This defies easy description, it feels solid but the surface is yielding.  Looking at it, static creeps in on the edges of your vision.",
    symbol = "@",
    color = "magenta",
    mass = "10 g",
    volume = "250 ml",
    flags = { "SINGLE_USE" },
    tool = {},
}

ccb.content.define_item {
    id = "cascade_stone",
    name = ccb.content.plural_text("energy locus", "energy locus"),
    description = "This defies easy description, it feels solid but the surface is yielding.  The skin on your entire body tingles when you touch it.",
    symbol = "@",
    color = "magenta",
    mass = "10 g",
    volume = "250 ml",
    flags = { "SINGLE_USE" },
    tool = {},
}
