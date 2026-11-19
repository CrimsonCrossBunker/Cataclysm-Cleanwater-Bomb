local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_voltaic_cartridge",
    copy_from = "afs_cartridge",
    name = ccb.content.text("voltaic cell"),
    description = ccb.content.text("A high-density energy cell purposely made to power voltaic weaponry."),
    mass = "20 g",
    volume = "125 ml",
    survival_price = "3 kUSD",
    flags = { "NO_UNLOAD", "NO_RELOAD", "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { battery = 1500 } } },
    magazine = { capacity = 1500 },
}
