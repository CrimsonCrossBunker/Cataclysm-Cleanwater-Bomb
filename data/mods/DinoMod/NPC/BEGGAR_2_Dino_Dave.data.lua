local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_WEARING",
    line = ccb.content.text("You ask me what I can see, but I don't tell you what you see.  Sometimes we have shields up, to protect ourselves."),
    replies = {
        {
            text = ccb.content.text("Yes.  I ask because I noticed there are dinosaurs around.  Do you know anything about that?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINO2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_DINO2",
    line = ccb.content.text("I know all kinds of weird useless stuff.  I've seen things at churches, I've seen things on farms, I've seen whole exhibits way out, a whole zoo even.  And there's someone pretending to be me, but it's not me, because I would know.  Or you would know.  One of us would be us.  Those Swampers, they know what's happening.  They're creatures of light come back to save us all.  Or eat us, I forget.  Oh and that Old Guard Repo Man hates them and Red is out there somewhere in the great red yonder."),
    replies = {
        {
            text = ccb.content.text("Yes.  How do I find the someone pretending to be you?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_DINO_Directions",
            when = predicates.all({ predicates.negate(predicates.has_mission("MISSION_REACH_FAKE_DAVE")), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_fake_dave" } })) }),
        },
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
        {
            text = ccb.content.text("Why are you sitting out here?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_REFUGEE",
        },
        { text = ccb.content.text("I think I have to get going…"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_2_DINO_Directions",
    line = ccb.content.text("Wait, what if I'm the probe?  What if you're the probe?  Let me mark that on your map nice and big."),
    on_enter = { { actions = { actions.assign_mission("MISSION_REACH_FAKE_DAVE") } } },
    replies = {
        {
            text = ccb.content.text("Thanks for the information.  I'd better go."),
            next_topic = "TALK_DONE",
        },
        { text = ccb.content.text("I was the probe the whole time."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("What was that about cardboard?"),
            next_topic = "TALK_REFUGEE_BEGGAR_2_CARDBOARD",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REACH_FAKE_DAVE",
    name = ccb.content.text("Find fake Dino Dave"),
    goal = "MGOAL_GO_TO_TYPE",
    difficulty = 2,
    value = 60000,
    start = { target = { terrain = "hunter_shack", reveal_radius = 5, special = "Swamp Shack" } },
    origins = { "ORIGIN_SECONDARY" },
    destination = "hunter_shack",
    dialogue = {
        describe = ccb.content.text("It must be an alien probe…"),
        offer = ccb.content.text("I think the shack was that way.  Might have cleared out but who knows.  Watch out for space lasers."),
        accepted = ccb.content.text("You'll see, it's just like I say."),
        rejected = ccb.content.text("You'll see, it's just like I say."),
        advice = ccb.content.text("There aren't a lot of things to have faith for in the world today, but if I were you I would bring some cardboard."),
        inquire = ccb.content.text("Did you see the probe?"),
        success = ccb.content.text("I knew it.  Good."),
        success_lie = ccb.content.text("I knew it.  Good."),
        failure = ccb.content.text("Could have been another shack.  I don't know, lots going on."),
    },
}
