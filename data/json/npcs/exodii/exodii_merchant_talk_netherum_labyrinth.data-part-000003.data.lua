local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_netherum_labyrinth_intro_NL_interface",
    line = ccb.content.text("Gettin' there a mite tricky, but not so tangled as jumpin' this whole castle.  They're less dear to go to an' fro, so t'speak, which is odd itself, I s'pose.\n\nDown below, ye'll find a ring o' metal, wi' a terminal us'n has just set up.  Ol' Rubik set the words by hand, in preparation, so ye should ken it well enough.  Ye'll be a free - a volunteer to escolt it.  Good for you, good for we - more metal for you, and sell extras to we, aye?  Ye're free to go an' make use of it.  Keep mind 'at once you jump, the ring'll need a full five day rest afore it'll take ye again.\n\nI'd give ye a word o' threat, but I think ye'ken it already."),
    replies = {
        {
            text = ccb.content.text("So there's a terminal downstairs?  I can just stand on the metal ring and use the terminal, but only once every five days or so?  Sounds too easy.  Sure, thanks Rubik."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "rubik_told_about_labyrinth", "yes"), actions.handler("dlg_a_dda_b2da7a0b0214"), actions.assign_mission("MISSION_EXODII_LABYRINTHS_INTRO") },
        },
    },
}
