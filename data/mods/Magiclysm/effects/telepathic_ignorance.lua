local ccb = require("ccb")
local content = ccb.content

-- id is hardcoded, used by the Animist spell A Shadow in the Crowd
content.upsert_effect_type(content.EffectType {
    id = "telepathic_ignorance",
    name = "",
    description = "",
})

-- id is hardcoded, used by the Animist spell A Shadow in the Crowd
content.upsert_effect_type(content.EffectType {
    id = "telepathic_ignorance_self",
    name = "",
    description = "",
})
