local ccb = require("ccb")

-- om_special does nothing because we are at the evac_center. I added this to make the linter happy.
ccb.content.define_mission {
    id = "MISSION_FREE_MERCHANTS_EVAC_1",
    name = ccb.content.text("Clear Back Bay"),
    description = ccb.content.text("Clear out the barricaded back area in the refugee center and lay the former leader of the Free Merchants to rest, in exchange for the local currency: Free Merchant certified notes."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 2,
    value = 50000,
    start = {
        target = { special = "evac_center", terrain = "evac_center_9", reveal_radius = 1 },
        map_updates = {
            {
                terrain = "evac_center_9",
                layout = {
                    monster_placements = {
                        {
                            group = "GROUP_REFUGEE_BOSS_ZOMBIE",
                            name = ccb.content.text("Sean McLaughlin"),
                            x = 10,
                            y = 10,
                            target = true,
                        },
                    },
                },
            },
        },
        actions = {
            ccb.content.dialogue_actions.update_map("smokes_take_down_back_bay_barricade", "evac_center_8"),
        },
    },
    finish = {
        map_updates = {
            {
                terrain = "evac_center_9",
                layout = {
                    tile_edits = {
                        {
                            shape = "rectangle",
                            operation = "terrain",
                            id = "t_floor",
                            x = 0,
                            y = 23,
                            end_x = 1,
                            end_y = 23,
                        },
                    },
                },
            },
        },
        actions = {
            { item = "FMCNote", count = 25 },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_FMShopkeep_Mission1", "yes"),
            { handler = "advance_counter_refugee_center_refugee_happiness_by_3" },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_FREE_MERCHANTS_EVAC_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("If you really want to lend a hand we could use your help clearing out the dead in the back bay.  Fearful of going outside during the first days of the Cataclysm we ended up throwing our dead and the zombies we managed to kill in the sealed back bay.  Our promising leader at the time even fell… he turned into something different.  Kill all of them and make sure they won't bother us again.  We can't pay much, besides some of our own internal money which isn't good for that much yet, but it would help us to reclaim the bay.  <color_red>If you accept, I'll tell the guards to immediately take down the barricade in the back.  You should only accept if you're ready to do this now.</color>"),
        accepted = ccb.content.text("Please be careful, we don't need any more deaths."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("If you can, get a friend or two to help you."),
        inquire = ccb.content.text("Will they be bothering us any longer?"),
        success = ccb.content.text("Thank you, having that big of a threat close to home was nerve wracking.  Here's some of our local certified notes, we've been paying these to our workers in exchange for supplies.  They're getting some value in the center as a trade item, I'm afraid they're all we have to spare at the moment."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}
