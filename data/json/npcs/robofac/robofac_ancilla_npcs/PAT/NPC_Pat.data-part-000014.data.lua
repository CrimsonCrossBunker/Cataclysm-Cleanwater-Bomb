local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_2",
    line = ccb.content.text("Well holy shit!  That's freakin' nuts!  Maybe you can score some kinda fancy implant so we can ditch the ugly-ass AR glasses, yeah?  Lemme know if ya' find one, ya' nut-ckle-head, hah!  Get it?  Nuts n' bolts."),
    replies = {
        {
            text = ccb.content.text("Actually, I have an implanted AR system.  Think you could use it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_EXODII_AR",
            when = predicates.all({ predicates.has_inventory("speaker", "integrated_ar", 1), predicates.has_trait("speaker", "CBM_Interface") }),
            actions = {
                actions.set_actor_value("speaker", "robofac_pat_said_no_to_exodii_AR_CBM", "yes"),
                actions.set_actor_value("speaker", "robofac_pat_knows_u_cyborg", "yes"),
            },
        },
        {
            text = ccb.content.text("Yeah, alright."),
            next_topic = "TALK_ROBOFAC_MERC_PAT",
            actions = { actions.set_actor_value("speaker", "robofac_pat_knows_u_cyborg", "yes") },
        },
    },
}
