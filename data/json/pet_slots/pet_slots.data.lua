local ccb = require("ccb")

ccb.content.define_pet_slot {
    id = "saddle",
    mount_only = true,
    required_flags = { "TACK" },
    sub_slots = { "saddlebag", "stirrup" },
    name = "saddle",
    description = "Holds tack used to control and ride a mount.",
}

ccb.content.define_pet_slot {
    id = "saddlebag",
    min_storage = "250 ml",
    mount_only = true,
    required_flags = { "SADDLE_BAG" },
    name = "saddlebag",
    description = "Holds a storage bag attached to an equipped saddle.",
}

ccb.content.define_pet_slot {
    id = "stirrup",
    mount_only = true,
    required_flags = { "STIRRUP" },
    name = "stirrups",
    description = "Holds stirrups that make mounting and mounted combat easier.",
}

ccb.content.define_pet_slot {
    id = "bridle",
    bodytypes = { "horse" },
    mount_only = true,
    name = "bridle",
    description = "Holds a separate head restraint for controlling a mount.",
}

ccb.content.define_pet_slot {
    id = "horseshoes",
    bodytypes = { "horse" },
    mount_only = true,
    name = "horseshoes",
    description = "Holds a fitted set of shoes on a horse's hooves.",
}

ccb.content.define_pet_slot {
    id = "armor",
    pet_armor = true,
    passive_effects = { "monster_armor" },
    name = "armor",
    description = "Holds fitted armor for the creature.",
}

ccb.content.define_pet_slot {
    id = "storage",
    min_storage = "250 ml",
    passive_effects = { "has_bag" },
    name = "storage",
    description = "Holds a container used to carry items.",
}
