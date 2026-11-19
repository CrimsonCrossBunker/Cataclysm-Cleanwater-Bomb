local ccb = require("ccb")

ccb.content.define_item {
    id = "rocket_disposable",
    copy_from = "AT4",
    name = ccb.content.text("disposable rocket launcher"),
    description = ccb.content.text("Constructed of fiberglass, with crude plastic sights and a titanium barrel, this is a launcher for a single rocket.  Though not as effective as other anti-armor weapons, the true value in this disposable rocket launcher is its portability and lack of dead weight once expended.  Has a backblast, so make sure nothing you mind destroying is behind you."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_rocket = 1 }, rigid = true } },
    gun = { ammunition = { "ammo_rocket" }, clip_size = 1 },
}

ccb.content.define_item {
    id = "rocket_recoilless",
    copy_from = "m3_carlgustav",
    name = ccb.content.text("recoilless rocket launcher"),
    description = ccb.content.text("This heavy, gigantic rifled tube features a complex optical sight and can launch a wide variety of payloads, including rockets or laser guided missiles.  Depending on the warhead loaded, such weapons are effective against older tanks, most vehicles, bunkers and personnel.  These are meant to be operated by a two-man crew, so reloading might be a bit slow.  Its recoilless design allows for superior range and damage, but it produces tremendous backblast, so make sure nothing you mind destroying is behind you."),
    pockets = { { kind = "MAGAZINE", ammunition = { ammo_rocket = 1 }, rigid = true } },
    gun = { ammunition = { "ammo_rocket" }, clip_size = 1, default_mods = { "acog_scope" } },
}
