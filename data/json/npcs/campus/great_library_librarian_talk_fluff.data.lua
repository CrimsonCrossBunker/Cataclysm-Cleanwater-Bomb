local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting",
    line = ccb.content.text("*frowning.  \"Listen, we are doing our best here.  Most of our original staff is gone and people keep stealing and breaking things for no reason.  We're just trying to protect some information for the future.\""),
    replies = {
        {
            text = ccb.content.text("Okay, I'm sorry."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_End",
        },
        {
            text = ccb.content.text("But why bother then?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_Why",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_End",
    line = ccb.content.text("*deep breath, tired smile.  \"How else can I help you?\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_Why",
    line = ccb.content.text("*frowning, grimacing.  \"I don't know.  It's.  I can't talk about this right now.\""),
    replies = {
        {
            text = ccb.content.text("Of course, I'm sorry."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutGreeting_End",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe", "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe_Basic" },
    line = ccb.content.text("Oh.  Um.  I guess I like stories.  And quiet."),
    replies = {
        {
            text = ccb.content.text("How did you end up here?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe_Basic",
        },
        {
            text = ccb.content.text("That's fine for now."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AboutMe_Basic",
    line = ccb.content.text("Oh, well I took a job here about a year before <the_cataclysm>, and I was living alone when things got bad and I thought I might be safer here with work friends.  My friends Beatrice and Ross and I got some supplies ready and then more people started to join us.  And then it got bad.  But I think that has settled down some now."),
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin", "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin1",
        "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin2",
    },
    line = ccb.content.text("Oh.  Um.  I don't.  I don't think that makes sense right now.  I have enough help here, and we.  Maybe when things are more settled but not now.  But you might ask others if they need help."),
    replies = {
        {
            text = ccb.content.text("Another time, then."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
        {
            text = ccb.content.text("I'm useful!  I have skills!"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin1",
        },
        {
            text = ccb.content.text("Maybe I could change your mind…?~"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin2",
            when = predicates.has_item("speaker", "condom"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin1",
    line = ccb.content.text("Um.  Right, I guess you made it this far.  But.  Really I don't have something right now.  But really if you could find some books to trade us that would be great.  We really should be rebuilding the collection.  Really.  Um."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_AskJoin2",
    line = ccb.content.text("Um.  Well.  You shouldn't.  I shouldn't.  Um.  I don't.  Let's talk about something else."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_OutsideWorld1",
    line = ccb.content.text("Yes, so I hear.  One trader I talked to said they have a whole market somewhere with all kinds of useful things.  Not a lot of books though, it sounds like."),
}

ccb.content.define_dialogue_topic {
    id = { "TALK_GREAT_LIBRARY_LIBRARIAN_Plans", "TALK_GREAT_LIBRARY_LIBRARIAN_Plans2" },
    line = ccb.content.text("Trying to keep the library here in good order.  She's seen some hard times recently and needs a lot of love.  Past that, well…I guess it would be good to get the rest of the campus cleaned up.  That's what Jack wants to do but we don't have any guns and we don't want to.  I know Callista wants to get classes going again as soon as possible though I imagine we have some problems with the academic interests of the students still with us and the teachers we have left."),
    replies = {
        {
            text = ccb.content.text("You're really just going to keep going like nothing happened?"),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Plans2",
        },
        {
            text = ccb.content.text("I hope it works out for you."),
            next_topic = "TALK_GREAT_LIBRARY_LIBRARIAN_Talk",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_Plans2",
    line = ccb.content.text("*frowning.  \"It's not.  I'm not saying nothing happened.  We lost a lot.  I lost a lot.  We just need to go forward.  We need to put things back together and help people.  That's why this place is here.  What else would we do?  We can't give up too.\""),
}

ccb.content.define_dialogue_topic {
    id = "TALK_GREAT_LIBRARY_LIBRARIAN_WhosInCharge",
    line = ccb.content.text("Oh, we did have a President, Mx. Rose.  As things were starting to get bad they locked themself into the administrative building with all of the senior staff.  It's a good thing too because that building is full of the dead now, just like the rest except the library here.  For now everyone is still trying to operate under the old library structure, so I guess I'm in charge now as the most senior library staff left, though we have some survivors here from the other buildings from other divisions.  Callista Rupp from Academics is here, she taught physics.  I think she was at MIT for a while.  And Jack Springer from Facilities is here too, he's probably the only really practical person here, very handy!  It was his idea to board up the other buildings."),
}
