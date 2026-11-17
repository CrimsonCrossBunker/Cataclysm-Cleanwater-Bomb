local ccb = require("ccb")
local content = ccb.content

content.upsert_ammunition_type(content.AmmunitionType {
    id = "acidic_bore",
    name = ccb.content.text("acidic bore"),
    default_item = "acidic_bore",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "xray_laser_barrel",
    name = ccb.content.text("ray laser barrel"),
    default_item = "xray_laser_barrel",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_foam",
    name = ccb.content.text("industrial foam"),
    default_item = "afs_foamcrete",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_shydrogen",
    name = ccb.content.text("solid hydrogen"),
    default_item = "afs_shydrogen",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "3x35",
    name = ccb.content.text("3x35mm"),
    default_item = "3x35dart",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_25mm",
    name = ccb.content.text("25mm"),
    default_item = "afs_25mm_shot",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_shuttle_beacon",
    name = ccb.content.text("signaling payload"),
    default_item = "afs_shuttle_beacon",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_25mm_smart",
    name = ccb.content.text("25mm microjet"),
    default_item = "afs_25mm_smart",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_10mm",
    name = ccb.content.text("10mm"),
    default_item = "afs_10mm_caseless_JHP",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_10mm_smart",
    name = ccb.content.text("10mm microjet"),
    default_item = "afs_10mm_smart",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_7.50mm",
    name = ccb.content.text("7.50mm"),
    default_item = "afs_7.50mm_caseless",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_7.50mm_smart",
    name = ccb.content.text("7.50mm microjet"),
    default_item = "afs_7.50mm_smart",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_82mm_flashbulb",
    name = ccb.content.text("82x225mm flashbulb"),
    default_item = "afs_82mm_flashbulb",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "metal_rail",
    name = ccb.content.text("ferrous rail projectile"),
    default_item = "steel_rail",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "30x200mm",
    name = ccb.content.text("30x200mm railgun slug"),
    default_item = "afs_30x200mm",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "afs_5x50",
    name = ccb.content.text("5x50mm flechette"),
    default_item = "afs_5x50dart",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "exo_connector",
    name = ccb.content.text("exosuit interface fitting"),
    default_item = "exo_connector",
})
