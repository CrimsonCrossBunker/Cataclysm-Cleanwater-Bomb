local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    id = {
        "hollow_village5_roofs", "hollow_village6_roofs", "hollow_village7_roofs",
        "hollow_village8_roofs", "hollow_village9_roofs",
    },
    name = ccb.content.text("small village"),
    vision_levels = "roof_or_air",
    symbol = "v",
    color = "red",
    see_cost = "low",
    flags = { "RISK_HIGH" },
}
