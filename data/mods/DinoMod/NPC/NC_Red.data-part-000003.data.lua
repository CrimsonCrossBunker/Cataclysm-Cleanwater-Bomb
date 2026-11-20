local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_DINO_1",
    name = ccb.content.text("Secure Area"),
    description = ccb.content.text("We lost another trade caravan.  Whatever did the damage is still out there.  Investigate the trade route and eliminate the threat."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 100000,
    start = {
        target = { terrain = "field", reveal_radius = 5, random = true, search_range = 30 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { group = "GROUP_DINOSAUR_DANGEROUS", x = 12, y = 12, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_DINO_2",
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {},
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("It sounds like you get it.  There is something out there scaring the merchants.  They got away safe but lost a grain shipment, you're welcome to it if you can haul it back.  Check out the area and report anything you find."),
        accepted = ccb.content.text("Thanks, keeping the people safe is what we try and do."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Search the bushes for any trace?  I'm not an expert tracker but you should be able to find something."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great work, wasn't sure what I was sending you after."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_DINO_2",
    name = ccb.content.text("Lost in the Woods"),
    description = ccb.content.text("We lost a scout searching the woods for a lost family.  Find the scout or take out what got them."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 7,
    value = 100000,
    start = {
        target = { terrain = "forest", reveal_radius = 5, random = true, search_range = 40 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { group = "GROUP_DINOSAUR_MEGA_CARNIVORE", x = 12, y = 12, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_OLD_GUARD_DINO_3",
    -- Native mission phases did not apply the giver opinion (trust +2, value +2).
    finish = {},
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("Seems like the only news we get here is bad.  A weirdo family was staying outside the center, I don't know why.  They said something about germs.  Anyway, they're gone, vanished in the night.  We sent a scout out to find them but now they're gone too.  We have a pretty good idea of where in the woods the scout was searching.  Bring back anyone you can alive and end whatever is keeping them."),
        accepted = ccb.content.text("Thanks, keeping the people safe is what we try and do."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Try not to make too much noise.  Visibility is bad in the woods so it's all about sound."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great work, wasn't sure what I was sending you after."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
