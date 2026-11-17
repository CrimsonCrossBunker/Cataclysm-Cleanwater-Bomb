local ccb = require("ccb")
local content = ccb.content

content.upsert_ammunition_type(content.AmmunitionType {
    id = "dragon_blood",
    name = ccb.content.text("dragon blood"),
    default_item = "dragon_blood",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "blood_tainted",
    name = ccb.content.text("tainted blood"),
    default_item = "blood_tainted",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "blood",
    name = ccb.content.text("blood"),
    default_item = "blood",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "mana_infused_blood",
    name = ccb.content.text("mana infused blood"),
    default_item = "mana_infused_blood",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "arrow_orichalcum",
    name = ccb.content.text("orichalcum arrow"),
    default_item = "arrow_odin",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "alumentum",
    name = ccb.content.text("alumentum"),
    default_item = "alumentum",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "parabolan_yarn",
    name = ccb.content.text("parabolan yarn"),
    default_item = "parabolan_yarn",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "elastic_potential_energy",
    name = ccb.content.text("elastic potential energy"),
    default_item = "elastic_potential_energy",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "biomancer_booster_sludge",
    name = ccb.content.text("biomancer booster sludge"),
    default_item = "biomancer_booster_sludge",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "mag_awakened_water",
    name = ccb.content.text("Awakened Water"),
    default_item = "mag_awakened_water",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "crystallized_mana",
    name = ccb.content.text("crystallized mana"),
    default_item = "crystallized_mana",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "mana",
    name = ccb.content.text("mana energy"),
    default_item = "mana",
})
