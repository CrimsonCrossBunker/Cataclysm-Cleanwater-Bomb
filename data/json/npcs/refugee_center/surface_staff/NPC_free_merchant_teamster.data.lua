local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc_class {
    id = "NC_TEAMSTER",
    name = ccb.content.text("Scavenger"),
    job_description = ccb.content.text("I'm just trying to survive."),
    traits = {
        { group = "BG_survival_story_EVACUEE" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
        { trait = "IGNORE_SOUND" },
        { trait = "NO_BASH" },
        { trait = "RETURN_TO_START_POS" },
    },
    common = false,
    skills = {
        { skill = "ALL", level = { sum = { { dice = { 3, 2 } }, { constant = -3 } } } },
        { skill = "gun", bonus = { rng = { 2, 4 } } },
        { skill = "pistol", bonus = { rng = { 2, 5 } } },
        { skill = "rifle", bonus = { rng = { 0, 3 } } },
        { skill = "archery", bonus = { rng = { 0, 3 } } },
    },
}

ccb.content.define_npc {
    id = "evac_teamster",
    suffix = ccb.content.text("Teamster"),
    class = "NC_TEAMSTER",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_FREE_MERCHANT_TEAMSTER",
    faction = "free_merchants",
    on_death = "godco_trader_mission_deathfail",
}

-- initial greeting
ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER",
    line = {
        when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_teamster" } }),
        yes = ccb.content.text("What can I help you with?"),
        no = ccb.content.text("Well now, a new face.  Nice ta meet ya.  I'm the one sendin' out these here caravans far and wide.  What can I do ya for?"),
    },
    replies = {
        {
            text = ccb.content.text("Can I ask you some questions?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_teamster", "yes") },
        },
        {
            text = ccb.content.text("I've gotta run, nice talking to you."),
            next_topic = "TALK_DONE",
            actions = { actions.set_actor_value("speaker", "general_meeting_u_met_teamster", "yes") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
    line = ccb.content.text("Sure, got nothin' to load up just now."),
    replies = {
        {
            text = ccb.content.text("I've gotta run, nice talking to you."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS",
    line = {
        when = predicates.handler("dlg_p_dda_93de4f1e1331"),
        yes = ccb.content.text("No, sorry.  Nothin' much worth notin' out there these days, just the odd scattered survivor and they usually don't want random visitors."),
        no = {
            when = predicates.handler("dlg_p_dda_2fad9a32b6ea"),
            yes = ccb.content.text("Matter of fact, yeah.  Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
            no = {
                when = predicates.handler("dlg_p_dda_ffef735f5e6b"),
                yes = ccb.content.gendered_line("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it.  I haven't seen it myself, mind you.", { "interlocutor" }),
                no = {
                    when = predicates.handler("dlg_p_dda_c854bbaab2c0"),
                    yes = ccb.content.text("Well, a few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
                    no = {
                        when = predicates.handler("dlg_p_dda_aea23a04550e"),
                        yes = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
                        no = ccb.content.text("ERROR: out of bounds on randomize_directions."),
                    },
                },
            },
        },
    },
    replies = {
        {
            text = ccb.content.text("How do I get to that farm?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_a1b66fb7c4f1"),
            actions = { actions.assign_mission("directions_isherwood") },
            switch = true,
        },
        {
            text = ccb.content.text("How do I get to that lab?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_873376a17718"),
            actions = { actions.assign_mission("directions_hub01") },
            switch = true,
        },
        {
            text = ccb.content.text("How do I get to that castle?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_a2718e906bff"),
            actions = { actions.assign_mission("directions_exodii") },
            switch = true,
        },
        {
            text = ccb.content.text("Where was that?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
            when = predicates.handler("dlg_p_dda_09f33bbde74b"),
            actions = { actions.assign_mission("directions_artisans") },
            switch = true,
        },
        {
            text = ccb.content.text("Ah, that's nothing new to me.  Thanks anyway though."),
            next_topic = "TALK_DONE",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Hold on, what were you saying before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS_2",
    line = ccb.content.text("*shows you on your map where to find it.  \"That should get you there.  Good luck, I 'spect you'll need it.\""),
    replies = {
        {
            text = ccb.content.text("Thanks for the directions.  I'll check it out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_MISSION_WAREHOUSE",
    line = {
        joined = {
            ccb.content.text("&You describe the warehouse to the best of your ability.  The teamster considers for a moment"),
            {
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            yes = ccb.content.gendered_line(", then frowns.  \"I don't believe I've heard about anything like that, no.  Sorry.\"", { "interlocutor" }),
            no = ccb.content.gendered_line(", looking thoughtful.  \"Hmm.  I'm not sure, but I've heard of an odd building that's a bit like you're describing.\"", { "interlocutor" }),
        },
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "asked_about_exodii_warehouse_mission", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("Oh well.  Thanks anyway.  I'll go ask around."),
            next_topic = "TALK_DONE",
            when = predicates.any_equal({ "no", { scope = "interlocutor", key = "exodii_mission_wh_correct" } }),
            actions = { actions.handler("dlg_a_dda_399f0cdb5f50") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_FACTION_INTRO",
    line = ccb.content.text("Always lookin' for new places to trade.  What you got for me?"),
    replies = {
        {
            text = ccb.content.text("[Tell them about Rubik and the Exodii.]"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_1",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
        {
            text = ccb.content.text("Hold on, what were you saying before?"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_later>"),
            next_topic = "TALK_DONE",
        },
    },
}

-- In the future this should start a quest line or allow free merchant caravans to sometimes show up near the Exodii base.
ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_1",
    line = ccb.content.text("Well now, that's a hell of a story.  Some day, I'll see if we can get out there an' look into it.  Sounds like there'd be some real interestin' trade."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Boris_Mission_1",
    line = ccb.content.gendered_line("Yeah, I'll help out.  I've pretty much been waiting for someone to ask, the mess is in my way but I've been too busy to organize it myself.  Boris is the one to talk to, you say?  I'll let him know.", { "interlocutor" }),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_1771a2e9be11") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks so much!  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("Thanks so much!  I have to go ask a few others, talk to you later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader",
    line = ccb.content.gendered_line("Oh yeah, they're my rookie representative.  I figured that those people wouldn't cause too much trouble for them, so I sent them over there.  What about them?", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("I think they're gouging the prices for the people living there."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Pricegouge",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Pricegouge",
    line = ccb.content.text("Is that so?  What makes you think that?  My accounting reports have come back clean, just like everybody else."),
    replies = {
        {
            text = ccb.content.text("Everything they sell I can buy for twice as less here, even a box of crackers is an arm and a leg."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Investigation_Mission",
        },
        {
            text = ccb.content.text("I guess you guys are a bunch of thieves if you charge that much."),
            next_topic = "TALK_DONE",
            opinion = { anger = 2 },
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Investigation_Mission",
    line = ccb.content.text("Tell you what, if you can find some sort of evidence that proves they're shafting customers and bring it to me, I'll send someone to look in to it."),
    replies = {
        {
            text = ccb.content.text("Alright, you have yourself a deal."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What sort of \"evidence\" did you have in mind?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Type",
        },
        {
            text = ccb.content.text("Why do you want me to do it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
    line = ccb.content.text("Look, I have limited manpower these days, and not everyone can go off of a strangers word with no supporting evidence."),
    replies = {
        {
            text = ccb.content.text("Makes sense, I'll find you some evidence."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("What sort of \"evidence\" did you have in mind?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Type",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("Forget it, since you're not interested in taking this seriously."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Type",
    line = ccb.content.text("I guess sales records could work, or stock lists of inventory that give a discrepancy between what's sold and what money comes in."),
    replies = {
        {
            text = ccb.content.text("I'll get right to it, see you later."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Who would have these sorts of things?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Who",
        },
        {
            text = ccb.content.text("Why do you want me to do it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("<end_talking_later>  <end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Evidence_Who",
    line = ccb.content.text("Well, there's somebody else who works there, handles all of the money management.  I'd look into them first, should be in the same spot the other guy is."),
    replies = {
        {
            text = ccb.content.text("Makes sense, I'll get right to it."),
            actions = { actions.assign_mission("MISSION_INVESTIGATE_TRADER") },
            next_topic = "TALK_DONE",
        },
        {
            text = ccb.content.text("Why do you want me to do it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_DoItYourself",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_CHAT",
        },
        {
            text = ccb.content.text("I'm not doing any of this legwork for you, figure it out on your own."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Success",
    line = ccb.content.text("*looks over the papers for a moment, before pocketing them.  \"I'd say this is sufficient, here's some money for your trouble.  I'll get somebody on this.\""),
    replies = {
        {
            text = ccb.content.text("Glad to help."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_8224d2ff1410"), actions.clear_actor_value("speaker", "general_trade_u_think_suspicious_price"), actions.handler("dlg_a_dda_9d4a5a864597"), actions.transfer_items("godcotrader_accounting_records_dirty") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Fail",
    line = ccb.content.text("*looks over the papers for a moment, before pocketing them.  \"This seems perfectly alright to me.  I don't know what you have against them, but give it up and quit wasting our time.\""),
    replies = {
        {
            text = ccb.content.text("Alright then, <name_b>.  I guess that's what I get for my troubles."),
            next_topic = "TALK_DONE",
            actions = { actions.clear_actor_value("speaker", "general_trade_u_think_suspicious_price"), actions.finish_mission("MISSION_INVESTIGATE_TRADER", { success = false }), actions.transfer_items("godcotrader_accounting_records_clean") },
        },
    },
}

ccb.content.define_mission {
    id = "directions_isherwood",
    name = ccb.content.text("Check out that farm"),
    description = ccb.content.text("Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Isherwood Farm Mutable", terrain = "farm_isherwood_1", reveal_radius = 5 },
        handler = "set_teamster_mission_directions_to_isherwood",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
        offer = ccb.content.text("Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
        accepted = ccb.content.text("Nice."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Be careful.  It's rough out there."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("It is what it is."),
    },
}

ccb.content.define_mission {
    id = "directions_hub01",
    name = ccb.content.text("Check out that lab"),
    description = ccb.content.text("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "hub_01", terrain = "robofachq_surface_entrance", reveal_radius = 5 },
        handler = "set_teamster_mission_directions_to_hub01",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it."),
        offer = ccb.content.text("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it."),
        accepted = ccb.content.text("Nice."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Be careful.  It's rough out there."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("It is what it is."),
    },
}

ccb.content.define_mission {
    id = "directions_exodii",
    name = ccb.content.text("Check out that scrap metal castle"),
    description = ccb.content.text("A few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { terrain = "exodii_base_x0y3z0", special = "exodii_base", reveal_radius = 5 },
        handler = "set_teamster_mission_directions_to_exodii",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("A few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
        offer = ccb.content.text("A few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
        accepted = ccb.content.text("Your funeral."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("Seems reasonable."),
    },
}

ccb.content.define_mission {
    id = "directions_artisans",
    name = ccb.content.text("Check out that bullet bank"),
    description = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea, but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "isolated_road", terrain = "isolated_house_farm_gunsmith", reveal_radius = 2 },
        handler = "set_teamster_mission_directions_to_artisans",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea, but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
        offer = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea, but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
        accepted = ccb.content.text("Hopefully they are still around."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Don't worry about the turrets they seem friendly to people."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("Seems reasonable."),
    },
}

ccb.content.define_dialogue_topic {
    id = { "TALK_FREE_MERCHANT_TEAMSTER_CHAT" },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Boris_Mission_1",
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
        },
        {
            text = ccb.content.text("So, have your caravans seen anything interesting out there in the wasteland?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS",
            when = predicates.handler("w16b_p_dda_8fcd96d5462f"),
            actions = { actions.handler("w16b_a_dda_6f156aa98a67") },
            switch = true,
        },
        {
            text = ccb.content.text("So, have your caravans seen anything interesting out there in the wasteland?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_DIRECTIONS",
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("I'm looking for a specific, strange building.  I wonder if you've heard anything about it?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_EXODII_MISSION_WAREHOUSE",
            when = predicates.all({ predicates.has_mission("EXODII_MISSION_WAREHOUSE"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "asked_about_exodii_warehouse_mission" } })) }),
            actions = { actions.handler("w16b_a_dda_9812bef589e2") },
        },
        {
            text = ccb.content.text("Do you know anything about a trader near the New England Church Community, claims to be from here?"),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader",
            when = predicates.handler("w16b_p_dda_eab15290189e"),
        },
        {
            text = ccb.content.text("I think I've got the evidence you were looking for."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Success",
            when = predicates.handler("w16b_p_dda_62e742a59346"),
        },
        {
            text = ccb.content.text("I think I've got the evidence you were looking for."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Fail",
            when = predicates.handler("w16b_p_dda_9a64a4490965"),
        },
        {
            text = ccb.content.text("I wanted to tell you about a potential new trading partner I met recently."),
            next_topic = "TALK_FREE_MERCHANT_TEAMSTER_FACTION_INTRO",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
    },
}
