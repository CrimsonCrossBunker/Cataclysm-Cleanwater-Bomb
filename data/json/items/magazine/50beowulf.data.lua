local ccb = require("ccb")

ccb.content.define_item {
    id = "stanag20_beowulf",
    copy_from = "stanag20",
    name = ccb.content.text("retooled STANAG 20-round magazine"),
    description = ccb.content.text("This 20-round box magazine is compatible with STANAG rifles and has been modified to hold a single-stack, seven round column of .50-caliber Beowulf ammo.  The front lip of the magazine has been beveled to allow for reliable feeding of the Beowulf rounds into a properly converted weapon's chamber, and, happily, this modification hasn't interfered with the magazine's ability to hold standard ammunition."),
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["50beowulf"] = 7, ["223"] = 20, ["300blk"] = 20 },
        },
    },
    magazine = { ammunition = { "50beowulf", "223", "300blk" } },
}

ccb.content.define_item {
    id = "stanag20ranger_beowulf",
    copy_from = "stanag20ranger",
    name = ccb.content.plural_text("retooled STANAG 20-round magazine with ranger plate", "retooled STANAG 20-round magazines with ranger plates"),
    description = ccb.content.text("This 20-round box magazine is compatible with STANAG rifles and has been modified to hold a single-stack, seven round column of .50-caliber Beowulf ammo.  The front lip of the magazine has been beveled to allow for reliable feeding of the Beowulf rounds into a properly converted weapon's chamber, and, happily, this modification hasn't interfered with the magazine's ability to hold standard ammunition.  The bottom has been modified with a ranger plate attachment to allow it to clip to carabiners."),
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["50beowulf"] = 7, ["223"] = 30, ["300blk"] = 30 },
        },
    },
    magazine = { ammunition = { "50beowulf", "223", "300blk" } },
}

ccb.content.define_item {
    id = "stanag30_beowulf",
    copy_from = "stanag30",
    name = ccb.content.text("retooled STANAG 30-round magazine"),
    description = ccb.content.text("This 30-round box magazine is compatible with STANAG rifles and has been modified to hold a single-stack, 10-round column of .50-caliber Beowulf ammo.  The front lip of the magazine has been beveled to allow for reliable feeding of the Beowulf rounds into a properly converted weapon's chamber, and, happily, this modification hasn't interfered with the magazine's ability to hold standard ammunition."),
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            allowed_speedloaders = { "clip223_10rd" },
            ammunition = { ["50beowulf"] = 10, ["223"] = 30, ["300blk"] = 30 },
        },
    },
    magazine = { ammunition = { "50beowulf", "223", "300blk" } },
}

ccb.content.define_item {
    id = "stanag30ranger_beowulf",
    copy_from = "stanag30ranger",
    name = ccb.content.plural_text("retooled STANAG 30-round magazine with ranger plate", "retooled STANAG 30-round magazines with ranger plates"),
    description = ccb.content.text("This 30-round box magazine is compatible with STANAG rifles and has been modified to hold a single-stack, 10-round column of .50-caliber Beowulf ammo.  The front lip of the magazine has been beveled to allow for reliable feeding of the Beowulf rounds into a properly converted weapon's chamber, and, happily, this modification hasn't interfered with the magazine's ability to hold standard ammunition.  The bottom has been modified with a ranger plate attachment to allow it to clip to carabiners."),
    pockets = {
        {
            kind = "MAGAZINE",
            rigid = true,
            ammunition = { ["50beowulf"] = 10, ["223"] = 30, ["300blk"] = 30 },
        },
    },
    magazine = { ammunition = { "50beowulf", "223", "300blk" } },
}

ccb.content.define_item {
    id = "50beowulf_ar15mag",
    name = ccb.content.text(".50 Beowulf 10-round conversion magazine"),
    description = ccb.content.text("A detachable 10-round box magazine, nearly identical in size and shape to standard 30-round STANAG magazines, and able to be inserted into the same compatible rifles.  The magazine has been engineered to feed a single-stack column of .50 Beowulf ammunition into the chamber of an appropriately converted AR-style firearm."),
    mass = "226 g",
    volume = "290 ml",
    length = "190 mm",
    price = "29 USD 99 cent",
    survival_price = "2 USD 50 cent",
    materials = { "aluminum" },
    symbol = "#",
    color = "light_gray",
    flags = { "MAG_COMPACT" },
    pockets = { { kind = "MAGAZINE", rigid = true, ammunition = { ["50beowulf"] = 10 } } },
    magazine = { ammunition = { "50beowulf" } },
}
