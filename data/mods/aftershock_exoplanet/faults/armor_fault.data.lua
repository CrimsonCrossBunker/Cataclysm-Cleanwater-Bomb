local ccb = require("ccb")

ccb.content.define_fault {
    id = "fault_armor_carbide",
    name = ccb.content.text("damaged"),
    description = ccb.content.text("Fractures and cracks have formed across the carbide panels of this armor piece, reducing its effectiveness."),
    fault_type = "mechanical_damage",
    item_prefix = ccb.content.text("damaged"),
    message = ccb.content.text("%s was damaged!"),
    degradation_mod = 100,
    price_modifier = 0.3,
    armor = {
        { damage_type = "bash", multiply = 0.6 },
        { damage_type = "cut", multiply = 0.6 },
        { damage_type = "stab", multiply = 0.8 },
        { damage_type = "bullet", multiply = 0.6 },
        { damage_type = "afs_laser", multiply = 0.6 },
    },
}

ccb.content.define_fault {
    id = "fault_armor_carbide_bad",
    name = ccb.content.text("compromised"),
    affected_by_degradation = true,
    description = ccb.content.text("The carbide panels of this armor piece are heavily fractured and cracked, to the point where you can see the hexagonal polymer backing underneath.  The whole piece should be replaced as soon as possible."),
    fault_type = "mechanical_damage",
    item_prefix = ccb.content.text("compromised"),
    message = ccb.content.text("%s was heavily damaged!"),
    degradation_mod = 100,
    price_modifier = 0.01,
    armor = {
        { damage_type = "bash", multiply = 0.3 },
        { damage_type = "cut", multiply = 0.6 },
        { damage_type = "stab", multiply = 0.3 },
        { damage_type = "bullet", multiply = 0.3 },
        { damage_type = "afs_laser", multiply = 0.4 },
        { damage_type = "afs_plasma", multiply = 0.1 },
    },
}

ccb.content.define_fault {
    id = "afs_fault_armor_steel",
    name = ccb.content.text("damaged"),
    description = ccb.content.text("Successive impacts have dented and weakened the steel panels of this armor piece, reducing its effectiveness."),
    fault_type = "mechanical_damage",
    item_prefix = ccb.content.text("damaged"),
    message = ccb.content.text("%s was damaged!"),
    degradation_mod = 100,
    price_modifier = 0.3,
    armor = {
        { damage_type = "bash", multiply = 0.6 },
        { damage_type = "cut", multiply = 0.9 },
        { damage_type = "stab", multiply = 0.9 },
        { damage_type = "bullet", multiply = 0.6 },
        { damage_type = "afs_laser", multiply = 0.6 },
    },
}

ccb.content.define_fault {
    id = "afs_fault_armor_steel_bad",
    name = ccb.content.text("compromised"),
    affected_by_degradation = true,
    description = ccb.content.text("Most of the steel panels of this armor piece have been torn away or completely destroyed.  It won't provide much protection at all, and could at best be recycled for scrap."),
    fault_type = "mechanical_damage",
    item_prefix = ccb.content.text("compromised"),
    message = ccb.content.text("%s was heavily damaged!"),
    degradation_mod = 100,
    price_modifier = 0.01,
    armor = {
        { damage_type = "bash", multiply = 0.3 },
        { damage_type = "cut", multiply = 0.6 },
        { damage_type = "stab", multiply = 0.3 },
        { damage_type = "bullet", multiply = 0.3 },
        { damage_type = "afs_laser", multiply = 0.4 },
        { damage_type = "afs_plasma", multiply = 0.1 },
    },
}
