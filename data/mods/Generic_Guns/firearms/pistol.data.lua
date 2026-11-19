local ccb = require("ccb")

ccb.content.define_item {
    id = "pistol_levergun",
    copy_from = "henry_big_boy",
    name = ccb.content.text("cowboy carbine"),
    description = ccb.content.text("Since the early days of western expansion, when ammunition supply was infrequent, shooters sought to share ammo between their sidearms and long arms.  This tube magazine lever-action carbine allows the shooter to reduce the number of calibers carried and squeeze more power from their pistol ammunition."),
    variants = {},
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_pistol = 10 }, rigid = true } },
    gun = { ammunition = { "ammo_pistol" }, clip_size = 10 },
}

ccb.content.define_item {
    id = "pistol_machine",
    copy_from = "glock_18c",
    name = ccb.content.text("machine pistol"),
    description = ccb.content.text("This pistol is a tiny machinegun you can stuff into a holster, with which you could dump its magazine at a blistering rate into any close range foes.  Machine pistols mostly see use by vehicle crewmen or bodyguards of VIPs.  Due to its preposterous rate of fire it is difficult to control."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_mag", "pistol_smg_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol" } },
}

ccb.content.define_item {
    id = "pistol_medium",
    copy_from = "glock_19",
    name = ccb.content.text("defensive pistol"),
    description = ccb.content.text("A modern pistol fit for duty, military service, or personal defense, with a detachable box magazine and a reliable action.  Though its chambering is capable of meeting FBI penetration minimums, the lack of a shoulder stock limits its utility."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_mag", "pistol_smg_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol" } },
}

ccb.content.define_item {
    id = "pistol_pcc",
    copy_from = "m1carbine",
    name = ccb.content.text("survivalist carbine"),
    description = ccb.content.text("These small carbines share ammunition and magazines with common pistols, offering a more controllable carbine than a normal rifle, while also reducing ammunition costs.  Because of their compatibility, they pair well with duty pistols, allowing one to transition to a more stable weapon without carrying extra ammo or magazines."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_mag", "pistol_smg_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol" } },
}

ccb.content.define_item {
    id = "pistol_revolver",
    copy_from = "model_10_revolver",
    name = ccb.content.text("police revolver"),
    description = ccb.content.text("Revolvers like this, chambered for standard defensive calibers, were a favorite of police departments for nearly a century, up until the 1986 Miami shootout.  Afterwards, the slow reloading and shooting of revolvers were considered liabilities; still, this model's accuracy and moderate recoil make for a serviceable sidearm, and there are no magazines for you to lose or damage."),
    variants = {},
    volume = "400 ml",
    length = "25 cm",
    pockets = { { kind = "MAGAZINE", holster = true, ammunition = { ammo_pistol = 6 }, rigid = true } },
    gun = { ammunition = { "ammo_pistol" }, clip_size = 6 },
}

ccb.content.define_item {
    id = "pistol_smg",
    copy_from = "hk_mp5",
    name = ccb.content.text("submachine gun"),
    description = ccb.content.text("Chambered in common pistol ammunition, this compact long arm is perfect for trench raiders, vehicular crewmen, SWAT teams and special forces.  Though not as accurate as a proper rifle, especially at longer ranges, it is very controllable in automatic fire.  It feeds from detachable box magazines, which are easy to unload into close range targets."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_mag", "pistol_smg_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol" } },
}

ccb.content.define_item {
    id = "pistol_pipe_smg",
    copy_from = "smg_9mm",
    name = ccb.content.text("survivor subgun"),
    description = ccb.content.text("A crudely constructed fully automatic submachine gun, accepting standard pistol and submachine gun magazines.  The heavy bolt makes accurate fire difficult, and its questionable construction makes for poor reliability and longevity.  Similar designs of desperation from the Second World War served their nations well enough, so this should be good for zombies… right?  Accepts standard pistol ammunition."),
    variants = {},
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_mag", "pistol_smg_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol" } },
}
