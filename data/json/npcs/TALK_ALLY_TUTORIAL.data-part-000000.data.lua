local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ALLY_TUTORIAL",
    line = ccb.content.text("I'm my own person, but I'm mostly willing to follow your lead.  I can do a lot of things for you: I can fight, I can train you or you can train me, I can carry stuff, I can bandage your wounds, I can build faction camps, I can do some other activities, I can ride horses, I can go places, I can guard things, I can use some bionics, I can even chit-chat with you or give you tips or talk about my background.  You can give me instructions in conversation or by radio or shout commands at me.\n  What do you want to know more about?"),
    replies = {
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("Skip it.  <lets_go>"),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Any hints about the world we now live in?"),
            trial = { kind = "condition", when = predicates.handler("dlg_p_dda_2019ca9934b5") },
            success = { next_topic = "TALK_SHELTER_DENY_ADVICE" },
            failure = { next_topic = "TALK_SHELTER_ADVICE", actions = { actions.add_effect("interlocutor", "asked_to_hint", { turns = 300 }) } },
        },
        {
            text = ccb.content.text("Let's talk about faction camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("What do you mean, \"mostly\" willing to follow my lead?"),
            next_topic = "TALK_ALLY_TUTORIAL_MUTINY",
        },
        {
            text = ccb.content.text("What's that about giving instructions?"),
            next_topic = "TALK_ALLY_TUTORIAL_TALK",
        },
        {
            text = ccb.content.text("We can talk with radios?"),
            next_topic = "TALK_ALLY_TUTORIAL_RADIO",
        },
        {
            text = ccb.content.text("How do shouted commands work?"),
            next_topic = "TALK_ALLY_TUTORIAL_SHOUTS",
        },
        {
            text = ccb.content.text("How does fighting work?"),
            next_topic = "TALK_ALLY_TUTORIAL_COMBAT",
        },
        {
            text = ccb.content.text("What's that about training?"),
            next_topic = "TALK_ALLY_TUTORIAL_TRAINING",
        },
        {
            text = ccb.content.text("Tell me about you carrying stuff."),
            next_topic = "TALK_ALLY_TUTORIAL_MULE",
        },
        {
            text = ccb.content.text("You can perform first aid?"),
            next_topic = "TALK_ALLY_TUTORIAL_MEDIC",
        },
        {
            text = ccb.content.text("Tell me about faction camps."),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
        {
            text = ccb.content.text("What's that about activities?  Like what, you can farm for me?"),
            next_topic = "TALK_ALLY_TUTORIAL_ACTIVITIES",
        },
        {
            text = ccb.content.text("You can ride horses?"),
            next_topic = "TALK_ALLY_TUTORIAL_HORSES",
        },
        {
            text = ccb.content.text("What do you mean, you can go places?"),
            next_topic = "TALK_ALLY_TUTORIAL_MOVEMENT",
        },
        {
            text = ccb.content.text("What do you do as a guard?"),
            next_topic = "TALK_ALLY_TUTORIAL_GUARD",
        },
        {
            text = ccb.content.text("You can use bionics?  How does that work?"),
            next_topic = "TALK_ALLY_TUTORIAL_CBMS",
        },
        {
            text = ccb.content.text("What about chit-chatting and your background?"),
            next_topic = "TALK_ALLY_TUTORIAL_SOCIAL",
        },
        {
            text = ccb.content.text("Anything else I should know, like making you pulp zombies or assigning you a seat in my vehicle?"),
            next_topic = "TALK_ALLY_TUTORIAL_MISC",
        },
        {
            text = ccb.content.text("Any new abilities recently?"),
            next_topic = "TALK_ALLY_TUTORIAL_CHANGES",
        },
    },
}
