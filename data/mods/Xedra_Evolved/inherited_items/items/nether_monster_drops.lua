local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "shoggoth_ooze",
        name = ccb.content.plural_text("protoplasmic ooze", "protoplasmic oozes"),
        description = ccb.content.text("A deeply disturbing ooze that seems to attempt to take on form over and over again, never quite succeeding.  The only thing it seems to manage are eyes that look around madly for a few seconds before dissolving back into the steaming gunk."),
        copy_from = "blood_mi-go",
        looks_like = "blood_mi-go",
        symbol = "/",
        color = "yellow",
        mass_milligrams = 275000,
        volume_ml = 250,
        phase = "liquid",
    }
    item:material("shoggoth_protoplasmic_ooze", 1)
    item:clear_flags()
    item:flag("TRADER_AVOID")
    item:conditional_names {
        { kind = "flag", key = "DIRTY", name = ccb.content.plural_text("protoplasmic spill", "protoplasmic spills") },
    }
    content.add(item)
end
