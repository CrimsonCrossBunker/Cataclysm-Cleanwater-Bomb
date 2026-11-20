local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_PROVE_YOUR_WORTH",
    name = ccb.content.text("Prove your worth to Foodperson"),
    description = ccb.content.text("Prove your dedication to the Foodperson and Foodplace as a whole by finding <color_yellow>10 Foodplace loyalty cards</color>."),
    goal = "MGOAL_FIND_ITEM",
    item = "fp_loyalty_card",
    item_count = 10,
    difficulty = 1,
    value = 0,
    finish = {
        item_rewards = { { item = "badge_foodkid" } },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_foodperson_npc_foodperson_impressed", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Prove your dedication to Foodplace."),
        offer = ccb.content.text("Show me the proof of your loyalty to the great Foodplace, and I'll consider you worthy of my friendship.  Ten loyalty cards should be enough, I'm sure you already have much more than that waiting for you at home, right?"),
        accepted = ccb.content.text("That's the spirit!  Good luck kid."),
        rejected = ccb.content.text("That's alright not everyone is cutout for this."),
        advice = ccb.content.text("Those are very precious, people would probably keep them on their person or in bank vaults.  And definitely not throw them in the trash!"),
        inquire = ccb.content.text("How is it going?  Do you have them?"),
        success = ccb.content.text("YES!  I knew you could do it!  You proved your worth and I'm proud to call you a friend."),
        success_lie = ccb.content.text("Well… where are they?"),
        failure = ccb.content.text("I'm so disappointed in you kid…"),
    },
}
