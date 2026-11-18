local ccb = require("ccb")
local content = ccb.content

-- Hidden effect, used since item flags can't be detected by jmath
content.add(content.EffectType {
    id = "effect_magiclysm_spellcasting_aid_item_wielded",
    name = "",
    description = "",
})
