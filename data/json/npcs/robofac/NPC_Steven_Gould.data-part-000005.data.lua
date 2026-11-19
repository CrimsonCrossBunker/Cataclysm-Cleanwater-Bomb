local ccb = require("ccb")

-- just a grunt
ccb.content.define_npc {
    id = "robofac_merc_monster_corpse_2",
    unique_name = ccb.content.text("armed mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_MONSTER_CORPSE_2",
    faction = "robofac_auxiliaries",
}
