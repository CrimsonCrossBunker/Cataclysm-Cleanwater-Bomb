local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode",
    line = ccb.content.text("*blushes.  \"Yeah we are.\"  He smiles dopily, apparently forgetting that you'd asked for his thoughts."),
    replies = {
        {
            text = ccb.content.text("Any opinions on the job itself?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode2",
        },
        {
            text = ccb.content.text("Just wanted to point that out.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode2",
    line = ccb.content.text("Uh, right.  Maybe a gun store?  Or a library?  Or we could check high school lockers, haha.  Oh, that made me sad."),
    replies = {
        {
            text = ccb.content.text("You've got it *bad*, dude.  I'd like your opinion on a different thing though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_TACOMA_Nunez",
    line = ccb.content.text("&He looks at you, a bit surprised.  \"Yeah, of course.  I mean, that situation they're in now is miserable, no matter how much we've helped folks out there.  Can you imagine trying to be a young couple in that cramped space?\"  He waggles his eyebrows suggestively.  \"They're tryin' to have a *baby*, you know.  Gonna be hard in a bunkhouse.  Let's get them out to a nice farm, some fresh air, and, *you* know.\"  He winks, to drive the point far, far further home than necessary.  \"Let the magic happen, right?\""),
    replies = {
        {
            text = ccb.content.text("That was unnecessarily clear.  Still, I'd like your opinion on a different thing, somehow."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_1",
    line = ccb.content.text("Seems pretty cut and dry to me.  Let's raid a few first aid kits.  I'm pretty sure you can find that stuff in the basement of those government evac shelters, for example."),
    replies = {
        {
            text = ccb.content.text("Thanks.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_2",
    line = ccb.content.text("Kinda don't think she needs our help on this one, but she's in a bind I guess.\"  He pauses.  \"No pun intended this time,\" he chuckles.  \"Anyway, let's just find some spare fabric, choppy-choppy, and Bob's your uncle.\"  He thinks for a moment.  \"Actually she'll probably want them disinfected, and we should find her some tape too just to be on the safe side."),
    replies = {
        {
            text = ccb.content.text("Fair enough.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_3",
    line = ccb.content.text("I admit, I haven't been paying attention to it, but I'm sure those things must be around in half the medicine cabinets in the area, right?  Seems like an easy looting job to me."),
    replies = {
        {
            text = ccb.content.text("Good point.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_REFUGEE_Vanessa_1",
    line = ccb.content.text("Worse things we could do for people than help them get haircuts,\" he shrugs.  \"No job too small, right?  Vanessa seems a bit cranky to me, but I'm not judging.  Those folks are in a tough spot.  Maybe she'll turn suddenly nice if we bring her the hair stuff she wants.\"  He grins.  \"I'm one hundred percent sure that's what'll happen."),
    replies = {
        {
            text = ccb.content.text("That's my optimistic Liam.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
    line = ccb.content.text("*laughs.  \"Look, Makayla is a trained professional, she knows what she's doing with several kilograms of improvised explosives, doesn't she?\"  He shrugs.  \"If not, let's just stay far away when she tests it.\""),
    replies = {
        {
            text = ccb.content.text("That's my optimistic Liam.  I'd like your opinion on a different thing, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1",
    line = ccb.content.text("*blows out a long breath.  \"Well, my friend, I do think it's good to help clean out some of the mess that's going on.  I'll be with you for it.  I'm just not sure why you figure I'm the right guy for this job.  Shouldn't you have, like, a cop or a soldier or something?  I'm a delivery driver.\""),
    replies = {
        {
            text = ccb.content.text("Don't sell yourself short, Liam.  You've got my back."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Reassure",
        },
        {
            text = ccb.content.text("I'll handle the tough parts, Liam.  You're there to cover my back, that's all."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Bravado",
        },
        {
            text = ccb.content.text("In troubled times, we learn what sort of people we really are."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Fortunecookie",
        },
        {
            text = ccb.content.text("Meh.  What's a few bandits?  We'll flatten 'em."),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Psycho",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Reassure",
    line = ccb.content.text("Thanks.  You're right.  Okay, I can do this.\"  He shakes his shoulders and limbers up, like a boxer preparing for a match.  \"Let's go."),
    replies = {
        {
            text = ccb.content.text("Hold up Balboa, I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Bravado",
    line = ccb.content.text("Oh, oh yeah that makes sense.  Okay, well, that's something I can do.  I'll cover your back like it's never been covered before.  You and me like Calvin and Hobbes, baby."),
    replies = {
        {
            text = ccb.content.text("Thanks, Hooch.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Fortunecookie",
    line = ccb.content.text("*sniffs the air around your head.  \"You been getting in the ganja?  No judgment if so, but maybe you shouldn't be taking mercenary jobs while you're high, y'know?\""),
    replies = {
        {
            text = ccb.content.text("Shut up, you're not my dad!  Anyway, I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Psycho",
    line = ccb.content.text("*gives you some serious side-eye.  \"You okay?  This is serious shit, you're making me kinda worried getting so gung-ho about it.\""),
    replies = {
        {
            text = ccb.content.text("Don't worry, man.  Trust me, it'll be great.  Anyway, I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

-- I really need to touch up the informant quest :(
ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_2",
    line = ccb.content.text("You know, this sounds like it's gonna be some big exciting mystery whodunnit, but I have this feeling if we just look around for someone who is acting obviously and extremely suspicious it'll all fall apart at once."),
    replies = {
        {
            text = ccb.content.text("That's optimistic, thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-NotMet",
    line = ccb.content.text("I dunno, but compared to the last two missions for that guy, I gotta admit I'm kinda stoked.  Robots?  This sounds *wicked*.  Do you think we're talking more Terminator, or Wall-E?  Doesn't matter.  Robots!"),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-HasMet",
    line = ccb.content.text("Uh, well, we *did* meet that weird cyborg guy in the castle full of giant robot dogs matching this exact description, right?  Tell me you remember that.  Damn, it's worse saying it out loud.  I still can't really believe all this stuff has really happened."),
    replies = {
        {
            text = ccb.content.text("Oh, right, I remember that.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_4",
    line = ccb.content.text("You know me my friend,\" he shrugs and grins at you.  \"I'd have said it was some kinda cryptid or something *before* the world got flooded with monsters and mutants.  Nowadays, I think I'd be more surprised if it was bandits again.  As for how to deal with it, well, I guess we're getting pretty good at dealing with this kind of thing now.  Let's handle it how we usually do: with style."),
    replies = {
        {
            text = ccb.content.text("Damn straight.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_5",
    line = ccb.content.text("I dunno,\" he points to your Marshal badge.  \"I guess if they give you a shiny bit of metal you're not really an assassin for hire anymore, you're the law.  Judge, jury, and executioner.\"  He scratches his neck and looks away for a moment.  \"You know how I feel about all these high risk missions, but we've gotten this far.  It's different now than when we started out.  I don't think you need my advice, you know I'll have your back whatever happens."),
    replies = {
        {
            text = ccb.content.text("I might not need it, but I still like to hear it.  I'd like your opinion on something else, anyway."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REPEATER_BEGIN",
    line = ccb.content.text("Honestly my friend, this is the kinda stuff I hoped we'd be doing when we offered to help these guys out.  Fresh air, great views, climbing on things we'd have gotten in trouble for in the old days, maybe pushing a zombie off the edge of a maintenance platform to see how big a splat it leaves at the bottom.  Sounds wicked.  Let's bring a couple cold ones up to the top and crack a brew while we survey the wasteland, hey?"),
    replies = {
        {
            text = ccb.content.text("Sounds like a great idea.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_exodii_signpost",
    line = ccb.content.text("Yeah, I'm with you there, it's some kind of weird map.  The smart thing to do is probably avoid it, this is some really weird shit.  I've never been one to do the smart thing though, myself.  Probably gonna have troubles sleeping until I know what that thing is trying to lead us to."),
    replies = {
        {
            text = ccb.content.text("I know what you mean.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK",
    line = ccb.content.text("I just like, wanna back up a second.  We're trying to score drugs for a cyborg so it can do surgery on you?  That's really where life's taking us, now?"),
    replies = {
        { text = ccb.content.text("…Yes."), next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1" },
        { text = ccb.content.text("Yes?"), next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1" },
        { text = ccb.content.text("Yes!"), next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1",
    line = ccb.content.text("*grins.  \"Okay, just wanted to clear that up.  I thought maybe I was having some kind of psychotic break, glad it's at least mutual.  Anyway, first place that comes to mind for that kinda stuff would be a hospital, but that's suicide.  Maybe a pharmacy?  Would they have the right stuff?  Seems like a stretch.  Maybe like, a vet clinic or a private surgery clinic might be safer?  I'll level with you, I never got into anything harder than Mary Jane, this is past my pay grade.\""),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_EXODII_MISSION_CONTACT_HUB",
    line = ccb.content.text("Something about this kinda rubs me the wrong way, my friend.  I don't know what it is.  That Rubik guy seems nice enough but I feel like we're not getting the whole story.  Just tread carefully, okay?"),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_EXODII_MISSION_WAREHOUSE",
    line = ccb.content.text("Seems to me we could be wandering the area forever just looking for this thing, to be honest.  I guess we could go up somewhere high like a radio tower, maybe with some binoculars, and see if we can spot it?  Our best bet might be to ask a few folks that have been around though, pool our resources."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_1",
    line = ccb.content.text("*leans in close, speaking softly, clearly trying to avoid notice from the pizzaiolo.  \"Are you sure we should be hanging with this guy?  He's not exactly all there, is he?  He reminds me a bit of Chris before things went all chompy-chompy.\""),
    replies = {
        {
            text = ccb.content.text("Chill, man.  It's just a little light arson, it'll be fine."),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-chill",
        },
        {
            text = ccb.content.text("I hear you, but he's following us now and I don't know how else to get rid of him."),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-yeah",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-chill",
    line = ccb.content.text("I guess everything else is wrecked already anyway, what's one more burning building?  And like, it *does* sound fun.  Let's just keep an eye on this guy, he's a slice short of a full pie, if you catch my drift."),
    replies = {
        {
            text = ccb.content.text("I knew you'd come around.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_1-yeah",
    line = ccb.content.text("True enough, and I don't wanna like, just *kill* him.  Well, I don't have anything against a bonfire this season I suppose.  Let's just make sure neither of us ends up lying face-down in a wood-fired oven, y'know?"),
    replies = {
        {
            text = ccb.content.text("We're on the same page.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

-- Be nice to have some different reply if the player is true foodperson here
ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_2",
    line = ccb.content.text("No.\"  He stares at you, his eyes wild.  For a moment, you barely know the man in front of you.  \"The things I've seen when I wore that mask… it changes you.  It's a burden you can't truly understand unless you've borne it.\"  He shudders, and becomes again the Liam you know.  \"Anyone who chooses to keep wearing it after the end of the world… putting them down would be a kindness, believe me."),
    replies = {
        {
            text = ccb.content.text("Uh… okay.  I'd like your opinion on something else, anyway."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_3",
    line = ccb.content.text("*shrugs.  \"My thoughts on Murder Mario haven't changed much, but he hasn't killed us yet.  I don't love the idea of just killing some other survivors for him.  Foodperson doesn't count.\"  He shudders and takes a quick breath.  \"I have a funny feeling they won't let us talk them out of there, though.\""),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_4",
    line = ccb.content.text("What if the cake is a lie?  Also do you really want to follow this guy back to his house?  We both know that's not tomato sauce on his apron.  Don't eat anything he cooks.\"  He shrugs, giving a nonplussed look.  \"Still, we've committed actual murder for him multiple times now, so I guess I'm being a bit of a hypocrite.  Let's party."),
    replies = {
        {
            text = ccb.content.text("You didn't have fun?  I think this whole adventure has been a…"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_4-slice",
        },
        {
            text = ccb.content.text("I think it's worth it all, for the cake.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_pizzaiolo_4-slice",
    line = ccb.content.text("…SLICE!\"  Liam shouts along with you, then gives you a leaping high five before dissolving into belly laughter.  \"OK fine, that makes all the murder and arson worth it, you mad bastard."),
    replies = {
        {
            text = ccb.content.text("That, and the cake.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_KILL_SLIMES",
    line = ccb.content.text("I feel like at some point we must have switched to playing Stardew Valley, and I'm not quite sure when that happened.\"  He scratches his head.  \"Oh well, let's just be sure to wear gumboots."),
    replies = {
        {
            text = ccb.content.text("And aprons.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_HUNT_ANTS",
    line = ccb.content.text("BUGHUNT!\"  Liam raises his arms over his head and grins.  \"BUUUG HUUUNT!\"  He mimes stomping on ants.  \"I'm doing my part!"),
    replies = {
        {
            text = ccb.content.text("I did actually want your opinion on something though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_1",
    line = ccb.content.text("It's all good, I never minded doing deliveries, especially with a friend for company.  I guess we could try to find lumber in a lumberyard, right?  Probably not a lot of zombies hanging out in lumber yards.  Or maybe we could find an old barn and knock it down and take all the pieces.\"  He laughs.  \"Or saw it ourselves from scratch, if you're feeling like a mad lad.  Make sure we've got a vehicle that can fit it though, that much lumber ain't gonna fit in a hatchback."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_2",
    line = ccb.content.text("Something, something, wood pun, something something.  This is starting to feel like Settlers of Catan, think they'll give us some sheep in return?"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_3",
    line = ccb.content.text("Six ropes?  I find it hard to believe these guys can't just get 'em themselves, but, uh, OK I guess.  Maybe we could take some old seatbelts and tie them together, or something.  It shouldn't be hard to find a few ropes laying around."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_4",
    line = ccb.content.text("Okay, wait, what?  One wood saw?  Why are you agreeing to this?  I like deliveries as much as the next guy, but it's a *single wood saw*.  It's starting to feel like you'll just agree to do anything anyone asks.\"  He sighs.  \"No worries though I guess.  One time I delivered a single cold soda to a guy living way out in the back woods.  Cost him seventy bucks.  People are weird."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5",
    line = ccb.content.text("A shovel?"),
    replies = {
        {
            text = ccb.content.text("Yeah, a shovel."),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-1",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-1",
    line = ccb.content.text("A shovel."),
    replies = {
        {
            text = ccb.content.text("That's right."),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-2",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-2",
    line = ccb.content.text("You're not joking."),
    replies = { { text = ccb.content.text("No."), next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-3" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-3",
    line = ccb.content.text("*stares at you for a few seconds.  \"At the shovel store, I guess.\""),
    replies = { { text = ccb.content.text("Thanks."), next_topic = "TALK_Liam_Opinions" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_6",
    line = ccb.content.text("What now, a vegetable peele… oh, a smoker?  That's actually kinda legit I guess.  Maybe we should hunt through peoples' backyards.  We could jump over fences like in Shaun of the Dead!"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_COWBOYT_SHOTGUN",
    line = ccb.content.text("I'm not a great expert on guns, to be honest.  I know how to shoot a bit, but my focus was always on archery when I was a kid.  That sounds like a pretty rare gun though, I think maybe we should see if we can find some old collector rather than trying to raid a gun store?  Just a guess."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_lapin",
    line = ccb.content.text("Nah, you got it.  This is the sort of job that never, ever went wrong, certainly not in any one of a thousand TV tropes.  Let's go find an unknown old man in a secluded cabin."),
    replies = {
        {
            text = ccb.content.text("Glad we're on the same page.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_Warrener_LOG_1",
    line = ccb.content.text("Hell yeah I am.  This guy seems nice.  Bunnies are cute.  This is the sort of job I like, let's find him some logs.  We should be able to just hunt around the woods for 'em, right?  Might need a hatchet or a saw."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_Warrener_FOOD_2",
    line = ccb.content.text("It sure does!  Is it blackberry season though?  I guess if they're not ripe, we could check around abandoned kitchens and fridges, see if we can find some that are still intact."),
    replies = {
        {
            text = ccb.content.text("Thanks man.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_Warrener_ISHERWOOD",
    line = ccb.content.text("Nah.  Lapin's sweet.  I wanna smoke a joint with the bunny man.  If you ever turn into a zombie I'm gonna come back here and settle down as an assistant bunny tamer.  Hope you don't mind."),
    replies = {
        {
            text = ccb.content.text("No hard feelings.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_1",
    line = ccb.content.text("An anvil?  Where do you come up with this stuff?  Yeah, I met this guy, Wile-E Coyote, he had a bunch of 'em."),
    replies = {
        {
            text = ccb.content.text("I'll track him down.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_2",
    line = ccb.content.text("I'm worried for these guys.  My gut tells me they're dealing with something really dangerous.  Let's make sure we're packing heat, you know?"),
    replies = {
        {
            text = ccb.content.text("Roger that.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CHRIS_1",
    line = ccb.content.text("You can say that again.  This is some serious shit, my friend.  I know we've been through a lot, but this might be the big one.  We need to make sure we're ready for anything before we even consider going in there."),
    replies = {
        {
            text = ccb.content.text("Roger that.  I'd like your opinion on something else, first."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}
