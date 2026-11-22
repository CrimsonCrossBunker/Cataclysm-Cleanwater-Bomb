local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "TALK_OUTWORLD_CONFIRM" },
    line = ccb.content.text("Are you certain?  Leaving this world is a one-way trip.  There is still a very long time before it becomes urgent to do so and many things to gain from staying here a little longer."),
    replies = {
        {
            text = ccb.content.text("I changed my mind.  I'll stay for now."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("I am sure.  Bring me out of here.  (This will end the game)"),
            next_topic = "TALK_LEAVE_THIS_WORLD",
        },
        {
            text = ccb.content.text("I am sure.  Bring me and my followers out of here.  (This will end the game)"),
            next_topic = "TALK_LEAVE_THIS_WORLD",
            when = predicates.handler("dlg_p_xedra_evolved_b52f0aa23941"),
            actions = { actions.set_actor_value("speaker", "u_has_followers", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_THIS_WORLD",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_has_followers" } }),
        yes = ccb.content.text("(Boann leads you and your followers to a hidden ritual circle) This is the exit point.  After the ritual, you will all go through the decontamination process before you are allowed to claim your own barony, as fit for a member of my court.  Your followers will then claim a small part of it for their homes."),
        no = ccb.content.text("(Boann leads you to a hidden ritual circle) This is the exit point.  After the ritual, you'll go through the decontamination process before being allowed to claim your own barony, as fit for a member of my court."),
    },
    replies = {
        {
            text = ccb.content.text("A whole new world, filled with possibilities.  A place where the Cataclysm isn't.  What you do now is another story."),
            next_topic = "TALK_DONE",
            actions = { "u_die", actions.add_effect("speaker", "a_winner_is_u", { permanent = true }) },
        },
    },
}
