local ccb = require("ccb")

-- A generic guard for the Tacoma Commune faction companion missions.
ccb.content.define_npc {
    id = "commune_guard",
    suffix = ccb.content.text("Guard"),
    class = "NC_BOUNTY_HUNTER",
    attitude = 0,
    mission = "GUARD_PATROL",
    chat = "TALK_RANCH_GUARD",
    faction = "tacoma_commune",
}
