local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_GODCO_CORRIE_MACHINE1",
    name = ccb.content.text("Renewable Energy"),
    description = ccb.content.text("Find a solar panel array or 4 solar panels of either regular or advanced variant for Corrie."),
    goal = "MGOAL_CONDITION",
    difficulty = 1,
    value = 0,
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I have a plan…"),
        offer = ccb.content.text("Okay, great.  We're gonna create a charger and a generator all in one.  Here's the battle plan.  Zack could create the framework, you'll get me a solar panel, the rest I can craft or repurpose from the bus.  Helena's promised us a reward if this thing lives up to her standards."),
        accepted = ccb.content.text("With my brains and your brawn we'll make an excellent team.  A regular solar panel will do just fine."),
        rejected = ccb.content.text("No electricity for us then."),
        advice = ccb.content.text("All you need is a good wrench and a solar car."),
        inquire = ccb.content.text("Do you have the solar panel?"),
        success = ccb.content.text("The great work is now complete.  Are you good with words, by the way?  I was thinking, maybe you should be the one to negotiate with Helena.  But whatever you do, don't accept their icons.  Our work is worth a lot more than their valueless currency."),
        success_lie = ccb.content.text("Thanks for trying… I guess."),
        failure = ccb.content.text("No electricity for us then."),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            { handler = "deliver_mission_godco_corrie_machine1" },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_godco_corrie_machine", "in-progress"),
            ccb.content.dialogue_actions.update_map("place_solar_farm", "godco_1"),
        },
    },
    -- Native mission phases did not apply the giver opinion (anger +1).
    failure = {},
    complete_when = "complete_mission_godco_corrie_machine1",
}
