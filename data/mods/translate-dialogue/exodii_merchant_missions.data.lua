local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_clarify",
    line = {
        joined = {
            ccb.content.text("A jut be a long, thin post, kennit.  The store-cabin be made o' con-crete an' rusty iron, and atop it be a glintin' post.  The post be broken, I'd razz.  Turnt off.  Rubik's got a tool for you to pop, make it turnt on."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("A jut is a long, thin pole.  The warehouse is made of concrete and rusty iron, and atop it there's a glistening pole.  The pole is broken, turned off.  I got a tool for you to turn it back on."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_intro1",
    line = {
        joined = {
            ccb.content.text("Just so.  'Tis like yarkin' fit f'r me beloved jaryi, y'kennit so fine.  What say you?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Exactly.  This is some talking fit for my beloved jaryi.  What do you think?"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_jaryi",
    line = {
        joined = {
            ccb.content.text("Ha, not callin' y'me jaryi.  Jaryi be the mother-twice.  'Tis but a King's Landing assert f'r a grandmother, Rubik's makin' a chestnut at ye."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("No, I'm not calling you jaryi.  Jaryi is my mother's mother.  It's a King's Landing word for a grandmother, I'm making a little joke at you."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_jaryi2",
    line = {
        joined = {
            ccb.content.text("Right so, a fine notice.  Rubik's mother-twice, she were a woman o'th'old kind.  And were her mate, and Rubik's father-twice.  Rubik's father-mother, she were a gran, a fitty bit of ol' London-Town, right so, but Rubik had a jaryi and a taita and a tamoi.\" Rubik's voice goes distant for a moment.  \"An' they was all there, right to the end.  Standin' by, we were, one and all.\" They pause, then seem to snap back.  \"No time for stories, kennit?  Back to the here an' now."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("That's right, I did.  My mother's mother was a woman of the old kind, and so was my father's father.  My father's mother, she was a grandma, a little piece of old London-Town, but I had a jaryi and a taita and a tamoi (these are words for grandparents in a guarani dialect).  They were all there, right to the end.  Standing by, we were, one and all.  No time for stories, though.  Back to the here and now."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_explain",
    line = {
        joined = {
            ccb.content.text("'Tis a gull's errand, with narry a sign.  Our stompers cannot cover each squarrel, and they've many a dropsy to search.  This'n be a right easy spot for keen eyes, so mayhap your sameworlds can be of a snap."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Without any indication of its location, there's too much ground to cover, and we have many other things to look for.  This one is pretty easy to see, so maybe some of the locals can help find it."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_find",
    line = {
        joined = {
            ccb.content.text("That's be for your assert, an I'm ken.  If ol' Rubik could find 'er, us'n'd send out the stompers.  For a yark an' a lark, though, couldst ask another of your sameworld?  Mercants or traveler-such?  It be a fine slick to a local guide."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("that's up to you, I think.  If I could find it myself, I'd send quads out there.  Maybe it would be worth asking around to other survivors?  Seems like a good job for a local guide."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete",
    line = {
        joined = {
            ccb.content.text("Aye?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Aye?"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_complete_double_crossed_truth",
    line = {
        joined = {
            ccb.content.text("*looks you up and down, sizing you up fully before speaking in a matter-of-fact tone.  \"Alas and alack.  A pop-an-work you'n be, a pop-an-work you'n do.  Now, ye remember this… the Exodii remembers, aye?\""),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Alas.  You're a mercenary, so you'll act like a mercenary.  But you better remember that the Exodii also remember."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_ExodiiFrame_no",
    line = {
        joined = {
            ccb.content.text("No.  Too mighty an ask, and we can't spare the steelies.  I'll give ye a lump'a'ice.  Keep up the work, n' mayhaps somethin' changes one'a these days."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("No.  That's too much to ask, and we can't spare the materials.  I'll give you some advice.  Keep up the good work, and maybe I'll change my mind one day."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_2_ExodiiFrame_yes",
    line = {
        joined = {
            ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Hm.  That's a really big ask.  You seem to be the sort of person who would ask for this kind of thing, but are you certain you want to be permanently attached to this suitcase?  You sure you're thinking clearly?  This isn't like the CBMs I sell.  There's no going back.  And you better be able to produce enough power.  These need constant power.  Without it, you're as good as dead.  For a Cyberframe like mine, one power storage unit will last less than an hour of walking.  Less if you're fighting or running.  It's not an easy life."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_intro",
    line = {
        joined = {
            ccb.content.text("Ye mind that bunker ye ferreted fer us'n?  Turns they be no kindly folk.  Us'n learned one o'their scavs keep'n a second hall, an' we reckon an escolt we lost be held fast inside.  One kin t'me - Exodii - much metal, deep red shell, hard t'miss.  Torture'n the like - bad if tassed this'n.  If ye can fetch 'em back pop-n-work-like, us'll pay ye right handsome."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Do you remember that bunker you found for us?  Well, turns out they're not so friendly.  We found out one of their people is running some sort of workshop, and we think that an explorer we lost is being held inside.  They're Exodii like me - lots of metal, not easy to miss.  I think they're being tortured, at the least.  If you, a mercenary, can recover them, we'd pay handsomely."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_explain",
    line = {
        joined = {
            ccb.content.text("Ol' Rubik don't want'n 'em kennin' us'n be involved.  Folk o' this kind we've spied in otherlands, an' we ken it be perilous t'let 'em learn o'er much about us'n."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("I don't want them to know we are involved.  We've seen people like this in other otherlands, and we know it's dangerous to let them know too much about us."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_advice_dead",
    line = {
        joined = {
            ccb.content.text("If that be the case, fetch back the proof ya' can.  Any piece'o'their frame will do, but I'd prefer all of it.  Deep red color.  Hard t'miss."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("If that's the case, just bring back proof.  We know them well, so any part of their frame will do.  It's a deep red color.  Hard to miss."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_complete",
    line = {
        joined = {
            ccb.content.text("&Rubik sighs, takes the head, stares at it for a moment, then sets it gently down on the counter.  They then reach below the counter and take out three clear plastic bags, each containing a different cybernetic module.  \"Ye've done us'n a true service, so as us'n promised, take one o' these dandies as true reward.  Which'll it be?  As y'like."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("You've done us a real service.  As promised, you can take one of these bionics as reward.  What would you like?"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_ExodiiFrame_no",
    line = {
        joined = {
            ccb.content.text("No.  As ye' can see, us'n can't spare the steelies.  Too much to danger."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("No.  As you can probably see, we can't spare the parts.  Too much risk these days."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_3_ExodiiFrame_yes",
    line = {
        joined = {
            ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Hm.  That's a really big ask.  You seem to be the sort of person who would ask for this kind of thing, but are you certain you want to be permanently attached to this suitcase?  You sure you're thinking clearly?  This isn't like the CBMs I sell.  There's no going back.  And you better be able to produce enough power.  These need constant power.  Without it, you're as good as dead.  For a Cyberframe like mine, one power storage unit will last less than an hour of walking.  Less if you're fighting or running.  It's not an easy life."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer1",
    line = {
        joined = {
            ccb.content.text("All dead, eh?  A sorry shame.  Ahh, but, might I tempt ye with a pop-n-work's bond t'fetch us'n more ken?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("All dead.  That's a shame.  Could I interest you in a mercenary contract to get me some more information on this place?"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Offer2",
    line = {
        joined = {
            ccb.content.text("If ye wend back that way, escolt fer some manner o' terminal, computer, the like.  Ye mayhap upon one wi' a jack fer this contraption.\"  Rubik pulls out a small, scrap metal device that looks like an otherworldly USB drive.  \"If ye set it in, an' it takes, an' the node strayed not o'er far from us'n, it should draw down a trove o' vital reckonin' we can make use of.  Do this fer me, an' us'll pay ye right handsome."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("If you can find your way back to that place, look all over for some sort of terminal or computer.  You may or may not find one with a plug for this contraption.  If you plug it in, and it works, and the Exodii there aren't too diverged from us, it should download lots of important data we can use.  Do this for me, and I'll reward you handsomely."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii_Mission_Accepted",
    line = {
        joined = {
            ccb.content.text("&Rubik hands you the device and nods.  \"Good fortune.\""),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("&Rubik hands you the device and nods.  \"Good luck.\""),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_mission_string_dimension_ExodiiFrame_yes",
    line = {
        joined = {
            ccb.content.text("Hm.  A mighty ask on a mighty ask.  Ye certainly got the disposition, but you sure you wanna be cut inta' this crowded space?\"  Rubik taps their metal torso.  \"You sure ya' lump is screwed on tight?  This isn't like the bright'n'steelies on offer.  No goin' back.  And ye best be happy with the amount'a power you can generate.  This'ere needs contant power.  Without power, yer good as dead.  The power storage units?  Fer a case this'n kind, one'a the power storage units buys you a little-less'an an hour of walkin'.  Less for scrappin' and scramblin'.  Nothin's easy about it.\""),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Hm.  That's a really big ask.  You seem to be the sort of person who would ask for this kind of thing, but are you certain you want to be permanently attached to this suitcase?  You sure you're thinking clearly?  This isn't like the CBMs I sell.  There's no going back.  And you better be able to produce enough power.  These need constant power.  Without it, you're as good as dead.  For a Cyberframe like mine, one power storage unit will last less than an hour of walking.  Less if you're fighting or running.  It's not an easy life."),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_ANUS_FETICK_ALT",
    line = {
        joined = {
            ccb.content.text("Mayhap ye bringin' us a nip o' good tea.  Not 'tea', o'course.  I'm yarkin dockside Anglic here.  Us means the stuff what puts y'to sleep f'r a chirurgery.  The Great Grey says y'r assert for it is 'anus fetick'.  You bring us a thousand unit of 'anus fetick', us'll fix'n ye up with a wire an' a tiff."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Maybe you could bring us a bit of good tea.  Not literally 'tea' of course.  That's my Anglic street slang.  I mean the stuff that puts you to sleep for surgery.  The Great Grey says your word for it is 'anesthetic'.  You bring us a thousand units of anesthetic, we'll fix you up with a wire and everything."),
        },
    },
}
