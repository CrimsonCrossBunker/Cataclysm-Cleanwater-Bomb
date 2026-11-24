local ccb = require("ccb")

-- Should add a Mercurial version with stronger performance enhancing effects later on.  As a quest/alliance reward?
ccb.content.define_item {
    id = "afs_synth_blood",
    name = ccb.content.plural_text("synthetic blood", "synthetic blood"),
    mass = "262 g",
    color = "white",
    default_container = "bag_iv",
    symbol = "~",
    survival_price = "250 USD",
    price = "250 USD",
    description = ccb.content.text("A chalk white blood analogue for emergency medical use.  Far more efficient at oxygenation than natural blood, it can also be used as a general performance enhancer.  Once injected, it will be metabolized or otherwise expunged from the body in around 8 hours."),
    materials = { "blood" },
    volume = "250 ml",
    phase = "liquid",
    flags = { "NO_INGEST", "NPC_SAFE", "EDIBLE_FROZEN" },
    comestible = {
        kind = "MED",
        quench = 5,
        servings = 1,
        healthy = -1,
        fun = -10,
        vitamins = { { id = "meat_allergen", amount = 1 } },
    },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You inject the %s."),
            tools_needed = { syringe = -1 },
            effects = { { id = "synth_blood_perf", duration = 28800 } },
            vitamins = { { id = "blood", minimum = 2500 }, { id = "redcells", minimum = 2500 } },
        },
    },
}

ccb.content.define_item {
    id = "afs_painkiller",
    name = ccb.content.plural_text("serendipnol", "serendipnols"),
    description = ccb.content.text("A very strong, synthetic narcotic built from alien biochemistry and used to treat intense pain while in the field.  You'll need to inject it, and it's very addictive, so be careful."),
    mass = "1 g",
    volume = "1 ml",
    price = "122 cent",
    survival_price = "1 USD",
    symbol = "!",
    color = "yellow",
    default_container = "bag_iv",
    flags = { "NO_INGEST", "EDIBLE_FROZEN" },
    comestible = { kind = "MED", fun = 6, addiction_potential = 10, addiction = "opiate" },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You shoot up."),
            tools_needed = { syringe = -1 },
            effects = { { id = "pkill3", duration = "40 minutes" }, { id = "pkill2", duration = "2 hours" } },
        },
    },
}

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

ccb.content.define_item {
    id = "afs_stimpack",
    name = ccb.content.plural_text("combat stim", "combat stims"),
    description = ccb.content.text("A small, disposable injector filled with a cocktail of stimulants and painkillers.  Will kick you from death's door into awareness, but it's not a long-term solution."),
    mass = "10 g",
    volume = "50 ml",
    price = "122 cent",
    survival_price = "1 USD",
    symbol = "!",
    color = "yellow",
    flags = { "NO_INGEST", "EDIBLE_FROZEN" },
    comestible = { kind = "MED", fun = 6, addiction_potential = 25, addiction = "amphetamine", stimulation = 40 },
    use_actions = {
        {
            kind = "consume_drug",
            message = ccb.content.text("You shove the stimpack against your chest."),
            moves = 15,
            effects = {
                { id = "pkill3", duration = "40 minutes" },
                { id = "afs_combat_stims", duration = "40 minutes" },
            },
        },
    },
}
