local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Jenny Forcette is an experienced mechanical engineer.  Like the other refugees in the center, she's terrified of the outside world.  Unlike many, she has some ideas what to do about it.
ccb.content.define_npc_class {
    id = "NC_REFUGEE_Jenny",
    name = ccb.content.text("Refugee"),
    job_description = ccb.content.text("I'm just trying to survive."),
    common = false,
    strength = { rng = { -4, -2 } },
    dexterity = { rng = { -2, 1 } },
    intelligence = { rng = { 3, 4 } },
    perception = { rng = { -1, 1 } },
    worn = "REFUGEE_Jenny_worn",
    carry = "REFUGEE_Jenny_carried",
    weapon = "REFUGEE_Jenny_wield",
    traits = {
        { trait = "PACIFIST" },
        { group = "Appearance_Caucasian" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    proficiencies = { "prof_elec_soldering", "prof_metalworking", "prof_welding_basic" },
    skills = {
        { skill = "mechanics", bonus = { rng = { 5, 6 } } },
        { skill = "computer", bonus = { rng = { 2, 5 } } },
        { skill = "electronics", bonus = { rng = { 3, 6 } } },
        { skill = "fabrication", bonus = { rng = { 2, 5 } } },
    },
}

ccb.content.define_npc {
    id = "refugee_JennyForcette",
    unique_name = ccb.content.text("Jenny Forcette"),
    gender = "female",
    suffix = ccb.content.text("Refugee"),
    class = "NC_REFUGEE_Jenny",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_REFUGEE_JENNY_1",
    faction = "free_merchants",
    missions_offered = "MISSION_REFUGEE_Jenny_GET_MOTOR",
}

ccb.content.define_dialogue_topic {
    id = { "TALK_REFUGEE_JENNY_2", "TALK_REFUGEE_JENNY_Background1", "TALK_REFUGEE_JENNY_Personal1", "TALK_REFUGEE_JENNY_Project1", "TALK_REFUGEE_JENNY_Project2", "TALK_REFUGEE_JENNY_Project3", "TALK_REFUGEE_JENNY_Refugees1", "TALK_REFUGEE_JENNY_FreeMerchants", "TALK_REFUGEE_JENNY_Refugees2_Fatima", "TALK_REFUGEE_JENNY_Refugees2_Friends", "TALK_REFUGEE_JENNY_Refugees2_Borichenko", "TALK_REFUGEE_JENNY_Refugees2_Singh", "TALK_REFUGEE_JENNY_Refugees2_Others" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_REFUGEE_Refuse_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("What are you working on?"),
            next_topic = "TALK_REFUGEE_JENNY_Project1",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Jenny_mission_3" } })),
        },
        {
            text = ccb.content.text("How's everything going with that defense system?"),
            next_topic = "TALK_REFUGEE_JENNY_Project3",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "mission_completed_Jenny_mission_3" } }),
        },
        {
            text = ccb.content.text("Tell me a bit about your background."),
            next_topic = "TALK_REFUGEE_JENNY_Background1",
        },
        {
            text = ccb.content.text("How are things, living here?"),
            next_topic = "TALK_REFUGEE_JENNY_Personal1",
        },
        {
            text = ccb.content.text("Are you free to teach me anything today?"),
            next_topic = "TALK_REFUGEE_JENNY_Teach2",
            when = predicates.handler("dlg_p_dda_dc1bf359f426"),
        },
        {
            text = ccb.content.text("Can you tell me anything about the other refugees here?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees1",
        },
        {
            text = ccb.content.text("How did you make it here during the chaos?"),
            next_topic = "TALK_REFUGEE_JENNY_Survival",
        },
        {
            text = ccb.content.text("What do you think happened to the world?"),
            next_topic = "TALK_REFUGEE_JENNY_World",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_1",
    line = ccb.content.text("*is a thin woman in her early thirties, with the sort of pale, freckled skin that looks like it would burn if she thought too hard about the sun.  Her clothes and bearing suggest she might once have been carefully put-together, but she now has the harried look of someone with too many worries and too little sleep.  She looks up from a laptop and smiles as you approach.  \"Hi there.  Haven't see you around here before.  I'm Jenny, Jenny Forcette.\""),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("speaker", "general_meeting_u_met_Jenny_Forcette", "yes"),
                actions.set_first_topic("TALK_REFUGEE_JENNY_1a"),
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("Nice meeting you.  What are you doing on that computer?"),
            next_topic = "TALK_REFUGEE_JENNY_2",
        },
        {
            text = ccb.content.text("Nice meeting you.  I'd best get going, though."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_1a",
    line = {
        choices = {
            ccb.content.text("*looks up from her computer and gives you a quick, thin smile.  \"Hello again.\""),
            ccb.content.text("*tips the lid of her laptop closed and looks up.  \"Nice to see you again.\""),
        },
    },
    replies = {
        {
            text = ccb.content.text("Hi, Jenny.  What are you up to these days?"),
            next_topic = "TALK_REFUGEE_JENNY_2",
        },
        { text = ccb.content.text("Sorry Jenny.  <end_talking_leave>"), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_2",
    line = ccb.content.text("I'm puttering around, I always have stuff on the go.\"  Jenny rubs the bridge of her nose briefly, blinking fatigue from her eyes.  \"Gotta keep busy, keep my mind off stuff, you know?"),
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
    id = "TALK_REFUGEE_JENNY_Background1",
    line = ccb.content.text("Me?  I trained at MIT in mechanical engineering, I worked for a long time as senior engineer at Marduk Thermal in Rhode Island.  It was a good job, but I landed my dream gig at Boston Dynamics and moved up north to start there.\"  She tips back her head and lets out a long, wistful sigh.  \"I had just finished my orientation and was going to start work when the riots started.  Just my damn luck."),
    replies = {
        {
            text = ccb.content.text("That's impressive, but there must be more to you than just your job."),
            next_topic = "TALK_REFUGEE_JENNY_Background2",
        },
        {
            text = ccb.content.text("You must know some great stuff.  Can you teach me anything?"),
            next_topic = "TALK_REFUGEE_JENNY_Teach1",
            when = predicates.handler("dlg_p_dda_40f96f0660d7"),
        },
        {
            text = ccb.content.text("So, did anyone tell you there are actual no-kidding talking cyborg-robot people out there now?"),
            next_topic = "TALK_REFUGEE_JENNY_Exodii",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
        {
            text = ccb.content.text("Sorry about your luck.  <done_conversation_section>"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Background2",
    line = ccb.content.text("*grins and tugs at her shirt, an uncharacteristically crisp white T-shirt sporting a brightly colored penguin holding a slide rule, and a rainbow slogan reading 'sudo build it the way I told you to'.  \"Ha!  You must not know many engineers, hey?  I guess there's more to me than engineering, but most of my hobbies come back to it one way or the other.  It's not that I live for my work, doing engineering for a heating company wasn't some great dream, but when I got home I'd putter with the projects I wanted to do instead of the ones they made me do.  You know?  And of course, I had my friends and things, we'd go out or hang out and play board games and stuff.  Maybe some day I'll get a board game group started up here, although there's nothing wrong with the card games we've got now.  Plus I don't think Zombicide would hold the same interest for me as it used to.\""),
    replies = {
        {
            text = ccb.content.text("What kind of board games do you play?"),
            next_topic = "TALK_REFUGEE_JENNY_Games1",
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
    id = "TALK_REFUGEE_JENNY_Survival",
    line = ccb.content.text("*shrugs, looking distant.  \"I don't really like to talk about that time much.  None of us do.  Short story is that I made it to one of the evacuation shelters and got loaded onto a bus.  It was supposed to go to some sort of FEMA support camp, but there was a roadblock on the way there.  A few people just jumped out and ran for the military for protection.  They… it… it was bad.  The driver managed to get us turned around and booked it, and I guess they didn't chase us.  She took us back to one of the shelters and we found the address for this place.  Only a few of us decided to risk it, the rest stayed at the shelter to try their luck a different way.  I still wonder how they did.\""),
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
    id = "TALK_REFUGEE_JENNY_World",
    line = ccb.content.text("Ha!  I wonder how long that's going to be one of our go-to small talk questions.  It's perfect, isn't it?  Doesn't make you talk about the worst stuff but stays on theme for what's on everyone's mind.  Okay, I'll bite.  Have you heard any of the really wild stories?  Giant monsters the size of skyscrapers kicking over tanks and stuff, during the worst days?  I think somehow our planet got moved into another dimension, probably some kind of experimental process gone wrong.  During transit, some of those things came across, but they left when we arrived wherever we are now.  The rules are different here, and maybe we're superimposed with whatever version of Earth was here to start with, and that's why we hear about aliens and other unbelievable stuff out there along with the zombies.\"  She grins.  \"And before you say that's implausible, bear in mind that *the dead walk now*, so plausibility is off the table."),
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
    id = "TALK_REFUGEE_JENNY_Exodii",
    line = ccb.content.text("*lets out a low whistle.  \"No, not as such.  I've heard some rumors, I guess, but nothing credible.\"  She pauses, looking thoughtful.  \"I think, unless you can offer me some detailed answers about who and what they are and how they work, you'd better not tell me anything else.  I don't know if I could handle the stress.\"  With a gulp, she pulls listlessly at her earlobe.  \"If you do really know some juicy tidbits though, spill.\""),
    replies = {
        {
            text = ccb.content.text("Well, I know they're cyborgs, from some other dimension.  I think they're humans underneath the machines though.  Some of them kinda speak English."),
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "knowledge_exodization_u_knows_exodiilore" } }),
            next_topic = "TALK_REFUGEE_JENNY_Exodii2",
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
    id = "TALK_REFUGEE_JENNY_Exodii2",
    line = ccb.content.text("*puts her hands on her hips and glares at you.  \"I thought I made it clear I wasn't willing to accept enticing tidbits of information.  What the actual fuck?  Interdimensional cyborgs?  I don't want to believe you, but also, I already kinda thought there might be some multidimensional hijinks going on here, so I kinda do want to believe you.  They speak English though?  Are you sure this isn't some kind of scam?  Are you just fucking with me?  Honestly this would be a great way to fuck with me.\""),
    replies = {
        {
            text = ccb.content.text("[Show her your bionic interface.]"),
            when = predicates.has_trait("speaker", "CBM_Interface"),
            next_topic = "TALK_REFUGEE_JENNY_Exodii_Proof",
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

-- TK: Bring her a CBM to check out. Nothing useful results, it just makes her happy.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Exodii_Proof",
    line = ccb.content.text("*breathes a long, sighing curse as she examines your CBM interface.  \"Holeeeeeeshiiiiiiit.  This is amazing!  Like seriously, it's not even high tech.  At least not this part.  Can I see the schematics?  Can we dissect you?  I'm kidding.  Unless?  No, really kidding though.  Holy shit.\"  She pauses and studies you with a furrowed brow.  \"Wait, you let a strange interdimensional cyborg do brain surgery on you?  Never mind, I'd totally do that too.  Can you get me one of these?  No, I'd wind up taking it out and dismantling it.\"  She looks you up and down.  \"Thanks.  That's incredible.  It sucks that the world ended but I'm glad to know at least it ended with *cyborgs*.\""),
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
    id = "TALK_REFUGEE_JENNY_Games1",
    line = ccb.content.text("*scrunches her face in thought for a moment.  \"There was a whole world out there of weird board games for ultra nerdy people.  Lots of that stuff never really reached mainstream.  One of the hardest parts of evacuating for me was leaving my garage full of esoteric crowdfunded games I've never played.\""),
    replies = {
        {
            text = ccb.content.text("Have you ever thought about going back for them?"),
            next_topic = "TALK_REFUGEE_JENNY_Games2",
        },
        {
            text = ccb.content.text("Do you mean stuff like D&D?"),
            next_topic = "TALK_REFUGEE_JENNY_Games3",
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
    id = "TALK_REFUGEE_JENNY_Games2",
    line = ccb.content.text("No, mainly because my whole neighborhood burnt to the ground.  Some scouts went by a while ago.  Nothing there for me but melted plastic miniatures and thousands of hours of gameplay I'll never have."),
    replies = {
        {
            text = ccb.content.text("Do you mean stuff like D&D?"),
            next_topic = "TALK_REFUGEE_JENNY_Games3",
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
    id = "TALK_REFUGEE_JENNY_Games3",
    line = ccb.content.text("Well, of course I played the mandatory amount of dice based RPGs necessary to graduate my engineering program,\" she grins.  \"They're fun, something like that would be nice around here, but I'm not that kind of storyteller and I don't think anyone else here is nerdy enough for it.\"  Jenny tips her head a bit.  \"It's nice that you're asking but don't worry about me, I've got recreation."),
    replies = {
        {
            text = ccb.content.text("Have you ever thought about going back for your board games?"),
            next_topic = "TALK_REFUGEE_JENNY_Games2",
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
    id = "TALK_REFUGEE_JENNY_Teach1",
    line = ccb.content.text("Huh.\"  She purses her lips and looks at you reluctantly.  \"I guess I can teach you a bit, but you'd have to be like, my on-the-job apprentice and help me get stuff done.  It'll cost you a bit depending on what you want to learn.  Do you know anything about electronics, computers, or mechanics already?"),
    replies = {
        {
            text = ccb.content.text("[Skill 2] I'm not a total noob."),
            next_topic = "TALK_REFUGEE_JENNY_Teach2",
            when = predicates.handler("dlg_p_dda_c0d07b73df17"),
        },
        {
            text = ccb.content.text("[Skill <2] No, that's why I want you to teach me."),
            next_topic = "TALK_REFUGEE_JENNY_Teach2_Sorry",
            when = predicates.handler("dlg_p_dda_54492866b5b0"),
        },
        {
            text = ccb.content.text("[INT 10] No, but I'm a fast learner."),
            when = predicates.handler("dlg_p_dda_7ae74f090fb2"),
            trial = { kind = "persuade", difficulty = 30 },
            success = { next_topic = "TALK_REFUGEE_JENNY_Teach2" },
            failure = { next_topic = "TALK_REFUGEE_JENNY_Teach2_Sorry" },
        },
        {
            text = ccb.content.text("Um, you know what?  Never mind.  What were you saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Teach2",
    line = ccb.content.text("All right, fine.\"  Jenny sets aside the computer and gets up.  \"Grab some tools and do as I tell you."),
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "knowledge_flag_Jenny_teach", "yes"), actions.handler("dlg_a_dda_d8be20af72a2") } },
    },
    replies = {
        {
            text = ccb.content.text("Just say the word, teach."),
            next_topic = "TALK_TRAIN",
        },
        {
            text = ccb.content.text("<end_talking_leave>  Let's do this later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Teach2_Sorry",
    line = ccb.content.text("&\"I'm sorry, I don't have the time to teach someone who can't pull their weight, I just don't.\"  She gives you a look of genuine regret, then shrugs."),
    on_enter = {
        { actions = { actions.handler("dlg_a_dda_d8be20af72a2") } },
    },
    replies = {
        {
            text = ccb.content.text("Fine.  What were you saying?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Project1",
    line = {
        when = predicates.any_equal({ "mission_complete", { scope = "speaker", key = "Jenny_pneumatics" } }),
        yes = ccb.content.text("Well, thanks to your help, I've been designing some turrets that would use a central air system to power pneumatic rifle turrets around the center.  It's a lot easier than trying to make gunpowder!\"  She shrugs quickly.  \"I'm probably getting ahead of myself here, I don't think we're due to run out of gunpowder for years, but I also think the design is quieter and more long-term extendable."),
        no = {
            when = predicates.handler("dlg_p_dda_14d6d86ed426"),
            yes = ccb.content.text("About a month ago, I got a mold for making high-caliber air rifle bullets.  I've been designing some turrets that would use a central air system to power pneumatic rifle turrets around the center.  It's a lot easier than trying to make gunpowder!\"  She shrugs quickly.  \"I'm probably getting ahead of myself here, I don't think we're due to run out of gunpowder for years, but I also think the design is quieter and more long-term extendable."),
            no = ccb.content.text("I recently came into possession of this mold for making high-caliber air rifle bullets.  I'm kinda working on a design that would use them to protect the base.  Got a long way to go, though.  If you happen to see anything in your travels about high-powered air rifles, it would help a lot."),
        },
    },
    replies = {
        {
            text = ccb.content.text("If I see anything, I'll let you know.  Can you tell me more about your project?"),
            next_topic = "TALK_REFUGEE_JENNY_Project2",
            when = predicates.handler("dlg_p_dda_ec4cf1c5815e"),
            actions = { actions.offer_mission("MISSION_REFUGEE_Jenny_GET_PNEUMATICS") },
        },
        {
            text = ccb.content.text("Tell me more about your project."),
            next_topic = "TALK_REFUGEE_JENNY_Project2",
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

-- The talk_response to lead here should be in TALK_REFUGEE_JENNY_Project1, and should have these components, saved here until we can check for the pneumatics proficiency in conditions: What do you need to know?  I'm pretty handy with pneumatic devices, I can probably help. 'u_add_var: Jenny_pneumatics value: mission_complete'.
ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Project1_helped",
    line = ccb.content.gendered_line("&\"Holy shit, what are the odds?  OK, stand back and hold on.\"  Jenny begins peppering you with questions, which you answer to the best of your ability.  She seems quite satisfied.  \"Well, I can't thank you enough,\" she smiles after a few minutes.  \"You probably just saved me weeks of reinventing the wheel.  Here, it's not much but it's all I've got.\"  She hands you a bundle of the local currency.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Tell me more about your project."),
            next_topic = "TALK_REFUGEE_JENNY_Project2",
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
    id = "TALK_REFUGEE_JENNY_Project2",
    line = {
        when = predicates.handler("dlg_p_dda_14d6d86ed426"),
        yes = ccb.content.text("They're pretty big.  This isn't something you'd carry around with you.  They fire .30 cal bullets using compressed air that we'd make inside the basement and then pipe up to individual storage tanks for the guns that would be good for a few hundred shots each.  The design should be capable of auto or semi-auto fire, at a range that's pretty comparable to a gunpowder-based weapon.  It takes out some of the most limited parts of ranged weapons: no gunpowder, no brass casings, just lead that we melt into my mold.  It's not soundless, but it's not as loud as a chemical weapon.  There are tons of advantages.  Only trouble is, I can't convince the Free Merchants to give me the parts I need, even though it's for our own defense.\"  She grimaces.  \"Being one of the 'surface people' is so frustrating.  I'm pretty sure they talk about these decisions downstairs, behind our backs, and we're just not part of the process and can't advocate for our own projects."),
        no = ccb.content.text("Well, these things are a standard .30 caliber.  They should be compatible with any similar rifle barrel.  It would be pretty easy to repurpose some rifle parts into large air weapons that we could use without relying on gunpowder, and without so much noise.  I'm still drawing up an actual design though, I have a bunch of features I want.  Ask me again in a couple weeks and I'll give you some more info."),
    },
    replies = {
        {
            text = ccb.content.text("Is there some way I can help you get the stuff you need?"),
            next_topic = "TALK_MISSION_LIST",
            when = predicates.handler("dlg_p_dda_14d6d86ed426"),
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
    id = "TALK_REFUGEE_JENNY_Project3",
    line = {
        when = predicates.handler("dlg_p_dda_f8ea0408a5a9"),
        yes = {
            when = predicates.handler("dlg_p_dda_f7b8fa61ed7a"),
            yes = ccb.content.text("It's finally ready!  The pipes are laid to the first patch of ground we'll set turrets up in and I'd like for you to join me to go inspect how they are working.  I'll let you know when I'm ready to go."),
            no = ccb.content.text("I'm really making headway.  We've done some live demonstrations with a working device, and now it's just a matter of manufacturing a few of them.  We should be ready for release in a week or two."),
        },
        no = ccb.content.gendered_line("Things are coming along.  I have a lot of studying to do before I know how to fix my design issues, but the book you brought definitely has everything I need.  Now that I've got some progress to show, administration is much more willing to help me get the parts I need.  You've been a great gofer, but I can probably handle the rest on my own.  Check back in a week or two!", { "speaker" }),
    },
    replies = {
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
    id = "TALK_REFUGEE_JENNY_Personal1",
    line = {
        when = predicates.handler("dlg_p_dda_37c4c4e2de83"),
        yes = {
            when = predicates.handler("dlg_p_dda_14d6d86ed426"),
            yes = {
                when = predicates.handler("dlg_p_dda_179329b6cb3b"),
                yes = ccb.content.text("It's getting bad.  We've been stuck in here for months, nothing changing, nothing improving.  We can't go outside, we don't have enough to eat, and we didn't choose to be with each other.  I don't know how long we can stay like this before somebody snaps."),
                no = ccb.content.text("There's good and there's bad.  We're all pretty sick of being cooped up in here for months, never knowing if there's going to be food to eat or not.  It's starting to look like they're never going to let us go down to the secure basement, and none of us have slept well since we were brought in.  We know we've got it pretty good… we're safe, we're alive.  It's just, like, what kind of life are we even living?"),
            },
            no = ccb.content.text("It's been over a month now, so I guess I'm starting to get used to it.  Things were pretty rough after Sean died, but it wasn't our first big loss and it won't be the last I guess.  I've made a couple friends, and in a weird way we're all like family.  We were all hoping they'd let us downstairs sooner than this though.  We're never quite sure if there's going to be enough food to go around.  I'm really hoping I can lose myself in this project.  Still haven't had a good night's sleep since <the_cataclysm>."),
        },
        no = ccb.content.text("Living here?  Yeah, I guess I live here now.  It's… it's weird.  We're crowded into this tiny space, I don't know these people, but we're sharing bathrooms and we've all been through the same stuff.  It's not great.  At night we can hear the <zombies> outside, and we all just lie there awake, thinking the same things but too scared to talk about it."),
    },
    replies = {
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

-- Table of contents for repeated conversation options when asking Jenny about the other refugees
ccb.content.define_dialogue_topic {
    id = {
        "TALK_REFUGEE_JENNY_Refugees1", "TALK_REFUGEE_JENNY_FreeMerchants",
        "TALK_REFUGEE_JENNY_Refugees2_Fatima", "TALK_REFUGEE_JENNY_Refugees2_Friends",
        "TALK_REFUGEE_JENNY_Refugees2_Borichenko", "TALK_REFUGEE_JENNY_Refugees2_Singh",
        "TALK_REFUGEE_JENNY_Refugees2_Others",
    },
    replies = {
        {
            text = ccb.content.text("Can you tell me about the Free Merchants?"),
            next_topic = "TALK_REFUGEE_JENNY_FreeMerchants",
        },
        {
            text = ccb.content.text("Can you tell me about Fatima?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Fatima",
        },
        {
            text = ccb.content.text("What has made you friends with Dana, Draco, and Aleesha?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Friends",
        },
        {
            text = ccb.content.text("Can you tell me about the Borichenkos?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Borichenko",
        },
        {
            text = ccb.content.text("Can you tell me about the Singhs?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Singh",
        },
        {
            text = ccb.content.text("Can you tell me about the others?"),
            next_topic = "TALK_REFUGEE_JENNY_Refugees2_Others",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_REFUGEE_JENNY_Refugees1",
    line = {
        when = predicates.handler("dlg_p_dda_3b14879c9833"),
        yes = ccb.content.text("For better or worse, we're a community now.  Fatima and I work together a fair bit, and I consider Dana, Draco, and Aleesha my friends, and so of course I've gotten to know Dana's husband Pedro too.  The Borichenkos are their own sweet brand of messed up, like all of us.  The Singhs have each other, and keep mostly to themselves.  Vanessa and I don't see eye to eye, but I'm still glad she's here.  Uyen and Rhyzaea are always bickering about leadership decisions, as if they made those kind of calls.  What did you want to know?"),
        no = ccb.content.text("Well, there's a bunch of us.  We're starting to form a bit of a community.  Fatima and I work together a fair bit, and I've been hanging out with Dana, Draco, and Aleesha quite a lot.  I don't know the Borichenko bunch, the Singhs, Vanessa, Uyen, or Rhyzaea quite as well, but we've talked.  What did you want to know?"),
    },
    replies = {
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
    id = "TALK_REFUGEE_JENNY_FreeMerchants",
    line = ccb.content.text("They run this place, and they don't run a charity.  We get paid for working around the place, maintaining it, what have you, and we trade cash for food.  The thing is, supply and demand and all… there's a lot more cash than food around.  It's easier to buy a laptop than a piece of beef jerky, and there's no sign of that getting better.  The balance is way off right now, a hard day of work barely gets you enough to fill your belly.  I shouldn't bitch too much though.  I don't know much better way to run it, although rumor is that the folks living downstairs have it a lot easier than we do.  I try not to think too much on that."),
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
    id = "TALK_REFUGEE_JENNY_Refugees2_Fatima",
    line = ccb.content.text("Fatima's a sweety, but she's a total dork.  I know, I know, it's backwards for the engineer to call the heavy-duty mechanic a nerd, but hey.  I call it like it is.  She and I have been doing some odd jobs around the upstairs here, fixing up old machinery and things."),
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
    id = "TALK_REFUGEE_JENNY_Refugees2_Friends",
    line = ccb.content.text("Well, Dana lost her baby right after <the_cataclysm>, in a bus rollover.  She was lucky to make it out alive.  She and Pedro had one of the rougher trips here, I guess.  We just kinda click as friends, I'm grateful there's someone else here I can really get along with.  Her husband, Pedro, is still pretty shell-shocked.  He doesn't talk much.  I like him though, when he opens up he's just hilarious.  Draco is just a cantankerous old fart who hasn't actually got old yet, give him twenty years and he'll be there.  I like grumpy people.  We also have pretty similar taste in music.  Aleesha's a sweet kid, and we've all kind of adopted her, but she seems to hang out with me and Dana the most.  She's a great artist, and she's full of crazy ideas.  I guess I like her because of all of us, she seems to have the most hope that there's a future to be had."),
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
    id = "TALK_REFUGEE_JENNY_Refugees2_Borichenko",
    line = {
        when = predicates.handler("dlg_p_dda_3b14879c9833"),
        yes = ccb.content.text("I didn't get to know Boris, Garry, and Stan so well for the first while.  They kinda kept to themselves.  Boris and Stan had just lost their son, you know.  It's pretty lucky that Garry was with them, he's Stan's little brother.  Together, they're a pretty good team.  I feel bad for thinking they were standoffish before.  They probably do the most to pull their weight around here whenever there's work to be done."),
        no = ccb.content.text("Boris and Stan are married, I guess.  They kinda keep to themselves, they seem a bit standoffish if you ask me.  Garry is Stan's brother, I think, but I'm not totally sure.  He seems nice enough, but he's a man of few words.  I can't get a good bead on them.  I've learned not to pry too much though."),
    },
    replies = {
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
    id = "TALK_REFUGEE_JENNY_Refugees2_Singh",
    line = {
        when = predicates.handler("dlg_p_dda_179329b6cb3b"),
        yes = ccb.content.text("The Singhs are really shy, and I think they feel pretty bad about making it through this together.  They're the only complete family I've seen since <the_cataclysm>.  That has to feel really weird, and I think it's made them stick really close together.  I think… I think they also just don't really like any of us."),
        no = ccb.content.text("I really can't get a bead on them.  They never really talk to anyone outside of their little family group, they just sit in their own spot and speak Punjabi.  They always seem nice, and they do their share, they just don't have any social connection."),
    },
    replies = {
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
    id = "TALK_REFUGEE_JENNY_Refugees2_Others",
    line = {
        when = predicates.handler("dlg_p_dda_fe3a896fea99"),
        yes = ccb.content.text("Vanessa… I'm doing my best, I really am, but we just do not get along.  One of these days one of us is probably going to brain the other with a tire iron, and I'm just grateful I spend more time around the tire irons.  Uyen and Rhyzaea are both excellent people, and I genuinely like them, but I can't stand this ongoing political bullshit they've got going on.  Alonso is just a… he's… there's no polite word for what he is.  A lot of the others are fine with it, and okay, sure, I guess.  John is a walking stereotype, but he's a great poker buddy.  I admit I kinda like him."),
        no = ccb.content.text("Vanessa… well, she's nice, I guess.  I gotta say, she kinda drives me nuts, but we're in this together so I try not to be too harsh.  Uyen and Rhyzaea both seem to want to run the show here, but I try to stay out of those politics and just focus on building stuff.  I don't see much good coming of it.  Alonso is fine, he's clearly interested in me, and also in every other single person here.  Not my thing, in a group this small.  John is a walking stereotype, I imagine there must be more depth to him, but I haven't seen it yet."),
    },
    replies = {
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

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
    name = ccb.content.text("Find reference material about air rifles for Jenny."),
    description = ccb.content.text("Find reference material about air rifles.  <color_yellow>A book that has 'Pneumatic' in its name</color> could be the thing she wants.  She probably wants a physical copy, if I can find it. "),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "book_pneumatics",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("If you happen to see anything in your travels about high-powered air rifles, it would help a lot."),
        offer = ccb.content.text("If you happen to see anything in your travels about high-powered air rifles, it would help a lot."),
        accepted = ccb.content.text("Great!  Bring it to me if you find one."),
        rejected = ccb.content.text("Oh well.  Thanks anyway."),
        advice = ccb.content.text("Honestly I don't even have a search engine to find the name of a good book.  It's the air compression part I need to know about, gun books won't help much."),
        inquire = ccb.content.text("Any sign of an air rifle book I can use?"),
        success = ccb.content.text("That's exactly what I need!  Here, I saved a few merch for you, I hope this helps cover your troubles."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 4 } },
        handler = "set_Jenny_pneumatics_to_mission_complete",
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_MOTOR",
    name = ccb.content.text("Find an electric motor"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "motor",
    followup = "MISSION_REFUGEE_Jenny_GET_TANK",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("Yeah, if you want to risk your neck out there and bring me what I need, I'm not gonna say no.  I can't, like, pay you or anything though, you know that right?"),
        offer = ccb.content.text("Before I get anything going, I'm going to need to set up a compressor.  I have a lot of the stuff for that, but I need a large tank for air, and a good sized electric motor - about 10 kg or so.  I'm also going to need a 60 liter tank, after that."),
        accepted = ccb.content.text("Great!  Bring it to me when you find one."),
        rejected = ccb.content.text("Oh well.  Thanks for offering anyway."),
        advice = ccb.content.text("Try a basic hybrid car, or maybe farm equipment that uses an electric motor.  The kind on a bike would be too small, and the kind on those fancy Edison sports cars is going to be too big."),
        inquire = ccb.content.text("Any sign of a motor I can use?"),
        success = ccb.content.text("That's exactly what I need!  Want to talk about that tank now?  I saved a few merch for you, by the way."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 4 } },
        handler = {
            "mark_mission_completed_Jenny_mission_2",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_TANK",
    name = ccb.content.text("Bring back a 60 L metal tank"),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "metal_tank",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_REFUGEE_Jenny_GET_TEXT",
    dialogue = {
        describe = ccb.content.text("Now that I've got that motor, I can get my compressor mostly built.  I will need a tank though."),
        offer = ccb.content.text("I can get started building the compressor, but I need a large metal tank to store compressed air centrally.  About 60 liters should do…"),
        accepted = ccb.content.text("Great!  Bring it to me when you find one."),
        rejected = ccb.content.text("Oh well.  Thanks for offering anyway."),
        advice = ccb.content.text("It needs to be a good strong tank, like a big propane tank or something… you could look at fuel storage tanks and things, as long as they're durable enough.  Heck, if you get some sheet metal you could probably even weld a good one together."),
        inquire = ccb.content.text("Any sign of a tank I can use?"),
        success = ccb.content.text("Hey, this is perfect, \"tanks\" a bunch.  Okay, I'm sorry for that.  Anyway, now that I've got the parts, I might be able to build a proof of concept.  First I gotta get this thing up and running, and argue with the bean counters about letting me draw power to run it.  Oh right, and here's some merch, thanks for the help!"),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought.  Back to the drawing board I guess."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        item_rewards = { { item = "FMCNote", count = 5 } },
        handler = {
            "mark_mission_completed_Jenny_mission_2",
            "advance_counter_refugee_center_refugee_happiness_by_1",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_REFUGEE_Jenny_GET_TEXT",
    name = ccb.content.text("Find a gunsmithing textbook"),
    description = ccb.content.text("Find a gunsmithing textbook for Jenny.  <color_yellow>A book with 'Gunsmithing' and/or 'Firearm Design' in its name</color> will do."),
    difficulty = 1,
    value = 0,
    goal = "MGOAL_FIND_ITEM",
    item = "text_gunsmith",
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("I hate to admit it, but my first few tests haven't gone well.  I think I know what's wrong, but I need more information."),
        offer = ccb.content.text("I need a good quality reference book on gunsmithing.  This isn't my area of expertise, and I don't want to blow anybody up."),
        accepted = ccb.content.text("Great!  Bring it to me when you find one."),
        rejected = ccb.content.text("Oh well.  Thanks for offering anyway."),
        advice = ccb.content.text("This is a bit of a tricky one.  A college library would be a good start, and I imagine maybe military bases have that kind of thing?  I'm not entirely sure."),
        inquire = ccb.content.text("Any luck looking for that gunsmithing text?"),
        success = ccb.content.text("Oh yeah.  Ooooh yeah.  Now we're cookin' with gas.  Here's a bit more merch, you beautiful gofer maniac."),
        success_lie = ccb.content.text("Huh.  This isn't going to work like I thought.  Back to the drawing board I guess."),
        failure = ccb.content.text("No worries.  Let me know if you want to try again."),
    },
    finish = {
        actions = {
            { item = "FMCNote", count = 5 },
            ccb.content.dialogue_actions.set_actor_value("speaker", "mission_completed_Jenny_mission_3", "yes"),
            ccb.content.dialogue_actions.record_time({ scope = "interlocutor", key = "timer_flag_Jenny_project_timer" }),
            { handler = "advance_counter_refugee_center_refugee_happiness_by_1" },
        },
    },
}
