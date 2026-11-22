local ccb = require("ccb")

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
