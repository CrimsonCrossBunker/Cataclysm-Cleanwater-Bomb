local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_RECOVER_PRIEST_DIARY",
    name = ccb.content.text("Recover Priest's Diary"),
    description = ccb.content.text("Find something that may reveal what the church's stance is on these events.  Something like <color_yellow>a priest's diary</color> would suffice."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 70000,
    item = "priest_diary",
    start = {
        target = { terrain = "house", match = "PREFIX", min_distance = 5, random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    item_placements = { { id = "priest_diary", x = { 3, 21 }, y = { 6, 21 }, amount = 1 } },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_INVESTIGATE_CULT",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("From what I understand, the creatures you encountered surrounding this relic were unlike anything I've heard of.  It is laughable that I now consider the living dead to be part of our ordinary reality.  Never-the-less, the church must have some explanation for these events.  I have located the residence of a local clergy man, could you go to this address and recover any items that may reveal what the church's stance is on these events?"),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("If the information is confidential the priest must have it hidden within his own home."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, a diary is exactly what I was looking for."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
