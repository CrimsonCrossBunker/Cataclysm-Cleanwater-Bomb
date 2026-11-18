local ccb = require("ccb")
local content = ccb.content

content.add(content.EffectType {
    id = "flaming_eye_warming_up",
    name = ccb.content.text("Flaming Eye Warming Up"),
    description = ccb.content.text("You got a bad feeling about this flaming eye's intentions."),
    apply_message = "",
    maximum_duration_turns = 60,
    rating = "bad",
})
