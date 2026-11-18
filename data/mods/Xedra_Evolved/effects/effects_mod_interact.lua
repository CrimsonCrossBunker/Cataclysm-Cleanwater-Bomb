local ccb = require("ccb")
local content = ccb.content

-- These are overriden in mod interactions
content.upsert_effect_type(content.EffectType {
    id = "effect_iron_allergy_wearing_iron",
    name = ccb.content.text("Touching Iron"),
    description = ccb.content.text("You are in contact with iron.  It will cause you pain and discomfort until removed."),
})

content.upsert_effect_type(content.EffectType {
    id = "effect_iron_allergy_wearing_steel",
    name = ccb.content.text("Touching Steel"),
    description = ccb.content.text("You are in contact with steel.  It will cause you pain and discomfort until removed."),
})
