local ccb = require("ccb")

-- Flavor
ccb.content.define_npc {
    id = "ranch_crop_overseer",
    suffix = ccb.content.text("Crop Overseer"),
    class = "NC_BOUNTY_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_RANCH_CROP_OVERSEER",
    faction = "tacoma_commune",
}
