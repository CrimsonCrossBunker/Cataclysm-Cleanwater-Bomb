local ccb = require("ccb")

-- A mysterious member of a doomsday cult.
ccb.content.define_npc {
    id = "SEER_Brigitte_LaCroix",
    unique_name = ccb.content.text("Brigitte LaCroix"),
    gender = "female",
    suffix = ccb.content.text("Bone Seer"),
    class = "NC_BONE_SEER",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_BONE_SEER",
    friend_chat = "TALK_FRIEND_BONE_SEER",
    friend_guard_chat = "TALK_FRIEND_GUARD_BONE_SEER",
    faction = "no_faction",
    missions_offered = "MISSION_SEER_GATHER_BONE",
}
