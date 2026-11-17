local ccb = require("ccb")
local content = ccb.content

content.add(content.MoraleType {
    id = "morale_iocus",
    text = ccb.content.text("Enjoyed Iocus"),
})

content.add(content.MoraleType {
    id = "morale_need_shiny_objects",
    text = ccb.content.text("Lacking shiny objects"),
})
