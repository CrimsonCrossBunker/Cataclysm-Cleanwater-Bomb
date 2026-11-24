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

ccb.content.define_item {
    id = "grenade_revolver",
    copy_from = "mgl",
    name = ccb.content.text("revolver grenade launcher"),
    description = ccb.content.text("Looking something like a large revolver from a cartoon this launcher is capable of firing six grenades in rapid succession.  Its huge cylinder is wound by a clock spring, which hastens firing, but slows reloading, as it must be re-wound.  Needless to say, six well placed shots is an incredible amount of firepower, depending on the cartridges loaded."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_grenade = 6 }, rigid = true } },
    gun = { ammunition = { "ammo_grenade" }, clip_size = 6 },
}

ccb.content.define_item {
    id = "grenade_pistol",
    copy_from = "m320",
    name = "grenade pistol",
    description = "A stubby single shot pistol with a large bore barrel, suitable for launching grenades or flares.  This is a slightly more convenient way to transport a grenade launcher than mounted to one's rifle, a practice more common among special forces.  In more recent years, variants were sold commercially to ostensibly launch flares.  With the right cartridges, this would be devastating against hard or soft targets.  This could be attached to a suitable rifle, if so desired.",
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ammo_grenade = 1 },
        },
    },
    use_actions = {
        {
            kind = "transform",
            target = "grenade_under",
            message = "You make the launcher ready for attachment.",
            menu_text = "Deploy as attachment",
        },
    },
    gun = {
        ammunition = { "ammo_grenade" },
        clip_size = 1,
    },
}
