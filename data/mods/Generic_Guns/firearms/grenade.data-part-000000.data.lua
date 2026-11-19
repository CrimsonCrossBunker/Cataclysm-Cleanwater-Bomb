local ccb = require("ccb")

ccb.content.define_item {
    id = "grenade_blooper",
    copy_from = "m79",
    name = ccb.content.text("grenade launcher"),
    description = ccb.content.text("An older single shot grenade launcher, looking something like a sawn off shotgun.  Though it's mostly been replaced by underbarrel launchers, dedicated models like this have seen use by law enforcement and riot personnel.  Still deadly against hard or soft targets, depending on what cartridges are available."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_grenade = 1 }, rigid = true } },
    gun = { ammunition = { "ammo_grenade" }, clip_size = 1 },
}

ccb.content.define_item {
    id = "grenade_hmg",
    copy_from = "mark19",
    name = ccb.content.text("automatic grenade launcher"),
    description = ccb.content.text("This large, clumsy looking launcher looks like the offspring of a machine gun and a mortar; its bore is huge, and its action is just as massive.  A huge belt of grenade cartridges loads into its tray, allowing several grenades to be launched in rapid succession.  If one grenade fired from this isn't enough to solve your problems, surely a dozen more are.  This must be mounted on a frame to be fired, and reloading is a bit slow."),
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "grenade_belt" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_grenade" } },
}
