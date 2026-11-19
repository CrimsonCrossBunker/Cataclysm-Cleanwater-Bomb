local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_atomic_headlamp",
    category = "clothing",
    symbol = "[",
    color = "blue",
    looks_like = "wearable_light_on",
    name = ccb.content.plural_text("atomic headlamp", "atomic headlamps"),
    description = ccb.content.text("A custom-made headlamp, salvaged from an atomic lamp.  While the weight on your head is light, you had to awkwardly find a way to carry the base of the lamp, which provided the actual power.  The base now proudly sits strapped to your back."),
    price = "40 USD",
    survival_price = "15 USD",
    materials = { "aluminum", "nylon" },
    flags = { "LEAK_DAM", "RADIOACTIVE", "OVERSIZE", "PADDED", "ALLOWS_NATURAL_ATTACKS", "SPAWN_ACTIVE" },
    light = 15,
    mass = "4 kg",
    volume = "1500 ml",
    melee_damage = { bash = 2 },
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {
        portions = {
            {
                materials = { { id = "nylon", coverage = 100, thickness = 2 } },
                encumbrance = 1,
                layers = { "BELTED" },
                coverage = 50,
                covers = { "head" },
                subparts = { "head_crown", "head_forehead" },
            },
            {
                materials = { { id = "aluminum", coverage = 100, thickness = 5 } },
                encumbrance = 5,
                layers = { "NORMAL" },
                coverage = 50,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You close the headlamp's cover."),
            menu_text = ccb.content.text("Close cover"),
            target = "afs_atomic_headlamp_off",
        },
    },
}

ccb.content.define_item {
    id = "afs_atomic_headlamp_off",
    copy_from = "afs_atomic_headlamp",
    looks_like = "wearable_light",
    name = ccb.content.plural_text("atomic headlamp (covered)", "atomic headlamps (covered)"),
    description = ccb.content.text("A custom-made headlamp, salvaged from an atomic lamp.  While the weight on your head is light, you had to awkwardly find a way to carry the base of the lamp, which provided the actual power.  The base now proudly sits strapped to your back.  It is now covered, concealing the light."),
    flags = { "LEAK_DAM", "RADIOACTIVE", "OVERSIZE", "PADDED", "ALLOWS_NATURAL_ATTACKS" },
    light = 0,
    subtype_order = { "tool", "armor" },
    tool = {},
    armor = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You open the headlamp's cover."),
            menu_text = ccb.content.text("Open cover"),
            target = "afs_atomic_headlamp",
        },
    },
}
