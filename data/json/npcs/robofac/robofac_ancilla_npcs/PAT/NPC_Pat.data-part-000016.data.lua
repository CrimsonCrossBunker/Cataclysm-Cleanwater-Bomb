local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01",
    line = ccb.content.text("I have, I have.  I hear they're stickin' radios in the skull's of some mercs.  You too, eh?  Crazy shit.  Maybe you can score some kinda fancy implant so we can ditch the ugly-ass AR glasses, yeah?  Lemme know if ya' find one, ya' nut-ckle-head, hah!  Get it?  Nuts n' bolts."),
    replies = {
        {
            text = ccb.content.text("Actually, I have an implanted AR system.  Think you could use it?"),
            next_topic = "TALK_ROBOFAC_MERC_PAT_TELL_U_CYBORG_HUB01_AR",
            when = predicates.all({ predicates.has_inventory("speaker", "integrated_ar", 1), predicates.has_trait("speaker", "Hub01_CBM_Interface") }),
        },
        { text = ccb.content.text("Yeah, alright."), next_topic = "TALK_ROBOFAC_MERC_PAT" },
    },
}
