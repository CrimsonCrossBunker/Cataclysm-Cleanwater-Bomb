local ccb = require("ccb")

-- TO-DO - Maybe add a physical charcoal smoker 'fake_char_smoker' to the camp mapgen?
ccb.content.define_mission {
    id = "MISSION_BUILD_CAMP_6",
    name = ccb.content.text("Refurbishments Pt. VI"),
    description = ccb.content.text("Obtain a charcoal smoker."),
    goal = "MGOAL_FIND_ITEM",
    item = "char_smoker",
    item_count = 1,
    difficulty = 1,
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    finish = {
        map_updates = {
            {
                terrain = "homelesscamp_npc",
                layout = { nested = { { x = 0, y = 0, id = "homeless_camp_refurb_5" } } },
            },
        },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_trade_smoked_meat_tradeable", "yes"),
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("Turns out that ant meat you got us wasn't actually too bad.  A little tough, sure, but perfectly edible.  The problem now is we need a way of preserving it.  One of those portable charcoal smokers would be really great.  Heck, you might even wanna buy some."),
        advice = ccb.content.text("Maybe try a farm?  I bet those rural folks were pretty invested in preserving their food."),
        accepted = ccb.content.text("Thank you.  We'll be sure to compensate your efforts."),
        rejected = ccb.content.text("Alright, I can understand that.  I guess I'll have to get it myself."),
        inquire = ccb.content.text("Do you have the charcoal smoker?"),
        success = ccb.content.text("Thank you.  We'll get started right away."),
        success_lie = ccb.content.text("I can tell you're lying.  I don't see shit."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}
