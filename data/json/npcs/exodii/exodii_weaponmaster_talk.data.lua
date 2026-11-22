local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_WEAPONMASTER_INTRO_4",
    line = {
        when = predicates.handler("w16b_p_dda_1e86b617dd38"),
        yes = ccb.content.text("&Still completely mute, it looks at you more closely, and you can see subtle movements in some of the cameras.  Then, without a word, it turns back to the workbench."),
        no = ccb.content.text("&Still completely mute, it shows you something you had initially missed.  The entire wall behind the workbench is full of various weapons; some as big as modern rifles, a few as large as the machine guns installed on aircraft, and one that looks like a dismantled tank turret.  Melee weapons were not forgotten, from moderately-sized swords and clubs to war hammers twice the height of a human, and what you can describe only as \"boots for mecha\".  Then it points to a sign near you that shows three things: the carved pictograms of coins, some sign you are not familiar with, and a pictogram of a bullet - all things considered, this creature is either a weaponmaster, or a weapon merchant."),
    },
    replies = {
        {
            text = ccb.content.text("Woah.  Can I buy one?"),
            next_topic = "TALK_WEAPONMASTER_INTRO_5",
            when = predicates.handler("w16b_p_dda_f87ec3601d53"),
        },
        {
            text = ccb.content.text("Hey!"),
            next_topic = "TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK",
            when = predicates.handler("w16b_p_dda_1e86b617dd38"),
            actions = { actions.set_first_topic("TALK_WEAPONMASTER_EXODII_DO_NOT_SPEAK_TO_FAIR_FOLK") },
        },
    },
}
