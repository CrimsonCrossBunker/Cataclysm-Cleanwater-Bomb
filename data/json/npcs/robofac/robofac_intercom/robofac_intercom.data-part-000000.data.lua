local ccb = require("ccb")

-- The voice behind the Hub 01 intercom. They handle all front-facing stuff for mercenaries, and trade items using a tray embedded into the wall.
-- This isn't a single person, but rather a rotating group of staff managing the intercom. Be mindful of tone when writing dialogue, since there's no guarantee that the same person will be on the intercom at any given time that the player speaks with Hub 01.
-- Note: Using '*' for non-quoted text will result in the sentence starting out lowercase due to the unique name being an improper noun. Use '&The intercom ' if you want to produce the same effect while maintaining proper grammar!
ccb.content.define_npc {
    id = "robofac_intercom",
    unique_name = ccb.content.text("the intercom"),
    gender = "female",
    class = "NC_ROBOFAC_INTERCOM",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_INTERCOM",
    missions_offered = { "MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1", "MISSION_ROBOFAC_INTERCOM_2" },
    faction = "robofac",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_INTERCOM_BASE",
    name = ccb.content.text("intercom (base)"),
    job_description = ccb.content.text("."),
    common = false,
    strength = { rng = { 8, 10 } },
    intelligence = { rng = { 1, 2 } },
    perception = { rng = { 1, 2 } },
    skills = { { skill = "speech", level = { dice = { 2, 2 } } } },
    carry = "EMPTY_GROUP",
    worn = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
}
