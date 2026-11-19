local ccb = require("ccb")

-- Density of 1.2 g/cm3
ccb.content.define_item {
    id = "polycarbonate_sheet",
    category = "spare_parts",
    name = ccb.content.text("polycarbonate sheet"),
    description = ccb.content.text("A polycarbonate sheet that can be used for, among other things, vacuum molding."),
    mass = "30 g",
    volume = "500 ml",
    price = "0 cent",
    survival_price = "25 cent",
    materials = { "plastic" },
    symbol = ")",
    stack_size = 20,
    color = "light_blue",
    flags = { "UNRECOVERABLE" },
    ammunition = { type = "NULL", count = 20 },
}
