local ccb = require("ccb")

ccb.content.define_map_extra {
    id = "mx_bandits_ambush",
    name = ccb.content.text("Bandit Ambush"),
    description = ccb.content.text("There were bandits here."),
    generator = { method = "update_mapgen", id = "bandits_ambush" },
    symbol = "x",
    color = "yellow",
}

ccb.content.define_map_extra {
    id = "mx_bandits_campsite",
    name = ccb.content.text("Bandit Campsite"),
    description = ccb.content.text("There are bandits here."),
    generator = { method = "update_mapgen", id = "bandits_campsite" },
    symbol = "x",
    color = "yellow",
}

ccb.content.define_map_extra {
    id = "mx_bandits_hideout",
    name = ccb.content.text("Bandit Hideout"),
    description = ccb.content.text("There are bandits here."),
    generator = { method = "update_mapgen", id = "bandits_hideout" },
    symbol = "x",
    color = "yellow",
}

ccb.content.define_map_extra {
    id = "mx_bandits_grave",
    name = ccb.content.text("Bandit Gravesite"),
    description = ccb.content.text("There are bandits here."),
    generator = { method = "update_mapgen", id = "bandits_grave" },
    symbol = "x",
    color = "yellow",
}

ccb.content.define_map_extra {
    id = "mx_bandits_outpost",
    name = ccb.content.text("Bandit Outpost"),
    description = ccb.content.text("There are bandits here."),
    generator = { method = "update_mapgen", id = "bandits_outpost" },
    symbol = "x",
    color = "yellow",
}
