local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_SCIENTIST_GARAGE",
    line = {
        when = predicates.handler("dlg_p_dda_2e6ab3005522"),
        yes = ccb.content.text("Ah, it's you.  Good to see you.  What can I do for you?  Here to collect on the bounty?"),
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_scientist_garage_first_meet" } }),
            yes = ccb.content.text("Got something for me?"),
            no = {
                when = predicates.has_trait("speaker", "EXODII_CYBERFRAME_GENERIC"),
                yes = ccb.content.text("Oh, my.  Look at you.  As they promised, you are quite the machine.  On the side of humanity, too, I hear.  I take it you're here for the bounty?"),
                no = ccb.content.text("Ah, good, another independent contractor, right?  I take it you've heard about the bounty?"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Bounty?"),
            next_topic = "TALK_ROBOFAC_SCIENTIST_GARAGE_BOUNTY",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_scientist_garage_first_meet" } })),
            actions = { actions.set_actor_value("speaker", "dialogue_robofac_scientist_garage_first_meet", "yes") },
        },
        {
            text = ccb.content.text("I'm here to collect on the bounty."),
            next_topic = "TALK_ROBOFAC_SCIENTIST_GARAGE_SELL_EXODII",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_scientist_garage_first_meet" } }),
        },
        {
            text = ccb.content.text("How goes research?"),
            next_topic = "TALK_ROBOFAC_SCIENTIST_GARAGE_RESEARCH_PROGRESS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_robofac_scientist_garage_first_meet" } }),
        },
        {
            text = ccb.content.text("Nevermind.  Bye."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_SCIENTIST_GARAGE_BOUNTY",
    line = ccb.content.text("That's right, bounty.  No doubt you've heard of the aliens known as the \"Exodii\", right?  Big killer-robot-vibes, am I right?  Well, I've spun off an initiative adjacent to our Cybernetic Enhancements Program.  The basic strategy is simple: learn what we can, synergize with our strengths, and fight fire with fire.\n\nSo here's the play: I'm actively sourcing \"decommissioned\" Exodii hardware for teardown and reverse engineering.\n\nIt's simple: you bring inactivated Exodii here, and I'll pay you for each one.  Think of yourself as a citizen scientist, yeah?  A community R&D effort.\n\nSmall note, though.  None of those \"zomborg\" things - the walking corpses with devices jammed into them.  Another team is running that pipeline, and honestly, the signals out of that aren't so great.\n\nRight now, the highest value pickups are worker drones, the big four-legged robots, and turret platforms.  They're hard to come by, but trust me, I'll pay a good price."),
    replies = {
        {
            text = ccb.content.text("I'll keep that in mind.  See you around."),
            next_topic = "TALK_DONE",
        },
    },
}
