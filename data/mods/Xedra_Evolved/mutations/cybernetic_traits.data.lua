local ccb = require("ccb")

-- When Hub01 is able to develop their own bionic installations they might receive this trait.
ccb.content.define_mutation {
    id = "XEDRA_CYBORG",
    name = ccb.content.text("XEDRA Neurobionic Interface"),
    points = 0,
    description = ccb.content.text("The compact bionic command and control interface interwoven with your nervous system had a previous life inside of a cybernetic tribesperson.  Best case scenario, none of them are on this Earth."),
    valid = false,
    purifiable = false,
    types = { "Cybernetic" },
    species_anger = { CYBORG = 95 },
    cancels = { "NO_CBM_INSTALLATION" },
}

ccb.content.define_mutation_type {
    id = "Cybernetic_expansion_data",
}

ccb.content.define_mutation {
    id = "XE_DATA_SHUNT2",
    name = ccb.content.text("Data Shunt, expansion"),
    points = 0,
    description = ccb.content.text("This is an expansion to your Neurobionic Interface.  It adds ports that can accept data cores which provide instantaneous proficiency knowledge."),
    valid = false,
    purifiable = false,
    types = { "Cybernetic_expansion_data" },
    bionic_slots = { data_shunt = 2 },
}
