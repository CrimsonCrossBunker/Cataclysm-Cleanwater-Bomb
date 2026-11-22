local ccb = require("ccb")

ccb.content.define_item {
    id = "oxyacetylene",
    name = ccb.content.plural_text("oxyacetylene", "oxyacetylene"),
    description = "Pressurized, dangerous acetylene gas.  Can be used for welding or cutting with a torch.",
    symbol = "=",
    color = "red",
    phase = "liquid",
    mass = "1 g",
    volume = "250 ml",
    price = "24 USD",
    survival_price = "5 USD",
    stackable = true,
    explode_in_fire = true,
    stack_size = 35,
    flags = { "NO_DROP", "IRREMOVABLE" },
    materials = { "hydrocarbons" },
    blast = { power = 20, shrapnel = 0 },
    ammunition = {
        type = "weldgas",
        count = 35,
        effects = { "COOKOFF" },
    },
}
