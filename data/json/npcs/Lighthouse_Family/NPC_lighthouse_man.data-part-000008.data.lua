local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_lighthouse_man_5",
    name = ccb.content.text("Fixing lighthouse"),
    description = ccb.content.text("Mikhail asked you to find someone, who have enough expertise to fix the mechanism of lighthouse."),
    goal = "MGOAL_CONDITION",
    difficulty = 0,
    value = 100000,
    -- Native mission phases did not apply the giver opinion (trust +3, value +3).
    finish = {
        map_updates = {
            {
                terrain = "lighthouse_z5",
                layout = {
                    terrain_placements = {
                        { id = "t_floor_olight", x = 11, y = 12 },
                        { id = "t_floor_olight", x = 13, y = 13 },
                    },
                },
            },
        },
        actions = {
            ccb.content.dialogue_actions.record_time({ scope = "interlocutor", key = "time_survivors_wait" }),
            ccb.content.dialogue_actions.set_actor_value("speaker", "global_safe_space_lighthouse_fixed", "yes"),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("-"),
        offer = ccb.content.text("My family is here, we have food, water, boat and a roof over our heads, all thanks to you, <name_g>.  Now, I also want to help other survivors.  Here's what I thought: if I can get this old lighthouse up and running, other survivors will see its light from afar.  If they see it, they will think that there are living people here, and will try to get here.  Can you help me fix it?"),
        accepted = ccb.content.text("I knew you wouldn't refuse!  But there is one problem: I have no idea how to fix it.  Maybe if you met someone who have experience in electrical engineering, we can figure out how to start this old junk."),
        rejected = ccb.content.text("Well, it's your choice."),
        advice = ccb.content.text("I'm sure that not all burned in flames of <the_cataclysm> and you can find someone suitable."),
        inquire = ccb.content.text("Well, have you fixed it?"),
        success = ccb.content.text("Splendid, <name_g>!  We can only wait now…"),
        success_lie = ccb.content.text("-"),
        failure = ccb.content.text("-"),
    },
    complete_when = "complete_mission_lighthouse_man_5",
}
