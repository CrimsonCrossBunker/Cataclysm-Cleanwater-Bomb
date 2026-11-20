local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_gun_blackpowder",
    severity = "minor",
    name = ccb.content.text("Blackpowder fouling"),
    description = ccb.content.text("Firing blackpowder loads from a gun fouls it, which reduces reliability and, if left uncleaned, leads to rust.  It fouls the gun much faster than the use of modern smokeless powder cartridges.  Fouling is only a significant impact on reliability at high levels, but black powder fouling accumulates quickly."),
    item_prefix = ccb.content.text("rusting"),
    flags = { "BLACKPOWDER_FOULING_DAMAGE", "NO_DIRTYING" },
}

ccb.content.define_fault {
    id = "fault_gun_unlubricated",
    severity = "minor",
    name = ccb.content.text("Unlubricated"),
    description = ccb.content.text("Either this gun is brand new and came without lubrication or it was recently cleaned with a solvent without oiling afterwards.  Either way, it's not lubricated and will not cycle properly, and can even be damaged."),
    item_prefix = ccb.content.text("unlubricated"),
    flags = { "UNLUBRICATED", "BAD_CYCLING" },
}

ccb.content.define_fault {
    id = "fault_gun_dirt",
    severity = "minor",
    name = ccb.content.text("Fouling"),
    description = ccb.content.text("Fouling is caused by firing gunpowder loads repeatedly, which reduces reliability and can eventually cause damage to the gun.  Fouling accumulates slowly (unless blackpowder is used) due to the design of modern smokeless powder found in the vast majority of retail cartridges and it is not a significant problem until high levels of fouling are reached due to firing thousands of rounds without cleaning your firearm."),
}

ccb.content.define_fault {
    id = "fault_overheat_explosion",
    name = ccb.content.text("Fatal containment failure"),
    description = ccb.content.text("It got hot."),
}

ccb.content.define_fault {
    id = "fault_overheat_venting",
    name = ccb.content.text("Emergency venting"),
    description = ccb.content.text("This weapon can uncontrollably vent coolant when overheated."),
}

ccb.content.define_fault {
    id = "fault_overheat_melting",
    severity = "critical",
    name = ccb.content.text("Fused internals"),
    description = ccb.content.text("Excessive heat has rendered this weapon inoperable."),
    item_prefix = ccb.content.text("ruined", "prefix"),
    flags = { "RUINED_GUN" },
}

ccb.content.define_fault {
    id = "fault_overheat_safety",
    severity = "minor",
    name = ccb.content.text("Overheat safety"),
    description = ccb.content.text("This weapon will attempt to enter a cooling cycle when overheated."),
    flags = { "OVERHEATED_GUN" },
}

ccb.content.define_fault {
    id = "fault_overheat_forced_safety",
    severity = "minor",
    name = ccb.content.text("Overheat Protection"),
    description = ccb.content.text("This weapon will enter a cooling cycle when overheated."),
    flags = { "OVERHEATED_GUN" },
}

-- gun_mechanical_simple can be fixed on the fly
ccb.content.define_fault {
    id = "fault_fail_to_feed",
    severity = "minor",
    fault_type = "gun_mechanical_simple",
    name = ccb.content.text("Fail to feed"),
    description = ccb.content.text("This gun did not load the round in the chamber properly."),
    item_prefix = ccb.content.text("jammed"),
}

-- aka fail to extract
ccb.content.define_fault {
    id = "fault_gun_chamber_spent",
    severity = "minor",
    fault_type = "gun_mechanical_simple",
    name = ccb.content.text("Spent casing in chamber"),
    description = ccb.content.text("This gun currently has an empty casing in the chamber."),
    item_prefix = ccb.content.text("jammed"),
}

-- only closed bolt
ccb.content.define_fault {
    id = "fault_stovepipe",
    severity = "minor",
    fault_type = "gun_mechanical_simple",
    name = ccb.content.text("Stovepipe"),
    description = ccb.content.text("The casing of the cartridge is stuck in the ejection port without being properly ejected, forming an exhaust pipe shape."),
    item_prefix = ccb.content.text("jammed"),
}

-- only magazine-fed firearms
ccb.content.define_fault {
    id = "fault_double_feed",
    severity = "minor",
    fault_type = "gun_mechanical_simple",
    name = ccb.content.text("Double feed"),
    description = ccb.content.text("The magazine of the gun tried to put two rounds in the chamber at once."),
    item_prefix = ccb.content.text("jammed"),
}
