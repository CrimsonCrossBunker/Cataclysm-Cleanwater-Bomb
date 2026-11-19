local ccb = require("ccb")

ccb.content.define_item {
    id = "pistol_tiny_rifle",
    copy_from = "marlin_9a",
    name = ccb.content.text("plinker carbine"),
    description = ccb.content.text("With near non-existent recoil and inexpensive ammunition, rifles like this one are popular introductory firearms.  It has a built in magazine, capable of holding an impressive amount of its small cartridges.  You could take small game with this, but anything bigger might not even notice."),
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_tiny_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol_tiny" }, clip_size = 19 },
}

ccb.content.define_item {
    id = "pistol_tiny_target",
    copy_from = "ruger_mk4",
    name = ccb.content.text("target pistol"),
    description = ccb.content.text("This medium sized pistol fires cheap and plentiful plinking ammo, and is exceptionally popular for practice or target shooting.  This pistol is unsuited for taking on anything but small game, as it is meant to poke holes in paper.  Accepts box magazines."),
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            holster = true,
            capacity = "20 L",
            mass_limit = "20 kg",
            allowed_items = { "pistol_tiny_mag" },
            rigid = true,
        },
    },
    gun = { ammunition = { "ammo_pistol_tiny" } },
}

ccb.content.define_item {
    id = "pistol_tiny_zip",
    copy_from = "ruger_lcr_22",
    name = ccb.content.text("zip gun"),
    description = ccb.content.text("A crude single shot firearm made from improvised or homemade components, chambered for tiny plinking ammunition.  Zip guns like these often turned up in the hands of criminals and insurgents.  There's no extractor, so it might be slow to reload, and its construction leaves its longevity in question."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_pistol_tiny = 1 }, rigid = true } },
    gun = { ammunition = { "ammo_pistol_tiny" }, clip_size = 1 },
}
