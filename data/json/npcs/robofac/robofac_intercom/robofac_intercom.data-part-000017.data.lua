local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_2",
    line = ccb.content.text("In a way.  In the days and hours leading up to one of these events, you may see things that are obviously out of place, or that don't make sense.  This is most clear during the nighttime, but you can see it during the day, too.  If this happens once, take note of it.  If it happens again, be ready for anything."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_3",
    line = ccb.content.text("Yes and no.  When something like this is going on, the storm is going to affect you one way or another, but being outside is much more dangerous.  If you can, find a solid shelter.  Stay as far away from the outer walls as you can.  Being underground is probably a good idea.  There are likely undocumented psychological effects; use your best judgment and your common sense."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_4",
    line = ccb.content.text("Unfortunately, it seems likely.  This isn't exactly something we can measure with traditional instruments, but observation has shown that they're not likely to get better.  By far the strongest so far was at the start of the Cataclysm, and while we cannot accurately predict what the future holds, our projections are not optimistic.  I wish I could tell you anything else, but I would advise you get used to seeing them going forward."),
}

-- this is lie of omission. Hub 01 is explicitly aware of XEDRA and the work they were doing, and the staff likely had an indication just before the Cataclysm hit that things were about to get really bad, leading them to back up a vast amount of online information before the internet was completely knocked out.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_5",
    line = ccb.content.text("We have a vested interest in determining how these events will influence the future of the planet - as should you.  Most of the equipment inside of this facility has remained in working order, and although the Internet no longer exists in a functional way, we still have a plethora of information that was stored locally prior to <the_cataclysm>.  We are monitoring and documenting these portal storms, and we will continue to do so for the foreseeable future."),
}

-- A recording to give proof without requiring those who know the most about portal storms to risk their agents.
ccb.content.define_dialogue_topic {
    id = "TALK_ROBOFAC_INTERCOM_PORTAL_STORMS_6",
    line = ccb.content.text("Potentially.  We recently came into possession of a video taken during the first days of <the_cataclysm> using a home camcorder.  We have ruled out possible tampering, and conclude that the recording is legitimate.  It depicts an entity that appeared to rapidly change shape, but responded especially strongly to human presence.  Eventually, the entity reshaped itself into a small object, which the author of the recording claimed had anomalous properties.\"\n\n\"Subsequent entities of this type have failed to manifest during remote observation of the phenomenon.  We hypothesize that, if they do exist at all, they may only appear in response to human presence.  While we consider the hypothesis too dangerous and too uncertain to test using our own resources, we would be eager to hear the results if you attempted to do so yourself."),
}
