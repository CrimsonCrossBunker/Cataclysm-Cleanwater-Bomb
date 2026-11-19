local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Even though material possessions have been made trivially easy to obtain in the apocalypse, the prepper still values their stash, hence the difficult trial here.
ccb.content.define_dialogue_topic {
    id = "BGSS_PREPPER_1_LMOE2",
    line = ccb.content.gendered_line("The shelter?  Bought the land pretty cheap.  I hired a contractor to build the thing but did the door myself.  Metal pin in the door frame.  Can't open unless you remove it.  There's a little pulley inside you have to pull up to reset.  They made dozens of these in the area, and I couldn't sleep knowing just any <name_b> at that company could waltz in as soon as shit hit the fan.  They'd know exactly where to go and what to do!  Nah… how do you think I've made it this long?  Always keep a trick up your sleeve.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("A contractor?  How much does something like a survivalist shelter cost?"),
            next_topic = "BGSS_PREPPER_1_LMOE4",
        },
        {
            text = ccb.content.text("But we're good to go, right?  I mean… the door is the only trick you had?  No clever traps hidden in the walls or anything?"),
            next_topic = "BGSS_PREPPER_1_LMOE3",
        },
        {
            text = ccb.content.text("You wouldn't keep ALL your tricks and secrets from me, though, would you?  After everything we've been through?"),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_asked_about_secrets" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_BGSS_prepper_1_found_computer" } })) }),
            trial = {
                kind = "persuade",
                difficulty = -75,
                modifiers = {
                    { score = "TRUST", scale = 1 },
                    { score = "VALUE", scale = 1 },
                    { score = "ANGER", scale = -8 },
                },
            },
            success = {
                next_topic = "BGSS_PREPPER_1_SHARELOOTSUCCESS",
                actions = {
                    actions.set_actor_value("speaker", "mission_BGSS_prepper_1_asked_about_secrets", "yes"),
                },
            },
            failure = {
                next_topic = "BGSS_PREPPER_1_SHARELOOTFAILURE",
                actions = {
                    actions.set_actor_value("speaker", "mission_BGSS_prepper_1_asked_about_secrets", "yes"),
                },
                opinion = { trust = -6, value = -3, anger = 5 },
            },
        },
        { text = ccb.content.text("That's all I wanted to know."), next_topic = "TALK_DONE" },
    },
}
