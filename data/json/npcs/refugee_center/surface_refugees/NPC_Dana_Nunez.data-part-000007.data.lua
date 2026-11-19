local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_Dana_Background_baking2",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } }),
        yes = {
            choices = {
                ccb.content.text("Great, here's a loaf of the best damn sourdough bread in the world.  I used to make that claim as a joke, but I feel like now there's a fighting chance nobody else can beat me."),
                ccb.content.text("Nice.  Enjoy the mighty bounty of Landough Calrisean."),
                ccb.content.text("Here you go, from the family recipe."),
                ccb.content.text("Hope you enjoy it as much as I do, this is the best damn bread in the world now."),
            },
        },
        no = ccb.content.text("Great, here's a loaf of my locally-famous, not-very-mature sourdough.  It's not too bad honestly.  Everyone here seems to like it."),
    },
    on_enter = {
        {
            actions = {
                actions.add_effect("interlocutor", "dana_baking_sold", { turns = 64800 }),
                actions.set_actor_value("speaker", "knowledge_Dana_Sourdough", "yes"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("You seem pretty unhappy about the quality of your bread.  Is there something I can do to help?"),
            next_topic = "TALK_DANA_Sourdough",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_flag_Dana_Sourdough" } })),
        },
        {
            text = ccb.content.text("It smells awesome.  <end_talking_leave>  Thanks!"),
            next_topic = "TALK_DONE",
        },
    },
}
