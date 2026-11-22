local ccb = require("ccb")

ccb.content.define_mutation {
    id = "perk_artifact_resonance_detection",
    name = "Nether Resonator",
    description = "You get a tingling feeling when you hold the objects that the Cataclysm seems to have given anomalous properties to.  Activate to determine roughly how much resonance an artifact has.",
    points = 0,
    purifiable = false,
    valid = false,
    active = true,
    flags = { "PERK" },
    activation_message = "You close your eyes for a moment and look for the inner hum.",
    on_activate = "w16b_mut_activate_bombasticperks_51b0edbfc83d",
}
