local ccb = require("ccb")

-- This Exodii is named Venn.  You've met before.  Venn and the Autodoc will do some serious work on you.  They'll take out all of your important organs and stick them in a Cyberframe, like these.  It will take a long time.  We can offer you one of two basic Cyberframes.  If your mind is set on doing this, you can pick.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe",
    line = ccb.content.text("&Rubik makes a stiff, bowing gesture and leads you out of the shop and down a stone pathway towards a familiar building - the gloomy surgical suite.  Rubik greets the humanoid cyborg that operates the suite, then stares a long moment in wordless communication.  The cyborg brings out a bulbous CRT monitor with a wired mechanical clicker, which they hand to you.  Rubik's joints hiss as they crouch to view the screen with you.\n\n\"This'ere Exodii monicked Venn.  Ye've met'afore.  Venn'n'the'robot here'll do you somethin' fierce.  They'll carve out all yer important meat bits, and stick'em in a Cyberframe, like this'n.  It'll take time.  Lots'o'time.  We've the means for two basic frames.  If yer lump is set, ye can pick.\"\n\nRubik gestures to the glowing terminal.  Displayed is an outline of what looks like a human.  Beside it are two other outlines.  The first, which Rubik calls \"one-aye,\" looks a lot like Rubik himself.  It towers over the human shape, and can only be called humanoid.  Its center mass is a thick, squat shape, with the head and torso hard to distinguish from one another.  The second, which Rubik calls \"one-bay,\" looks slender, traced by hard, mechanical lines, but is nevertheless distinctly human-like."),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

-- Simple, really.  You'll still be human on the inside.  Most of your meat will be there.  Even a lot of your muscle and bone.  But your arms and legs will mostly be robotic.  Your eyes, too.  You'll keep the inside parts, but they'll be part of the armored interface.  They'll all need power to work properly.  It'll all still work a bit without it, but it's not pleasant.  Your torso and head, and everything in them, will be integrated into the shell itself.  Your body will keep everything going as it is now, so no need for power there.  You'll be more sturdy, and the machines will do most of the hard work for you, so no more worrying about getting out of breath while running from the dead.  But that's only if you keep it powered and in good repair.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
    line = ccb.content.text("Peasey, truly.  You'll still be mostly mince, like ol' Rubik here.  Even much'a muscle n' bone.  Human inside.  But yer wiggles and wobs, that is yer limbs and digits, will be mostly steel.\"  Rubik motions to your eyes.  \"Yer berry pies, too.  Ye'll keep the see-ey bits, but they'll be part'a the new interface.  So, arms, legs, eyes, it'll all need power to work.  They'll work without, but tassed it isn't nice.\"  Rubik motions to your torso and head.  \"Now, yer chest n' lump, and everything in'em, will go inside the tidy bell.  Yer heart n' lungs n' all of that will keep going as it is now, no need for power.  All in all, you'll be more sturdy, n' the steel'll do the hard work for ye.  No more losin' breath on a scramble with the dead… if ye can stay powered n' in fine repair."),
    replies = {
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

-- Since we're stripping you down to flesh and bone you need to survive, we can take the time to salvage your CBMs, and keep it all intact, reinstalled in your new Cyberframe.  But your limbs and other parts will be exchangeable, like bionics.  In the future, if you take off a limb, you'll have to remove your CBMs, fix them, clean them, and reinstall them.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
    line = ccb.content.text("Since ye've gotta strip down t'vital flesh n' hard scones, we'll salvage your bright'n'steelies, and repackage them in the new frame.  After, you can swap your wiggles and wobs, that is yer limbs and digits, like steelies, with a bit of effort.  If ye plan to do that, also plan to remove your implants, fix'em, clean'em, and shove'em back in."),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

-- Aye, so this one's a lot like mine.  Real popular among this Exodii node.  It's heavy duty, but as you can see, it's a little less human-like than maybe you're comfortable with.  It's a good, sturdy design, that will keep you safe.  But you'll have to get used to going without most clothing and armor.  The body just isn't made for them.  This is my suggestion.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
    line = ccb.content.text("&Rubik flicks a heavy plastic switch and the terminal whirs.  The image changes to a more detailed blueprint of the bulky, humanoid frame.  \"Aye, so this'n like thisn's, ol' Rubik's I mean.  Popular with us'n.  It's heavy n' tough.  Keep yer mince meat safe.  But if ye' wanna be real human, yer out of luck, as ye'll have to get used to goin' without cloth n' steel gear.  The frame just isn't made for them.  Won't fit.  But who needs'em?  Not me.  My lump'a'ice is ta' seal yourself up in this one.\""),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe 1a] Okay, I'll take 1a, the bulky, armored frame."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a_yes",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

-- This one's for the nostalgic, I suppose, like Venn here.  You'll still have a human shape, and can still do and wear all your human things.  Downside is it can't be plated as well, so it's a bit more vulnerable by itself.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
    line = ccb.content.text("&Rubik flicks a heavy plastic switch and the terminal whirs.  The image changes to a more detailed blueprint of the human-like frame.  It's very familiar, and has all of the body parts one expects to find, albeit made of plates and metal joints.  \"This'n for those'n can't help'a look back, like Venn, aye?  You'll still have the shape'o'yerself, and ye'd still wear yer human things.  But can't be plated like this'n's and keep'at shape, so it's more tattarrattat, less thunk, should somethin' come and smash ya' up.  That is to say, yer less tough.\""),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("[Integrate your body into an Exodii Cyberframe 1b] Okay, I'll take 1b, the human-like frame."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b_yes",
        },
        {
            text = ccb.content.text("So, will I be an Exodii after this?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}

-- No.  You'll be wearing an Exodii-suit, but nobody is Exodii until they jump with the Exodii, and that remains to be seen.
ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_exodii_question",
    line = ccb.content.text("No.  Ye'll have the Exodii-suit, but nobody Exodii until there's a scrabble and jump to otherlands or otherworlds.  Who'at'll be remains to be."),
    replies = {
        {
            text = ccb.content.text("Can you tell me a bit more about how Cyberframes work?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_info",
        },
        {
            text = ccb.content.text("What about my existing bionics?"),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_bionics",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1a."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1a",
        },
        {
            text = ccb.content.text("Tell me more about Cyberframe 1b."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_1b",
        },
        {
            text = ccb.content.text("Actually, can we wait?  I'll ask you about this again later."),
            next_topic = "TALK_EXODII_MERCHANT_Exodize_Cyberframe_back_out",
        },
    },
}
