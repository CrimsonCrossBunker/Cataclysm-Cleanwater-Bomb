local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "robofac_garage_scientist_1",
    unique_name = ccb.content.text("Sebastian Smith"),
    suffix = ccb.content.text("Hub Scientist"),
    class = "NC_ROBOFAC_SCIENTIST_GARAGE",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_ROBOFAC_SCIENTIST_GARAGE",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc_class {
    id = "NC_ROBOFAC_SCIENTIST_GARAGE",
    name = ccb.content.text("Hub Scientist"),
    job_description = ccb.content.text("A Hub 01 scientist."),
    common = false,
    traits = {
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "RETURN_TO_START_POS" },
    },
    strength = { rng = { 0, 1 } },
    dexterity = { rng = { 0, 2 } },
    intelligence = { rng = { -2, 0 } },
    perception = { rng = { 0, 2 } },
    worn = "NC_ROBOFAC_SCIENTIST_GARAGE_worn",
    weapon = "NC_ROBOFAC_SCIENTIST_GARAGE_wield",
    skills = { { skill = "firstaid", bonus = 8 }, { skill = "electronics", bonus = 8 } },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_SCIENTIST_GARAGE_SELL_EXODII",
    line = ccb.content.text("Is that so?  What do you have?"),
    replies = {
        {
            text = ccb.content.text("[1 HGC] I've brought you one of those workers."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_d5a685558a07"),
            actions = { actions.handler("dlg_a_dda_4c91eb166453") },
        },
        {
            text = ccb.content.text("[2 HGC] I've brought you one of those quadrupeds."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_4c42079ffa99"),
            actions = { actions.handler("dlg_a_dda_f7a1fbc5f069") },
        },
        {
            text = ccb.content.text("[2 HGC] I've brought you one of those turrets."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c7eeecf43eb7"),
            actions = { actions.handler("dlg_a_dda_6d2f64f6260e") },
        },
        {
            text = ccb.content.text("[4 HGC] I found this strange balloon robot."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_4004e2d04b14"),
            actions = { actions.handler("dlg_a_dda_49ea36d673a8") },
        },
        {
            text = ccb.content.text("Nevermind.  Let's talk about something else."),
            next_topic = "TALK_ROBOFAC_SCIENTIST_GARAGE",
        },
        {
            text = ccb.content.text("Actually, I'd better be going."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_SCIENTIST_GARAGE_RESEARCH_PROGRESS",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_3" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_3" } }),
            yes = {
                when = predicates.handler("dlg_p_dda_a5d50abe7c2d"),
                yes = ccb.content.text("R&D is going well.  Maybe we'll have new products ready sometime soon."),
                no = ccb.content.text("Research is ongoing.  Nothing new to report."),
            },
            no = ccb.content.text("We've made some progress.  If you're keen to use our newest prototypes, I'd encourage you to see the Doc across the street.  Now we're looking for some cool military tech to synergize with the circuits I'm slapping together.  The intercom will have a relevant open contract, if they don't already."),
        },
        no = ccb.content.text("Honestly?  I'm able to reverse engineer a lot of this tech, but I can't recreate it.  Our top engineers know what we need to fix the problem, and are looking for mercs to help us solve the problem.  Ask about contracts at the intercom."),
    },
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_ROBOFAC_SCIENTIST_GARAGE",
        },
        {
            text = ccb.content.text("I'd better be going."),
            next_topic = "TALK_DONE",
        },
    },
}
