local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "RAILGUN_THROW_MULTIPLIER",
    info = ccb.content.text("Its throwing multipliers apply only to throws powered by an active Railgun CBM."),
})
