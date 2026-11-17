local ccb = require("ccb")
local content = ccb.content

content.upsert_ammunition_type(content.AmmunitionType {
    id = "test_9mm",
    name = ccb.content.text("test 9x19mm"),
    default_item = "test_9mm_ammo",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "test_100mm",
    name = ccb.content.text("test_100mm"),
    default_item = "test_100mm_ammo",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "test_liquid",
    name = ccb.content.text("test_liquid"),
    default_item = "test_napalm",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "test_graphite",
    name = ccb.content.text("graphite"),
    default_item = "graphite_test_item",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "test_gas",
    name = ccb.content.text("heady vapours"),
    default_item = "test_gas",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "welding_wire",
    name = ccb.content.text("welding_wire_for_tests_yay"),
    default_item = "welding_wire_steel_tests_dupe",
})

content.upsert_ammunition_type(content.AmmunitionType {
    id = "test_throwing",
    name = ccb.content.text("test throwing ammunition"),
    default_item = "test_throwing_ammo",
})
