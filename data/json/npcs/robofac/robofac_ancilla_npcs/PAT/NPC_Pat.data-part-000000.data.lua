local ccb = require("ccb")

-- Appears on the Hub service.
ccb.content.define_npc {
    id = "chief_meteorologist_pat",
    unique_name = ccb.content.text("Pat"),
    suffix = ccb.content.text("Hub Mercenary"),
    class = "NPC_ROBOFAC_MERC_PAT",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_ROBOFAC_MERC_PAT",
    faction = "robofac_auxiliaries",
    on_death = "record_hub_pat_death",
}
