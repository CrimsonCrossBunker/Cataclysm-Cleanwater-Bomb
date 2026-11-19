local ccb = require("ccb")

ccb.content.define_item {
    id = "inventor_gaming_rig",
    name = ccb.content.plural_text("Oneiromantic gaming rig", "Oneiromantic gaming rigs"),
    description = ccb.content.text("One of the harsh realities of being an inventor is needing to devote a third of your time to sleep and then devote some time to do non-inventor fun things.  This little wonder alleviates this issue by turning your sleep time in entertainment time through application of your deductive power!  Have it on your person while you sleep and your dreams will become anything you want!  No nightmare will disturb you, for you decide if they happen at all!"),
    materials = { "steel" },
    symbol = "n",
    volume = "750 ml",
    mass = "1 kg",
    pockets = {
        {
            kind = "MAGAZINE_WELL",
            rigid = true,
            allowed_flags = { "BATTERY_MEDIUM", "BATTERY_HEAVY" },
            default_magazine = "inventor_heavy_cell",
        },
    },
    flags = { "ELECTRONIC", "INVENTOR_CRAFTED" },
    faults = { { group = "electronic_general" } },
    subtype_order = { "tool", "artifact" },
    tool = { ammo_types = "battery" },
    artifact = { enchantments = { "ench_inventor_gaming_rig" } },
    use_actions = {
        {
            kind = "transform",
            target = "inventor_gaming_rig_on",
            need_charges = 1,
            message = ccb.content.text("The gaming rig is activated."),
        },
    },
}
