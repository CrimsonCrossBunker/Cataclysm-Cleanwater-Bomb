local ccb = require("ccb")

ccb.content.define_mission {
    id = "EXODII_MISSION_WAREHOUSE",
    name = ccb.content.text("Find the lost Exodii warehouse and reboot its locator antenna."),
    goal = "MGOAL_GO_TO_TYPE",
    destination = "exo_warehouse_1",
    start = {
        item_rewards = { { item = "warehouse_rebooter" } },
        handler = "set_world_exodii_mission_wh_chance_to_6",
    },
    finish = { handler = "mark_mission_completed_u_found_warehouse" },
    difficulty = 5,
    value = 2,
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = "",
        offer = "",
        accepted = ccb.content.text("King's own luck!"),
        rejected = ccb.content.text("That be a choice an' you can tass.  Come back to this'n if you like."),
        advice = ccb.content.text("What ye'r searching is safehouse-like, sand, stone, metal an' all."),
        inquire = ccb.content.text("Us'n waits patient-like for that'."),
        success = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        success_lie = ccb.content.text("Fine an' fine.  We can pass it in when you like."),
        failure = ccb.content.text("Fine an' fine.  Come back to this'n if you like to try again."),
    },
}
