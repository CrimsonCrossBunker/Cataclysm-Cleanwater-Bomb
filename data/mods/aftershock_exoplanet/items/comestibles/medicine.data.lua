local ccb = require("ccb")

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
