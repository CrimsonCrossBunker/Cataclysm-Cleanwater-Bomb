local ccb = require("ccb")
local content = ccb.content

content.add(content.MoraleType {
    id = "morale_telepathy",
    text = ccb.content.text("Thought-Editing"),
})

content.add(content.MoraleType {
    id = "morale_silent_one_drain",
    text = ccb.content.text("Malaise"),
})
