local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "gummed",
    name = ccb.content.text("Gummed"),
    description = ccb.content.text("You have some gum on you."),
    apply_message = ccb.content.text("You're covered in gum!"),
    rating = "bad",
    maximum_intensity = 6,
    maximum_duration_turns = 30,
    show_in_info = true,
}
    :description(ccb.content.text("You're covered in gum!"))
    :description(ccb.content.text("You're trapped in gum!"))
    :flag("EFFECT_IMPEDING")
    :modifier("speed", "amount", { base = -20, per_intensity = -20 })
    :miss_message(ccb.content.text("The gum webs constrict your movement."), 4))
