local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CARLOS_1",
    name = ccb.content.text("Find an anvil"),
    goal = "MGOAL_CONDITION",
    complete_when = "complete_mission_isherwood_carlos_1",
    difficulty = 5,
    value = 50000,
    item_count = 1,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_ISHERWOOD_CARLOS_2",
    dialogue = {
        describe = ccb.content.text("I need an anvil to do advanced metal work."),
        offer = ccb.content.text("I could really use an anvil."),
        accepted = ccb.content.text("You might be able to find one in a hardware store or similar."),
        rejected = ccb.content.text("Thanks anyway, we'll find the time to make it ourselves."),
        advice = ccb.content.text("If you can't find one, maybe you can make one for me."),
        inquire = ccb.content.text("Do you have the anvil?"),
        success = ccb.content.text("I appreciate it, this will really make a difference, here's some horse armor I've been working on.  Eventually I'll have the whole herd outfitted."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            { handler = "deliver_isherwood_carlos_anvil" },
            { item = "leather_armor_horse", count = 1 },
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "carlos_has_anvil", "yes"),
            ccb.content.dialogue_actions.record_time({ scope = "global", key = "timer_carlos_has_anvil" }),
        },
        map_updates = {
            {
                terrain = "horse_farm_isherwood_4",
                layout = {
                    tile_edits = {
                        { shape = "point", operation = "furniture", id = "f_anvil", x = 6, y = 12 },
                    },
                },
            },
        },
    },
}

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
