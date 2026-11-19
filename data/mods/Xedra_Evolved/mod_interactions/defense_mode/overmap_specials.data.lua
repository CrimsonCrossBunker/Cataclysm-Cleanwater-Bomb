local ccb = require("ccb")

ccb.content.define_overmap_terrain {
    name = ccb.content.text("border patrol office"),
    id = {
        "dm_field_office_1", "dm_field_office_2", "dm_field_office_3", "dm_field_office_4",
        "dm_field_office_5", "dm_field_office_6", "dm_field_office_7", "dm_field_office_8",
        "dm_field_office_9", "dm_field_office_10", "dm_field_office_11", "dm_field_office_12",
        "dm_field_office_13", "dm_field_office_14", "dm_field_office_15", "dm_field_office_16",
        "dm_field_office_17", "dm_field_office_18", "dm_field_office_19", "dm_field_office_20",
    },
    copy_from = "generic_large_office_tower",
}
