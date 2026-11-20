local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New",
    line = { joined = {
        ccb.content.text("Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface",
    line = { joined = {
        ccb.content.text("Us call us the Exodii, eh?  An' other things, but that'n's good.  This're our home, such as it.  This'n's monicked as Rubik, and tassed with a trade an'.  You lookin' to trade?  Us'n's alay for the scrap, metal an' more as it be."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("We call ourselves the Exodii, eh?  And other things, but that's good.  This is our home, such as it is.  I'm called Rubik, and I've been assigned to trade with you.  Are you looking to trade?  We're always looking for scrap, metal and more."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_New_NL_Interface2",
    line = { joined = {
        ccb.content.text("&The towering cyborg listens intently, bowing its entire torso now and again, in a sort of understanding nod.  Unseen speakers emit a whistle, like a human impressed, tinged with only the faintest amount of static.  \"S'a tale, no doubt.  At times, we happen by places this'n might call \"labyrinths.\"   Apples an' pears down to otherlands, in their own right.  The Exodii keeps the reckonin'.  An there's one \"nearby\", so t'speak, spotted by a green Exodii 'emself.  That's the one, this'n takes it.  So we've got accord.  We're kin by circumstance has it, aye?  Yer welcome here, n' this'n will remember n' yark the tale.\""),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Now that's a story.  Sometimes, we find places we call \"labyrinths.\"  Stairs down to other worlds.  We keep track of them.  And, one is nearby, spotted by a novice Exodii, themselves.  That'd be the one you were trapped in, I believe.  So, I guess we're related, by circumstance, at least.  You're welcome here, and I'll remember and tell your story."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DoneTrade",
    line = { choices = {
        ccb.content.text("Good an' fine, then."),
        ccb.content.text("Have it as ye'll see."),
        { joined = {
            ccb.content.text("For a card an' a wink, eh?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("That was a good exchange."),
        } },
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Medieval",
    line = { joined = {
        ccb.content.text("That be a right welcher, eh?  Afore us'n were to this land, the preface were on a half-score century by the reckonin'.  Landed us in amidst of a war'd turned wrong, for an' as the dead had come back in.  By the butcher's block, not much an unusual case, really.  The Enemy makes us fight.  By an' by, we came in, an' by then the killin' fields were plump and ready to harvest the bronze.  'Tain't no steel-of-the-lake, but 'tis a good dross metal for holdin' off a nibblin' mouth, so we kept a few o' their vestments an' stickers for to trade."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("It's a bit of a surprise, isn't it?  Before we came here, we were in a place about 600 years earlier in time, or so.  We landed in the middle of a war that turned wrong when the dead started joining back in.  Truth be told, not a very unusual situation.  The Enemy makes us fight.  By and by, we came in, and by then the killing fields were ready for us to harvest their bronze.  It's not Avalonian steel, but it's a good strong metal for stopping a nibbling mouth, so we kept some of their armor and weapons to trade."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad",
    line = { joined = {
        ccb.content.text("Ah, a real monger's eye, ye be.  Them's the mettle o' many a year of trials.  Us'n've been clashin wi' the Enemy for a long an' then, an' o'er the turns us've worked out some vestments for the job.  Keep's a walker walkin' longer, an I'm ken.  This'n keeps some o' the parst in an' around, but ye'd be tassed to make the vestment with the grease o' your own brow."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Ah, you've got a discerning eye.  They're the result of many years of work.  We've been fighting the Enemy for a long time, and over the years we've worked out some armor for the job.  Keeps you going a bit longer in the field, if you ask me.  I keep some of the parts in stock, but you'll have to put it together yourself."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad2",
    line = { joined = {
        ccb.content.text("This 'n that, an I'm ken.  It be made for a fine wander, beladen with the goods o' the hunt, y'see.  By which I'm to say, 'tis well suited to carry all ye can wrest from the cold arms o' the deadlands, without troublin' your gait nor makin' it easy for the cold clutch o' the scrabblin' arm.  Be an' it is tough as a tarket's nut, I'd razz."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("This and that, you know.  It's made for a traveling scavenger, you see.  What I mean is, it's well suited to carry around whatever you pick up in the wastelands, without making it too hard to get around nor giving any easy handholds for scrambling arms.  That, and I'd say it's as tough as nails."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Stock_Nomad3",
    line = { joined = {
        ccb.content.text("'Tis as simple as comes to a wobble.  Our vestment be oft made from the fine clothes and hides of the land, and our jibber tears the stuff o' life apart here and there when us'n travel.  For as some can be saved if care be taken, there be no case to store nigh enough o' this.  That, an' our manuc-makers run as hot as a sunstone, no spit'n taste for that which we don't use usselves."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("It's a simple matter of how we teleport.  Our clothes are often made from cloth and hides from wherever we visit, and our teleporter tears living stuff apart here and there when we travel.  Some can be saved if we take care, but there's no room to store nearly enough extra.  That, and our fabricators are always busy, no time to waste on stuff we don't need for ourselves."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_AskedRestock",
    line = { joined = {
        ccb.content.text("HEH, ye c'nnae get enough o' ol' Rubik's merchandise, eh?  Sure as 'ell, come back after <restock_time_point>."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("HEH, you can't get enough of old Rubik's merchandise, eh?  Sure as hell, come back after <restock_time_point>."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_started_rubik_intro" } }),
        yes = { joined = {
            ccb.content.text("Sure as you c'n try.  Us're not the greatest yarker, nor do it all for gratis, kennit."),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("You can surely try.  I'm not the greatest speaker, and I won't just chat forever for free, you know."),
        } },
        no = { joined = {
            ccb.content.text("Oy, c'n I bark you summat first?"),
            ccb.content.text("\"\n\n[TRANSLATE:] \""),
            ccb.content.text("Hey, can I ask you something first?"),
        } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_DoSomething",
    line = { joined = {
        ccb.content.text("Sure as can,\" the gravelly voice takes on an unmistakeable 'customer service' tone.  \"What'll ye tass this'n for?"),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Of course, what can I do for you?"),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_TalkJob",
    line = { joined = {
        ccb.content.text("Aye, business afore, 'tis said.  What'll ye tass to ol' Rubik?"),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Business before pleasure.  What do you need?"),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue_Complete",
    line = { joined = {
        ccb.content.text("Gimme spek, 'n  fetch 'em 'ere."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Give me a second, and I'll bring them here."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Cyborg_Rescue",
    line = { joined = {
        ccb.content.text("Lemme poke.  Will tass what ye can for a shiny."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Let me see.  Will do what I can for a coin."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Prototype_Cyborg_Rescue",
    line = { joined = {
        ccb.content.text("Fer this 'un, I can yank out their bits 'n give 'em to ya, or I can jus' take out the busted pieces so they can still use th' rest o' stuff in 'em. Elsewise, why don't ya jest give 'im to me?  I reckon I can turn 'im into a right useful worker."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("For this one, I can pull out their CBM and give any working to you, or I can just take out broken bits so that they will still be able to use the rest of stuff in them.  Alternatively, why don't you just give them to me?  I surely can help them adjust to life as a cyborg."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Experiment_Broken_Cyborg_Rescue",
    line = { joined = {
        ccb.content.text("This 'unwon't be twitching', too much grey lost to dead.  But ye can salvage bits from 'em or born 'em for a walker, or just cut out the rot 'n grey link so ya can miss 'em proper."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("This one can't be saved, too much brain rotted.  But I can salvage bits from them or repurpose them for walker, or just cut out rot and neural interface so you can bury them proper."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro2",
    line = { joined = {
        ccb.content.text("Lovely!  Benzete's gonna be a pair, that's a track!  I mean, they'll be right happy.  This is their first jump, and it's a flappin' duck."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Lovely!  Benzete (this is a name) is going to be beside themselves, that's for sure.  I mean, they'll be really happy.  This is their first jump, and it's a lucky one."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro2a",
    line = { joined = {
        ccb.content.text("So 'twere an I recalt, us're yarkin' of Benzete an' their great first jump."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("As I recall, we were talking about Benzete and how this is a great jump for their first time."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro3",
    line = { joined = {
        ccb.content.text("Us gotta leave the old world afore it's worn right to the gums, an y'ken, and find a nice twitchy one on t'other side.  Your deadland be a brand shiny"),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("We've got to leave the old world before it gets too worn out, you see, and find a nice fresh one on the other side.  Your deadland is as fresh as it gets."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro3a",
    line = { joined = {
        ccb.content.text("Neverken.  Right and so, the Enemy is new here, and us'n have a few good hours in the sun beforenext the jump."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("No worries.  I mean, the Enemy is new here, and we have a bit of safe time ahead of us before we have to jump away again."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro4a",
    line = { joined = {
        ccb.content.text("That be a part an' switch, but this be'n nice for all, overtop the last jump by heads.  Otherlands with fusillies and mobbings, us'n gets a fine change on that."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("That's a part of it, sure, but this is nice for other reasons, and much better than our last jump.  Otherlands with fusillies and mobbings are really useful to us."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro4b",
    line = { joined = {
        ccb.content.text("You kennit rightly!  That and this be'n nice for all, overtop the last jump by heads.  Otherlands with fusillies and mobbings, us'n gets a fine change on that."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("That's exactly it!  This is nice for many reasons, and much better than our last jump.  Otherlands with fusillies and mobbings are really useful to us."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro5",
    line = { joined = {
        ccb.content.text("Oh, rights.  Many lands be'd assert on thosun's.  A fusilly, she's a weapon, shoots a shot at high speeds usin' bang.  A mobbing, he's a grand box o' metal, pushed by burnin' and boomin' from wit'in, kennit?"),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Oh, yeah.  Lots of places have different words for those.  A fusilly is a weapon that fires a bullet at high speeds using propellant.  A mobbing is a big metal box that's moved around by an internal explosion.  Do you get it?"),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_Intro6",
    line = { joined = {
        ccb.content.text("Right so, us'n'll write it in the dicky.  Here, a shiny brass farthing for crossin' the nation."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Great, I'll put that in the dictionary.  Here's a token of my gratitude for your explanation."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete1",
    line = { joined = {
        ccb.content.text("Them's an otherlander from thrice jumps an' change, wide as the sky.  They's got happily on sommat for the tracking, you ken?"),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("They're an otherlander from around three jumps ago, a real optimistic greenhorn.  They're really interested in how we do tracking, you see?"),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete2",
    line = { joined = {
        ccb.content.text("Hmm.  They… planned out the last jump?  Like as an apprentice to the ol' sexten."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Like an apprentice to the old tracker."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_IntroBenzete3",
    line = { joined = {
        ccb.content.text("Sure an' that's a fine enough word, an I'm ken."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Sure, that word is fine, I think."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Aliens",
    line = { joined = {
        ccb.content.text("Yeah, you could call us as it.  Us're from otherlands mostlike.  Not otherworlds though.  Too risky bringin' them squelchies into the fold."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Yeah, you could say that.  We're from otherlands, most of the time.  Not otherworlds though.  Too risky bringing those monsters into our safe haven."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Aliens2",
    line = { joined = {
        ccb.content.text("Sure an that's a biggun'.  Otherworlds be the wherefore o' them uggo buggers you got round and here, eh?  Walkin' plants and talkin' mushrooms and whatlike.  Otherlands be tassed more of a kinship.  I be from Earth, but my Earth be differed.  So you's shouldno be asked what the Exodii is doin' on Earth, because some is feelin' of us fine an' fine at home, an I'm ken.  You's should be askin' what the Exodii is doin' razzin up your green and brown."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Yeah, that's a big question.  Otherworlds are how you got those ugly bug-creatures around here, you know?  Walking plants, talking mushroom, stuff like that.  Otherlands are closer related.  I'm from Earth, just a different Earth.  You shouldn't be asking what the Exodii are doing in Earth, because some of us are feeling pretty at home here, I think.  You should be asking what we're doing hanging out in your part of town."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Home",
    line = { joined = {
        ccb.content.text("*becomes distant for a moment.  \"Ah.  Home.  It were a long time gone, kennit.  Your'n be not too far.  This'n… I don't think I want to talk 'bout it.  Too much metal atwixt now an' then.\""),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Ah.  Home.  That's a long time gone, you know?  Yours isn't too different.  I… don't think I want to talk about it.  I've changed too much between then and now."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Metal",
    line = { joined = {
        ccb.content.text("Us'n saw this were a pidgeon's road, I'd razz.  Only one way, I'm ken, if I'm not to join the rank an' file."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("I realized that it was a no-brainer question.  There was only one other option, you see, if I didn't join the Exodii."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot",
    line = { joined = {
        ccb.content.text("Robot?  What assert is f'r it?  Ahold…\"  Rubik stops for a moment, as if thinking.  \"Ah, an automate?  No, this'n be flesh 'n blood as ye be, encased in a shell o' metal an' wire.  Not so much flesh as there were.  The wire is amixed an' afloat with the flesh, all as one, kennit."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Robot?  What does that word mean?  Hang on.  …Ah, an automate?  No, I'm as flesh and blood as you are, encased in a shell of metal and wire.  Not as much flesh as there used to be.  The wire is mixed and woven into the flesh, all as one, you see."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot2",
    line = { joined = {
        ccb.content.text("Yeah, that be the soggy leaves, an I'm ken.  A bit o' both, but Rubik were once as a kin, to you be."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Yeah, that's the basic explanation.  A bit of both now, but I used to be just like you."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Base",
    line = { joined = {
        ccb.content.text("A junker base, innit?  Pile o' gamp.  Us'll pack it up and sing along soon enough."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("A junker base, obviously.  A jury-rigged mess.  We'll pack it up and leave eventually."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_BaseTimeLeft",
    line = { joined = {
        ccb.content.text("Yon aforetime otherland, 'twere a right soggy biscuit.  This'n be crisp an' fresh yet.  Us'n'll try as might stay a fair tick."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("The otherlands we were in before had only little time left, so we can't say for sure.  But this land is as fresh as it can be."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Base2",
    line = { joined = {
        ccb.content.text("For an' how, ye be needin' to think wi' them elevens o' directions, kennit?  Us'll open a gate an' wibble-an-wobble.  Same as us came."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("To understand how, you've gotta think eleven-dimensionally.  We'll open up a gate and teleport out, the same as we came."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Zomborgs",
    line = { joined = {
        ccb.content.text("'Tis a good an' yark, sooth.  Them as can have the metal deep in, can be saved for the risen, but it b'ain't a sure course.  Some as comes back anyway, an' some be too much flesh.  The grander lot are no Exodii like ol' Rubik, most be friends more kin to thyself.  Us'll hearken out and trundle home the pieces for a scrub-and-bucket."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Ah, good question.  Enough cybernetic implants can keep someone from coming back as a zombie, but it's not a sure thing.  Some come back anyway, and some just don't have enough cybernetics.  Most of them aren't full Exodii like old Rubik, they're more our friends - like you.  Sooner or later we'll get out there, put them down, and bring their parts back for cleaning."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Make",
    line = { joined = {
        ccb.content.text("Rubik's not the finest dandy to yark it, an I'm ken, but this'n'll do best as can.  Ol' Rubik an' the stompy-clanker gang be shiny an' fine as can be, for y'see so well, but on the wind-up, the guts be nigh so fleshy as they were afore, twixt as they be with wire and steel.  Ain't none so left as remembers precise how it all goes, and much is boggled from bits and drabs o' a dozen elsewheres.  'Tis a marked fine they work at all, though work they do, and nicely.  Still, 'tis hard to know what'll crumple out from the can.  Those as return, they be… less well made as ol' Rubik.  Some as did work themselves, even, and mayhap against the good old ways."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("I don't think I'm the best to explain that, but I'll do my best.  Our technology might seem pretty high-tech and well made to you, but on the inside I'm still mostly human meat bound up in wires and steel.  Nobody's left that remembers exactly how it all goes, and much of it is cobbled together from a few different dimensions.  It's a miracle they work as well as they do, but somehow it's actually pretty functional.  Still, it can be hard to know exactly what could go wrong.  The ones who come back as zombies, they're generally less well made than me.  Some even did their own cybernetic conversions, and didn't exactly follow best practices."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Make_Time",
    line = { joined = {
        ccb.content.text("Blinker than a bat, but downer than a cat.  Razzin' up the bits be a trick and some.  The draw-make automates can manufactorize the outer shell, and there be automates for the most o' the tools.  Some bits be more a breakfast o' rats, an' for them, us'n has some artisanals.  Us'n b'ain't on the solid now, so 'tis a longer down."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Faster than you might guess, but it can still take a while, the hardest part is sourcing the materials for one.  We've got printers that make the body, and others that make the tools and equipment the walker will use.  Some of the special parts have to be manufactured by hand, so we have a small team that does that.  Right now, it's very slow, we're still setting up our operations."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Robot_Buy",
    line = { joined = {
        ccb.content.text("*sounds thoughtful.  \"This'n can't make a call o' the quarter.  The stompers be a king's necklace, and the manufactory don't run on dreams.  Mayhap when us'n be more on the solid, but for the tick and tumble, no.\""),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("I don't know about that.  Each one we make is very important to our operations here, and they're extremely expensive.  I might be able to sell you one later, but not right now."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_String_Dimension_Exodii",
    line = { joined = {
        ccb.content.text("Ahh, mayhaps ye've found another node - kin o' us'n Exodii.  Tell ol' Rubik:  what'd ye escolt there?  Exodii alive?  Trade?  Stompers?  Manufactory?"),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Ah, you found another node - another community of Exodii.  Tell me what you saw?"),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Jobs",
    line = { joined = {
        ccb.content.text("*pulls out a sheaf of mismatched papers, and leafs through the pages for a second.  Their broad metallic fingers look surprisingly deft and delicate, and incongruous on the otherwise unremarkable looseleaf.  \"Aye, an' there's room for a pop-an-work roun' here.  Rubik's got tassed a lissy, right and clean."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Yeah, we're always in need of some help around here.  Here's the list I've got for stuff like this."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Dialect",
    line = { joined = {
        ccb.content.text("Sure as ye can, at least sommat.  Us'n'll try as we might to parley your Anglic, but so ye kennit as us be from otherlands and all, it ain't that simple."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Sure you can, at least a bit.  I'll do my best to speak your Anglic, but seeing as we're from otherlands and all, it's not that simple."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Exodus2",
    line = { joined = {
        ccb.content.text("Same as you will be, an I'm ken.  The Enemy.  The dead."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Same as you, I'd guess.  The Enemy.  The dead."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmCause",
    line = { joined = {
        ccb.content.text("F'r to wax religious, eh?\n\n*Rubik pauses for a while.  When they start talking again, their voice is slow and more serious than usual.*\n\nThis'n can't tell ye, rightly, but those what have a bottle an' a cork what fits it, they yark about the Enemy.  Most folks got a story like that in their ol' hearth-tales, an I'm ken.  A bad way, from times old, come back.  Ol' Rubik don't know much about that, but something makes them bodies walk and moan, and it don't seem to be somethin' of the way o' our kin.  How it gets in, well, that be anyone's for a guess.  It can come the way we came, wibbling and wobbling, but it don't always.  How it be'd the end for your deadland, Rubik can't say for ye."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("You want to get religious, eh?  I can't tell you for sure, but the people who claim to know, they talk about the Enemy.  Most folks have a fairy tale like that, I think.  A monster from ancient memory, returned.  I don't know much about that, but something makes those bodies walk and moan, and it doesn't seem to be anything human.  How it gets in, well, that's anyone's guess.  It can come the way we came, through a portal, but it doesn't always.  How it was for your world, I can't tell you."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline",
    line = { joined = {
        ccb.content.text("This be a deadland, kennit.  Spend a farthing at the pastor's house, d'ye razz?  What be left for ye?  The dead'll be in the fields, the forests, all around the green and brown.  Anything what walks, they'll salt 'n fallow, and most'll rise up and rejoin.  Those what don't, the Enemy twists and turns as well.  Every deadland be the same.  Ye've turns and twain, but come as it may, this land be dead.  Though, an I'm ken, ye've quite a few turns and twain to go yet."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("This is a deadland, you see.  Take a moment and look around, know what I mean?  What's left for you?  The dead will be in the fields, the forests, all over the world.  Anything that walks, they'll make it so it doesn't, and most will come back as undead.  Those that don't, the Enemy will change them as well.  Every deadland is the same.  You've years and more to go, but one way or another, this place is dead.  Though, as far as I can see, you've got quite a few years to go yet."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline2",
    line = { joined = {
        ccb.content.text("Spread, aye, through the wibbles, but we ain't ken on how.  After the green an' brown be to grey and black, so t'speak, Rubik be long gone.  On a moment, we folk've sent back a lover's robe or so t'the deadlands what left, but narry have returned.  An I'm ken, there be only one course from here."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Spread, yes, through the portals, but we don't know how.  After the world is down to dust, I'm long gone.  Once or twice we've send back a probe to the deadlands we left behind, but none have returned.  As far as I know, there's only one way it goes from here."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimeline3",
    line = { joined = {
        ccb.content.text("If ye be champed t'try, this'n won't stop ye.  Right so, Rubik'll sell ye the pieces ye might use t'do."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("If you want to try it, I won't stop you.  In fact, I'll sell you equipment that might help."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Talk_CataclysmTimelineTough",
    line = { joined = {
        ccb.content.text("Fine an' fine.  Rubik'll clarion for ye when ye stand o'er the garried trick o' Anubine hisself."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("You do that then.  I'll cheer for you when you stand over the vanquished corpse of the devil himself."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Dialect_Anglic",
    line = { joined = {
        ccb.content.text("Be an' as us're a dock climber from ol' Upper Landin', this'll be our way o' yarkin'.  All an' all from our green an' brown yark like this'n."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("I'm a lowlife from old Upper Landing, this is my way of talking.  Everyone from where I come from talks like this."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Scythean",
    line = { joined = {
        ccb.content.text("Ha!  A new string and beans, an I'm ken.  Latched and keyed in the bright shine o' the deadland afore this'n.  He be a thing o' fire and bronze, an' the node appreciates his grit.  \"A cnight of old, clade in shining steel, leading the hoste onward to glorie,\" as 'twere.  This'n finds him an apt one to give rede.  To command in battle, that's t'yark."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Ha!  A new part of our crew.  Signed up early on in the world we were in before.  He's a really tough guy, and the node appreciates his grit.  (Recites some poetry), as it were.  I think he's pretty good as a military commander."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Anglic_Tease",
    line = { joined = {
        ccb.content.text("Mayhap, but where'd be the fun in that?  Asides, quoth poetry is one thing, but changin' this'n's whole yark for always takes a lot o' practice."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Maybe, but where's the fun in that?  Besides, quoting poetry is one thing, but changing the way I speak all the time takes a lot of practice."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Meetcute",
    line = { joined = {
        ccb.content.text("Aye.  Ye kennit, when two of a sort happen upon each other as per chance, an' find a liking to another?  'Tis a bit o' Anglic yark."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Right.  You see, it's when two compatible people randomly happen into each other and take a liking to one another.  It's a bit of Anglic slang."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Hempen1",
    line = { joined = {
        ccb.content.text("*seems to become wistful for a moment.  \"Harks this'n yonder, right so.  'Tis a bit o' t'ol' King's Landing right there, kennit, yarkin' from back when Rubik were nigh smaller than a kelpie.  It…\"  Rubik's gravelly voice falters.  \"Ah, 'tis mightily tassed to hearken back yonder.  Mayhap another time.\""),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("That takes me way back.  That's a bit of the old King's Landing right there, you know, calling back from when I was just little.  It… ah, it's really hard for me to think about those old days.  Maybe another time."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose",
    line = { joined = {
        ccb.content.text("Makin' do, makin' do, same as you, an I'm ken.  Last home got a bit too dead 'n putrid roun' the edges, like.  Happens to the best of 'em.  Caught a jibber that made us ken 'bout your place here, fired up the ol' wibble-wammles and boom!  Now it's all tick-tock on a zimmer, here we be.  Got a good timing this time, I razz you only been dead a few days when we wobbled in.  Freshest corpse this'n's seen in a kitchen sink."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Making do, making do, same as you I'd imagine.  Our last home got too dead and putrid around the edges, basically.  It happens to the best of them.  We caught some news that brought us along to your place here, fired up the engines, and boom!  Now, quick as can be, here we are.  We got a good timing this time, seems to me you'd only been dead a few days when we got here.  Freshest corpse I've seen in a while."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose_Dialect",
    line = { joined = {
        ccb.content.text("Us're here to live and breathe, kennit?  After our last otherland got a li'l too dead an' all.  So, us'n came to a new place.  This'n.  An I'm ken, it's not so long dead round here jus' yet."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("We're just here to survive, you understand?  Our last world got too overrun with undead.  So, we came to a new world.  This one.  If I'm not mistaken, it's not so long dead around here just yet."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose2",
    line = { joined = {
        ccb.content.text("Aside from jus' livin' in such a cozy nook?  Us be minin', ye kennit.  Pickin' the scraps, seein' if for your otherland has any tech worth an upside-down.  No sense lettin' good scraps go to waste.  If we're lucky, pickin' a few new Exodii afore we wobble out.  Pickin' up the pieces of our sweet, shattered dreams, suchlike."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Aside from just having a safe place to live?  We're here to mine, you understand.  Picking the scraps, seeing if this world has any tech worth reverse engineering.  No sense letting good scraps go to waste.  If we're lucky, maybe we'll get some new Exodii before we teleport out.  Pickin' up the pieces of our sweet, shattered dreams, such as they are."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose3",
    line = { joined = {
        ccb.content.text("This'n be a deadland, an I'm ken.  You gots you a case o' the willies ain't gonna sing along.  No cure for these rats and fleas."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("This is a deadland, don't you see?  You've already got an infestation and it's not going away.  There's no cure for the zombies."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Purpose4",
    line = { joined = {
        ccb.content.text("Means what it means.  Your land's a deadun', still kickin' is all."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("It means what it means.  Your land's dead already, it's just still kicking is all."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival",
    line = { joined = {
        ccb.content.text("Oh, us can wobble along as needs.  Sends the scrap back, brings in the foods, and shakes off a willie or three, kennit.  No good for you, won't take too much meat-an'-bone."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Oh, we can teleport along as we need to.  We send the scrap along, then the food, and shake off some baddies, you understand.  It's no good for you though, it won't take too much flesh and bone."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival2",
    line = { joined = {
        ccb.content.text("Haha, not mostly, mate.  Not worth riskin' the willies, innit?  I keep what's Rubik, but the rest is all solid."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Haha, not mostly, mate.  It's not worth risking the side effects, you see?  I keep the parts of me that make me Rubik, but the rest is all solid."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Survival3",
    line = { joined = {
        ccb.content.text("Oh, sure an it's bagged in a coffer an' all that.  That is t'say, this'n does get a wipe o' a grinny t'see the perplexion upon a visage, an I'm ken.*  You're pretty sure you hear a faint chuckle in the metallic voice.  *What I be meanin' is at, for my body were t'be meat-an'-bone, the tool what we be usin' for t'travel to an' fro, it rips up the meat an' leaves it a right mess.  A bit can come along for a right fun, but too much… on a time, an earlier Rubik felt a spot o' those willies, an' this'n be not in the farrier's hut for t'try it again."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Oh, sure, that's a fair assessment.  I mean, I do get a bit of a laugh out of the look on your face sometimes.  What I'm saying is, if my body were flesh and bone, the device we use to travel around dimensions would rip up the meat and leave me quite a mess.  We can take a bit, but too much… one time, I felt a bit of that, and I'm not in any rush to try it again."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Tech",
    line = { joined = {
        ccb.content.text("Not to me it don't.  We ain't tassed from around here though.  Looks fine an' fine to you I'd razz."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Not to me it doesn't.  We didn't get it from around here though.  I bet it looks pretty nice to you."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Bionic_Install",
    line = { joined = {
        ccb.content.text("If'n you're full an' plenty, this'n's happy to make the call, for a shiny farthing."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("If you've got what I need, I'm happy to call ahead and make the arrangements, for a fee."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Found_Hub01_CBM_interface",
    line = { joined = {
        ccb.content.text("&Rubik pulls out a glowing, green terminal while a surgical robot rolls in to do standard pre-surgical checks.  \"Rightly then, let us'n see what can do 'ye for.\"  Then the surgical robot starts to beep loudly and blurts out words you don't understand in a mechanical voice.  Rubik stares at it a moment, then stares at you.  \"Well now.  Seems to this'n ye've had yer interface swapped.  I'll hear no excuses.  We've had some tech an' stompers gone missin', an' word aroun' says a certain bunker offerin' stolen steelies.  Ye've two minutes to traipse out o'here.  Ken it.\""),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("Right, let's see what we can do for you.  Well, well, well.  Looks like you got your interface swapped out.  I won't hear any excuses.  We've had some tech and some workers go missing, and we've heard from a few trade partners that a certain bunker is offering stolen cybernetics.  You've got two minutes to get out of here.  Got it?\""),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_You_Buy_Riot_Gear_On_Credit",
    line = { joined = {
        ccb.content.text("If'n you survive, we can give you a fortnight and six odd days to pay us'n back."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("If you survive, we can give you twenty-odd days to pay us back."),
    } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_EXODII_MERCHANT_Hates_Hub_Cyborgs",
    line = { joined = {
        ccb.content.text("Shinies an' stompers missin', an' escoltin' a bunker offerin' stolen steelies.  Thine steelies.  Ne.  Ye ain't tassed from around here.  Ye've two minutes to traipse out o'here.  Ken it."),
        ccb.content.text("\"\n\n[TRANSLATE:] \""),
        ccb.content.text("We've had some tech and some workers go missing, and we've heard from a few trade partners that a certain bunker is offering stolen cybernetics.  Your bionics.  You didn't get them from around here.  You've got two minutes to get out of here.  You are not welcome here.  Got it?"),
    } },
}
