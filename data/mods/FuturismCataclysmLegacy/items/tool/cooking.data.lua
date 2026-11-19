local ccb = require("ccb")

ccb.content.define_item {
    id = "fcl_atompot",
    name = ccb.content.plural_text("atompot", "atompots"),
    copy_from = "pressure_cooker",
    description = ccb.content.text("Rivtech's premiere self-heating kitchen appliance, complete with lid, hand-crafted with the power of the atom to reach any temperature in thirty seconds.  As bulky as it is, its plutonium power source means that it can be used to cook an absurd amount of meals without ever worrying about running low on power.  Unsurprisingly, sales weren't particularly good because of the prospect of irradiating your food, but internal shielding ensures that only trace amounts find their way into the center."),
    price = "300 USD",
    survival_price = "50 USD",
    materials = { "steel", "plastic" },
    looks_like = "pot",
    symbol = ")",
    color = "light_green",
    qualities = {
        { id = "COOK", level = 3 },
        { id = "BOIL", level = 2 },
        { id = "CONTAIN", level = 1 },
        { id = "CHEM", level = 1 },
        { id = "HOTPLATE", level = 2 },
    },
    flags = { "ALLOWS_REMOTE_USE" },
    tool = {},
    use_actions = { "HOTPLATE_ATOMIC" },
}
