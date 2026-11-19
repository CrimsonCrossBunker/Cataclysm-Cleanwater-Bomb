local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_jetpack",
    name = ccb.content.plural_text("rocket pack", "rocket packs"),
    description = ccb.content.text("A back mounted rocket pack, its well worn superalloy nozzles seem to suggest great age.  Units like this one are rarely used by elite military forces and by scavenger-explorers hoping to find high value salvage.  Not powerful enough to enable true flight within a gravity well, but it may still be used to perform short jumps and air-dashes."),
    mass = "4350 g",
    volume = "15 L",
    price = "50 kUSD",
    survival_price = "50 kUSD",
    materials = { "vacuum_carbide_hard" },
    symbol = "[",
    looks_like = "rpg",
    pockets = {
        {
            kind = "MAGAZINE",
            description = ccb.content.text("The rocket pack fuel tank.  Holds up to 10 liters of pressurized fuel."),
            rigid = true,
            watertight = true,
            ammunition = { ammonia_liquid = 10 },
        },
    },
    color = "white",
    flags = { "BELTED", "JETPACK", "MUNDANE" },
    max_worn = 1,
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, turns_per_charge = 30, ammo_types = { "ammonia_liquid" } },
    armor = {
        warmth = 6,
        thickness = 5,
        portions = {
            {
                encumbrance = 10,
                coverage = 60,
                covers = { "torso" },
                subparts = { "torso_hanging_back" },
            },
        },
    },
    artifact = { enchantments = { "afs_ench_jetpack_sprint" } },
    use_actions = {
        {
            kind = "cast_spell",
            spell = "spell_rocket_jump",
            no_fail = true,
            level = 1,
            mundane = true,
        },
        {
            kind = "transform",
            ammo_scale = 0,
            target = "afs_jetpack_active",
            menu_text = ccb.content.text("Activate"),
            message = ccb.content.text("You ignite the rocket pack thrusters."),
            need_charges = 1,
            need_charges_message = ccb.content.text("The fuel tank is empty."),
        },
    },
}

ccb.content.define_item {
    id = "afs_jetpack_active",
    copy_from = "afs_jetpack",
    name = ccb.content.plural_text("rocket pack", "rocket packs"),
    revert_to = "afs_jetpack",
    inheritance = { add = { flags = { "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = {},
    armor = {},
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            target = "afs_jetpack",
            menu_text = ccb.content.text("Deactivate"),
            message = ccb.content.text("You stop using the rocket pack."),
        },
        {
            kind = "cast_spell",
            spell = "spell_rocket_jump",
            no_fail = true,
            level = 1,
            mundane = true,
        },
    },
}
