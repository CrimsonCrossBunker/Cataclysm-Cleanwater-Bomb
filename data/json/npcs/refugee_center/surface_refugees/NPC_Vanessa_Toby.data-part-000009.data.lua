local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Vanessa_1",
    name = ccb.content.text("Make a makeshift haircut kit for Vanessa Toby in the refugee center"),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 0,
    item = "survivor_hairtrimmer",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("If I had some equipment, I could do some hairdresser work here."),
        offer = ccb.content.text("I didn't think to pack my hairdressing equipment when I was evacuated.  If you could put together a basic hair cutting kit for me, I could do a bit of styling for people around here.  I'll even give you a free haircut for your troubles."),
        accepted = ccb.content.text("Cool, thanks.  It'll be good to have something useful to do, and to not be staring at so many shaggy slobs."),
        rejected = ccb.content.text("Whatever, I'll keep twiddling my thumbs then."),
        advice = ccb.content.text("I don't need too much.  Scissors, a small mirror, a bit of cloth, and some way to keep it all stored clean when I'm not using it, like a leather pouch or something.  I can get the rest of what I need from shelter supplies."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Well, this is pretty serviceable.  Heck, these scissors are nice enough that I could probably inexplicably make your hair longer or a different color with them."),
        success_lie = ccb.content.text("What good does this do me?"),
        failure = ccb.content.text("Seriously?  You failed to find *scissors*?  How do you tie your shoes in the morning?"),
    },
    finish = {
        handler = "advance_counter_refugee_center_refugee_happiness_by_2",
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Vanessa_Mission1", "yes"),
            ccb.content.dialogue_actions.set_actor_value("interlocutor", "mission_services_owed_haircut_1", "yes"),
        },
    },
}
