local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_RANCH_FOREMAN_ANESTHETIC_FOR_DOCTOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped" } }),
        yes = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } }),
            yes = ccb.content.text("I'm afraid I don't have anything to offer."),
            no = ccb.content.text("I don't have anything to offer, but maybe the scrappers could help find some materials."),
        },
        no = {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } }),
            yes = ccb.content.text("I don't have anything to offer, but maybe the scavenger boss could help find some materials."),
            no = ccb.content.text("I don't have anything to offer, but you could talk to the scavenger boss and the scrappers; They might be able to help."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_RANCH_FOREMAN",
            when = predicates.any({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped" } })), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } })) }),
        },
        {
            text = ccb.content.text("Thanks anyway."),
            next_topic = "TALK_RANCH_FOREMAN",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scavengers_helped" } }), predicates.any_equal({ "yes", { scope = "speaker", key = "mission_tacoma_ranch_doctor_anesthetic_scrappers_helped" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}
