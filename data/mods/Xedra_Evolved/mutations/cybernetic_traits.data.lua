local ccb = require("ccb")

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
