local ccb = require("ccb")

ccb.content.define_item {
    id = "plut_cell",
    name = ccb.content.text("plutonium fuel cell"),
    copy_from = "plut_cell",
    price = "2400 USD",
    survival_price = "2400 USD",
    ammunition = {},
}
