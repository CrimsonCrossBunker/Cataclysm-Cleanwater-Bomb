local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_OTHERS_FRIEND",
    line = ccb.content.text("There are others who know the power the bones hold, but not all of them are my kin.  Not anymore, at least."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_knows_kindred", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do you mean 'not anymore'?"),
            next_topic = "TALK_BONE_SEER_COOPER_FRIEND",
        },
        {
            text = ccb.content.text("Why do we gather these bones again?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("Thank you for the recap, but I have to go now."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER_FRIEND",
    line = ccb.content.text("Some time ago, a man named Cooper joined me and my kin.  He showed great promise and devotion to our cause, but in his effort to weave songs, he justified increasingly grim actions.  We tried to stop him when we learned of this, but he managed to get away.  If you ever come across him, be sure to thread carefully, and if you can, stop him."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What exactly did he do again?"),
            next_topic = "TALK_BONE_SEER_COOPER2_FRIEND",
        },
        {
            text = ccb.content.text("What do we do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("I see.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_COOPER2_FRIEND",
    line = ccb.content.text("He began killing others to get their bones as fresh as possible.  Later, he… he started carving the bones of the living.  Thought the anguish alone would empower the song.  The goal of the Kindred is to banish the shadow of the Cataclysm, not to cast it.  Such heinous acts will likely twist the song of the world, but I don't think Cooper realizes it.  To him, the end justifies any means."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "dialogue_kindred_cooper_knows_cooper_kill", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Well… shit.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND_BONE_SEER",
        },
        {
            text = ccb.content.text("What if he is right?  Maybe what you do isn't enough and he's the only one to do what it takes."),
            next_topic = "TALK_BONE_SEER_COOPER3_FRIEND",
        },
    },
}
