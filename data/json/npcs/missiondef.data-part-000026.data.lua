local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_CAMP_LEADERSHIP_CHANGE",
    name = ccb.content.text("Faction succession"),
    goal = "MGOAL_CONDITION",
    description = ccb.content.text("You have some time left until you can transfer control to your companions, provided you have <color_yellow>established a Basecamp</color> and <color_yellow>have at least 1 NPC companion</color>."),
    difficulty = 0,
    value = 0,
    deadline = "3 days",
    invisible_on_complete = true,
    start = { actions = { { handler = "start_faction_succession_cooldown" } } },
}
