local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_JOIN_TRACKER",
    name = ccb.content.text("Find Deputy Badge"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 5,
    value = 0,
    urgent = true,
    item = "badge_deputy",
    start = { native_actions = { "follow" } },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Well damn, you must be the guys here to pick me up…"),
        offer = ccb.content.text("I got the brief so I know what I'm getting into.  Let me be upfront, treat me like shit and I'm going to cover my own hide.  However, you treat me well and give me something to believe in, even if it's just a shiny bit of metal, and I'll do you right.  Without a strong band a man doesn't stand a chance in this world.  You ready to take charge boss?  This world could use a Sheriff just about now."),
        accepted = ccb.content.text("Before we get into a major fight just make sure we have the gear we need, boss."),
        rejected = ccb.content.text("I don't think you're going to find many other survivors who haven't taken up a faction yet."),
        advice = ccb.content.text("I'm a pretty good shot with a rifle or pistol."),
        inquire = ccb.content.text("Any problems boss?"),
        success = ccb.content.text("Wait… are you really making me a deputy?"),
        success_lie = ccb.content.text("I don't think so…"),
        failure = ccb.content.text("Quitting already?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_100_Z",
    name = ccb.content.text("Kill 100 Zombies"),
    goal = "MGOAL_KILL_MONSTER_SPEC",
    monster_species = "ZOMBIE",
    monster_kill_goal = 100,
    difficulty = 5,
    value = 250000,
    start = { native_actions = { "follow_only" } },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_KILL_HORDE_MASTER",
    dialogue = {
        describe = ccb.content.text("You seem to know this new world better than most…"),
        offer = ccb.content.text("You're kitted out better than most… would you be interested in making this world a little better for the rest of us?  The towns have enough supplies for us survivors to start securing a foothold but we don't have anyone with the skills and equipment to thin the masses of undead.  I'll lend you a hand to the best of my ability but you really showed promise taking out that other beast.  You, I, and a 100 zombies laid to rest, what do you say?"),
        accepted = ccb.content.text("Hell ya, we may get ourselves killed but we'll be among the first legends of the apocalypse."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either… but then I remember that most of us survivors won't make it unless someone decides to take the initiative."),
        advice = ccb.content.text("I'd secure an ammo cache and try to sweep a town in multiple passes."),
        inquire = ccb.content.text("Got this knocked out?"),
        success = ccb.content.text("Man… you're a goddamn machine.  It was a pleasure working with you.  You know, you may just change our little neck of the world if you keep this up."),
        success_lie = ccb.content.text("I don't think that was quite a hundred dead zeds."),
        failure = ccb.content.text("Quitting already?"),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_HORDE_MASTER",
    name = ccb.content.text("Kill Horde Master"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 250000,
    urgent = true,
    start = {
        target = { terrain = "house", match = "CONTAINS", min_distance = 10, random = true, z = 0 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_zombie_master",
                            x = { 12, 15 },
                            y = { 12, 15 },
                            target = true,
                            name = ccb.content.text("Demonic Soul"),
                        },
                        { group = "GROUP_ZOMBIE", x = { 12, 15 }, y = { 12, 15 }, repetitions = { 21, 29 } },
                    },
                },
            },
        },
        native_actions = { "follow_only" },
    },
    finish = { native_actions = { "stop_following" } },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_RECRUIT_TRACKER",
    dialogue = {
        describe = ccb.content.text("I've heard some bad rumors so I hope you are up for another challenge…"),
        offer = ccb.content.text("Apparently one of the other survivors picked up on an unusually dense horde of undead moving into the area.  At the center of this throng there was a 'leader' of some sort.  The short of it is, kill the son of a bitch.  We don't know what it is capable of or why it is surrounded by other zombies but this thing reeks of trouble.  Do whatever it takes but we can't risk it getting away."),
        accepted = ccb.content.text("I'll lend you a hand but I'd try and recruit another gunslinger if you can."),
        rejected = ccb.content.text("What's the use of walking away, they'll track you down eventually."),
        advice = ccb.content.text("Don't risk torching the building it may be hiding in if it has a basement.  The sucker may still be alive under the rubble and ash."),
        inquire = ccb.content.text("Got this knocked out?"),
        success = ccb.content.text("May that bastard never get up again."),
        success_lie = ccb.content.text("I don't think we got it yet."),
        failure = ccb.content.text("Quitting already?"),
    },
}

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
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            { layout = { monster_placements = { { id = "mon_jabberwock", x = 11, y = 11, target = true } } } },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    followup = "MISSION_KILL_100_Z",
    dialogue = {
        describe = ccb.content.text("The eater of the dead… something was ripping zombies to shreds and only leaving a few scattered limbs…"),
        offer = ccb.content.text("A few days ago another survivor and I were trying to avoid the cities by staying in the woods during the day and foraging for gear at night.  It worked well against the normal zeds but one night something caught onto our trail and chased us for ten minutes or so until we decided to split up and meet-up back here.  My buddy never showed up and I don't have the means to kill whatever it was.  Can you lend a hand?"),
        accepted = ccb.content.text("Thanks, make sure you're ready for whatever the beast is."),
        rejected = ccb.content.text("Hey, I know I wouldn't volunteer for it either."),
        advice = ccb.content.text("I'd carry a shotgun at least, it sounded pretty big."),
        inquire = ccb.content.text("Any luck?"),
        success = ccb.content.text("You look a little shaken up, I can't tell you how glad I am that you killed it though."),
        success_lie = ccb.content.text("Something in the shadows still seems to stare at me when I look at the woods."),
        failure = ccb.content.text("I'm glad you came back alive… I wasn't sure if I had sent you to your death."),
    },
}

ccb.content.define_mission {
    id = "MISSION_KILL_ZOMBIE_MOM",
    name = ccb.content.text("Kill Zombie Mom"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 120000,
    urgent = true,
    start = {
        target = {
            terrain = "house",
            match = "PREFIX",
            reveal_radius = 1,
            random = true,
            min_distance = 5,
            z = 0,
        },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_zombie", x = 12, y = 12, target = true, random_name = "female" },
                    },
                },
            },
        },
    },
    finish = { native_actions = { "npc_thankful" } },
    origins = { "ORIGIN_OPENER_NPC", "ORIGIN_ANY_NPC" },
    dialogue = {
        describe = ccb.content.text("Oh god, I can't believe it happened…"),
        offer = ccb.content.text("My mom… she's… she was killed, but then she just got back up… she's one of those things now.  Can you put her out of her misery for me?"),
        accepted = ccb.content.text("Thank you… she would've wanted it this way."),
        rejected = ccb.content.text("Please reconsider, I know she's suffering…"),
        advice = ccb.content.text("Find a gun if you can, make it quick…"),
        inquire = ccb.content.text("Well…?  Did you… finish things for my mom?"),
        success = ccb.content.text("Thank you.  I couldn't rest until I knew that was finished."),
        success_lie = ccb.content.text("What?!  You're lying, I can tell!  Ugh, forget it!"),
        failure = ccb.content.text("Really… that's too bad."),
    },
}
