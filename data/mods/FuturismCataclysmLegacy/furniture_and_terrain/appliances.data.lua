local ccb = require("ccb")

ccb.content.define_furniture {
    id = "f_solar_unit_v3",
    copy_from = "f_solar_unit_v2",
    name = ccb.content.text("quantum solar panel array"),
    description = ccb.content.text("A collection of four quantum solar panels, ready to convert solar radiation into electric power with exotic photovoltaic materials."),
    color = "cyan",
    appliance_conversion = { furniture = "f_null", item = "ground_solar_panel_v3" },
    base_item = "ground_solar_panel_v3",
}
