local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FARM_DEFENSE",
    line = ccb.content.text("We want to put up more fencing and build some look out spots, maybe lay some traps for the monsters.  We could use some extra resources.  If you want to bring me logs, sand, clay, wire, nails, wood planks, and metal chunks, I'll give you signed chits you can use to buy goods from any of the family."),
    replies = {
        {
            text = ccb.content.text("Sounds reasonable, I'll see what I can do."),
            next_topic = "TALK_NONE",
            actions = { actions.set_actor_value("speaker", "u_scavenge_for_Jack_Isherwood", "yes") },
        },
        {
            text = ccb.content.text("I'm not interested right now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_WIFE",
    line = ccb.content.text("Claire and I have been together for 40 years now, couldn't run this place without her.  She's quite the herbalist too, been real useful lately.  She is probably in the house, you should stop in."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_claire_herbalist", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_DAUGHTER",
    line = ccb.content.text("Jesse and her family live up at the horse farm.  Her husband, Carlos, may have some jobs for you."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_about_jesse", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_JACK_BROTHER",
    line = ccb.content.text("Eddie's dairy is at the end of the road.  It's just him and his son since Barry was taken by that thing in the woods."),
    on_enter = { { actions = { actions.set_actor_value("speaker", "u_learned_about_eddie", "yes") } } },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_JACK_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
