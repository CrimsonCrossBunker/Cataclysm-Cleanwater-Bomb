local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_LUKE_1",
    name = ccb.content.text("Find The Art of Glassblowing book"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 50000,
    item = "glassblowing_book",
    item_count = 1,
    finish = {
        map_updates = {
            {
                terrain = "rural_outbuilding",
                layout = {
                    item_placements = {
                        { id = "glassblowing_book", x = 5, y = 9, faction = "isherwood_family" },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_ISHERWOOD_LUKE_2",
    dialogue = {
        describe = ccb.content.text("I need more knowledge to get the glass blowing started."),
        offer = ccb.content.text("I could really use a book on glass blowing.  With the internet gone, I don't have any handy references."),
        accepted = ccb.content.text("Fantastic, I'm not supposed to leave our land."),
        rejected = ccb.content.text("Oh well, figured I'd have to do a lot of practice anyway."),
        advice = ccb.content.text("A library, bookstore or a glass blower's studio should have one."),
        inquire = ccb.content.text("Do you have the book?"),
        success = ccb.content.text("I appreciate it, this will make my life so much easier."),
        success_lie = ccb.content.text("I don't see a book…?"),
        failure = ccb.content.text("At least you escaped with your life…"),
    },
}
