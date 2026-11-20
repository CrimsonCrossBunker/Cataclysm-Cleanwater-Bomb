local ccb = require("ccb")

ccb.content.define_item {
    id = "permanent_marker",
    name = ccb.content.plural_text("permanent marker", "permanent markers"),
    description = ccb.content.text("A King Size™ industrial-strength permanent marker, about halfway between a typical marker and a can of spray paint in size.  Activate it to write something down.  However, writing \"Elbereth\" probably won't help you."),
    mass = "28 g",
    volume = "50 ml",
    price = "5 USD",
    survival_price = "10 cent",
    materials = { "plastic" },
    symbol = ",",
    color = "dark_gray",
    pockets = { { kind = "MAGAZINE", ammunition = { permanent_ink = 500 }, watertight = true, rigid = true } },
    flags = { "WRITE_MESSAGE", "NO_RELOAD", "NO_UNLOAD" },
    tool = { charges_per_use = 1 },
    use_actions = {
        {
            kind = "inscribe",
            verb = ccb.content.text("Write"),
            gerund = ccb.content.text("Written"),
            on_terrain = true,
            material_restricted = false,
        },
    },
}
