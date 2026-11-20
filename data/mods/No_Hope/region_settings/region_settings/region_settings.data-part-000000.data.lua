local ccb = require("ccb")

ccb.content.define_map_extra_collection {
    id = "forest_nohope",
    copy_from = "forest",
    add_extras = {
        { extra = "mx_science", weight = 20 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_supplydrop", weight = 8 },
        { extra = "mx_military", weight = 8 },
        { extra = "mx_bandits_ambush", weight = 5 },
        { extra = "mx_bandits_grave", weight = 2 },
        { extra = "mx_bandits_outpost", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_thick_nohope",
    copy_from = "forest_thick",
    add_extras = {
        { extra = "mx_science", weight = 20 },
        { extra = "mx_collegekids", weight = 25 },
        { extra = "mx_crater", weight = 10 },
        { extra = "mx_supplydrop", weight = 5 },
        { extra = "mx_bandits_ambush", weight = 5 },
        { extra = "mx_bandits_grave", weight = 2 },
        { extra = "mx_bandits_outpost", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "forest_water_nohope",
    copy_from = "forest_water",
    add_extras = {
        { extra = "mx_science", weight = 50 },
        { extra = "mx_military", weight = 25 },
        { extra = "mx_supplydrop", weight = 25 },
        { extra = "mx_crater", weight = 20 },
        { extra = "mx_bandits_ambush", weight = 5 },
        { extra = "mx_bandits_grave", weight = 2 },
        { extra = "mx_bandits_outpost", weight = 2 },
    },
}

ccb.content.define_map_extra_collection {
    id = "field_nohope",
    copy_from = "field",
    add_extras = {
        { extra = "mx_crater", weight = 150 },
        { extra = "mx_supplydrop", weight = 40 },
        { extra = "mx_bandits_ambush", weight = 10 },
        { extra = "mx_bandits_campsite", weight = 10 },
        { extra = "mx_bandits_grave", weight = 10 },
        { extra = "mx_bandits_outpost", weight = 10 },
    },
}

ccb.content.define_map_extra_collection {
    id = "road_nohope",
    copy_from = "road",
    add_extras = {
        { extra = "mx_helicopter", weight = 10 },
        { extra = "mx_military", weight = 50 },
        { extra = "mx_science", weight = 400 },
        { extra = "mx_bandits_block", weight = 800 },
        { extra = "mx_drugdeal", weight = 300 },
        { extra = "mx_supplydrop", weight = 100 },
        { extra = "mx_crater", weight = 100 },
        { extra = "mx_bandits_ambush", weight = 100 },
    },
}

ccb.content.define_map_extra_collection {
    id = "build_nohope",
    copy_from = "build",
    add_extras = {
        { extra = "mx_bugout", weight = 20 },
        { extra = "mx_science", weight = 12 },
        { extra = "mx_crater", weight = 60 },
        { extra = "mx_bandits_ambush", weight = 10 },
        { extra = "mx_bandits_hideout", weight = 10 },
    },
}

ccb.content.define_map_extra_collection {
    id = "subway_nohope",
    copy_from = "subway",
    add_extras = { { extra = "mx_casings", weight = 10 }, { extra = "mx_bandits_ambush", weight = 5 } },
}
