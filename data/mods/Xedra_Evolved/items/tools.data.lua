local ccb = require("ccb")

ccb.content.define_item {
    id = "tailors_kit",
    name = ccb.content.plural_text("tailor's kit", "tailor's kits"),
    description = ccb.content.text("This is a high quality kit consisting of a variety of needles, some wooden spools for thread, some small scissors, and an awl.  Use a tailor's kit to customize your clothing and armor.  This uses your tailoring skill."),
    mass = "100 g",
    volume = "500 ml",
    price = "10 USD",
    survival_price = "10 USD",
    materials = { "wood", "steel" },
    symbol = ";",
    color = "red",
    qualities = {
        { id = "SEW", level = 4 },
        { id = "SEW_CURVED", level = 1 },
        { id = "KNIT", level = 1 },
        { id = "LEATHER_AWL", level = 2 },
        { id = "CUT", level = 2 },
        { id = "FABRIC_CUT", level = 2 },
    },
    pockets = { { kind = "MAGAZINE", ammunition = { thread = 400 } } },
    flags = { "ALLOWS_REMOTE_USE" },
    tool = { crafting_subtype = "sewing_kit", charges_per_use = 1, ammo_types = { "thread" } },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_fabric",
            materials = {
                "cotton", "leather", "lycra", "nylon", "wool", "fur", "faux_fur", "nomex", "kevlar",
                "kevlar_layered", "neoprene", "gutskin", "canvas", "denim", "fae_fur",
            },
            skill = "tailor",
            tool_quality = 1,
            cost_scaling = 0.1,
            move_cost = 800,
        },
    },
}

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

ccb.content.define_item {
    id = "hammer_bronze",
    copy_from = "hammer_bronze",
    qualities = {
        { id = "FEY_HAMMER", level = 3 },
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
    },
    tool = {},
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            materials = { "moon_tears", "moon_tears_fine_chain" },
            skill = "fabrication",
            tool_quality = -3,
            cost_scaling = 0.1,
            move_cost = 100,
        },
    },
}

ccb.content.define_item {
    id = "revenant_effigy",
    name = ccb.content.plural_text("revenant's effigy", "revenant's effigy"),
    description = "A macabre effigy made of meat and bone, with a heart filled with glass and faewild dust.  When the full moon will shine upon it, you will be able to use it to summon the Luna-attuned revenant.",
    symbol = "%",
    color = "magenta",
    mass = "91500 g",
    volume = "72500 ml",
    tool = {},
}

ccb.content.define_item {
    id = "hammer_fey_smith",
    copy_from = "hammer_peen",
    name = "fey smith's hammer",
    description = "This blacksmith's hammer is so full of delicate carvings and filigree it seems like it would snap at the first blow against heated metal.  Despite that, it doesn't have a single scratch or mark on it.",
    materials = {
        { id = "wood", portions = 5 },
        { id = "moon_tears" },
    },
    qualities = {
        { id = "FEY_HAMMER", level = 3, speed = 0.75 },
        { id = "HAMMER", level = 3 },
        { id = "HAMMER_FINE", level = 1 },
    },
    use_actions = {
        {
            kind = "repair_item",
            id = "repair_metal",
            skill = "fabrication",
            tool_quality = 1,
            move_cost = 100,
            cost_scaling = 0.1,
            materials = { "moon_tears", "moon_tears_fine_chain" },
        },
    },
    tool = {},
}
