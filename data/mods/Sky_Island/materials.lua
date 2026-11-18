local ccb = require("ccb")
local content = ccb.content

content.add(content.Material {
    id = "alien_resin_windblock",
    copy_from = "alien_resin",
    name = ccb.content.text("Resin"),
    wind_resistance = 100,
})
