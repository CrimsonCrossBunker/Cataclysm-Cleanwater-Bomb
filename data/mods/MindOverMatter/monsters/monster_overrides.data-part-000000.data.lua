local ccb = require("ccb")

ccb.content.define_monster {
    id = "mon_strange_megafrog",
    copy_from = "mon_strange_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_odd_megafrog",
    copy_from = "mon_odd_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster {
    id = "mon_foul_megafrog",
    copy_from = "mon_foul_megafrog",
    inheritance = { add = { flags = { "CANPLAY", "PET_MOUNTABLE" } } },
}

ccb.content.define_monster { id = "mon_pigeon", copy_from = "mon_pigeon", inheritance = { add = { flags = { "CANPLAY" } } } }
