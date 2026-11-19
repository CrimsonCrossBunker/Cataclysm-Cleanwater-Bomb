local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- TODO: The rep should know whether you're actually a sworn officer: Wearing the badge without the trait => Bad idea
ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP",
    line = {
        when = predicates.has_any_trait("speaker", { "PROF_FED" }),
        yes = ccb.content.text("Marshal…"),
        no = ccb.content.text("Citizen…"),
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            trial = { kind = "persuade", difficulty = 15 },
            failure = { next_topic = "TALK_OLD_GUARD_REP_Refuse_Boris_Mission_1" },
            success = { next_topic = "TALK_OLD_GUARD_REP_Accept_Boris_Mission_1" },
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_OLD_GUARD_REP_NEW" },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_OLD_GUARD_REP_WORLD",
        },
        {
            text = ccb.content.text("Is there any way I can join the 'Old Guard'?"),
            next_topic = "TALK_OLD_GUARD_REP_ASK_JOIN",
        },
        {
            text = ccb.content.text("I've got some questions for you about those weird robots."),
            next_topic = "TALK_OLD_GUARD_REP_EXODII_1",
            when = predicates.any({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.any_equal({ "encountered_base", { scope = "speaker", key = "factional_questline_mission_oldguard-exodii" } }) }),
        },
        {
            text = ccb.content.text("I think I can already tell you what you want to know about those 'robots'."),
            next_topic = "TALK_OLD_GUARD_REP_MISSION_3_Predone",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }) }),
        },
        {
            text = ccb.content.text("Does the Old Guard need anything?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("I wanted to ask you something about that offer."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_sunken_helicopter" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } }) }),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_HUB",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            actions = { actions.set_actor_value("speaker", "sunken_helicopter_tip_offer", "yes") },
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "proven_worth_to_old_guard_representative" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } })) }),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_0",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            when = predicates.any({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "proven_worth_to_old_guard_representative" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } }) }),
            next_topic = "TALK_DONE",
        },
    },
}
