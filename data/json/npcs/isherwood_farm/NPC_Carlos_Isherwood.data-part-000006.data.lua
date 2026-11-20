local ccb = require("ccb")

-- om_special is a no-op here - we are already at 'Isherwood Farm Mutable'. I added it to suppress a linter false positive.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CARLOS_2",
    name = ccb.content.text("Find Chris Isherwood"),
    goal = "MGOAL_TALK_TO_NPC",
    difficulty = 3,
    value = 20000,
    start = {
        target = {
            special = "Isherwood Farm Mutable",
            terrain = "cabin_isherwood",
            reveal_radius = 1,
            random = true,
            min_distance = 2,
        },
        map_updates = {
            { layout = { npc_placements = { { id = "isherwood_chris", x = 8, y = 17, target = true } } } },
        },
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        handler = "mark_u_found_chris_for_carlos",
        item_rewards = { { item = "chainmail_armor_horse", count = 1 } },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Chris hasn't come back from his latest search for Barry, I'm getting concerned."),
        offer = ccb.content.text("Can you go find my son and tell him to check in with us."),
        accepted = ccb.content.text("Thank you."),
        rejected = ccb.content.text("Oh well.  I hope he turns up soon."),
        advice = ccb.content.text("He might be on the property somewhere, maybe by that old cabin near the entrance, sometimes he camps there."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Thanks, I was getting ready to go look myself.  Now that I have the anvil, I've been working on new armor for the horses, take this prototype I made."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("I hope he didn't meet Barry's fate…"),
    },
}
