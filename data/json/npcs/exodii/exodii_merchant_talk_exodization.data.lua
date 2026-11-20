local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done",
    line = ccb.content.text("&You awaken.  Your vision is blurry, and it's as if there's something hiding at the edges of your sight that you can't shake.  You try to swat it away, only to find that your limbs don't work.  You become suddenly aware that none of your senses are truly working.  You're just staring at a great sea of nothing, through a non-existent window you can't discern the edges of.\n\nBefore you have time to panic, you come to.  Your head is swimming.  You see Rubik and Venn standing before you with a device wired to your chest.  But is it your chest?  You move your hands to feel, and all you sense is metal on metal.  You're no longer just flesh.  All you can see and feel is your new, mechanical Cyberframe.\n\nVenn detaches the wires and Rubik speaks:  \"Easy.\""),
    replies = {
        {
            text = ccb.content.text("Is it over?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done2",
    line = ccb.content.text(
        --~ Yes, it's done.  Don't waste time thinking about what's different.  You're still there, just inside a tough steel case.  It won't be easy to adapt, but keep a stiff upper lip - or be brave - as you might say.  Try to keep everything intact, but if you get any damage, come back here.  Venn'll do repairs in exchange for materials.
        "Aye, done'n'done.  Don' tarry on what's left.  Yer still there, just tougher'n steelies, now.  Time fer the stiff upper lip, as might be y'assert.\"  Rubik chuckles.  \"Anyhow, try'ta keep'er intact, but Ven'll keep ya' fixed up fer trade.  Got it?"),
    replies = {
        {
            text = ccb.content.text("I guess so.  I'll come talk to Venn if I need repairs.  Guess I'll be seeing you around, Rubik."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done3",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_done3",
    line = ccb.content.text("&Rubik offers you a shallow bow, then lumbers down the dusty hallway, leaving you alone in the surgical suite with Venn and your new bionic body."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}
