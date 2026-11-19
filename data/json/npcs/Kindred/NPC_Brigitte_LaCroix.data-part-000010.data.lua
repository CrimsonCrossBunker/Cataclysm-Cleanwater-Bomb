local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_OFFER_SEER",
    line = ccb.content.text("If you wish to be set on the path to enlightenment, first you must learn to listen and hear the song.  Go out, butcher an untainted creature and feel the power between your fingertips.  Then bring me the bones and I shall carve them for you."),
    replies = {
        {
            text = ccb.content.text("Well, I guess I oughta see where this goes.  I'm in."),
            next_topic = "TALK_MISSION_ACCEPTED_SEER",
            native_actions = { "assign_mission" },
        },
        { text = ccb.content.text("Not interested."), next_topic = "TALK_MISSION_REJECTED_SEER" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ACCEPTED_SEER",
    line = ccb.content.text("Excellent.  Now be on your way."),
    replies = {
        {
            text = ccb.content.text("Consider it done.  But I also wanted to ask…"),
            next_topic = "TALK_BONE_SEER",
        },
        {
            text = ccb.content.text("Where should I start?"),
            next_topic = "TALK_MISSION_ADVICE_SEER",
        },
        {
            text = ccb.content.text("Can you share some equipment to aid me in this?"),
            next_topic = "TALK_SHARE_EQUIPMENT_SEER",
        },
        { text = ccb.content.text("I'm off then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MISSION_ADVICE_SEER",
    line = ccb.content.text("The shambling corpses we see all around move in discord.  Their song can be used, but for an Acolyte, this would be needlessly hard.  Be sure to carve an unspoiled living creature."),
    replies = {
        {
            text = ccb.content.text("So, a creature that isn't a zombie, or a monster.  Got it."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_SHARE_EQUIPMENT_SEER",
    line = ccb.content.text("The path to enlightenment is for you to walk.  For me to aid you would ultimately impede your progress and muddle your song."),
    replies = { { text = ccb.content.text("I see.  Very well then."), next_topic = "TALK_NONE" } },
}
