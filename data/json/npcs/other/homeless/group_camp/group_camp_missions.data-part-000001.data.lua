local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_HUNT_ANTS",
    name = ccb.content.text("Arthropod Hunting"),
    description = ccb.content.text("Kill some ants and bring back ten slices of their meat in exchange for credit with some of the traders."),
    goal = "MGOAL_FIND_ITEM",
    item = "mutant_meat",
    item_count = 10,
    difficulty = 1,
    value = 4000,
    origins = { "ORIGIN_SECONDARY" },
    followup = "MISSION_BUILD_CAMP_1",
    start = {
        target = { terrain = "field", reveal_radius = 1, random = true, search_range = 15 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        { id = "mon_ant", pack_size = { 2, 2 }, x = 8, y = 8, target = true },
                    },
                },
            },
        },
    },
    finish = {
        actions = {
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "dialogue_trade_ant_meat_tradeable", "yes"),
        },
    },
    generic_rewards = true,
    dialogue = {
        describe = ccb.content.text("I need some help."),
        offer = ccb.content.text("The last time we went out scouting we found some gargantuan ants crawling around.  We thought we might see how they taste, if they could be cooked and whatnot.  I want you to go kill one and bring back some of its meat."),
        advice = ccb.content.text("A shotgun of some sort might work well."),
        accepted = ccb.content.text("I'll be here when you get back."),
        rejected = ccb.content.text("Alright, I can understand that."),
        inquire = ccb.content.text("Do you have the meat?"),
        success = ccb.content.text("Nice.  I'll get these cooked up.  Who knows, we might want some more in the future."),
        success_lie = ccb.content.text("You sure?  I don't see my meat anywhere."),
        failure = ccb.content.text("Ah, well.  It's no big deal."),
    },
}
