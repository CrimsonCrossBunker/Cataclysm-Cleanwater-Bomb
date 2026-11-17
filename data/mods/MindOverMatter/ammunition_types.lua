local ccb = require("ccb")
local content = ccb.content

content.upsert_ammunition_type(content.AmmunitionType {
    id = "mom_pulse_rifle_ammo",
    name = ccb.content.text("Pulse rifle charge"),
    default_item = "mom_pulse_rifle_ammo",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "psionic_charge_power",
    name = ccb.content.text("matrix charge"),
    default_item = "psionic_charge_power",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "noetic_charge_power",
    name = ccb.content.text("noetic energy"),
    default_item = "noetic_charge_power",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "mom_fusion_ammo",
    name = ccb.content.text("Ch47 fusion shot"),
    default_item = "mom_fusion_ammo",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "mom_fifth_sun_stungun_ammo",
    name = ccb.content.text("M12 neural shot"),
    default_item = "mom_fifth_sun_stungun_ammo",
})

-- Lightning flash
content.upsert_ammunition_type(content.AmmunitionType {
    id = "mom_lightning_rifle_ammo",
    name = ccb.content.text("tlapetlaniliztli ammo"),
    default_item = "mom_lightning_rifle_ammo",
})
