local ccb = require("ccb")
local actions = ccb.content.dialogue_actions
local predicates = ccb.content.dialogue_predicates



ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY",
    line = ccb.content.text("&As you sit, the older mercenary continues their narration of <merc_story>.\n\nWhen their tale reaches conclusion, you stop to consider what sort of story you could tell."),
    replies = {
        {
            text = ccb.content.text("Recall that time when you rescued a farmer's son from a citadel full of alien horrors."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_saved_barry_isherwood" } }),
        },
        {
            text = ccb.content.text("Tell them about your hunting of a pyramidal robot using a prototype energy rifle."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_OK",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_robot_sm_1" } }),
        },
        {
            text = ccb.content.text("Tell them about the time you hunted down an Exodii worker for the intercom."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_OK",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_circuit_safari" } }),
        },
        {
            text = ccb.content.text("Recall the time you were tricked into fighting against distorted versions of yourself while lost in a place beyond time."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.handler("dlg_p_dda_5957e2c14a79"),
        },
        {
            text = ccb.content.text("Tell about your slaying of an insectile horror after getting trapped within its lair."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_talk_killed_a_void_spider" } }),
        },
        {
            text = ccb.content.text("Recall the long story of how you agreed to help the remnants of the Federal Government."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_BAD",
            when = predicates.has_trait("speaker", "PROF_FED"),
        },
        {
            text = ccb.content.text("Tell them about the horrors uncovered by the mining expeditions of New England."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_talk_clearead_amigara_mine" } }),
        },
        {
            text = ccb.content.text("Tell them about the horrors wandering in these very same subway tunnels."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_OK",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_talk_clearead_amigara_mine" } }),
        },
        {
            text = ccb.content.text("Recall that time when you used a tactical nuclear weapon."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.handler("dlg_p_dda_ad5089f7518c"),
        },
        {
            text = ccb.content.text("Try to gross each other out with tales of mutant butchery."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_BUTCHERY",
            when = predicates.handler("dlg_p_dda_5e3595b3966d"),
        },
        {
            text = ccb.content.text("Speak about the alien construct you found while lost in an endless sea of black glass."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_yrax_u_met_apeirohedra" } }),
        },
        {
            text = ccb.content.text("Tell them the story of how you were trapped in an infinitely looping corridor, fighting the warped remnants of the researchers there and somehow the damned corridor itself.  And at the end of the day, you're not even sure the headache was worth it."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_LIXA",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_lixa_sm_1" } }),
        },
        {
            text = ccb.content.text("Tell them the story of how you dived into and were forced to fight for your life within a disgusting, toxic hellscape made from the un-living innards of some crushed zombie monstrosity.  All so the intercom could have some damned HDD back."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_TOWER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_intercom_completed_robofac_intercom_3" } }),
        },
        {
            text = ccb.content.text("Recall the quiet farmstead, and the terrible tale of being slowly transformed into a creature made of black glass."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.has_trait("speaker", "NOT_GLASS"),
        },
        {
            text = ccb.content.text("Regale the tale of the glowing church and the otherworldly strings."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_OK",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knows_xedra_field_station_1" } }),
        },
        {
            text = ccb.content.text("Tell them a story about the dimension of glowing strings…"),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_STRING_DIMENSION",
            when = predicates.handler("dlg_p_dda_722a72f0080f"),
        },
        {
            text = ccb.content.text("Recall the ruins in the woods, and the small, dish-faced creatures dancing behind the fence."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_OK",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knows_xedra_field_station_2" } }),
        },
        {
            text = ccb.content.text("Show them the red mp3 player, and tell them, no, really, it TALKS to you, and is leading you somewhere.  You swear."),
            when = predicates.has_item("speaker", "mp3_reverberation"),
            trial = { kind = "persuade", difficulty = 25 },
            success = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_OK" },
            failure = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_BAD" },
        },
        {
            text = ccb.content.text("[LIE] Just make something up."),
            trial = { kind = "lie", difficulty = 15 },
            success = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE" },
            failure = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_BAD" },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_TELL_STORY_STRING_DIMENSION",
    line = ccb.content.text("&The mercenaries listen carefully as you begin to tell them about your journey into the dimension of glowing strings…"),
    replies = {
        {
            text = ccb.content.text("Tell them all about the sea of black nothingness and the criss-crossing glowing strings, and hope they believe you."),
            trial = { kind = "persuade", difficulty = 25 },
            success = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE" },
            failure = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_BAD" },
        },
        {
            text = ccb.content.text("Show them the glowing string as you recall the tale of the other world, proving such things exist."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.has_item("speaker", "inert_glowing_string"),
        },
        {
            text = ccb.content.text("Tell them about the inverted ziggurat, the strange device underground, and the hypercube it housed.  They have to believe it was the only way home!"),
            when = predicates.handler("dlg_p_dda_25c93988a340"),
            trial = { kind = "persuade", difficulty = 25 },
            success = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE" },
            failure = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_BAD" },
        },
        {
            text = ccb.content.text("Speak about the inverted ziggurat and show them the hypercube that helped you escape."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.has_item("speaker", "string_dimension_hypercube"),
        },
        {
            text = ccb.content.text("Tell them about the inverted metal ziggurat, the hissing doors, and the mummified zombies.  Show them the otherworldly steel equipment to prove your tale."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.any({ predicates.has_item("speaker", "string_dimension_partigiana_ixwa"), predicates.has_item("speaker", "string_dimension_helmet_conical"), predicates.has_item("speaker", "string_dimension_chainmail_suit"), predicates.has_item("speaker", "string_dimension_mirror_cuirass") }),
        },
        {
            text = ccb.content.text("Also tell them the story of the domed ruin and its undead, cyborg inhabitants.  It's so crazy it has to be true, right?"),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_found_string_dimension_exodii" } }),
            trial = { kind = "persuade", difficulty = 25 },
            success = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE" },
            failure = { next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_BAD" },
        },
        {
            text = ccb.content.text("Recall the story of the domed ruin, and show them the odd, plastic key you recovered from the walking corpse."),
            next_topic = "BEM_CHATTING_VETERANS_TELL_STORY_IMPRESSIVE",
            when = predicates.has_item("speaker", "id_exodii_string_dimension"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "BEM_CHATTING_VETERANS_DRINKING",
    line = ccb.content.text("You share increasingly embellished stories about your exploits as you dare each other into downing series of eye-watering drinks."),
    on_enter = {
        { actions = { actions.add_effect("speaker", "drunk", { turns = 22200 }), actions.handler("w16b_a_dda_437a457cc817"), actions.adjust_faction_trust(1) } },
    },
    replies = {
        {
            text = ccb.content.text("Bar… barshender!  We… we?"),
            next_topic = "TALK_DONE",
            actions = { "end_conversation", actions.handler("w16b_a_dda_f6d831e35749") },
        },
    },
}
