local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_aerodyne_powerplant",
    copy_from = "engine_gasoline",
    name = ccb.content.plural_text("aerodyne power plant", "aerodyne power plants"),
    description = ccb.content.text("A massive turbine engine, used to power aerodynes.  Has a prodigiously high power output."),
    materials = { "qt_steel" },
    mass = "900 kg",
    volume = "900 L",
    price = "9 kUSD 600 USD",
    survival_price = "75 USD",
    engine = {},
}
