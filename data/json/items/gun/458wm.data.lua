local ccb = require("ccb")

ccb.content.define_item {
    id = "win70_458",
    copy_from = "win70",
    looks_like = "win70",
    name = ccb.content.text("Safari rifle"),
    description = ccb.content.text("A bolt-action sporting rifle for hunting dangerous game, chambered in the powerful .458 Winchester Magnum cartridge."),
    variant_kind = "gun",
    variants = {
        {
            id = "win70_458_safari",
            name = ccb.content.text("Winchester Model 70 Safari rifle"),
            description = ccb.content.text("This is a Winchester Model 70 Safari Express chambered in .458 Winchester Magnum, a fine bolt-action rifle for hunting dangerous game.  A fixture of American gun culture, the Model 70 has been held in high regard by shooters since it was introduced in 1936."),
        },
    },
    mass = "4082 g",
    volume = "3205 ml",
    price = "1 kUSD 760 USD",
    survival_price = "50 USD",
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["458wm"] = 3 } } },
    gun = { ammunition = { "458wm" } },
}
