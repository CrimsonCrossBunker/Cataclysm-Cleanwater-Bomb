local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Part of the Isherwood family.
ccb.content.define_npc {
    id = "isherwood_lisa",
    unique_name = ccb.content.text("Lisa Isherwood"),
    gender = "female",
    class = "NC_ISHERWOOD_LISA",
    attitude = 0,
    mission = "GUARD",
    age = 20,
    height = 170,
    strength = 8,
    dexterity = 9,
    intelligence = 10,
    perception = 9,
    personality = { aggression = 1, bravery = 5, collector = 1, altruism = 3 },
    chat = "TALK_ISHERWOOD_LISA",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_LISA",
    name = ccb.content.text("Lisa Isherwood"),
    job_description = ccb.content.text("Part of the Isherwood family"),
    traits = {
        { trait = "ANIMALEMPATH" },
        { trait = "ANTIJUNK" },
        { trait = "PRETTY" },
        { group = "Appearance_demographics" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    worn = "NC_Isherwood_female_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 3, 6 } } },
        { skill = "gun", bonus = { rng = { 3, 5 } } },
        { skill = "rifle", bonus = { rng = { 2, 5 } } },
        { skill = "archery", bonus = { rng = { 2, 5 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA",
    line = {
        when = predicates.wears("speaker", "badge_marshal"),
        yes = ccb.content.text("I see that badge, I think you need to keep on walking, straight off this property."),
        no = ccb.content.text("Hi, what brings you here?"),
    },
    on_enter = {
        { once = "u_met_lisa", actions = { actions.set_actor_value("speaker", "u_met_lisa_isherwood", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("…"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL",
            when = predicates.wears("speaker", "badge_marshal"),
            opinion = { trust = -20, value = -20 },
        },
        {
            text = ccb.content.text("Hi, this is a nice farm, your family lives here?"),
            next_topic = "TALK_ISHERWOOD_LISA_TALK1",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
            actions = { actions.set_actor_value("speaker", "u_met_Lisa_Isherwood", "yes"), actions.set_actor_value("speaker", "u_met_an_isherwood", "yes") },
        },
        {
            text = ccb.content.text("Hi, I'm looking for Jesse."),
            next_topic = "TALK_LISA_JESSE",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_learned_about_jesse" } }) }),
            actions = { actions.set_actor_value("speaker", "u_met_Lisa_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("Hi, I'm looking for Chris."),
            next_topic = "TALK_LISA_CHRIS",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_heard_about_chris" } }) }),
            actions = { actions.set_actor_value("speaker", "u_met_Lisa_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("I talked to Chris about rescuing Barry.  He thinks you might be able to help."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALKED_TO_LISA",
            when = predicates.handler("dlg_p_dda_c82f3dfba09e"),
        },
        {
            text = ccb.content.text("I talked to Chris about rescuing Barry.  He thinks you might be able to help."),
            next_topic = "TALK_ISHERWOOD_CHRIS_NOT_TALKED_TO_LISA",
            when = predicates.handler("dlg_p_dda_6ddab87473f0"),
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA_TALK1",
    line = ccb.content.text("My family owns all the land around here, my parents are out in the barn and my other family is down the road."),
    replies = {
        { text = ccb.content.text("Ok, I'll go find them."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_JESSE",
    line = ccb.content.text("Mom is in her office, in the barn.  Be careful that you don't let our horses out."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_CHRIS",
    line = ccb.content.text("Chris is out hunting or something right now."),
    replies = {
        { text = ccb.content.text("Oh, ok."), next_topic = "TALK_DONE" },
        { text = ccb.content.text("Or something?"), next_topic = "TALK_LISA_CHRIS2" },
        { text = ccb.content.text("Nice talking to you, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LISA_CHRIS2",
    line = ccb.content.text("Well, he's supposed to be hunting, but since you've been talking to Luke, I bet he mentioned Chris wants to learn more about the end of the world.  Sometimes he'll take off for a few days and I end up patching him up so my parents don't know he left the property."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_heard_about_lukefromlisa", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_LISA_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        { text = ccb.content.text("Hi, I'm looking for Jesse."), next_topic = "TALK_LISA_JESSE" },
        { text = ccb.content.text("Hi, I'm looking for Chris."), next_topic = "TALK_LISA_CHRIS" },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TALKED_TO_LISA",
    line = ccb.content.text("Yeah, Chris talked to me a minute ago.\"  She touches the shoulder strap on her rifle.  \"I can't believe he's not trying to talk me out of it, really, but I'd do anything to save Uncle Barry.  I'll be ready at the tower, when you need me."),
    replies = { { text = ccb.content.text("Great.  I'll see you there."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_NOT_TALKED_TO_LISA",
    line = ccb.content.text("He did?\"  She touches the shoulder strap on her rifle.  \"Like, action?  Yeah, I'm a pretty good shot, and I'd do anything to save Uncle Barry.  I'm surprised Chris didn't try to go all protective older brother on me.  What's the plan?"),
    replies = {
        {
            text = ccb.content.text("[Explain the plan.]"),
            next_topic = "TALK_ISHERWOOD_LISA_JOIN_RESCUE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_LISA_JOIN_RESCUE",
    line = ccb.content.text("&She listens intently as you explain.  \"All right.  I'll be ready at the tower when you need me.\""),
    replies = {
        {
            text = ccb.content.text("Great.  I'll see you there."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_4a6eb839c8e7") },
        },
    },
}
