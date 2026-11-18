local ccb = require("ccb")
local content = ccb.content

content.upsert_effect_type(content.EffectType {
    id = "invisibility",
    name = ccb.content.text("Invisibility"),
    description = ccb.content.text("Nothing can see you."),
    apply_message = ccb.content.text("You fade away."),
    remove_message = ccb.content.text("You can see your hands again."),
}
    :flag("INVISIBLE"))
