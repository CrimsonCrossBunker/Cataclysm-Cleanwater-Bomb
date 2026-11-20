local ccb = require("ccb")

-- Due to #48019, time to recharge is half of the listed numbers.  When that is fixed, set this to 24 hours.
ccb.content.define_item {
    id = "xedra_dreamsmith_time_watch",
    copy_from = "pocketwatch",
    name = ccb.content.plural_text("time shattering pocket watch", "time shattering pocket watches"),
    description = ccb.content.text("A pocket watch made entirely of dreamdross.  It somehow still accurately tells the time.  Once per day, press the button on the right to briefly stop time for everything but you."),
    price = "1000 cent",
    survival_price = "100 cent",
    materials = { "forged_dreamstuff" },
    flags = { "WATCH", "ALARMCLOCK" },
    symbol = ";",
    color = "light_gray",
    pockets = { { kind = "MAGAZINE", ammunition = { xedra_time_charge = 1 }, airtight = true } },
    inheritance = { scale = { mass = 0.5 } },
    subtype_order = { "tool", "artifact" },
    tool = { charges_per_use = 1 },
    artifact = { charge = { recharge_type = "periodic", interval = "48 h", regenerate_ammo = true } },
    use_actions = { { kind = "cast_spell", spell = "xedra_dreamsmith_time_stop", no_fail = true, level = 0 } },
}
