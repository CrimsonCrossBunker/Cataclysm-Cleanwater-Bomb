local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_seer" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
            yes = {
                when = predicates.has_trait("speaker", "seer_mark"),
                yes = {
                    when = predicates.actor_state("speaker", "female"),
                    yes = ccb.content.text("Greetings, sister."),
                    no = ccb.content.text("Greetings, brother."),
                },
                no = ccb.content.gendered_line("Traveler.", { "speaker" }),
            },
            no = ccb.content.gendered_line("You're back.  Have you come to listen to the song?", { "speaker" }),
        },
        no = ccb.content.text("You there.  Quiet down.  Can you hear it?  The song?"),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_first_meeting_talked_to_seer", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What song?"),
            next_topic = "TALK_BONE_SEER_SONG",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } })),
        },
        {
            text = ccb.content.text("So about the songs…"),
            next_topic = "TALK_BONE_SEER_SONG2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("Do others follow this belief as well?"),
            next_topic = "TALK_BONE_SEER_OTHERS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("Can you tell me more about yourself?"),
            next_topic = "TALK_BONE_SEER_ABOUT",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("You mentioned some cycle before.  What does that mean?"),
            next_topic = "TALK_BONE_SEER_CYCLE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text("I've met Cooper."),
            next_topic = "TALK_BONE_SEER_METCOOPER",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_first_meeting_talked_to_cooper" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_kindred_cooper_knows_cooper" } }) }),
        },
        {
            text = ccb.content.text("Would you like to join me on my travels?"),
            next_topic = "TALK_SUGGEST_FOLLOW_SEER",
            when = predicates.all({ predicates.negate(predicates.actor_state("interlocutor", "following")), predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }) }),
        },
        {
            text = ccb.content.text("Is there a way I can help you with your song?"),
            next_topic = "TALK_MISSION_LIST_SEER",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } })),
        },
        {
            text = ccb.content.text("I have to get going.  Take care, Seer."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_song_asked_about_song" } }),
        },
    },
}
