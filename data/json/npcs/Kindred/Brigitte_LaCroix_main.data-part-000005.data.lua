local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BONE_SEER_SONG2_FRIEND",
    line = ccb.content.text("When it all happened, the Cataclysm, something… changed.  You can see it in all creatures, most of all in their bones.  They break, morph, rise again, over and over - a never-ending cycle.  The dead walk again, horrors rip and tear each other apart.  And within each one… the quiet hum of raw strength.  Only by taking the bones does the cycle end - their story, their song, their strength; they become yours to use."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_song_asked_about_song", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What do we actually do with the bones?"),
            next_topic = "TALK_BONE_SEER_BONES_FRIEND",
        },
        {
            text = ccb.content.text("I'm still not remembering fully."),
            next_topic = "TALK_BONE_SEER_SONG3_FRIEND",
        },
        {
            text = ccb.content.text("Does anyone else, uh, believe this?"),
            next_topic = "TALK_BONE_SEER_OTHERS_FRIEND",
        },
    },
}
