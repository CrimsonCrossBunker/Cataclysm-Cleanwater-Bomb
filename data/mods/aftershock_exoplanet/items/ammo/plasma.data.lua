local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_shydrogen",
    name = ccb.content.plural_text("solid hydrogen", "solid hydrogen"),
    description = ccb.content.text("Pressurized and cryo-cooled rods of solidified hydrogen, used within plasma weapons or portable powerplants."),
    mass = "1 g",
    volume = "12 ml",
    price = "10 USD",
    survival_price = "10 USD",
    materials = { "hydrogen_cell" },
    symbol = "=",
    color = "light_blue",
    phase = "gas",
    ammunition = { type = "afs_shydrogen", range = 0, count = 1, effects = { "IGNITE" } },
}
