local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_SEER_GATHER_BONE",
    name = ccb.content.text("Find 8 bones"),
    description = ccb.content.text("Brigitte LaCroix asked you to collect clean, untainted bones in order to better understand her beliefs.  8 bones should be sufficient."),
    difficulty = 1,
    value = 10000,
    goal = "MGOAL_FIND_ITEM",
    item = "bone",
    item_count = 8,
    origins = { "ORIGIN_SECONDARY" },
    finish = { handler = { "mark_general_mission_NC_SEER_MISSION_1", "become_seer_mark" } },
    dialogue = {
        describe = ccb.content.text("There is always work to be done, song to be woven."),
        offer = ccb.content.text("If you wish to be set on the path to enlightenment, first you must learn to listen and hear the song.  Go out, butcher an untainted creature and feel the power between your fingertips.  Then bring me the bones and I shall carve them for you."),
        accepted = ccb.content.text("Excellent.  Now be on your way."),
        rejected = ccb.content.text("I understand your reluctance.  Feel free to return when you see the way."),
        advice = ccb.content.text("The shambling corpses we see all around move in discord.  Their song can be used, but for an Acolyte, this would be needlessly hard.  Be sure to carve an unspoiled living creature."),
        inquire = ccb.content.text("Have you felt the song in your hands yet?"),
        success = ccb.content.text("And so, another cycle ends.  You have done well.  I will now bestow my mark upon you, so that others may know the path you walk and aid you."),
        success_lie = ccb.content.text("So you say, but the song sings otherwise."),
        failure = ccb.content.text("Then you shall try again, until you hear."),
    },
}
