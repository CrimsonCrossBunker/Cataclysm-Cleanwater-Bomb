local ccb = require("ccb")

-- nv goggles weight 1020g.  hub armor rig weight 960g for full body.  figure this strikes a decent midpoint, esp.  since weight here becomes head encumb.  materials wise, same nylon/kevlar weave as the poncho; the visor is being handwaved per the riot helmet and motorcycle helmet visors as precedent.
ccb.content.define_item {
    id = "robofac_head_rig",
    category = "armor",
    name = ccb.content.plural_text("Hub 01 modular recon headgear", "Hub 01 modular recon headgear"),
    looks_like = "tac_helmet",
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer, made with robust Nylon sheeting reinforced with Kevlar fibers.  The top consists of a series of plastic plates with hooks and velcro strips, perhaps for attaching additional parts.  On the forehead of the assembly is a bulky box visor on a mechanism to quickly pull it down over your eyes, with a cover on the side to insert standard batteries.  Activate to lower the visor and use the light amplification functions."),
    mass = "1200 g",
    volume = "1200 ml",
    price = "100 USD",
    survival_price = "20 USD",
    materials = { "nylon", "kevlar" },
    symbol = "[",
    color = "dark_gray",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM" },
            default_magazine = "medium_battery_cell",
        },
        {
            kind = "CONTAINER",
            ablative = true,
            volume_encumbrance = 0,
            capacity = "5000 ml",
            mass_limit = "5 kg",
            moves = 200,
            description = ccb.content.text("Hooks for an armored helm plate."),
            allowed_flags = { "ABLATIVE_HELMET" },
        },
    },
    flags = { "VARSIZE", "WATERPROOF", "STURDY", "PADDED", "OUTER", "RAINPROOF", "SOFT", "MUNDANE" },
    techniques = { "WBLOCK_1" },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { charges_per_use = 1, ammo_types = "battery" },
    armor = {
        warmth = 5,
        thickness = 3,
        portions = { { covers = { "head" }, coverage = 95, encumbrance_modifiers = { "NONE" } } },
    },
    artifact = {},
    use_actions = {
        {
            kind = "transform",
            message = ccb.content.text("You lower the visor and flick the control dial to light amplification mode."),
            target = "robofac_head_rig_nv",
            need_charges = 1,
            need_charges_message = ccb.content.text("The batteries are dead."),
        },
    },
}

-- works out at 20 eye encumb in game, same as normal NV/IRs
ccb.content.define_item {
    id = "robofac_head_rig_nv",
    category = "armor",
    copy_from = "robofac_head_rig",
    name = ccb.content.plural_text("Hub 01 modular recon headgear (NV+IR)", "Hub 01 modular recon headgear (NV+IR)"),
    description = ccb.content.text("Heavy duty hooded headwear for the true frontier explorer.  The visor has been lowered over the eyes, and is drawing low power to provide light amplification by way of an infrared illuminator and detector.  Lets you see in the dark, and detects heat signatures emitted by (un)living organisms.  Activate again to turn off and stow the visor."),
    revert_to = "robofac_head_rig",
    inheritance = { add = { flags = { "GNV_EFFECT", "SPAWN_ACTIVE" } } },
    subtype_order = { "tool", "armor", "artifact" },
    tool = { power_draw = "320 mW" },
    armor = {
        portions = {
            { covers = { "head" }, coverage = 95, encumbrance_modifiers = { "NONE" } },
            {
                materials = {
                    { id = "plastic", coverage = 100, thickness = 4.0 },
                    { id = "steel", coverage = 100, thickness = 2.0 },
                },
                covers = { "eyes" },
                rigid_only = true,
                coverage = 100,
                encumbrance = 30,
                layers = { "BELTED" },
            },
        },
    },
    artifact = { enchantments = { "nvg_good", "THERMAL_VISION_GOOD" } },
    use_actions = {
        {
            kind = "transform",
            ammo_scale = 0,
            menu_text = ccb.content.text("Turn off"),
            message = ccb.content.text("You flick the visor off, and push it off your face."),
            target = "robofac_head_rig",
        },
    },
}
