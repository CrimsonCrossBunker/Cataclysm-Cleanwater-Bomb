local ccb = require("ccb")

ccb.content.define_item {
    id = "mspider_box",
    name = ccb.content.plural_text("spider box", "spider boxes"),
    description = ccb.content.text("This is a small glass box that contains a spider that diligently works day and night to produce silk thread that it stores in a reservoir you can open and retrieve it from."),
    mass = "100 g",
    volume = "100 ml",
    price = "1 kUSD",
    survival_price = "1150 USD",
    materials = { "glass" },
    symbol = ";",
    color = "red",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { thread = 1000 } } },
    subtype_order = { "tool", "artifact" },
    tool = { ammo_types = { "thread" } },
    artifact = { charge = { recharge_type = "periodic", interval = "1 h", regenerate_ammo = true } },
}
