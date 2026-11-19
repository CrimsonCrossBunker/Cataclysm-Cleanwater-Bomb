local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "MSU14_MAIN",
    line = ccb.content.text("&<color_red>WARNING: ADMINISTRATIVE LOCKDOWN IN EFFECT.  USAGE OF SYSTEM 14 HAS BEEN CURTAILED.</color>\n\n"),
    replies = {
        {
            text = ccb.content.text("Install the Hub software package."),
            next_topic = "MSU14_MISSION_COMPLETE",
            when = predicates.has_mission("RD_1"),
        },
        {
            text = ccb.content.text("Attempt to access System 14."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "computer_hacking_msu14_hack" } })),
            trial = { kind = "skill_check", difficulty = 5, skill = "computer" },
            success = { next_topic = "MSU14_UNIT_ACCESS" },
            failure = { next_topic = "MSU14_HACK_FAILURE" },
        },
        { text = ccb.content.text("Browse stored documents."), next_topic = "MSU14_PRE_DOCS" },
        { text = ccb.content.text("Log Off"), next_topic = "TALK_DONE" },
    },
}
