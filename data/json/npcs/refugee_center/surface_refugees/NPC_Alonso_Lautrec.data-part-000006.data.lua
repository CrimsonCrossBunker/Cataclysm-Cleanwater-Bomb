local ccb = require("ccb")

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Alonso_pants",
    name = ccb.content.text("Alonso must have his special pants"),
    description = ccb.content.text("Find Alonso's leather pants in the 'toy shop' Alonso has marked on your map."),
    goal = "MGOAL_FIND_ITEM",
    difficulty = 2,
    value = 1000,
    item = "pants_leather",
    start = {
        target = { terrain = "cs_sex_shop", reveal_radius = 1, random = true, search_range = 240 },
        map_updates = {
            {
                terrain = "cs_sex_shop",
                layout = { item_placements = { { id = "pants_leather", x = 19, y = 20 } } },
            },
        },
        actions = {
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_flag_Alonso_pants", "in_progress"),
        },
    },
    finish = {
        before_rewards = {
            "mark_mission_flag_Alonso_pants",
            "advance_counter_refugee_center_refugee_happiness_by_2",
        },
        actions = {
            ccb.content.dialogue_actions.add_effect("interlocutor", "Alonso_pants_restored", { permanent = true }),
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I think I might know where those special pants might be though…"),
        offer = ccb.content.text("This clown was into some of the different things, not the vanilla, you understand me?  Yes.  I think you will find my valuables in a toy shop not so far."),
        accepted = ccb.content.text("You make me so happy I could give you little kisses, and some big kisses, and then something else maybe."),
        rejected = ccb.content.text("I know that you cannot resist me long.  I will wait, and perhaps some other pretty thing will help me instead?"),
        advice = ccb.content.text("It may be crowded no?  A popular place before, maybe is better to visit at night.  Sounds like Alonso's apartment no?  Ah, and if something strange grabs you and another pair of leather pants comes to you, maybe Alonso is even happier?"),
        inquire = ccb.content.text("Have you found what it is that you seek?  There may be something in it for you no?  Something big, but we take it slow yes?"),
        success = ccb.content.text("This is the best news since those lonely teachers asked me to be a nude model at the college for the blind.  Alas, the special condoms have all been used.  This is not a surprise, few could resist this seductive clown.  You find a condom, I find a use for it.  Safety, she was never more important than now, in *so* many ways."),
        success_lie = ccb.content.text("You give me confidence.  I trust you.  I do not know why this is."),
        failure = ccb.content.text("Disaster, but I thank you for to try.  You want a backrub some time, it will happen for sure.  And maybe you give me a rub too?"),
    },
}
