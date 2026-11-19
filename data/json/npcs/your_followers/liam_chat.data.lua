local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_hasskills",
    line = ccb.content.text("Maybe?  It's hard to say without seeing the machine, but I know my way around enough to at least try."),
    replies = {
        {
            text = ccb.content.text("Gotcha.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills_noskills",
    line = ccb.content.text("What?  Me?  Dismantle a *robot*?  I love that you've got this kind of faith in me, my friend, but my contribution here is going to be a lot more smashy-smashy, less thinky-thinky."),
    replies = {
        {
            text = ccb.content.text("Gotcha.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
    line = ccb.content.text("*stares at you for a moment.  \"Remember when we were kids, and that huge storm hit?  I thought it was a hurricane, and we ran outside, and that tree fell down like just down the road, and smashed that guy's car?\"  He grins.  \"That was awesome.  Let's do that again!\""),
    replies = {
        {
            text = ccb.content.text("Let's hope it's not *our* car getting smashed this time.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
    line = ccb.content.text("Yo dawg, we heard you like science labs.\"  He grins.  \"My guess is there's gonna be some serious defenses in there.  We should stick together, and make sure we've got our best gear."),
    replies = {
        {
            text = ccb.content.text("Agreed.  Don't go running around a corner and eating turret fire.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_BEM_jabberwock_mission",
    line = ccb.content.text("I'm always a fan of a good monster hunt.  Anything that could shake up a merc like that is gonna be pretty serious business, though.  We better pack some heat.  Probably something we can use to take it on at range, I'm not keen to go toe-to-toe with something like that."),
    replies = {
        {
            text = ccb.content.text("That's your advice for everything.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_BEM_human_sample_mission",
    line = ccb.content.text("Yes, it does,\" he admits.  \"I'm not the one that took the job though.  Let's maybe get it from a feral though, right?  Not some hapless dork?"),
    replies = {
        {
            text = ccb.content.text("Right… Right.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
    line = ccb.content.text("There were a lot of private research centers in this part of the world.  I bet we could raid one of them.  It seems like the kind of thing that might be in a hospital, too."),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
    line = ccb.content.text("I guess, but the chemisty seemed to know about it.  Maybe it's easier to find it big bottles in some place they keep chemistry supplies.  Come to think of it, were there some back where we got the chemisty set?"),
    replies = {
        {
            text = ccb.content.text("I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_500_GAS",
    line = ccb.content.text("I think the biggest trick is just storing it.  That's 25 gallons, right?  I'm pretty sure we can get that much by siphoning from a bunch of cars, no big problem there, but it's a lot to carry around.  Maybe we could clean out a couple dozen milk jugs?"),
    replies = {
        {
            text = ccb.content.text("We'll think of something.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_not_met_smokes",
    line = ccb.content.text("It sounds like a hell of a road trip, getting to a place like that, but I think it's a great idea to check it out.  If all the evac shelters point to it, there could be some more survivors there."),
    replies = {
        {
            text = ccb.content.text("We'll see soon enough.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_has_met_smokes",
    line = ccb.content.text("Well, you know what Smokes is gonna say.  'No room at the refugee center, not even for a skilled chemist.'  I bet they'll be willing to set up a trade route or something, though."),
    replies = {
        {
            text = ccb.content.text("We'll see soon enough.  I'd like your opinion on something else."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_chef",
    line = ccb.content.text("*rubs his chin.  \"Mmmaaaybe?  What kind of chef?  I worked as a dishwasher in a fancy place for a couple months.  If they're a line chef, then yes.  Sous-chef or above?  Leave 'em for the zombies.\"  He pauses, staring into space for a moment.  \"I hated that job.\""),
    replies = {
        {
            text = ccb.content.text("Duly noted.  I'd like your opinion on something else, though."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_farmer",
    line = ccb.content.text("Seems like a good idea to me.  If they're alive, then we meet some new people, that's always fun.\"  He hesitates.  \"Well, it used to always be fun.  New people are a bit scarier these days.  But still, as a general rule, I'm a fan.  Anyway, if they're not alive, then we clear 'em out and we have a farm of our very own.  It's win-win, as long as none of us gets devoured by an undead menace."),
    replies = {
        {
            text = ccb.content.text("Well summarized.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_hospital_2_CABIN",
    line = ccb.content.text("We could if you want.  I got complex feelings about prepper cabins in the woods, obviously.  As far as loot goes though, they're pretty top tier, and low-risk.  Maybe we'll find a nice bow.  Or like, guns or whatever.  Or a bow!"),
    replies = {
        {
            text = ccb.content.text("You and your death springs.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_prepper_1_SHELTER",
    line = ccb.content.text("Fuck yeah we should.  Usually I'd be all, 'be careful my friend, preppers leave traps 'n shit', but in this case we have said prepper's word on the matter.  We could be running our operation from a cozy, well protected bunker!  What are we waiting for?"),
    replies = {
        {
            text = ccb.content.text("Thanks for the enthusiasm.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions_directions_rural_1_FARM",
    line = ccb.content.text("Normally I'd say something about needing to be careful, blah blah, and that's all true, but we're doing this for a friend, so I'm way more keen.  Let's help out our new pal.  The three of us can handle this, right?"),
    replies = {
        {
            text = ccb.content.text("Right on.  I'd like your opinion on something else, actually."),
            next_topic = "TALK_Liam_Opinions",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = {
        "TALK_Liam_Opinions_MISSION_REACH_REFUGEE_CENTER",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_1",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2-1",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_3",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_4",
        "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_5", "TALK_Liam_Opinions_MISSION_BROKER_1",
        "TALK_Liam_Opinions_MISSION_EVAC_SMOKER_GET_CIGARETTES",
        "TALK_Liam_Opinions_directions_isherwood", "TALK_Liam_Opinions_directions_hub01",
        "TALK_Liam_Opinions_directions_exodii", "TALK_Liam_Opinions_directions_artisans",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_SMALL", "TALK_Liam_Opinions_MISSION_BEGGAR_2_DUCT_TAPE",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_MEDIUM",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_PLASTIC_SHEET",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_LARGE",
        "TALK_Liam_Opinions_MISSION_BEGGAR_2_PERMISSION", "TALK_Liam_Opinions_MISSION_SCIENCE_REP_1",
        "TALK_Liam_Opinions_MISSION_SCIENCE_REP_2", "TALK_Liam_Opinions_MISSION_SCIENCE_REP_3",
        "TALK_Liam_Opinions_MISSION_SCIENCE_REP_4", "TALK_Liam_Opinions_MISSION_SCIENCE_REP_5",
        "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_1", "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_2",
        "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_3", "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_4",
        "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_5",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Reassure",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Bravado",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Fortunecookie",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1-Psycho",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_2",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-NotMet",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-HasMet",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_4", "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_5",
        "TALK_Liam_Opinions_MISSION_OLD_GUARD_REPEATER_BEGIN",
        "TALK_Liam_Opinions_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Alonso_pants",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_CLEANUP",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_WORKSPACE",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_LAPTOP",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Dana_Sourdough",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Draco_GET_GUITAR",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Fatima_1",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_MOTOR",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TANK",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXT",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode2",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_1", "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_2",
        "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_3", "TALK_Liam_Opinions_MISSION_REFUGEE_Vanessa_1",
        "TALK_Liam_Opinions_MISSION_TACOMA_Nunez", "TALK_Liam_Opinions_directions_exodii_signpost",
        "TALK_Liam_Opinions_RUBIK_ANUS_FETICK-1", "TALK_Liam_Opinions_EXODII_MISSION_CONTACT_HUB",
        "TALK_Liam_Opinions_EXODII_MISSION_WAREHOUSE", "TALK_Liam_Opinions_MISSION_pizzaiolo_1-chill",
        "TALK_Liam_Opinions_MISSION_pizzaiolo_1-yeah", "TALK_Liam_Opinions_MISSION_pizzaiolo_2",
        "TALK_Liam_Opinions_MISSION_pizzaiolo_3", "TALK_Liam_Opinions_MISSION_pizzaiolo_4",
        "TALK_Liam_Opinions_MISSION_pizzaiolo_4-slice", "TALK_Liam_Opinions_MISSION_KILL_SLIMES",
        "TALK_Liam_Opinions_MISSION_HUNT_ANTS", "TALK_Liam_Opinions_MISSION_BUILD_CAMP_1",
        "TALK_Liam_Opinions_MISSION_BUILD_CAMP_2", "TALK_Liam_Opinions_MISSION_BUILD_CAMP_3",
        "TALK_Liam_Opinions_MISSION_BUILD_CAMP_4", "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5-3",
        "TALK_Liam_Opinions_MISSION_BUILD_CAMP_6", "TALK_Liam_Opinions_MISSION_COWBOYT_SHOTGUN",
        "TALK_Liam_Opinions_directions_lapin", "TALK_Liam_Opinions_MISSION_Warrener_LOG_1",
        "TALK_Liam_Opinions_MISSION_Warrener_FOOD_2", "TALK_Liam_Opinions_MISSION_Warrener_ISHERWOOD",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_1", "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_2",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_CHRIS_1", "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_3",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_1", "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_2",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_3", "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_2", "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help1",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-help2",
        "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1-toughlove",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RADIO",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_1", "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_2",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_3",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1_Skills",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
        "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
        "TALK_Liam_Opinions_BEM_jabberwock_mission", "TALK_Liam_Opinions_BEM_human_sample_mission",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_500_GAS",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_not_met_smokes",
        "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_has_met_smokes",
        "TALK_Liam_Opinions_directions_chef", "TALK_Liam_Opinions_directions_farmer",
        "TALK_Liam_Opinions_directions_hospital_2_CABIN",
        "TALK_Liam_Opinions_directions_prepper_1_SHELTER", "TALK_Liam_Opinions_directions_rural_1_FARM",
    },
    replies = {
        {
            text = ccb.content.text("I want to talk about something a bit more fundamental now."),
            next_topic = "TALK_FRIEND_Liam",
        },
        {
            text = ccb.content.text("Can we chat about something else?"),
            next_topic = "TALK_Liam_SOCIAL",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
