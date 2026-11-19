local ccb = require("ccb")

-- 30 meters of thread per 1g, roughly 6 inches of thread per unit.
ccb.content.define_item {
    id = "thread_kevlar",
    category = "spare_parts",
    price = "50 USD",
    survival_price = "2 USD 50 cent",
    name = ccb.content.plural_text("Kevlar thread", "Kevlar thread"),
    symbol = "=",
    color = "light_gray",
    looks_like = "thread",
    description = ccb.content.text("Very durable Kevlar thread that would be particularly useful for making ballistic armor, though it's fine to use in place of normal thread too, in most cases.  Making armor-grade Kevlar sheets from this would need a particularly tight weave, and so would require some specialized machinery."),
    materials = { "kevlar" },
    flags = { "NO_SALVAGE" },
    volume = "200 ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = { type = "thread", count = 50 },
}

-- 30 meters of thread per 1g, roughly 6 inches of thread per unit.
ccb.content.define_item {
    id = "thread_nomex",
    category = "spare_parts",
    price = "50 USD",
    survival_price = "1 USD",
    name = ccb.content.plural_text("Nomex thread", "Nomex thread"),
    symbol = "=",
    color = "light_gray",
    looks_like = "thread",
    description = ccb.content.text("Heat-resistant Nomex thread that would be particularly useful for making heat protection gear, though it's fine to use in place of normal thread too, in most cases."),
    materials = { "nomex" },
    flags = { "NO_SALVAGE" },
    volume = "200 ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = { type = "thread", count = 50 },
}

-- 30 meters of thread per 1g, roughly 6 inches of thread per unit.
ccb.content.define_item {
    id = "thread_canvas",
    category = "spare_parts",
    price = "12 USD",
    survival_price = "2 USD 50 cent",
    name = ccb.content.plural_text("heavy duty thread", "heavy duty thread"),
    symbol = "=",
    color = "light_gray",
    looks_like = "thread",
    description = ccb.content.text("Some tough canvas-weight thread, sturdier than ordinary thread.  You could meticulously weave this into a sheet of canvas cloth.  It would also be useful for stitching such sheets together, though it's fine to use for normal tailoring projects too."),
    materials = { "canvas" },
    flags = { "NO_SALVAGE" },
    volume = "200 ml",
    mass = "1 g",
    stack_size = 200,
    ammunition = { type = "thread", count = 50 },
}
