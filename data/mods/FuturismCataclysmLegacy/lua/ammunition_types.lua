local ccb = require("ccb")
local content = ccb.content

content.upsert_ammunition_type(content.AmmunitionType {
    id = "fcl_5x50",
    name = ccb.content.text("5x50mm flechette"),
    default_item = "fcl_5x50dart",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "metal_rail",
    name = ccb.content.text("ferrous rail projectile"),
    default_item = "rebar_rail",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "fcl_fusion_pellet",
    name = ccb.content.text("fusion pellet"),
    default_item = "fcl_fusion_pellet",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "acidic_bore",
    name = ccb.content.text("acidic bore"),
    default_item = "acidic_bore",
})
