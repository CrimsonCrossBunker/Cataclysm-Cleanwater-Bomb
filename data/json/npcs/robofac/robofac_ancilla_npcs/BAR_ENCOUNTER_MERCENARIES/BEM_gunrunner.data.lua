local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = { "BEM_GUNRUNNER_1" },
    line = ccb.content.text("&You find the gun runner intently assessing the swirling smoke of a stale cigarette.  <mypronoun> barely acknowledges your approach.  \"Let's cut it short, I have come upon an excess supply of exotic weaponry and let's say that it would be expedient for it to disappear and you seem like just the kind of person I'm looking for.\"\n\n<mypronoun> hands you an inventory list, loosely annotated in a piece of graph paper.\n\n\"No harm in looking right?\""),
    on_enter = { { actions = { actions.set_actor_value("interlocutor", "bool_ancilla_barkeep", "yes") } } },
    replies = {
        {
            text = ccb.content.text("Sure, let's see what you have to offer."),
            next_topic = "TALK_DONE",
            actions = { "start_trade" },
        },
        { text = ccb.content.text("Sorry, not interested."), next_topic = "TALK_DONE" },
    },
}
