local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "ANTI_EVIL_EYE_GEAR",
    info = ccb.content.text("Wearing this will protect you from the Evil Eye."),
})

content.add(content.JsonFlag { id = "HIGH_HEELS" })

content.add(content.JsonFlag {
    id = "IS_GRIPPED",
    info = ccb.content.text("You are holding this object really hard, so hard it cannot be removed from your hand unless you die.  Activate the unopenable grip perk again to be able to drop this object."),
})
