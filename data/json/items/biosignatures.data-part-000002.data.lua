local ccb = require("ccb")

ccb.content.define_item {
    id = "fetid_goop",
    name = "fetid goop",
    description = "A foul-smelling goop.  It has a disgusting texture and a powerful smell that overwhelms every other smell around it.",
    symbol = "~",
    color = "white",
    mass = "750 g",
    volume = "1 L",
    flags = { "INEDIBLE" },
    use_actions = {
        {
            kind = "change_scent",
            scent_typeid = "sc_fetid",
            duration = "1 h",
            moves = 200,
            charges_to_use = 1,
            effects = {
                { id = "fetid_goop", duration = 3600 },
            },
        },
    },
}
