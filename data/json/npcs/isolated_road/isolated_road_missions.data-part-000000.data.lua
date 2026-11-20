local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_BLACKSMITH_1",
    name = ccb.content.text("Find the gun"),
    description = ccb.content.text("Cody wants you to go to a gun show and find a rare gun that Jay wanted to see.  It was an AK of some kind with a weird name… something like CARD or CORE."),
    goal = "MGOAL_CONDITION",
    difficulty = 5,
    item = "broken_kord",
    value = 1000,
    start = {
        target = {
            special = "gun_show",
            terrain = "gunshow_0",
            reveal_radius = 2,
            random = true,
            search_range = 800,
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("…"),
        offer = ccb.content.text("Before everything went to hell Jay was talking about going to some gun show.  There was a guy there who had managed to sneak some Russian gun into the US.  It was a massive deal for Jay, it was all he could talk about.  I know it's a long shot but maybe that guy was already at the gun show?  If you find the gun you can keep it, but it would mean a lot to Jay if he could take a look all he wanted was to pull it apart and put it back together."),
        accepted = ccb.content.text("Thanks.  I'll start working on an apology."),
        rejected = ccb.content.text("Let me know if you change your mind."),
        advice = ccb.content.text("I'd be careful there; Jay was saying they were bringing some new autonomous hardware to the show.  You're looking for a Russian rifle that should be modded to the moon.  CARD, CORE rifle, something like that."),
        inquire = ccb.content.text("Any luck finding that gun show?  I think it was a Russian gun, maybe a CARD or CORE rifle?  Something like that."),
        success = ccb.content.text("Thanks, darlin'.  If you could show it to Jay, that would mean a lot to me.  If there's anything I could ever make for you as payment after that, just let me know."),
        success_lie = ccb.content.text("That's great!  Make sure to show it to Jay."),
        failure = ccb.content.text("Well you tried at least…"),
    },
    finish = { handler = "mark_dialogue_artisans_blacksmith_completed_quest" },
    complete_when = "complete_mission_blacksmith_1",
}
