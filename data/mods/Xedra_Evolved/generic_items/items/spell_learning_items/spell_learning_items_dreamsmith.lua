local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "brass_cylinders",
        category = "artifacts",
        looks_like = "gradcylinder",
        name = ccb.content.plural_text("set of brass cylinders", "sets of brass cylinders"),
        description = ccb.content.text("These brass cylinders are engraved with cuneiform and could be rolled across wet clay to create a page of writing per cylinder.  When you touch one of the cylinders you hear a faint voice whisper 'Enki'."),
        mass_milligrams = 32000,
        volume_ml = 10,
        price_cents = 2000,
        price_postapoc_cents = 10,
        symbol = "U",
        color = "magenta_yellow",
    }
    item:material("forged_dreamstuff", 1)
    item:clear_use_actions()
    item:teach_spells { "spell_oneiric_hammer" }
    content.add(item)
end
