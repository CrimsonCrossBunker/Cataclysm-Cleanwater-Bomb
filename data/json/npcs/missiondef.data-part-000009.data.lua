local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_PRISON_VISIONARY",
    name = ccb.content.text("Prison Visionary"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "visions_solitude",
    start = {
        target = { terrain = "prison_1_4", special = "Prison", reveal_radius = 3 },
        map_updates = {
            {
                terrain = "prison_1_4",
                layout = { item_placements = { { id = "visions_solitude", x = 15, y = 22 } } },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("I have another task if you are feeling up to it.  There is a prisoner that the priest made special mention of.  I was wondering if you could see what may have happened to him or if he left anything in his cell.  The priest admits the individual is rather unstable, to put it lightly, but the priest personally believed the man was some kind of repentant visionary.  I'm not in a position to cast out the account just yet… it seems the man has prophesied events accurately before concerning the Church of Starry Wisdom."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path… I can only imagine that the prison will be a little slice of hell.  I'm not sure what they would have decided to do with the inmates when they knew death was almost certain."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("The worst case scenario will probably be that the prisoners have escaped their cells and turned the building into their own little fortress.  Best case, the building went into lock-down and secured the prisoners in their cells.  Either way, navigating the building will pose its own difficulties."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("Thank you, I'm not sure what to make of this but I'll ponder your account."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
