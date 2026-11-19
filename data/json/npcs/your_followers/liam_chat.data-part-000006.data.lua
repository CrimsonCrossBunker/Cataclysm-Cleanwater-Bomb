local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_Liam_Opinions",
    line = ccb.content.text("My opinion?  Sure, my friend, hit me up, what's eating you?"),
    replies = {
        {
            text = ccb.content.text("Check this out, I found an address of some kind of central refugee management facility.  Should we check it out?  Maybe they'll have answers?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REACH_REFUGEE_CENTER",
            when = predicates.has_mission("MISSION_REACH_REFUGEE_CENTER"),
        },
        {
            text = ccb.content.text("You thinking what I'm thinking about this mystery dropoff for Smokes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_HUB_DELIVERY_1",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_HUB_DELIVERY_1"),
        },
        {
            text = ccb.content.text("Any ideas about this job to clear out the back bay for Smokes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_1",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_1"),
        },
        {
            text = ccb.content.text("What do you think about taking down this bandit camp?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_2",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_2"),
        },
        {
            text = ccb.content.text("Any thoughts about bringing this prospectus out to the ranch?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_3",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_3"),
        },
        {
            text = ccb.content.text("What's the fastest way to find these guys some solar panels?"),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_4",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_4"),
        },
        {
            text = ccb.content.text("Liam, I need a lot of jars.  A shocking amount of jars."),
            next_topic = "TALK_Liam_Opinions_MISSION_FREE_MERCHANTS_EVAC_5",
            when = predicates.has_mission("MISSION_FREE_MERCHANTS_EVAC_5"),
        },
        {
            text = ccb.content.text("Liam, we need bigger jars."),
            next_topic = "TALK_Liam_Opinions_MISSION_BROKER_1",
            when = predicates.has_mission("MISSION_BROKER_1"),
        },
        {
            text = ccb.content.text("How about finding this guy some cigarettes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_EVAC_SMOKER_GET_CIGARETTES",
            when = predicates.has_mission("MISSION_EVAC_SMOKER_GET_CIGARETTES"),
        },
        {
            text = ccb.content.text("Should we go check out those farmers the teamster mentioned?"),
            next_topic = "TALK_Liam_Opinions_directions_isherwood",
            when = predicates.has_mission("directions_isherwood"),
        },
        {
            text = ccb.content.text("A secret lab in the wilds, with survivors in it, Liam.  You heard the teamster."),
            next_topic = "TALK_Liam_Opinions_directions_hub01",
            when = predicates.has_mission("directions_hub01"),
        },
        {
            text = ccb.content.text("This 'scrap metal castle' sounds far-fetched to me."),
            next_topic = "TALK_Liam_Opinions_directions_exodii",
            when = predicates.has_mission("directions_exodii"),
        },
        {
            text = ccb.content.text("What sounds better to you, a 'bullet bank' or a woman who feeds visitors?"),
            next_topic = "TALK_Liam_Opinions_directions_artisans",
            when = predicates.has_mission("directions_artisans"),
        },
        {
            text = ccb.content.text("What do you think about helping out this Dave guy?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_SMALL",
            when = predicates.has_mission("MISSION_BEGGAR_2_BOX_SMALL"),
        },
        {
            text = ccb.content.text("At least Dave has some practicality, and isn't just asking for more trash, right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_DUCT_TAPE",
            when = predicates.has_mission("MISSION_BEGGAR_2_DUCT_TAPE"),
        },
        {
            text = ccb.content.text("Any thoughts on Dave's cardboard needs?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_MEDIUM",
            when = predicates.has_mission("MISSION_BEGGAR_2_BOX_MEDIUM"),
        },
        {
            text = ccb.content.text("Looks like we might be done with cardboard for Dave, it's plastic now."),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PLASTIC_SHEET",
            when = predicates.has_mission("MISSION_BEGGAR_2_PLASTIC_SHEET"),
        },
        {
            text = ccb.content.text("I have a feeling this is the last of the cardboard for Dave."),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_BOX_LARGE",
            when = predicates.has_mission("MISSION_BEGGAR_2_BOX_LARGE"),
        },
        {
            text = ccb.content.text("Hey, this is a different direction for Dave, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BEGGAR_2_PERMISSION",
            when = predicates.has_mission("MISSION_BEGGAR_2_PERMISSION"),
        },
        {
            text = ccb.content.text("Do you think it's dangerous to get zombie blood, besides the obvious?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_1",
            when = predicates.has_mission("MISSION_SCIENCE_REP_1"),
        },
        {
            text = ccb.content.text("Sneaking into a lab to run some data analysis can't be bad, right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_2",
            when = predicates.has_mission("MISSION_SCIENCE_REP_2"),
        },
        {
            text = ccb.content.text("Who could have guessed there'd be some further complications to our stolen data analysis?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_3",
            when = predicates.has_mission("MISSION_SCIENCE_REP_3"),
        },
        {
            text = ccb.content.text("What do you think about checking out this freezing portal lab?"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_4",
            when = predicates.has_mission("MISSION_SCIENCE_REP_4"),
        },
        {
            text = ccb.content.text("If you were tired of underground labs, now we're gonna check out secret underground lab tunnels!"),
            next_topic = "TALK_Liam_Opinions_MISSION_SCIENCE_REP_5",
            when = predicates.has_mission("MISSION_SCIENCE_REP_5"),
        },
        {
            text = ccb.content.text("Do you know how to build a still?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_1",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_1"),
        },
        {
            text = ccb.content.text("How long does brewer's yeast last in the package?  Can we just find it at a supermarket?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_2",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_2"),
        },
        {
            text = ccb.content.text("Any idea where we could find sugar beet seeds for the bartender?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_3",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_3"),
        },
        {
            text = ccb.content.text("Do you like big jugs, Liam?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_4",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_4"),
        },
        {
            text = ccb.content.text("How are we gonna transport two giant drums?"),
            next_topic = "TALK_Liam_Opinions_MISSION_RANCH_BARTENDER_5",
            when = predicates.has_mission("MISSION_RANCH_BARTENDER_5"),
        },
        {
            text = ccb.content.text("Bringing a professional arsonist some commercial fertilizer seems like a normal thing to do."),
            next_topic = "TALK_Liam_Opinions_MISSION_ARSONIST_1_AMMONIUM_NITRATE",
            when = predicates.has_mission("MISSION_ARSONIST_1_AMMONIUM_NITRATE"),
        },
        {
            text = ccb.content.text("So, uh.  Alonso's pants, hey."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Alonso_pants",
            when = predicates.has_mission("MISSION_REFUGEE_Alonso_pants"),
        },
        {
            text = ccb.content.text("What do you think about helping these guys clean up all that dead zombie mess?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_CLEANUP",
            when = predicates.has_mission("MISSION_REFUGEE_Boris_CLEANUP"),
        },
        {
            text = ccb.content.text("Any thoughts on finding Boris a power saw?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_WORKSPACE",
            when = predicates.has_mission("MISSION_REFUGEE_Boris_WORKSPACE"),
        },
        {
            text = ccb.content.text("We're looking for Boris' kid's old laptop.  Thoughts?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Boris_LAPTOP",
            when = predicates.has_mission("MISSION_REFUGEE_Boris_LAPTOP"),
        },
        {
            text = ccb.content.text("You ever used a sourdough starter?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Dana_Sourdough",
            when = predicates.has_mission("MISSION_REFUGEE_Dana_Sourdough"),
        },
        {
            text = ccb.content.text("Draco seems like a kindred spirit for you."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Draco_GET_GUITAR",
            when = predicates.has_mission("MISSION_REFUGEE_Draco_GET_GUITAR"),
        },
        {
            text = ccb.content.text("Are you okay with tracking down a copy of the Quran?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Fatima_1",
            when = predicates.has_mission("MISSION_REFUGEE_Fatima_1"),
        },
        {
            text = ccb.content.text("Any idea where to find a really specific reference book about pneumatic guns?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_PNEUMATICS",
            when = predicates.has_mission("MISSION_REFUGEE_Jenny_GET_PNEUMATICS"),
        },
        {
            text = ccb.content.text("What do you think, where should we look for a motor for Jenny?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_MOTOR",
            when = predicates.has_mission("MISSION_REFUGEE_Jenny_GET_MOTOR"),
        },
        {
            text = ccb.content.text("It shouldn't be too hard to find Jenny a big metal tank, right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TANK",
            when = predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TANK"),
        },
        {
            text = ccb.content.text("You ever seen gunsmithing books just lying around?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXT",
            when = predicates.all({ predicates.negate(predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } })), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TEXT") }),
        },
        {
            text = ccb.content.text("So, we're finding a book about guns for your sweet nerd-girl."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Jenny_GET_TEXTcrushmode",
            when = predicates.all({ predicates.any_equal({ "crushing_hard", { scope = "speaker", key = "u_liam_jenny_feelings" } }), predicates.has_mission("MISSION_REFUGEE_Jenny_GET_TEXT") }),
        },
        {
            text = ccb.content.text("Do you think it's the right thing, trying to help the Nunez family move to Tacoma?"),
            next_topic = "TALK_Liam_Opinions_MISSION_TACOMA_Nunez",
            when = predicates.has_mission("MISSION_TACOMA_Nunez"),
        },
        {
            text = ccb.content.text("Any thoughts on helping Uyen out with her antiseptic?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_1",
            when = predicates.has_mission("MISSION_REFUGEE_Uyen_1"),
        },
        {
            text = ccb.content.text("Any thoughts on helping Uyen out with her bandages?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_2",
            when = predicates.has_mission("MISSION_REFUGEE_Uyen_2"),
        },
        {
            text = ccb.content.text("Any thoughts on helping Uyen out with her antidepressants?"),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Uyen_3",
            when = predicates.has_mission("MISSION_REFUGEE_Uyen_3"),
        },
        {
            text = ccb.content.text("You and me: hairdressing supply vendors now."),
            next_topic = "TALK_Liam_Opinions_MISSION_REFUGEE_Vanessa_1",
            when = predicates.has_mission("MISSION_REFUGEE_Vanessa_1"),
        },
        {
            text = ccb.content.text("What're your thoughts on this mission to kill bandits for the old guard?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_1",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_1"),
        },
        {
            text = ccb.content.text("How do you think we should track down this enemy informant?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_2",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_2"),
        },
        {
            text = ccb.content.text("What do you think about these robots?  Crazy stuff, hey?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-NotMet",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } })) }),
        },
        {
            text = ccb.content.text("What do you think about these robots?  Crazy stuff, hey?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_3-HasMet",
            when = predicates.all({ predicates.has_mission("MISSION_OLD_GUARD_REP_3"), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Rubik" } }) }),
        },
        {
            text = ccb.content.text("Do you think it's really a monster hitting those trade caravans?  Any ideas how we should deal with it?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_4",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_4"),
        },
        {
            text = ccb.content.text("So, we're officially assassins for hire now.  How do you feel about that?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REP_5",
            when = predicates.has_mission("MISSION_OLD_GUARD_REP_5"),
        },
        {
            text = ccb.content.text("Well, now we're radio technicians.  Sounds fun, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_OLD_GUARD_REPEATER_BEGIN",
            when = predicates.has_mission("MISSION_OLD_GUARD_REPEATER_BEGIN"),
        },
        {
            text = ccb.content.text("What do you make of these weird pictographs?  I think they're directions somewhere."),
            next_topic = "TALK_Liam_Opinions_directions_exodii_signpost",
            when = predicates.has_mission("directions_exodii_signpost"),
        },
        {
            text = ccb.content.text("Where do you think we can get some anesthetic for that robot guy?"),
            next_topic = "TALK_Liam_Opinions_RUBIK_ANUS_FETICK",
            when = predicates.has_mission("RUBIK_ANUS_FETICK"),
        },
        {
            text = ccb.content.text("Any thoughts on this scouting mission, checking out this bunker thing?"),
            next_topic = "TALK_Liam_Opinions_EXODII_MISSION_CONTACT_HUB",
            when = predicates.has_mission("EXODII_MISSION_CONTACT_HUB"),
        },
        {
            text = ccb.content.text("How do you think we should start looking for this lost interdimensional building?"),
            next_topic = "TALK_Liam_Opinions_EXODII_MISSION_WAREHOUSE",
            when = predicates.has_mission("EXODII_MISSION_WAREHOUSE"),
        },
        {
            text = ccb.content.text("You ready to go burn some shit down?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_1",
            when = predicates.has_mission("MISSION_pizzaiolo_1"),
        },
        {
            text = ccb.content.text("It's not gonna be a problem that we're hunting down Foodperson, is it?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_2",
            when = predicates.has_mission("MISSION_pizzaiolo_2"),
        },
        {
            text = ccb.content.text("What do you think about clearing out these pizzeria squatters?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_3",
            when = predicates.has_mission("MISSION_pizzaiolo_3"),
        },
        {
            text = ccb.content.text("So, cake and a party.  Think it was all worth it?"),
            next_topic = "TALK_Liam_Opinions_MISSION_pizzaiolo_4",
            when = predicates.has_mission("MISSION_pizzaiolo_4"),
        },
        {
            text = ccb.content.text("What do you think, you in the mood to hunt some slimes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_KILL_SLIMES",
            when = predicates.has_mission("MISSION_KILL_SLIMES"),
        },
        {
            text = ccb.content.text("Hey Liam!  Liam!  Bughunt!"),
            next_topic = "TALK_Liam_Opinions_MISSION_HUNT_ANTS",
            when = predicates.has_mission("MISSION_HUNT_ANTS"),
        },
        {
            text = ccb.content.text("Looks like I've got you doing deliveries again.  Where should we look for all this lumber?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_1",
            when = predicates.has_mission("MISSION_BUILD_CAMP_1"),
        },
        {
            text = ccb.content.text("I dunno if you heard, but guess what we're gonna deliver now?  More lumber!"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_2",
            when = predicates.has_mission("MISSION_BUILD_CAMP_2"),
        },
        {
            text = ccb.content.text("Any idea where we can find some ropes?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_3",
            when = predicates.has_mission("MISSION_BUILD_CAMP_3"),
        },
        {
            text = ccb.content.text("These guys need a wood saw.  You carrying one?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_4",
            when = predicates.has_mission("MISSION_BUILD_CAMP_4"),
        },
        {
            text = ccb.content.text("Where could we find a shovel?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_5",
            when = predicates.has_mission("MISSION_BUILD_CAMP_5"),
        },
        {
            text = ccb.content.text("We're looking for a charcoal smoker now.  You seen one?"),
            next_topic = "TALK_Liam_Opinions_MISSION_BUILD_CAMP_6",
            when = predicates.has_mission("MISSION_BUILD_CAMP_6"),
        },
        {
            text = ccb.content.text("This guy wants us to find a Remington 870 Express for a client.  You know a bit about that stuff, don't you?"),
            next_topic = "TALK_Liam_Opinions_MISSION_COWBOYT_SHOTGUN",
            when = predicates.has_mission("MISSION_COWBOYT_SHOTGUN"),
        },
        {
            text = ccb.content.text("Nothing ever went wrong tracking down a nice old guy in a cabin in the woods, right?"),
            next_topic = "TALK_Liam_Opinions_directions_lapin",
            when = predicates.has_mission("directions_lapin"),
        },
        {
            text = ccb.content.text("You fine with helping this guy and his rabbits?"),
            next_topic = "TALK_Liam_Opinions_MISSION_Warrener_LOG_1",
            when = predicates.has_mission("MISSION_Warrener_LOG_1"),
        },
        {
            text = ccb.content.text("Does blackberry hunting sound nice?"),
            next_topic = "TALK_Liam_Opinions_MISSION_Warrener_FOOD_2",
            when = predicates.has_mission("MISSION_Warrener_FOOD_2"),
        },
        {
            text = ccb.content.text("Mind helping Mr. Lapin get in touch with his friends?"),
            next_topic = "TALK_Liam_Opinions_MISSION_Warrener_ISHERWOOD",
            when = predicates.has_mission("MISSION_Warrener_ISHERWOOD"),
        },
        {
            text = ccb.content.text("Seen an anvil around recently?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_CARLOS_1"),
        },
        {
            text = ccb.content.text("Anything we should consider before trying to find Chris Isherwood?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CARLOS_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_CARLOS_2"),
        },
        {
            text = ccb.content.text("Looks like Barry Isherwood's got himself into some trouble."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CHRIS_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_CHRIS_1"),
        },
        {
            text = ccb.content.text("Want to help me collect some dandelions?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_1"),
        },
        {
            text = ccb.content.text("Hey Liam.  Bee balm?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_2"),
        },
        {
            text = ccb.content.text("Tonight, on 'to catch a predator'…"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_CLAIRE_3",
            when = predicates.has_mission("MISSION_ISHERWOOD_CLAIRE_3"),
        },
        {
            text = ccb.content.text("Eddie wants a *lot* of rocks."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_EDDIE_1"),
        },
        {
            text = ccb.content.text("So, Liam, you ready to gather sand?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_EDDIE_2"),
        },
        {
            text = ccb.content.text("I told Eddie we'd help him gather some clay."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_EDDIE_3",
            when = predicates.has_mission("MISSION_ISHERWOOD_EDDIE_3"),
        },
        {
            text = ccb.content.text("Where should we look for jars for the Isherwoods?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_JACK_1"),
        },
        {
            text = ccb.content.text("Any thoughts about looking for wheat seeds?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JACK_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_JACK_2"),
        },
        {
            text = ccb.content.text("Liam, you're not afraid of the big bad wolf, are you?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_JESSE_1"),
        },
        {
            text = ccb.content.text("What do you think about hunting some mystery monsters for Jesse?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_JESSE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_JESSE_2"),
        },
        {
            text = ccb.content.text("Hey, you ever seen a book about glassblowing?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_LUKE_1"),
        },
        {
            text = ccb.content.text("Luke Isherwood wants a copy of the DIY Compendium."),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_LUKE_2",
            when = predicates.has_mission("MISSION_ISHERWOOD_LUKE_2"),
        },
        {
            text = ccb.content.text("You think Barry's gonna be okay?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ISHERWOOD_BARRY_1",
            when = predicates.has_mission("MISSION_ISHERWOOD_BARRY_1"),
        },
        {
            text = ccb.content.text("You know anything about how to troubleshoot a radio tower, Liam?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RADIO",
            when = predicates.has_mission("MISSION_ROBOFAC_MERC_1_RADIO"),
        },
        {
            text = ccb.content.text("How do we explain what we saw out at the radio tower to the guys back at the Hub?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB",
            when = predicates.has_mission("MISSION_ROBOFAC_MERC_1_RETURN_TO_HUB"),
        },
        {
            text = ccb.content.text("These guys seriously want us to try to take down a robot with EMP grenades.  How you feeling?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_1"),
        },
        {
            text = ccb.content.text("Think this will be an easy find and retrieve job, looking for the hard case?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_2",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_2"),
        },
        {
            text = ccb.content.text("This collapsed tower business sounds pretty risky.  Are you still in?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_3",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_3"),
        },
        {
            text = ccb.content.text("This robot interception stuff sounds pretty heavy, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_ROBOT_SM_1"),
        },
        {
            text = ccb.content.text("What are your thoughts on standing outside during a portal storm?  Seems like a good way to spend an evening right?"),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_PORTAL_SM_1"),
        },
        {
            text = ccb.content.text("Liam, the guys in the secret lab want us to break into a secret lab."),
            next_topic = "TALK_Liam_Opinions_MISSION_ROBOFAC_INTERCOM_LIXA_SM_1",
            when = predicates.has_mission("MISSION_ROBOFAC_INTERCOM_LIXA_SM_1"),
        },
        {
            text = ccb.content.text("Looks like we're on a monster hunt, my friend."),
            next_topic = "TALK_Liam_Opinions_BEM_jabberwock_mission",
            when = predicates.has_mission("BEM_jabberwock_mission"),
        },
        {
            text = ccb.content.text("Does this 'human sample' business seem a little off to you?"),
            next_topic = "TALK_Liam_Opinions_BEM_human_sample_mission",
            when = predicates.has_mission("BEM_human_sample_mission"),
        },
        {
            text = ccb.content.text("Where should we look for one of those chemistry sets?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_analytical_set_basic",
            when = predicates.has_mission("MISSION_CABIN_CHEMIST_GET_analytical_set_basic"),
        },
        {
            text = ccb.content.text("Fifteen liters of hydrochloric acid seems like a lot to me, don't you think?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid",
            when = predicates.has_mission("MISSION_CABIN_CHEMIST_GET_60_chem_muriatic_acid"),
        },
        {
            text = ccb.content.text("What do you think is the best way to get a hundred liters of gas for this guy's generator?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_GET_500_GAS",
            when = predicates.has_mission("MISSION_CABIN_CHEMIST_GET_500_GAS"),
        },
        {
            text = ccb.content.text("Any thoughts about tracking down that refugee center?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_not_met_smokes",
            when = predicates.all({ predicates.has_mission("MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE"), predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } })) }),
        },
        {
            text = ccb.content.text("What do you think about connecting that chemist to the Free Merchants?"),
            next_topic = "TALK_Liam_Opinions_MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE_has_met_smokes",
            when = predicates.all({ predicates.has_mission("MISSION_CABIN_CHEMIST_SET_TRADE_ROUTE"), predicates.any_equal({ "yes", { scope = "speaker", key = "general_meeting_u_met_Gavin" } }) }),
        },
        {
            text = ccb.content.text("Liam!  There's a chef, trapped in a restaurant!  Want to help save them?"),
            next_topic = "TALK_Liam_Opinions_directions_chef",
            when = predicates.has_mission("directions_chef"),
        },
        {
            text = ccb.content.text("What do you think about tracking down these survivors camping out on a farm?"),
            next_topic = "TALK_Liam_Opinions_directions_farmer",
            when = predicates.has_mission("directions_farmer"),
        },
        {
            text = ccb.content.text("Should we go track down this mystery cabin?"),
            next_topic = "TALK_Liam_Opinions_directions_hospital_2_CABIN",
            when = predicates.has_mission("directions_hospital_2_CABIN"),
        },
        {
            text = ccb.content.text("Liam, I've got the location of a prepper bunker.  Should we check this out?"),
            next_topic = "TALK_Liam_Opinions_directions_prepper_1_SHELTER",
            when = predicates.has_mission("directions_prepper_1_SHELTER"),
        },
        {
            text = ccb.content.text("How do you feel about checking out a zombie-infested farm?"),
            next_topic = "TALK_Liam_Opinions_directions_rural_1_FARM",
            when = predicates.has_mission("directions_rural_1_FARM"),
        },
        {
            text = ccb.content.text_without_extraction("<done_conversation_section>"),
            next_topic = "TALK_FRIEND_Liam",
        },
        { text = ccb.content.text_without_extraction("<end_talking>"), next_topic = "TALK_DONE" },
    },
}
