local ccb = require("ccb")

ccb.content.define_item {
    id = "spearsling_canvas",
    copy_from = "spearsling",
    name = ccb.content.text("canvas spear strap"),
    description = ccb.content.text("A canvas strap tied around the torso for toting spears while keeping your hands free.  You have to duck to get through doors while one's in it, though.  Activate to holster/draw a weapon."),
    materials = { "canvas" },
    price = "25 USD",
    survival_price = "1 USD 50 cent",
    symbol = "[",
    color = "blue",
    armor = {},
}
