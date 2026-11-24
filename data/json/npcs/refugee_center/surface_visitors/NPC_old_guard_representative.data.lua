local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_npc {
    id = "old_guard_rep",
    suffix = ccb.content.text("Representative"),
    class = "NC_COWBOY",
    attitude = 0,
    mission = "GUARD",
    chat = "TALK_OLD_GUARD_REP",
    faction = "old_guard",
    missions_offered = "MISSION_OLD_GUARD_REP_1",
}

-- TODO: The rep should know whether you're actually a sworn officer: Wearing the badge without the trait => Bad idea
ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP",
    line = {
        when = predicates.has_any_trait("speaker", { "PROF_FED" }),
        yes = ccb.content.text("Marshal…"),
        no = ccb.content.text("Citizen…"),
    },
    replies = {
        {
            text = ccb.content.text("I'm trying to put a cleanup crew together to tidy up the back room.  Can you help?"),
            when = predicates.all({ predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"), predicates.negate(predicates.any_equal({ "yes", { scope = "interlocutor", key = "mission_Boris_mission_1_cleanup_asked" } })) }),
            trial = { kind = "persuade", difficulty = 15 },
            failure = { next_topic = "TALK_OLD_GUARD_REP_Refuse_Boris_Mission_1" },
            success = { next_topic = "TALK_OLD_GUARD_REP_Accept_Boris_Mission_1" },
        },
        { text = ccb.content.text("Who are you?"), next_topic = "TALK_OLD_GUARD_REP_NEW" },
        {
            text = ccb.content.text("Heard anything about the outside world?"),
            next_topic = "TALK_OLD_GUARD_REP_WORLD",
        },
        {
            text = ccb.content.text("Is there any way I can join the 'Old Guard'?"),
            next_topic = "TALK_OLD_GUARD_REP_ASK_JOIN",
        },
        {
            text = ccb.content.text("I've got some questions for you about those weird robots."),
            next_topic = "TALK_OLD_GUARD_REP_EXODII_1",
            when = predicates.any({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.any_equal({ "encountered_base", { scope = "speaker", key = "factional_questline_mission_oldguard-exodii" } }) }),
        },
        {
            text = ccb.content.text("I think I can already tell you what you want to know about those 'robots'."),
            next_topic = "TALK_OLD_GUARD_REP_MISSION_3_Predone",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }) }),
        },
        {
            text = ccb.content.text("Does the Old Guard need anything?"),
            next_topic = "TALK_MISSION_LIST",
        },
        {
            text = ccb.content.text("I wanted to ask you something about that offer."),
            when = predicates.all({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "found_sunken_helicopter" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } }) }),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_HUB",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            actions = { actions.set_actor_value("speaker", "sunken_helicopter_tip_offer", "yes") },
            when = predicates.all({ predicates.any_equal({ "yes", { scope = "speaker", key = "proven_worth_to_old_guard_representative" } }), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } })) }),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_0",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            when = predicates.any({ predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "proven_worth_to_old_guard_representative" } })), predicates.any_equal({ "yes", { scope = "speaker", key = "sunken_helicopter_tip_offer" } }) }),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_NEW",
    line = ccb.content.text("I'm the region's federal liaison.  Most people here call us the 'Old Guard' and I rather like the sound of it.  Despite how things currently appear, the federal government was not entirely destroyed.  After the outbreak I was chosen to coordinate civilian and militia efforts in support of military operations."),
    replies = {
        {
            text = ccb.content.text("So what are you actually doing here?"),
            next_topic = "TALK_OLD_GUARD_REP_NEW_DOING",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_OLD_GUARD_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_NEW_DOING",
    line = ccb.content.text("I ensure that the citizens here have what they need to survive and protect themselves from raiders.  Keeping some form of law is going to be the most important element in rebuilding the world.  We do what we can to keep the 'Free Merchants' here prospering and in return they have provided us with spare men and supplies when they can."),
    replies = {
        {
            text = ccb.content.text("Is there a catch?"),
            next_topic = "TALK_OLD_GUARD_REP_NEW_DOWNSIDE",
        },
        {
            text = ccb.content.text("Anything more to it?"),
            next_topic = "TALK_OLD_GUARD_REP_NEW_DOWNSIDE",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_OLD_GUARD_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_NEW_DOWNSIDE",
    line = ccb.content.gendered_line("Well… I was like any other civilian till they conscripted me so I'll tell it to you straight.  They're the best hope we got right now.  They are stretched impossibly thin but are willing to do what is needed to maintain order.  They don't care much about looters since they understand most everyone is dead, but if you have something they need… you WILL give it to them.  Since most survivors here have nothing they want, they are welcomed as champions.", { "interlocutor" }),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_WORLD",
    line = ccb.content.text("There isn't much pushed out by public relations that I'd actually believe.  From what I gather, communication between the regional force commands is almost non-existent.  What I do know is that the 'Old Guard' is currently based out of the 2nd Fleet and patrols the Atlantic coast trying to provide support to the remaining footholds."),
    replies = {
        {
            text = ccb.content.text("The 2nd Fleet?"),
            next_topic = "TALK_OLD_GUARD_REP_WORLD_2NDFLEET",
        },
        {
            text = ccb.content.text("Tell me about the footholds."),
            next_topic = "TALK_OLD_GUARD_REP_WORLD_FOOTHOLDS",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_OLD_GUARD_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_WORLD_2NDFLEET",
    line = ccb.content.text("I don't know much about how it formed but it is the armada of military and commercial ships that's floating off the coast.  They have everything from supertankers and carriers to fishing trawlers… even a few NATO ships.  Most civilians are offered a cabin on one of the liners to retire to if they serve as a federal employee for a few years."),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_WORLD_FOOTHOLDS",
    line = ccb.content.text("They may just be propaganda but apparently one or two cities were successful in 'walling themselves off.'  Around here I was told that there were a few places like this one but I couldn't tell you where."),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_ASK_JOIN",
    line = ccb.content.text("You can't actually join unless you go through a recruiter.  We can usually use help though, ask me from time to time if there is any work available.  Completing missions as a contractor is a great way to make a name for yourself among the most powerful men left in the world."),
    replies = { { text = ccb.content.text("Hmmm…"), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_EXODII_1",
    line = ccb.content.gendered_line("If you want to know what our next steps are, I'm not at liberty to tell you.  Truth be told, I don't even know myself.  They don't share that sort of information with me.", { "interlocutor" }),
    replies = {
        {
            text = ccb.content.text("Actually, I've met them.  They seem open to trade and things.  Thought you might want to know."),
            next_topic = "TALK_OLD_GUARD_REP_EXODII_2",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_EXODII_2",
    line = ccb.content.text("Well, that's interesting.  It's not something I'm in a position to do something about, but you might want to take that information to one of the teamsters for the Free Merchants.  Maybe that's a way we could establish some friendlier relationships."),
    replies = {
        { text = ccb.content.text("Good idea.  I'll go do that."), next_topic = "TALK_DONE" },
        {
            text = ccb.content.text("Huh, maybe.  <done_conversation_section>"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_MISSION_3_Predone",
    line = ccb.content.text("Oh, well.  In that case, I would be interested in hearing what you know about them.  I can relay it to command.  Let's see what I have to trade… how about some antibiotics from our stores?  You can never have too many of them out there."),
    replies = {
        {
            text = ccb.content.text("Yeah, I've met them.  They seem open to trade and things.  Not hostile, at least not to me."),
            next_topic = "TALK_OLD_GUARD_REP_EXODII_2",
            actions = { actions.handler("dlg_a_dda_0b1562fc78f3"), "mission_success", "clear_mission" },
        },
        {
            text = ccb.content.text("I'll have to think about it.  <done_conversation_section>"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
        {
            text = ccb.content.text("<end_talking_leave>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_Refuse_Boris_Mission_1",
    line = ccb.content.text("I'm sorry, but I can't leave my post here, and I just don't have the human resources even for a project like that."),
    on_enter = {
        {
            actions = {
                actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"),
            },
        },
    },
    replies = { { text = ccb.content.text("Well, thanks anyway."), next_topic = "TALK_OLD_GUARD_REP" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_Accept_Boris_Mission_1",
    line = ccb.content.text("It's your lucky day: I just made contact with a couple volunteers like yourself, and that's exactly the sort of project I can put them to."),
    on_enter = {
        { actions = { actions.set_actor_value("interlocutor", "mission_Boris_mission_1_cleanup_asked", "yes"), actions.handler("dlg_a_dda_70d7de14f9c9") } },
    },
    replies = {
        {
            text = ccb.content.text("Thanks, that's great news!"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_1",
    name = ccb.content.text("Kill Bandits"),
    description = ccb.content.text("A pair of bandits have been preying on locals, based out of a nearby cabin.  Ensure they meet a bitter end along with any associates, but watch out for traps around their hideout."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 5,
    value = 50000,
    start = {
        target = { terrain = "bandit_cabin", special = "bandit_cabin", reveal_radius = 1 },
        map_updates = {
            {
                layout = {
                    npc_placements = { { id = "bandit", x = 12, y = 12, target = true } },
                    tile_edits = {
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 7, y = 6 },
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 5, y = 5 },
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 8, y = 5 },
                        { shape = "point", operation = "trap", id = "tr_beartrap_buried", x = 0, y = 11 },
                    },
                },
            },
        },
    },
    finish = { handler = "mark_proven_worth_to_old_guard_representative" },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_2",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I don't like sending untested men into the field but if you have stayed alive so far you might have some skills.  There are at least a pair of bandits squatting in a local cabin, anyone who preys upon civilians meets a quick end… execute both of them for their crimes.  Complete this and the Old Guard will consider you an asset in the region."),
        accepted = ccb.content.text("Contractor, I welcome you aboard."),
        rejected = ccb.content.text("The States will remain a wasteland unless good men choose to save it."),
        advice = ccb.content.text("They might suspect you are coming, keep an eye out for traps."),
        inquire = ccb.content.text("Have you completed your mission?"),
        success = ccb.content.text("The Old Guard thanks you for eliminating the criminals.  You won't be forgotten."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_2",
    name = ccb.content.text("Deal with Informant"),
    description = ccb.content.text("The Hell's Raiders bandit group may have an informant working inside the Refugee Center.  Investigate and bring them to justice without arousing any suspicions."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 5,
    value = 50000,
    start = {
        map_updates = {
            {
                terrain = "evac_center_19",
                layout = { npc_placements = { { id = "evac_guard3", x = 12, y = 12, target = true } } },
            },
            {
                terrain = "evac_center_7",
                layout = { npc_placements = { { id = "scavenger_hunter", x = { 9, 15 }, y = { 9, 15 } } } },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_3",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("This task is going to require a little more persuasive skill.  I believe the Hell's Raiders have an informant here to monitor who comes and goes.  I need you to find out who it is and deal with them without letting anyone else know of my suspicions.  We normally allow the Free Merchants to govern themselves so I would hate to offend them."),
        accepted = ccb.content.text("Thank you, please keep this discreet."),
        rejected = ccb.content.text("Come back when you get a chance, we could use a few good men."),
        advice = ccb.content.text("If they draw first blood their friends are less likely to blame you…"),
        inquire = ccb.content.text("You deal with the rat?"),
        success = ccb.content.text("Thank you, I'll do the explaining if anyone else asks about it."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_3",
    name = ccb.content.text("Find Source of Robots"),
    description = ccb.content.text("Go to the supposed source of the weird robots marked on your map and report back to the Old Guard representative what you've seen."),
    goal = "MGOAL_CONDITION",
    difficulty = 2,
    value = 10000,
    start = {
        target = { terrain = "exodii_base_x0y3z0", special = "exodii_base", reveal_radius = 5 },
        handler = "set_world_old_guard_rep_scouting_to_1",
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_4",
    dialogue = {
        describe = ccb.content.text("Got a weird one for you this time…"),
        offer = ccb.content.text("I don't usually hear much from command, but we got a message by radio recently.  You might be the right choice to look into it for me.  There've been reports of weird robots and things wandering around since things went south.  Dunno how, but apparently command tracked down what they think is the source.  They want someone to go check out who is making these, and if we can get any tech or assistance from them.  This is strictly recon, you understand: could be a hostile entity, so do not engage directly.  Report back to me when you've found out something."),
        accepted = ccb.content.text("Thanks, once you know who it is, report back to me and I'll pass that on."),
        rejected = ccb.content.text("Come back when you get a chance, if there's any chance these things are on our side, we need all the help we can get."),
        advice = ccb.content.text("If you see any weird machines around, do not engage.  Sneak away, I'd say.  They seem to be hostile to zombies, but that doesn't mean they can tell you aren't one."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great work, wasn't sure what I was sending you after."),
        success_lie = ccb.content.text("That's a shame, a damn shame.  Wish you could have learned more.  Thanks for trying."),
        failure = ccb.content.text("Damn… let's hope we can try again sometime."),
    },
    finish = { handler = "set_factional_questline_mission_oldguard-exodii_to_encountered_base" },
    complete_when = "complete_mission_old_guard_rep_3",
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_4",
    name = ccb.content.text("Secure Trade Route"),
    description = ccb.content.text("One of the Free Merchants silently disappeared while escorting a trade caravan.  Whoever or whatever is responsible must be quick and quiet - investigate the trade route and eliminate the threat."),
    goal = "MGOAL_KILL_MONSTER",
    difficulty = 5,
    value = 100000,
    start = {
        target = { terrain = "field", reveal_radius = 5, random = true, search_range = 30 },
        map_updates = {
            {
                layout = {
                    monster_placements = {
                        {
                            id = "mon_spider_trapdoor_small",
                            x = 12,
                            y = 12,
                            target = true,
                            repetitions = { 3, 5 },
                        },
                    },
                },
            },
        },
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REP_5",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("There is another monster troubling the merchants but this time it isn't human… at least I don't think.  Guy just disappeared while walking behind a packed caravan.  They didn't hear any shots but I suppose some raider may have been real sneaky.  Check out the area and report anything you find."),
        accepted = ccb.content.text("Thanks, keeping the people safe is what we try and do."),
        rejected = ccb.content.text("Come back when you get a chance, we really need to start reclaiming the region."),
        advice = ccb.content.text("Search the bushes for any trace?  I'm not an expert tracker but you should be able to find something."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Great work, wasn't sure what I was sending you after."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REP_5",
    name = ccb.content.text("Assassinate Raider Leader"),
    description = ccb.content.text("The Old Guard have located a Hell's Raiders encampment that is coordinating attacks on the Free Merchants.  Pay them a visit and execute the area leadership."),
    goal = "MGOAL_ASSASSINATE",
    difficulty = 10,
    value = 300000,
    start = {
        target = { terrain = "bandit_camp_1", special = "bandit_camp", reveal_radius = 1, min_distance = 10 },
        map_updates = { { layout = { npc_placements = { { id = "bandit", x = 17, y = 9, target = true } } } } },
        item_rewards = {
            { item = "sw629" },
            { item = "44magnum", count = 17 },
            { item = "western_holster" },
            { item = "badge_marshal" },
        },
        handler = "become_prof_fed",
    },
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REPEATER_BEGIN",
    dialogue = {
        describe = ccb.content.text("We need help…"),
        offer = ccb.content.text("I've located a Hell's Raiders encampment in the region that appears to be coordinating operations against the Free Merchants.  We know almost nothing about the command structure in the 'gang' so I need to send someone in to decapitate the leadership.  The raid will be held under orders of the U.S. Marshals Service and by agreeing to the mission you will become a marshal, swearing to assist the federal government in regaining order."),
        accepted = ccb.content.text("Now repeat after me… I do solemnly swear that I will support and defend the Constitution of the United States against all enemies, foreign and domestic… that I will bear true faith and allegiance to the same… that I take this obligation freely, without any mental reservation or purpose of evasion… and that I will well and faithfully discharge the duties of the office on which I am about to enter.  To establish justice, insure domestic tranquility, provide for the common defense, promote the general welfare and secure the blessings of liberty.  So help me God.  Congratulations Marshal, don't forget your badge and gun.  As a marshal all men or women assisting you are considered deputy marshals so keep them in line."),
        rejected = ccb.content.text("Come back when you get a chance, we could use a few good men."),
        advice = ccb.content.text("I'd recommend having two deputies… it would be a death trap if a single man got surrounded."),
        inquire = ccb.content.text("Has the leadership been dealt with?"),
        success = ccb.content.text("Marshal, you continue to impress us.  We may have some hope of long term survival yet thanks to you."),
        success_lie = ccb.content.text("What good does this do us?"),
        failure = ccb.content.text("It was a lost cause anyways…"),
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REPEATER_BEGIN",
    name = ccb.content.text("Install radio repeater mod"),
    description = ccb.content.text("The Old Guard wishes to expand their range of communications to get in touch with other survivors in the Wasteland.  Find a Radio Station and install a repeater mod via its terminal."),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 5,
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REPEATER",
    dialogue = {
        describe = ccb.content.text("I don't need anything major for now, Marshal.  Well, except…"),
        offer = ccb.content.text("For now, the perimeter of the Refugee Center is free of threats.  That means we can afford to divert our attention to others in need of help.  However, our communication with the wasteland is lacking at best and nonexistent at worst.  We need to broaden our reach to intercept and send radio broadcasts.  Unfortunately Radio Towers are out of the question to widen our broadcasts, as the emergency grid for them is out of action.  However, Radio Stations in towns or urban areas should still have some juice left.  I want you to install something called a \"radio repeater mod\" in these stations that can broaden their reach and allow them to pick weaker signals.  Sadly, I have neither these devices nor a manual for them at my disposal.  You'll need to find instructions and assemble them yourself.  Are you up for this task?"),
        accepted = ccb.content.text("As I said, I have no repeaters or manuals at my disposal.  But you might want to try you chances in Libraries or maybe other survivors.  Godspeed, Marshal."),
        rejected = ccb.content.text("Come back when you get a chance Marshal.  We really need get in touch with rest of the region."),
        advice = ccb.content.text("As I recommended, libraries would be a good start.  Or any place that sells books and manuals, really."),
        inquire = ccb.content.text("Have you set up a repeater yet, Marshal?"),
        success = ccb.content.text("Thank you for the good work, Marshal.  It's not much but please accept these supplies to compensate.  Come back to me if you are willing to install more."),
        success_lie = ccb.content.text("Huh; that's weird, the boys at comms say that they didn't really see an improvement.  Well, if you want to try again, come to me.  Maybe this time it'll work."),
        failure = ccb.content.text("That's a damn shame…  You can come back anytime if you want to try again."),
    },
    finish = {
        item_rewards = {
            { item = "jerky", count = 5, container = "bag_plastic" },
            { item = "water_clean", count = 8, container = "bottle_twoliter" },
            { item = "bandages", count = 5 },
            { item = "9mmP", count = 15, container = "box_small" },
            { item = "9mmfmj", count = 15, container = "box_small" },
            { item = "9mm", count = 30, container = "box_small" },
            { item = "556", count = 60, container = "box_small" },
            { item = "FMCNote", count = 25 },
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_OLD_GUARD_REPEATER",
    name = ccb.content.text("Install radio repeater mod"),
    description = ccb.content.text("The Old Guard wishes to expand their range of communications to get in touch with other survivors in the Wasteland.  Find a Radio Station and install a repeater mod via its terminal."),
    goal = "MGOAL_COMPUTER_TOGGLE",
    difficulty = 5,
    value = 5000,
    origins = { "ORIGIN_SECONDARY" },
    generic_rewards = false,
    followup = "MISSION_OLD_GUARD_REPEATER",
    dialogue = {
        describe = ccb.content.text("We need more help…"),
        offer = ccb.content.text("We need more repeaters to expand our range and ability of our communications.  You know the drill Marshal, find or assemble a radio repeater mod and set it up in a Radio Station.  Radio Towers are still off the table."),
        accepted = ccb.content.text("Stay safe, Marshal."),
        rejected = ccb.content.text("Come back when you get a chance Marshal.  We really need get in touch with rest of the region."),
        advice = ccb.content.text("You can find the Radio Stations in towns or urban centers.  I still have no repeater mod available Marshal.  However you can craft one yourself, if you find the manual.  Try libraries or bookstores if you still don't have one."),
        inquire = ccb.content.text("Have you set up a repeater yet, Marshal?"),
        success = ccb.content.text("Good work, Marshal.  Here's some supplies for your next venture.  Come back to me if you are willing to install more."),
        success_lie = ccb.content.text("Huh, that's weird, the boys at comms say that they didn't really see an improvement.  Well, if you want to try again, come to me.  Maybe this time it'll work."),
        failure = ccb.content.text("Oh well, you can try again anytime."),
    },
    finish = {
        item_rewards = {
            { item = "jerky", count = 5, container = "bag_plastic" },
            { item = "water_clean", count = 8, container = "bottle_twoliter" },
            { item = "bandages", count = 5 },
            { item = "9mmP", count = 15, container = "box_small" },
            { item = "9mmfmj", count = 15, container = "box_small" },
            { item = "9mm", count = 30, container = "box_small" },
            { item = "556", count = 60, container = "box_small" },
            { item = "FMCNote", count = 25 },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_0",
    line = ccb.content.text("Wait.  Before you go, I got an offer for you if you're interested."),
    replies = {
        {
            text = ccb.content.text("What is it?"),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_1",
        },
        { text = ccb.content.text("Maybe later."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_HUB",
    line = ccb.content.text("I'm listening."),
    replies = {
        {
            text = ccb.content.text("Tell me about it."),
            when = predicates.negate(predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER")),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_1",
        },
        {
            text = ccb.content.text("Anything else I should know?"),
            when = predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER"),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_DANGER",
        },
        {
            text = ccb.content.text("Tell me about the cargo."),
            when = predicates.has_mission("MISSION_FIND_SUNKEN_HELICOPTER"),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0",
        },
        { text = ccb.content.text("Never mind…"), next_topic = "TALK_NONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_1",
    line = ccb.content.text("A helicopter crashed in the region not long ago, at first I thought it was just a rumor, caravan guards talking about some crash nearby, but then I got a visit from a couple of Old Guard people looking for a lost helicopter, one of them got quite drunk one night and shared some interesting details, turns out it was an Old Guard heli coming back from way out west with quite the cargo, and I know where you can find it.  That's all you're getting for free though, I'd like to see some return on investment on that bottle you understand."),
    replies = {
        {
            text = ccb.content.text("I'm not buying anything without some proof."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_PROOF",
        },
        {
            text = ccb.content.text("Why sell the info instead of retrieving the cargo yourself?  What happened to the old guard investigation?  How can you be sure that it wasn't looted already?  This sounds sketchy as hell."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_SKETCHY",
        },
        {
            text = ccb.content.text("[50 merch] Fine."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_2",
            when = predicates.has_inventory("speaker", "FMCNote", 50),
            actions = { actions.transfer_items("FMCNote", 50), actions.assign_mission("MISSION_FIND_SUNKEN_HELICOPTER") },
            failure_topic = "TALK_DONE",
            failure_explanation = ccb.content.text("You don't have enough."),
        },
        {
            text = ccb.content.text("Never mind…"),
            next_topic = "TALK_OLD_GUARD_REP",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_PROOF",
    line = ccb.content.text("&He crosses his arms.  \"Fine.  Go talk to the guards, that crash was all the talk among them for a while.  Look, I'm not trying to do you over, I wouldn't risk my reputation and my job for a handful of cash, feel free to tell everyone in the center that I'm a liar sending people to their death for a quick buck if you find out that I lied.\""),
    replies = { { text = ccb.content.text("I see…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_SKETCHY",
    line = ccb.content.text("&He sighs.  \"Well, let's just say that the location of the helicopter doesn't make the retrieval of the cargo…trivial.  Apparently the higher-ups at the Old Guard agreed that it was too hard and too far to be worth.  It wasn't transporting Jesus, just valuable cargo.\""),
    replies = { { text = ccb.content.text("I see…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_DANGER",
    line = ccb.content.text("Yes actually.  The scout told me that he saw something weird down at the lake.  Translucent shapes swimming close to the surface from time to time.  I'm sure it has something to do with the weird storm that brought the helicopter down."),
    replies = { { text = ccb.content.text("I see…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_2",
    line = ccb.content.text("Alright, give me your map I'll show you the location."),
    replies = {
        {
            text = ccb.content.text("I had other questions."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_HUB",
        },
        { text = ccb.content.text("Thanks."), next_topic = "TALK_OLD_GUARD_REP" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0",
    line = ccb.content.text("The cargo?  That's the kind of optional information worth a small supplement."),
    replies = {
        {
            text = ccb.content.text("This wasn't the deal and you're starting to wear my nerves thin asshole, tell me or I'll make you pick your teeth off the floor."),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "failed_representative_cargo_trial" } })),
            trial = { kind = "intimidate", difficulty = 50, modifiers = { { score = "FEAR", scale = 2 }, { score = "TRUST", scale = -2 } } },
            success = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1" },
            failure = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_INTIMIDATE_FAILURE", actions = { actions.set_actor_value("speaker", "failed_representative_cargo_trial", "yes") }, opinion = { trust = -1 } },
        },
        {
            text = ccb.content.text("Come on, you already got what you wanted, are you really trying to fleece me?"),
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "failed_representative_cargo_trial" } })),
            trial = { kind = "persuade", difficulty = 50, modifiers = { { score = "FEAR", scale = -2 }, { score = "TRUST", scale = 2 } } },
            success = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1" },
            failure = { next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_PERSUADE_FAILURE", actions = { actions.set_actor_value("speaker", "failed_representative_cargo_trial", "yes") } },
        },
        {
            text = ccb.content.text("[25 merch] This better be worth."),
            next_topic = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1",
            when = predicates.has_inventory("speaker", "FMCNote", 25),
            actions = { actions.transfer_items("FMCNote", 25) },
            failure_topic = "TALK_DONE",
            failure_explanation = ccb.content.text("You don't have enough."),
        },
        {
            text = ccb.content.text("Never mind…"),
            next_topic = "TALK_NONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_INTIMIDATE_FAILURE",
    line = ccb.content.text("& He tenses and grits his teeth for a moment before regaining his composure.  \"No, we both know you won't.  Let's pretend this never happened, offer's still up.\""),
    replies = { { text = ccb.content.text("Fine…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_0_PERSUADE_FAILURE",
    line = ccb.content.text("What are you talking about, I'm not \"fleecing\" anyone, you're free to make the retrieval with the information you have, all I'm offering is purely optional information for a reasonable price."),
    replies = { { text = ccb.content.text("Fine…"), next_topic = "TALK_NONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_OLD_GUARD_REP_SUNKEN_HELICOPTER_CARGO_1",
    line = ccb.content.text("Fine.  The heli was transporting a few sets of those combat exoskeletons back from a DoubleTech testing site way out west, the ones they were showing on TV before all this, I'm sure a guy like you could put those to good use.  I won't risk my life for one but if you succeed and would like to trade them you know where to find me."),
    replies = {
        {
            text = ccb.content.text_without_extraction("<end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_mission {
    id = "MISSION_FIND_SUNKEN_HELICOPTER",
    name = ccb.content.text("Find the sunken helicopter"),
    description = ccb.content.text("You got the location of a sunken helicopter, all that's left to do is find a way to get there."),
    goal = "MGOAL_GO_TO",
    value = 0,
    difficulty = 0,
    start = { target = { terrain = "sunken_helicopter", special = "sunken_helicopter", reveal_radius = 5 } },
    finish = { handler = "mark_eoc_sample_item_transporter_set_coordinates" },
    origins = { "ORIGIN_NULL" },
    invisible_on_complete = true,
}
