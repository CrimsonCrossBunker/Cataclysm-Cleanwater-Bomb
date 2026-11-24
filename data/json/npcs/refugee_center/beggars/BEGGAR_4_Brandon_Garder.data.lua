local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Sickly beggar in the refugee center.
ccb.content.define_npc {
    id = "refugee_beggar4",
    unique_name = ccb.content.text("Brandon Garder"),
    gender = "male",
    suffix = ccb.content.text("Carpenter"),
    temporary_suffix = "Beggar",
    class = "NC_BEGGAR_4",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_BEGGAR_4",
    faction = "lobby_beggars",
}

-- All the beggars have been camping inside the evac shelter because they're too weak and unskilled to make it on their own.
ccb.content.define_npc_class {
    id = "NC_BEGGAR_4",
    name = ccb.content.text("Beggar"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -4, -1 } },
    dexterity = { rng = { -4, -1 } },
    intelligence = { rng = { -6, -2 } },
    perception = { rng = { -3, -1 } },
    worn = "NC_BEGGAR_4_worn",
    carry = "EMPTY_GROUP",
    weapon = "EMPTY_GROUP",
    traits = {
        { trait = "GLASSJAW" },
        { trait = "ASTHMA" },
        { trait = "SLOWHEALER3" },
        { trait = "SLOWRUNNER" },
        { trait = "HEAVYSLEEPER" },
        { trait = "FLIMSY3" },
        { trait = "WEAKSTOMACH" },
        { trait = "MYOPIC" },
        { trait = "HYPEROPIC" },
        { trait = "JITTERY" },
        { trait = "SMELLY" },
        { trait = "PROJUNK" },
        { trait = "BADBACK" },
        { trait = "BADKNEES" },
        { trait = "BADCARDIO" },
        { group = "Appearance_demographics" },
    },
    skills = { { skill = "fabrication", bonus = { rng = { 2, 6 } } } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.gendered_line("Thanks again for the grub, my friend.", { "speaker" }),
        no = ccb.content.text("Hey, are you a big fan of survival of the fittest?"),
    },
    replies = {
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Why do you ask?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_TALK1",
        },
        {
            when = predicates.negate(predicates.has_effect("interlocutor", "beggar_has_eaten")),
            text = ccb.content.text("Sorry, not interested."),
            next_topic = "TALK_DONE",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("Nice to see you too, what's up?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_TALK1",
        },
        {
            when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
            text = ccb.content.text("Nice to see you.  I gotta be going though."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_TALK1",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("Oh you know, the usual: sittin' out here until I starve to death, playin' cards with Dave, that kinda thing."),
        no = ccb.content.text("Because I sure ain't fit, so I'm sittin' out here until I starve to death.  Help a poor sickly soul out?"),
    },
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_beggars_recruited" } }),
            text = ccb.content.text("I've talked to the others, and they're all willing to come.  So, you joining us?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUITED",
        },
        {
            text = ccb.content.text("I could maybe help you out… want something to eat?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_GIVE_FOOD",
        },
        {
            text = ccb.content.text("What's wrong with you?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_TALK2",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_GIVE_FOOD",
    line = {
        when = predicates.has_effect("interlocutor", "beggar_has_eaten"),
        yes = ccb.content.text("That's awful kind of you, you really are a wonderful person."),
        no = ccb.content.gendered_line("Oh, wow!  You're a real gem, you know that?  Thanks for even thinking of it.", { "speaker" }),
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("I'm sorry, I was wrong.  I can't help you."),
            next_topic = "TALK_DONE",
        },
    },
    repeat_replies = {
        {
            categories = { "food" },
            reply = {
                text = ccb.content.text("Here, you can have this <topic_item>."),
                next_topic = "TALK_REFUGEE_BEGGAR_4_GAVE_FOOD",
            },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_GAVE_FOOD",
    line = ccb.content.text("It's good to know there are still people like you in the world, it really is."),
    on_enter = {
        { actions = { "u_bulk_donate" } },
        { actions = { actions.handler("w16b_a_dda_ee5ac56a72a9") } },
    },
    replies = {
        {
            text = ccb.content.text("What are you up to?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_TALK1",
        },
        {
            text = ccb.content.text("No problem.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_TALK2",
    line = ccb.content.text("You name it!  Asthma, diabetes, arthritis.  Diabetes hasn't been so bad since I stopped, y'know, eating regularly.  Well, I assume it hasn't.  Not like I can check that ol' whatchamacallit, the blood test the docs used to bug me about every couple months."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_SICKLY",
    line = ccb.content.text("They got enough mouths to feed that can pull their own weight.  I got a lot of weight and I'm too weak to pull it, so I'm out here."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
    line = ccb.content.text("Came with a small group quite a while ago.  The others were young and fit, they got in.  They were some of the last ones to get in actually.  I didn't make the cutoff."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
    line = ccb.content.text("This is a mercy.  I get shelter, light, and heat, and those guards will help us if any zombies show up.  It ain't so bad.  If I was out on my own I'd have none of this and still have to look for food… in other words, I'd be dead as a doornail.  Or I guess undead."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_HAPPY",
    line = ccb.content.text("What's the alternative?  You take the hand you're dealt.  I've given eulogies for two of the people I love most on this earth, and the third wrote me off.  I've already been through the end of the world.  Came out the other side with my bits intact.  And you know, I've been pretty lonely since my wife passed.  Here I've got friends.  We might be hungry but we're close.  Reena's been teaching me math and science, Luo is one of the smartest folks I've ever met - she's got a doctorate you know - and Yusuke is the only one here that can beat me at poker.  And Dave, well, he's Dave.  There's more goin' on under the surface there, mark my words.  We may be unfit, but we aren't worthless."),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_conversation_luo_doctorate", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
    line = ccb.content.text("Well, I used to be a roofer, but I had a bad fall and wrecked my back around '06.  Tried to get into other kinds of carpentry but I just don't have the head for it.  My wife managed to support both of us with the extra bit I made from odd jobs, but she had a stroke in 2016 and left me on my own the last few years slowly draining my savings dry while I work whatever junk jobs I can handle.  Couple days before <the_cataclysm> I got the notice that the bank was going to foreclose on my crappy little trailer."),
    replies = {
        {
            text = ccb.content.text("You have any kids?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE2",
        },
        {
            text = ccb.content.text("Would you like to travel with me?  Someone good with a trade could be helpful, and it's got to be better than wasting away here."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp.  It's a damn sight better than those place, and there are regular meals.  Someone with your trades experience would be welcome, even if you can't do the big jobs anymore."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUIT1",
            when = predicates.handler("dlg_p_dda_451497940a38"),
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE2",
    line = ccb.content.text("Yeah, we had two.  My daughter died of an OD right at the start of that fentanyl stuff.  It did a real number on my son - they were twins you see - and he cut ties to me and my wife.  Wasn't even there for her funeral.  I can't blame him, it messed us all up pretty fierce.  As far as I'm concerned he's still out there with my grandkids, hiding away somewhere safe.  These days, no news is good news."),
    replies = {
        {
            text = ccb.content.text("What did you do before <the_cataclysm>?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_LIFEBEFORE1",
        },
        {
            text = ccb.content.text("Would you like to travel with me?  Someone good with a trade could be helpful, and it's got to be better than wasting away here."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_JOIN",
            when = predicates.handler("dlg_p_dda_19ac42f5fa83"),
        },
        {
            text = ccb.content.text("I have a camp.  It's a damn sight better than those place, and there are regular meals.  Someone with your trades experience would be welcome, even if you can't do the big jobs anymore."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUIT1",
            when = predicates.handler("dlg_p_dda_451497940a38"),
        },
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_JOIN",
    line = ccb.content.text("It's sweet of you to say that, but I'm just not up to the wandering life, not with these knees."),
    replies = {
        {
            text = ccb.content.text("You seem awfully happy considering the situation."),
            next_topic = "TALK_REFUGEE_BEGGAR_4_HAPPY",
        },
        {
            text = ccb.content.text("They won't let you in because you're sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_SICKLY",
        },
        {
            text = ccb.content.text("How did you even get here if you're so sick?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_ARRIVAL",
        },
        {
            text = ccb.content.text("Why are you camped out here if they won't let you in?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_CAMPOUT",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_RECRUIT1",
    line = ccb.content.text("That's awful nice of you.  Tell you what: if you can help Dave get himself sorted out, so I don't feel like I've gotta stay here keeping an eye on the poor fella, then I'll come along."),
    replies = {
        {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_recruit_dave_happy" } }),
            text = ccb.content.text("I think I've sorted Dave out pretty well, don't you?  Would you consider coming with me now?"),
            next_topic = "TALK_REFUGEE_BEGGAR_4_RECRUIT2",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_RECRUIT2",
    line = ccb.content.gendered_line("Well… I'll be honest, I didn't even think Dave could be sorted out, and you've gone and called my bluff!  It's a darn fine thing you've done for that poor soul.  Listen, I wasn't… entirely serious about wanting to come with you, but if you can convince the others to go, then I guess I'll come along.", { "speaker" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("speaker", "general_recruit_brendan_recruited", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_BEGGAR_4_RECRUITED",
    line = ccb.content.text("Golly.  I didn't expect that, but I'm as good as my word.  <lets_go>"),
    replies = {
        {
            text = ccb.content.text_without_extraction("<lets_go>"),
            next_topic = "TALK_DONE",
            native_actions = { "follow" },
        },
    },
}
