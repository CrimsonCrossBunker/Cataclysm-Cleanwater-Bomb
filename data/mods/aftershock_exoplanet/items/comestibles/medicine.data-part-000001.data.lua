local ccb = require("ccb")

ccb.content.define_item {
    id = "afs_medigel",
    copy_from = "disinfectant",
    name = ccb.content.plural_text("MediGel", "MediGels"),
    description = ccb.content.text("Mercurial brand medical gel; a thick, translucent substance that can be applied to wounds to seal them and promote rapid healing.  Perhaps the most useful medical invention ever devised, it's a staple of any first aid kit."),
    price = "200 USD",
    survival_price = "200 USD",
    volume = "500ml",
    default_container = "bag_iv",
    flags = { "NO_INGEST", "EDIBLE_FROZEN", "WATER_DISSOLVE" },
    comestible = { kind = "MED", servings = 2 },
    use_actions = {
        {
            kind = "heal",
            disinfectant_power = 4,
            bite = 0.95,
            moves = 3000,
            infect = 0.1,
            effects = { { id = "afs_medigel_eff_trigger", duration = "2 seconds" } },
        },
    },
}
