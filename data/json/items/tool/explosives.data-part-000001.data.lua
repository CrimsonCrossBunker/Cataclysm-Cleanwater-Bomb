local ccb = require("ccb")

ccb.content.define_item {
    id = "firecracker",
    name = ccb.content.plural_text("firecracker", "firecrackers"),
    description = ccb.content.text("A solitary firecracker with a short fuse.  Use this item to light the fuse.  Of course, you will need a lighter or some matches to do so.  Shortly after you light the fuse it will explode, so throw it quickly!"),
    mass = "3 g",
    volume = "25 ml",
    price = "4 cent",
    survival_price = "10 cent",
    materials = { "paper" },
    symbol = ";",
    color = "red",
    tool = {},
    use_actions = {
        {
            kind = "transform",
            target = "firecracker_act",
            message = ccb.content.text("You light the firecracker."),
            need_fire = 1,
            need_wielding = true,
            menu_text = ccb.content.text("Light up"),
        },
    },
}
