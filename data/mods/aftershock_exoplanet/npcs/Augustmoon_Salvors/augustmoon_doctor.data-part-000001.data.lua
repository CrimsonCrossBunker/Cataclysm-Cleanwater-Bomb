local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_MERCURIAL_DOCTOR",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_augustmoon_doctor_first_meet" } }),
        yes = {
            choices = {
                ccb.content.text("Try not to touch anything.  Keeping this place clean is a full time job."),
                ccb.content.gendered_line("I'm free at the moment if you need something.", { "interlocutor" }),
            },
        },
        no = ccb.content.text("Clinic is open, yes.  If you need medical assistance, this is the place."),
    },
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "dialogue_augustmoon_doctor_first_meet", "yes") },
            once = "mercurial_doctor_meet",
        },
    },
    replies = {
        {
            text = ccb.content.text("Could you help me with some bionics?"),
            next_topic = "TALK_MERCURIAL_DOCTOR_BIONICS",
        },
        {
            text = ccb.content.text("I could use your medical assistance."),
            next_topic = "TALK_MERCURIAL_DOCTOR_AID",
        },
        {
            text = ccb.content.text("I need to trade some medical supplies."),
            next_topic = "TALK_MERCURIAL_DOCTOR",
            actions = { "start_trade" },
        },
        { text = ccb.content.text("I should be fine."), next_topic = "TALK_DONE" },
    },
}
