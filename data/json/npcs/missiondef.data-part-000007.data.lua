local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_INVESTIGATE_CULT",
    name = ccb.content.text("Investigate Cult"),
    description = ccb.content.text("Investigate the strange cabin in the woods and find an item that may clue you in about <color_yellow>a potential human sacrifice</color> the cult has performed, such as <color_yellow>human bones or other remains</color>."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 150000,
    item = "etched_skull",
    start = { target = { terrain = "cabin_strange", special = "Strange Cabin", reveal_radius = 3 } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_INVESTIGATE_PRISON_VISIONARY",
    dialogue = {
        describe = ccb.content.text("St. Michael the archangel defend me in battle…"),
        offer = ccb.content.text("You have no idea how interesting this diary is.  I have two very promising leads… first things first, the Catholic Church has been performing its own investigations into global cult phenomenon and it appears to have become very interested in a local cult as of recently.  Could you investigate a location for me?  I'm not sure what was going on here but the priest seemed fairly worried about it."),
        accepted = ccb.content.text("I wish you the best of luck, may whatever god you please guide your path… You may need it this time more than the past excursions you have gone on.  There is a note about potential human sacrifice in the days immediately before and after the outbreak.  The name of the cult is believed to be the Church of Starry Wisdom but it is noted that accounts differ."),
        rejected = ccb.content.text("Ya, I guess the stress may just be getting to me…"),
        advice = ccb.content.text("I doubt the site is still occupied but I'd carry a firearm at least… I'm not sure what you might be looking for but I'm positive you'll find something out of the ordinary if you look long enough."),
        inquire = ccb.content.text("I'm positive there is something there… there has to be, any luck?"),
        success = ccb.content.text("Thank you, your account of these… demonic creations proves the fears the churches had were well founded.  Our priority should be routing out any survivors of this cult… I don't known if they are responsible for the outbreak but they certainly know more about it than I do."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
