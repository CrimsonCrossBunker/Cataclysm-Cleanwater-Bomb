local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_JESSE_2",
    name = ccb.content.text("Kill monsters"),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 8,
    value = 80000,
    start = {
        target = { terrain = "forest_thick", reveal_radius = 1, random = true, min_distance = 15 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_flying_polyp", pack_size = { 3, 6 }, x = 11, y = 11, target = true },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We could use some help killing some monsters."),
        offer = ccb.content.text("We could use some help killing a pack of monsters.  I don't know what they are, but they're very fast, I'm willing to outfit you with a horse if you succeed."),
        accepted = ccb.content.text("Be ready for anything."),
        rejected = ccb.content.text("Thanks anyway, we will try some traps."),
        advice = ccb.content.text("A gun will probably help."),
        inquire = ccb.content.text("Did you kill it?"),
        success = ccb.content.text("I appreciate it, this will help keep our animals safe.  This is, Steve, he's a good, steady horse.  You should talk to Carlos about some armor for him."),
        success_lie = ccb.content.text("Show me the bodies."),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +1, value +1).
    finish = {
        actions = {
            ccb.content.dialogue_actions.purchase_pet("mon_horse", { count = 1, name = ccb.content.text("Steve") }),
            ccb.content.dialogue_actions.set_actor_value("speaker", "u_did_jesse_missions", "yes"),
        },
    },
}
