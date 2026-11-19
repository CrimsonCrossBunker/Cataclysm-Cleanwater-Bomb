local ccb = require("ccb")

ccb.content.define_mutation {
    id = "iso_deliverator",
    name = ccb.content.text("The Deliverator"),
    points = 0,
    description = ccb.content.text("Every night you brave the highway, life-bound to a single promise: \"Your pie in thirty minutes or you can have it free.\"  People can respect that.  You are a role model.  A hero to the hungry.\n\nYou gain +1 quickness for each level of normality distortion."),
    categories = { "iso_start_perk" },
    enchantments = { "iso_ench_deliverator" },
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "iso_hypo_o",
    name = ccb.content.text("Hypocrite's Oath"),
    points = 0,
    description = ccb.content.text("I swear by Apollo the Healer, by Asclepius, by Hygieia, by Panacea, and by all the gods and goddesses, making them my witnesses, that I shall deliver, according to my ability and judgment, death.\n\nYou temporarily deal 50% more damage after being hurt.  The first time you bandage or disinfect a limb, it instantly heals by 10hp in addition to normal effects."),
    categories = { "iso_start_perk" },
    enchantments = { "iso_ench_hypo_o" },
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "iso_backup",
    name = ccb.content.text("Backup"),
    points = 0,
    description = ccb.content.text("We call this a tactical retreat.\n\nYou gain +50 movement speed for few moments after successfully dealing ballistic damage."),
    categories = { "iso_start_perk" },
    enchantments = { "iso_ench_backup" },
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "iso_robolove",
    name = ccb.content.text("Machine Whisperer"),
    points = 0,
    description = ccb.content.text("Error.  418 //I am a teapot.\n\nEvery 20 seconds, there's a small chance for nearby robots to become permanently friendly."),
    categories = { "iso_start_perk" },
    purifiable = false,
    valid = false,
}

ccb.content.define_mutation {
    id = "iso_geas",
    name = ccb.content.text("Ancient Vow"),
    points = 0,
    description = ccb.content.text("A lifetime ago you swore to protect your vanished homeland.  This oath binds you still.\n\nYou cannot flee from high danger enemies but gain increased damage and stamina regeneration when fighting them."),
    categories = { "iso_start_perk" },
    enchantments = { "iso_ench_geas_buff" },
    purifiable = false,
    valid = false,
}

-- Idea here is they can't have any NEW bionics because they're full up (and so they can't just cheat by finding fuel bionics)
ccb.content.define_mutation {
    id = "iso_bionic_vampire",
    name = ccb.content.text("Power Drain"),
    points = 0,
    description = ccb.content.text("Your cybernetic implants are constantly losing power, but a quirk of their design allows you regain power through murder.\n\nYou lose bionic power every second, but melee kills restore power, scaling with the danger level of your target."),
    categories = { "iso_start_perk" },
    enchantments = { "iso_bionic_vampire_buff" },
    purifiable = false,
    valid = false,
    flags = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation {
    id = "iso_eldritch_sorcery",
    name = ccb.content.text("Archmagister of the Gloaming Tower"),
    points = 0,
    description = ccb.content.text("You have spent long centuries poring over mouldering tomes and wresting knowledge from spirits who dwell within the translunary spheres and have forgotten more enchantments than some upstart conjurer will ever learn.\n\nWhen you pick up a ranged weapon, you will absorb its power into a new spell."),
    categories = { "iso_start_perk" },
    purifiable = false,
    valid = false,
    enchantments = { "iso_eldritch_sorcery_buff" },
}
