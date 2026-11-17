local ccb = require("ccb")
local content = ccb.content

do
    local definition = content.Vitamin {
        id = "vitamin_psionic_drain",
        name = ccb.content.text("Nether-Attunement Counter"),
        kind = "counter",
        minimum = 0,
        maximum = 250,
        rate_turns = 300,
        excess = "effect_disease_psionic_drain",
    }
    definition:excess_range(15, 34)
    definition:excess_range(35, 54)
    definition:excess_range(55, 74)
    definition:excess_range(75, 94)
    definition:excess_range(95, 114)
    definition:excess_range(115, 134)
    definition:excess_range(135, 154)
    definition:excess_range(155, 174)
    definition:excess_range(175, 194)
    definition:excess_range(195, 214)
    definition:excess_range(215, 234)
    definition:excess_range(235, 250)
    content.add(definition)
end
do
    local definition = content.Vitamin {
        id = "passenger_pigeon_aura",
        name = ccb.content.text("Passenger Pigeon Aura"),
        kind = "counter",
        minimum = 0,
        maximum = 1000,
        rate_turns = 60,
        deficiency = "pigeon_aura_prep",
        excess = "pigeon_aura",
    }
    definition:deficiency_range(1, 400)
    definition:excess_range(401, 1000)
    content.add(definition)
end
content.add(content.Vitamin {
    id = "vitamin_maintained_powers",
    name = ccb.content.text("Maintained Powers Counter"),
    kind = "counter",
    minimum = 0,
    maximum = 100,
    rate_turns = 0,
})
content.add(content.Vitamin {
    id = "vitamin_psi_learning_counter",
    name = ccb.content.text("Psionic Powers Learning Counter"),
    kind = "counter",
    minimum = 0,
    maximum = 1,
    rate_turns = 0,
})
