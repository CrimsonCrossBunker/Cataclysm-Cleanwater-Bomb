local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- Part of the Isherwood family.  Does not spawn until you get a mission from Carlos to track him down.
-- Son of Carlos and Jesse, nephew of Eddie.  Brother of Lisa, cousin of Luke.  Grandson of Claire and Jack, great-nephew of Barry.
ccb.content.define_npc {
    id = "isherwood_chris",
    unique_name = ccb.content.text("Chris Isherwood"),
    gender = "male",
    class = "NC_ISHERWOOD_CHRIS",
    attitude = 0,
    mission = "GUARD",
    age = 21,
    height = 177,
    strength = 8,
    dexterity = 9,
    intelligence = 8,
    perception = 9,
    personality = { aggression = 2, bravery = 5, collector = -3, altruism = 1 },
    chat = "TALK_ISHERWOOD_CHRIS",
    missions_offered = "MISSION_ISHERWOOD_CHRIS_1",
    faction = "isherwood_family",
}

ccb.content.define_npc_class {
    id = "NC_ISHERWOOD_CHRIS",
    name = ccb.content.text("Chris Isherwood"),
    job_description = ccb.content.text("I'm Jesse and Carlos' son, part of the Isherwood family"),
    traits = {
        { trait = "FLEET" },
        { trait = "LIGHTSTEP" },
        { trait = "WEAKSTOMACH" },
        { trait = "ANTIJUNK" },
        { trait = "PRETTY" },
        { trait = "SKIN_LIGHT" },
        { trait = "eye_color", variant = "blue" },
        { trait = "hair_medium", variant = "black" },
        { trait = "NO_BASH" },
    },
    common = false,
    perception = { one_in = 4 },
    worn = "NC_Isherwood_male_worn",
    weapon = "NC_ISHERWOOD_rifle",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "speech", bonus = { rng = { 2, 4 } } },
        { skill = "melee", bonus = { rng = { 3, 6 } } },
        { skill = "survival", bonus = { rng = { 7, 10 } } },
        { skill = "gun", bonus = { rng = { 4, 8 } } },
        { skill = "rifle", bonus = { rng = { 7, 10 } } },
        { skill = "archery", bonus = { rng = { 8, 10 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_ISHERWOOD_CHRIS" },
    replies = {
        {
            text = ccb.content.text("Hi, your dad asked me to come find you, said you've been looking for your uncle."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALK1",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
            actions = { actions.set_actor_value("speaker", "u_met_Chris_Isherwood", "yes"), actions.set_actor_value("speaker", "u_met_an_isherwood", "yes") },
        },
        {
            text = ccb.content.text("I was talking to Luke earlier, said you had some interesting ideas about the world ending.  Is it tied to Barry's abduction?"),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.handler("dlg_p_dda_4a15715ed8e3"),
        },
        {
            text = ccb.content.text("Hi, what have you been up to lately."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALK2",
            when = predicates.handler("dlg_p_dda_3563a6faba65"),
        },
        {
            text = ccb.content.text("Can I hear your ideas about the world ending, now that we saved Barry?"),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.handler("dlg_p_dda_c60e2fef403c"),
        },
        {
            text = ccb.content.text("Have you had any ideas for what your family could do?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN",
            when = predicates.handler("dlg_p_dda_e23779bc32b5"),
        },
        {
            text = ccb.content.text("Do you think we're ready to try this again?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
            when = predicates.handler("dlg_p_dda_9a6581117466"),
        },
        {
            text = ccb.content.text("Do you think we're ready to try this again?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN2",
            when = predicates.handler("dlg_p_dda_1b4379fba2e7"),
        },
        {
            text = ccb.content.text("I've got some SWAT gear that should work for the assault."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_352673c69d29"),
        },
        {
            text = ccb.content.text("I've got enough SWAT gear to set everyone up for the assault."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Done",
            when = predicates.handler("dlg_p_dda_58b387811876"),
            actions = { actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR", { success = true }) },
        },
        {
            text = ccb.content.text("[LIE] I tried to get the SWAT gear, but it looks like someone looted it before I could get there."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Fail",
            when = predicates.handler("dlg_p_dda_f3dffbfae44f"),
            actions = { actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR", { success = false }) },
        },
        {
            text = ccb.content.text("I've got enough bags to set up a defensive wall."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall_Done",
            when = predicates.handler("dlg_p_dda_c74ca0bd1916"),
            actions = { actions.transfer_items("bag_canvas", 20), actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS", { success = true }) },
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.negate(predicates.wears("speaker", "badge_marshal")),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS",
    line = {
        joined = {
            ccb.content.text("*is a young man, perhaps in his early twenties or late teens.  He eyes you up and down.  \""),
            {
                when = predicates.wears("speaker", "badge_marshal"),
                yes = ccb.content.text("I see that badge.  You need to leave our land, my relatives have no fondness for Marshals.\""),
                no = {
                    when = predicates.any_equal({ "seen", { scope = "speaker", key = "isherwood_chris_marshal_badge" } }),
                    yes = ccb.content.gendered_line("I see you took the badge off.  Fine, then, but you'd better not let anyone here know you've got ties to the Marshals.\"", { "speaker" }),
                    no = ccb.content.text("Hi, what's up?\""),
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("…[Leave.]"),
            next_topic = "TALK_LEAVE_NOW_MARSHAL_CHRIS",
            actions = { actions.set_actor_value("speaker", "isherwood_chris_marshal_badge", "seen") },
            opinion = { trust = -5, value = -5 },
            when = predicates.wears("speaker", "badge_marshal"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TALK1",
    line = ccb.content.text("Yeah, they are always worried about us, I prefer to survey the land and try to track the changes.  I'm thinking about fixing up this cabin for some peace and quiet…"),
    replies = {
        {
            text = ccb.content.text("Sounds like you are restless, why not leave?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_WANTS",
        },
        {
            text = ccb.content.text("What sort of changes have you seen?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_LAND",
        },
        {
            text = ccb.content.text("I was talking to Luke earlier, said you had some interesting ideas about the world ending."),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_heard_about_chris" } }) }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TALK2",
    line = ccb.content.text("I surveyed the land, and I am trying to track the changes.  I fixed up this cabin for some peace and quiet… you can settle here if you want"),
    replies = {
        {
            text = ccb.content.text("Sounds like you are restless, why not leave?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_WANTS",
        },
        {
            text = ccb.content.text("What sort of changes have you seen?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_LAND",
        },
        {
            text = ccb.content.text("Do you think, monsters that kidnaped Barry are responsible for end of the world?"),
            next_topic = "TALK_CHRIS_THEORIES2",
            when = predicates.all({ predicates.negate(predicates.wears("speaker", "badge_marshal")), predicates.any_equal({ "yes", { scope = "speaker", key = "u_heard_about_chris" } }) }),
        },
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        { text = ccb.content.text("I'd better get going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_WANTS",
    line = ccb.content.text("My family is convinced that if we stay here, we'll be able to weather this catastrophe.  Since technology has failed, they've doubled down on older traditions.  I think we need to get out there and find some answers before settling on a path."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRIS_THEORIES",
    line = ccb.content.text("In one of my longer trips looking for Barry, I saw something out in a field.  I didn't get close but I swear unbelievable monsters were coming out of it.  It kinda shimmered, almost like it wasn't quite there.  I've been tracking those monsters for a while…"),
    replies = {
        {
            text = ccb.content.text("What did you find?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_MIGO_BASE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CHRIS_THEORIES2",
    line = ccb.content.text("I doubt that, other monsters and zombies attacked them way too often"),
    replies = {
        {
            text = ccb.content.text("Let's talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        { text = ccb.content.text("I'd better get going."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_MIGO_BASE",
    line = ccb.content.text("They made their way to this weird spire like structure, I've never seen anything like it, it glistened in the sun like something organic.  I think they could be holding Barry there, I've seen them arrive and leave with other humans."),
    replies = {
        {
            text = ccb.content.text("I might be able to help you get Barry back, but we've got to plan this out."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY",
            when = predicates.handler("dlg_p_dda_4018badfc82f"),
            actions = { actions.offer_mission("MISSION_ISHERWOOD_CHRIS_1") },
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_LAND",
    line = ccb.content.text("Well, wildlife is more hostile and I've seen gigantic insects around, never mind all these monsters.  I've also found mysterious dead spots and mutated vegetation.  I don't think staying on a farm is sustainable forever, there are big planet wide changes occurring."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_LEAVE_NOW_MARSHAL_CHRIS",
    line = ccb.content.text("You should leave before my family sees you."),
    replies = { { text = ccb.content.text("…"), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_TOPICS",
    line = ccb.content.text("Go on…"),
    replies = {
        {
            text = ccb.content.text("Your dad asked me to come find you, said you've been looking for your uncle."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TALK1",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
        },
        {
            text = ccb.content.text("I was talking to Luke earlier, he said you had some interesting ideas about the world ending."),
            next_topic = "TALK_CHRIS_THEORIES",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
        },
        {
            text = ccb.content.text("Do you think, monsters that kidnaped Barry are responsible for end of the world?"),
            next_topic = "TALK_CHRIS_THEORIES2",
            when = predicates.handler("dlg_p_dda_3563a6faba65"),
        },
        {
            text = ccb.content.text("What sort of changes have you seen?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_LAND",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_a01355dd84c8"),
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY",
    line = ccb.content.text("&Chris looks you up and down, and nods.  \"I'm definitely not going to say no to a willing body, and you look like you know what's up.\"  He sighs.  \"To be honest with you, I've been a bit stuck.  I can't tackle that thing alone, and I'm not willing to bring my dad or Uncle Eddie in either.  Dad's got a bum knee - don't tell him I said that - and Eddie's not that great a shot.  Luke's still too young for something like this… you get the idea.\"  He leans forward, self-consciously running his hand through his hair.  \"I think if we work together maybe we'd stand a chance.  I don't have a great plan though.  That tower doesn't look like something a person could just storm up to full-frontal style.\""),
    replies = {
        {
            text = ccb.content.text("Actually, I was just planning to go in by myself.  I've handled worse."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_GO_IT_ALONE",
            when = predicates.handler("dlg_p_dda_1cb9d4920113"),
        },
        {
            text = ccb.content.text("I've got my own team here, we'll take this.  You stay back here, keep the family safe."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_OWN_TEAM",
            when = predicates.handler("dlg_p_dda_430389987a1c"),
        },
        {
            text = ccb.content.text("Yeah, I think we should work together on this.  Do you mind if I take the lead?  I've probably got more experience."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_GO_IT_ALONE",
    line = ccb.content.text("*looks at you with obvious doubt.  \"You sure you know what you're getting into?  I can't stop you if you plan on going in solo, but it seems like a terrible idea.  Those things mean business.  I won't be able to go in and help you if you get trapped too.  It's probably better we pair up.\""),
    replies = {
        { text = ccb.content.text("Trust me.  See you in a bit."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("If you insist, yeah, we could team up."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_OWN_TEAM",
    line = ccb.content.text("Yeah, bringing your own people in is reasonable.  Still, the more the better.  It's my uncle in there, I'm more than willing to help out.  I know my way around, I won't get in your way."),
    replies = {
        {
            text = ccb.content.text("All right.  As long as you follow my lead, we could use another pair of hands."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
        },
        {
            text = ccb.content.text("It's all right.  We've got this, you get things ready for when we return with Barry."),
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_THE_ISHERWOODS",
    line = ccb.content.text("Probably.  They'd want to, for sure.\"  He looks thoughtful.  \"I'm sure we could use more help, but this isn't my strong suit.  Let me think about it.  If you have any ideas, run them by me."),
    on_enter = {
        { once = "chris_thinking_about_plan", actions = { actions.handler("dlg_a_dda_6a23459ec0bd") } },
    },
    replies = {
        {
            text = ccb.content.text("Is there anyone else around here that could help us?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("OK.  Let's talk about it again in a bit."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN",
    line = ccb.content.text("Yeah.  I think they should cover our exit.  We've got an old truck they could set up as a platform, where Dad can put down covering fire without his knee being an issue.  Eddie can drive, instead of shoot, and Luke or Mom can be ready with some first aid supplies.  Then when we get out, we've got an easy getaway set up, and there's less chance of us getting flanked while we're in there looking for Barry.\"  He looks at you, suddenly nervous.  \"Is that a good plan?"),
    replies = {
        {
            text = ccb.content.text("Seems like a good plan to me."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN2",
            actions = { actions.handler("dlg_a_dda_ccd3f3c98ae9") },
        },
        {
            text = ccb.content.text("I think it's better we take my vehicle, and just leave them out of it."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
            actions = { actions.handler("dlg_a_dda_f193e384473c") },
        },
        {
            text = ccb.content.text("Is there anyone else around here that could help us?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA",
        },
        {
            text = ccb.content.text("I don't think one farmer with a hunting rifle is going to be enough to keep our backs safe."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear",
            when = predicates.handler("dlg_p_dda_58b78813d1ec"),
        },
        {
            text = ccb.content.text("I think we need some kind of secure fallback point for the family, maybe a defensive wall?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall",
            when = predicates.handler("dlg_p_dda_d878d0dca848"),
        },
        {
            text = ccb.content.text("We're going to need some way to breach the tower itself, possibly some form of explosives.  Do you know anyone who could help us with that?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_been_to_migos" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "chris_planned_for_bomb" } })) }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_JOINS",
    line = ccb.content.text("*nods.  \"I'm fine following your lead.  I'm a good scout and hunter, but I've never done anything like this before.  When you set the time, I'll head out and wait near the scout tower for you with the best gear I can get.\""),
    replies = {
        {
            text = ccb.content.text("All right.  Let's kick some alien butt."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_3a151799f896") },
        },
        {
            text = ccb.content.text("Is there anyone else around here that could help us?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA",
        },
        {
            text = ccb.content.text("You mentioned that Carlos, Eddie and Luke probably can't help in a firefight.  Is there any other way we could use them?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_THE_ISHERWOODS",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA",
    line = ccb.content.text("Like I said, I don't really think my dad or uncle should help, and I think Luke's more likely to get injured than be helpful."),
    replies = {
        {
            text = ccb.content.text("What about Lisa?  She seems like she could handle herself."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "u_met_lisa_isherwood" } }),
        },
        {
            text = ccb.content.text("You mentioned that Carlos, Eddie and Luke probably can't help in a firefight.  Is there any other way we could use them?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_THE_ISHERWOODS",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("Well, I guess it's just us.  <lets_go>"),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_3a151799f896") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA2",
    line = ccb.content.text("*blinks.  \"My… yeah, of course Lisa could come.  Damn, she'd smack me if she knew I didn't think of that myself.  Mind if I go talk to her about it?  I'll get her to come out with me and we'll meet you together, if she's willing.\""),
    on_enter = {
        { once = "plan_to_take_lisa", actions = { actions.set_actor_value("speaker", "lisa_isherwood_coming_too", "yes"), actions.handler("w16b_a_dda_3463a68f7091") } },
    },
    replies = {
        {
            text = ccb.content.text("You mentioned that Carlos, Eddie and Luke probably can't help in a firefight.  Is there any other way we could use them?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_THE_ISHERWOODS",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("All right.  Let's kick some alien butt."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_d6314d3ea231") },
        },
        {
            text = ccb.content.text("Okay, I'll give you about an hour to talk with her about it.  I'll be back soon."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_a205c9aeeaa7") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
    line = ccb.content.text("*looks crestfallen for a moment, then straightens up.  \"All right.  Yeah, maybe better not to put them at risk I guess.  So we're back to going in without them.  Maybe that's better, I don't want to lose anyone else.\""),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN2",
    line = ccb.content.text("Can you think of anything else we might need, or should we put this into action?"),
    replies = {
        {
            text = ccb.content.text("Let's go get your uncle back."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_be75d0d448ce") },
        },
        {
            text = ccb.content.text("I've changed my mind.  I think it's better we take my vehicle, and just leave them out of it."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
        },
        {
            text = ccb.content.text("I'm a bit worried about defenses.  Do you folks have any armor or equipment to help keep yourselves safe?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear",
            when = predicates.handler("w16b_p_dda_80c4c2e841bf"),
        },
        {
            text = ccb.content.text("I think we need some kind of secure fallback point for the family, maybe a defensive wall?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall",
            when = predicates.handler("w16b_p_dda_c2662bc2e1a2"),
        },
        {
            text = ccb.content.text("We're going to need some way to breach the tower itself, possibly some form of explosives.  Do you know anyone who could help us with that?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb",
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "u_been_to_migos" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "chris_planned_for_bomb" } })) }),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear",
    line = ccb.content.text("*looks thoughtful.  \"Well, we can wear our usual wrangling gear, but you're right.  It's no good against those claws.\"  He sighs.  \"I don't want to delay, but I don't want to lose another family member either.  If we could get our hands on some riot gear, that might give us a better chance to fend off the monsters.  Not too far away, our corrupt-as-hell local cops kept enough of that gear on hand to easily set our family up.  As if they needed it in this place.  Just used it to keep the boot on, y'know?\"  He spits on the ground.  \"I can show you where their stores were, it'd feel nice to put that stuff to good use.  Of course, any riot gear would do, if you happen to have already looted some.\""),
    replies = {
        {
            text = ccb.content.text("I think you're right, that would take too long.  We'll have to count on offense being our best defense."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
        },
        {
            text = ccb.content.text("Show me where, and I'll try to get some riot gear for you."),
            actions = { actions.assign_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
    line = ccb.content.text("*smiles slightly.  \"Awesome, getting our team kitted out better will go a long way to making this possible.\""),
    replies = {
        {
            text = ccb.content.text("[5 Riot Armor] I've got enough riot armor for everyone."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_f53210a49dbf"),
            actions = { actions.handler("dlg_a_dda_ac36764419c7") },
        },
        {
            text = ccb.content.text("[5 Riot Helmet] These crowd control helmets should help a lot."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_683b81f6faa8"),
            actions = { actions.handler("dlg_a_dda_5bcc06cfd5dd") },
        },
        {
            text = ccb.content.text("[5 Riot Arm Guard] I hope these armguards won't interfere with people's aim."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_657aabd51a14"),
            actions = { actions.handler("dlg_a_dda_a11617c84486") },
        },
        {
            text = ccb.content.text("[5 Riot Leg Guard] I've got these leg guards to keep people from getting hobbled."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Turn_Over",
            when = predicates.handler("dlg_p_dda_60d6d15b9b8b"),
            actions = { actions.handler("dlg_a_dda_e5ad87d70cd3") },
        },
        {
            text = ccb.content.text("We have enough full sets of riot control armor to cover everyone, head to toe."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Done",
            when = predicates.handler("dlg_p_dda_58b387811876"),
            actions = { actions.finish_mission("MISSION_ISHERWOOD_CHRIS_1_GET_GEAR", { success = true }) },
        },
        {
            text = ccb.content.text("That's all for now.  <done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("That's all for now.  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Done",
    line = ccb.content.text("*nods intently, looking at the assembled pile of equipment.  \"Like I said, I'll get this distributed to everyone who's coming.  It's starting to feel more real, but less impossible.  Thanks for doing this.\""),
    replies = {
        {
            text = ccb.content.text("Before you get on to that, I wanted to talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        { text = ccb.content.text("I'll let you get on that."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Gear_Fail",
    line = ccb.content.gendered_line("*nods slowly.  \"I understand.  You tried.  We could maybe… no, nevermind.  Time is important here, we can't spend forever hoping to get everything in place if we want to get Uncle Barry back alive.  Let's do it without the gear.\"", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Sorry.  <done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("I'm sorry.  I'm going to go take care of a few more things."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall",
    line = ccb.content.text("Good idea.  A sandbag wall would be easy enough, we've had to do those a few times when we've had flooding and everyone knows the drill.  Back then we just grabbed supplies from the hardware store, though.  Maybe you'd be able to make a run for those?  Something like 20 canvas bags would probably do it.  We can fill them up in advance and toss them out of the truck to get a decent barricade."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("I think this is going to take too long, honestly.  Let's just stick with the truck."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Cancel",
        },
        {
            text = ccb.content.text("I know where to find those canvas bags, I'll go get them."),
            actions = { actions.assign_mission("MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS") },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Wall_Done",
    line = ccb.content.text("All right.  I think that's everything we need.  Let me get it out to the family and we'll have it all prepped by tomorrow."),
    replies = {
        {
            text = ccb.content.text("Before I go, let's talk about something else."),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("I'll let you get on that, I've got my own preparations to take care of."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb",
    line = ccb.content.text("* looks thoughtful for a moment, then becomes a bit nervous.  \"Wait, won't that run the risk of injuring Barry, or possibly collapsing the tower?  I don't want him hurt during this, or anyone else if this bomb sends back a bunch of shrapnel.  What do you think about it?\""),
    replies = {
        {
            text = ccb.content.text("Don't worry, I know what I'm doing.  I've taken a look at these sorts of towers before, and I know that the structure itself is pretty solid.  If we tune it right, then the tower won't fall over."),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb_Luke",
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_PLAN_Bomb_Luke",
    line = ccb.content.text("Well, I trust you on this.  If you need a good hand with chemistry, go see Luke about it.  He knows a lot, you'd be surprised.  \" He pauses for a moment, and thinks as if trying to recall something.  \"Luke should be over in the old outbuilding near the dairy, that's on the other end of the property."),
    replies = {
        {
            text = ccb.content.text("That sounds great, I'll go talk to him about it.  Let's talk about something else first, though."),
            actions = { actions.set_actor_value("speaker", "chris_planned_for_bomb", "yes") },
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("That sounds great, I'll go talk to him about it."),
            actions = { actions.set_actor_value("speaker", "chris_planned_for_bomb", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CHRIS_1",
    name = ccb.content.text("Free Barry from the mysterious structure"),
    goal = "MGOAL_NULL",
    difficulty = 5,
    value = 50000,
    start = {
        target = {
            terrain = "barry_mi-go_scout_tower_3",
            special = "Barry's Mi-Go Scout Tower",
            reveal_radius = 3,
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("We need to investigate the alien encampment and try to find out what happened to Barry."),
        offer = ccb.content.text("I can take you to the structure, I tracked them to it."),
        accepted = ccb.content.text("Awesome, I want some answers!"),
        rejected = ccb.content.text("Thanks anyway, I'll keep my eye on it, maybe I'll find a way one day."),
        advice = ccb.content.text("I feel like we are underprepared if they see us, I marked the location for you."),
        inquire = ccb.content.text("You ready?"),
        success = ccb.content.text("It's taller then I remember, we should look for prisoners.  I left a note for my family before we left.  If we survive, the cabin should be fixed up and ready for you to move in if you want to stay."),
        success_lie = ccb.content.text("Well it was here…"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
    -- Native mission phases did not apply the giver opinion (trust +5, value +5).
    finish = {
        map_updates = {
            {
                terrain = "cabin_isherwood",
                layout = { nested = { { x = 3, y = 1, id = "cabin_isherwood_update" } } },
            },
        },
        handler = "set_world_isherwood_barry_rescued_to_1",
    },
}

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CHRIS_1_GET_GEAR",
    name = ccb.content.text("Retrieve 5 sets of riot armor for the Isherwoods"),
    goal = "MGOAL_NULL",
    difficulty = 1,
    value = 0,
    start = {
        target = { terrain = "police_2ndfloor_1", special = "police_1", reveal_radius = 3 },
        map_updates = {
            {
                terrain = "police_2ndfloor_1",
                layout = { nested = { { x = 1, y = 5, id = "isherwood_barry_riot_drop" } } },
            },
        },
    },
    finish = { handler = "set_world_isherwood_gear_status_to_1" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_CHRIS_TRY_AGAIN",
    line = ccb.content.text("If you think we're ready, I think we can try another go.  Even… even if it's too late for Uncle Barry, I think we've got to try to take that damn tower out of commission."),
    replies = {
        {
            text = ccb.content.text("All right.  Let's kick some alien butt."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("w16b_a_dda_617ec9bf0096") },
        },
        {
            text = ccb.content.text("Is there anyone else around here that could help us?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_TAKE_LISA",
        },
        {
            text = ccb.content.text("You mentioned that Carlos, Eddie and Luke probably can't help in a firefight.  Is there any other way we could use them?"),
            next_topic = "TALK_ISHERWOOD_CHRIS_RESCUE_BARRY_THE_ISHERWOODS",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_ISHERWOOD_CHRIS_TOPICS",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- Dialogue for this mission is handled externally.
ccb.content.define_mission {
    id = "MISSION_ISHERWOOD_CHRIS_1_GET_WALL_BAGS",
    name = ccb.content.text("Retrieve Canvas Bags for Chris"),
    goal = "MGOAL_NULL",
    difficulty = 1,
    value = 0,
    finish = { actions = { { handler = "start_isherwood_wall" } } },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    dialogue = {
        describe = ccb.content.text("."),
        offer = ccb.content.text("."),
        accepted = ccb.content.text("."),
        rejected = ccb.content.text("."),
        advice = ccb.content.text("."),
        inquire = ccb.content.text("."),
        success = ccb.content.text("."),
        success_lie = ccb.content.text("."),
        failure = ccb.content.text("."),
    },
}
