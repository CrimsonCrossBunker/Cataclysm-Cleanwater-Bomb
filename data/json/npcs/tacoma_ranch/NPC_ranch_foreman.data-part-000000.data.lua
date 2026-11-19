local ccb = require("ccb")

-- Appears at the ranch after you progress in the refugee center quests.  Faction critical.
ccb.content.define_npc {
    id = "ranch_foreman",
    suffix = ccb.content.text("Foreman"),
    class = "NC_BOUNTY_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_FOREMAN",
    missions_offered = "MISSION_RANCH_FOREMAN_1",
    faction = "tacoma_commune",
}
