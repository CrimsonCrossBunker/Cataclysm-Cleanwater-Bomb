local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "augustmoon_doctor",
    unique_name = ccb.content.text("Mercurial Medical Agent"),
    gender = "male",
    class = "NC_MERCURIAL_DOCTOR",
    attitude = 0,
    mission = "SHOPKEEP",
    chat = "TALK_MERCURIAL_DOCTOR",
    faction = "mercurial",
}

ccb.content.define_npc_class {
    id = "NC_MERCURIAL_DOCTOR",
    name = ccb.content.text("Mercurial Medical Agent"),
    job_description = ccb.content.text("I try to keep this gang in one piece.  It's a full time job."),
    traits = {
        { group = "NPC_starting_traits" },
        { trait = "RETURN_TO_START_POS" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { rng = { 5, 7 } },
    worn = "NC_AUGUSTMOON_DOCTOR_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    shop_groups = { { id = "NC_AUGUSTMOON_DOCTOR_stock", rigid = true } },
    price_rules = { { group = "NC_AUGUSTMOON_DOCTOR_stock", fixed_adjustment = 0 } },
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "firstaid", bonus = 7 },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_MERCURIAL_DOCTOR_BIONICS",
    line = ccb.content.text("Sure, what are you looking for?"),
    replies = {
        {
            text = ccb.content.text("I was wondering if you could install a cybernetic implant…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_install" },
        },
        {
            text = ccb.content.text("I was wondering if you could install a cybernetic implant in my friend here…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_install_allies" },
        },
        {
            text = ccb.content.text("I need help removing an implant…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_remove" },
        },
        {
            text = ccb.content.text("I need help removing an implant from one of my friends…"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_aftershock_exoplanet_c1784e867903"),
            actions = { "bionic_remove_allies" },
        },
        {
            text = ccb.content.text("Never mind."),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MERCURIAL_DOCTOR_AID",
    line = {
        when = predicates.has_effect("interlocutor", "currently_busy"),
        yes = ccb.content.text("Come back later, I need to take care of a few things first."),
        no = ccb.content.text("I can take a look at you or your companions if you have any injuries.  It'll cost you, of course."),
    },
    replies = {
        {
            text = ccb.content.text("[1200$, 30m] I need you to patch me up."),
            next_topic = "TALK_MERCURIAL_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_aftershock_exoplanet_bffe506920cd"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_9b49a23fa9cc") },
        },
        {
            text = ccb.content.text("[2400$, 1h] I need you to patch my friends up."),
            next_topic = "TALK_MERCURIAL_DOCTOR_AID_DONE",
            when = predicates.handler("w16b_p_aftershock_exoplanet_a3b5aab47d45"),
            actions = { actions.handler("w16b_a_aftershock_exoplanet_277f1df6f74f") },
        },
        {
            text = ccb.content.text("I should be fine."),
            next_topic = "TALK_MERCURIAL_DOCTOR",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MERCURIAL_DOCTOR_BIONICS_DONE",
    line = {
        choices = {
            ccb.content.text("Now some protocol tests for brain damage.  Please stare at the light over there…"),
            ccb.content.text("It might take some days for your nervous system to adapt.  Come back if you experience any concerning symptoms like…"),
            ccb.content.text("I suggest you take it easy for a few days now."),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_MERCURIAL_DOCTOR_AID_DONE",
    line = {
        choices = {
            ccb.content.text("Take it easy now, or come back soon.  All the same to me."),
            ccb.content.gendered_line("Now try not to do whatever you did again.  No, don't tell me more.", { "speaker" }),
        },
    },
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
