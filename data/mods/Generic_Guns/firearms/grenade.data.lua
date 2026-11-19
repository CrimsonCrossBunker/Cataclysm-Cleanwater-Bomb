local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_revolver",
    copy_from = "mgl",
    name = ccb.content.text("revolver grenade launcher"),
    description = ccb.content.text("Looking something like a large revolver from a cartoon this launcher is capable of firing six grenades in rapid succession.  Its huge cylinder is wound by a clock spring, which hastens firing, but slows reloading, as it must be re-wound.  Needless to say, six well placed shots is an incredible amount of firepower, depending on the cartridges loaded."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_grenade = 6 }, rigid = true } },
    gun = { ammunition = { "ammo_grenade" }, clip_size = 6 },
}
