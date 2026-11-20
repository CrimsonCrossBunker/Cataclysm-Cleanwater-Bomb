local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_KILL_JABBERWOCK",
    name = ccb.content.text("Kill Jabberwock"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 200000,
    urgent = true,
    start = {
        target = {
            terrain = "forest_thick",
            replace_terrain = "forest",
            reveal_radius = 1,
            random = true,
            search_range = 60,
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_jabberwock", x = 11, y = 11, target = true } } } },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("The eater of the dead… something was ripping trees to shreds and only leaving a few scattered limbs…"),
        offer = ccb.content.text("A few days ago another survivor and I were in the woods.  One night something caught onto our trail and chased us for ten minutes or so until we decided to split up and meet-up back here.  My buddy never showed up and I don't have the means to kill whatever it was.  Can you lend a hand?"),
        accepted = ccb.content.text("Thanks, make sure you're ready for whatever the beast is."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either."),
        advice = ccb.content.text("Make sure you have a good weapon.  It sounded pretty big."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("You look a little shaken up, I can't tell you how glad I am that you killed it though."),
        success_lie = ccb.content.text("Something in the shadows still seems to stare at me when I look at the woods."),
        failure = ccb.content.text("I'm glad you came back alive… I wasn't sure if I had sent you to your death."),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_ZOMBIE_MOM",
    name = ccb.content.text("Kill Zombie Bear"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 120000,
    urgent = true,
    start = {
        target = { terrain = "forest", reveal_radius = 3 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_zombear", name = ccb.content.text("Willa"), x = 12, y = 12, target = true },
                    },
                },
            },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh god, I can't believe it happened…"),
        offer = ccb.content.text("My bear… she's… she was killed, but then she just got back up… she's one of those things now.  Can you put her out of her misery for me?"),
        accepted = ccb.content.text("Thank you… she would've wanted it this way."),
        rejected = ccb.content.text("Please reconsider, I know she's suffering…"),
        advice = ccb.content.text("She's still a bear, and seemed furious, so be wary.  And please, make it quick…"),
        inquire = ccb.content.text("Well…?  Did you… finish things for my bear?"),
        success = ccb.content.text("Thank you.  I couldn't rest until I knew that was finished."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("Really… that's too bad."),
    },
}
