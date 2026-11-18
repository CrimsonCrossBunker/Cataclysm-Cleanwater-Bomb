local content = require("ccb").content

content.add(content.Material {
    id = "alien_resin_windblock",
    copy_from = "alien_resin",
    name = content.text("Resin"),
    wind_resistance = 100,
})
