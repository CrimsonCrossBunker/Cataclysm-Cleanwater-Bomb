local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_LUKE_2",
    name = ccb.content.text("Find a copy of DIY Compendium"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 3,
    value = 20000,
    item = "textbook_fabrication",
    item_count = 1,
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {
        map_updates = {
            {
                terrain = "rural_outbuilding",
                layout = {
                    item_placements = {
                        { id = "textbook_fabrication", x = 5, y = 9, faction = "isherwood_family" },
                    },
                },
            },
        },
        handler = { "mark_u_did_luke_missions", "record_timer_luke_isherwood_books" },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("I need more knowledge to get better pottery."),
        offer = ccb.content.text("I could really use the book, DIY Compendium.  With the internet gone, I don't have any handy references."),
        accepted = ccb.content.text("Fantastic, I'm not supposed to leave our land."),
        rejected = ccb.content.text("Oh well, figured I'd have to do a lot of practice anyway."),
        advice = ccb.content.text("A library, bookstore should have one, schools are another good idea."),
        inquire = ccb.content.text("Do you have the book?"),
        success = ccb.content.text("I appreciate it, this will make my life so much easier."),
        success_lie = ccb.content.text("I don't see a book…?"),
        failure = ccb.content.text("At least you escaped with your life…"),
    },
}
