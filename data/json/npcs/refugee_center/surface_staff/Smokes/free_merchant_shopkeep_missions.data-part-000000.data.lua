local ccb = require("ccb")

-- Breadcrumb quest from Free Merchants -> Hub 01.  Bring a hard drive to Hub 01 from the refugee center and then return.
ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
    name = ccb.content.text("Unknown Recipient"),
    description = ccb.content.text("Deliver the FEMA hard drive to the strange group that Smokes mentioned.  Return to the evacuation center when the data's been delivered."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    start = {
        target = { terrain = "robofachq_surface_entrance", special = "hub_01", reveal_radius = 1 },
        item_rewards = { { item = "fema_data", count = 1 } },
    },
    finish = { handler = "set_world_free_merchants_hub_trade_route_to_1" },
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("…"),
        accepted = ccb.content.text("…"),
        rejected = ccb.content.text("…"),
        advice = ccb.content.text("…"),
        inquire = ccb.content.text("Got the hard drive delivered?"),
        success = ccb.content.text("Oh, good.  I'm glad you're alright; I had no idea what to make of them.  Well, one less thing to worry about."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("At least you came back alive.  Don't sweat it too much - it's no skin off my back.  If they want it that bad, they can come get another copy themselves."),
    },
    complete_when = "complete_mission_free_merchants_hub_delivery_1",
}
