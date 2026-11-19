local ccb = require("ccb")

-- NO_I18N
-- NO_I18N
ccb.content.define_mutation {
    id = "NPC_TELEPATHY_IMMUNE",
    name = ccb.content.text_without_extraction("NPC Telepathy immunity"),
    points = 99,
    valid = false,
    description = ccb.content.text_without_extraction("For NPCs that should be immune to telepathy."),
    purifiable = false,
    flags = { "TEEPSHIELD" },
}
