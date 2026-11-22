local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_GENERAL",
    line = ccb.content.text("What about faction camps?"),
    replies = {
        {
            text = ccb.content.text("Tell me how faction camps work."),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
        {
            text = ccb.content.text("Tell me how faction camps have changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("I want you to build a camp here."),
            next_topic = "TALK_HALLU_CAMP",
            when = predicates.has_trait("interlocutor", "HALLUCINATION"),
            switch = true,
        },
        {
            text = ccb.content.text("I want you to build a camp here."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_0a469b3f65f6"),
            actions = { "start_camp" },
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("Since we can't build a camp here, where can we build a camp?"),
            next_topic = "TALK_CAMP_SITES",
            when = predicates.handler("dlg_p_dda_717555b46202"),
            switch = true,
            default = true,
        },
        {
            text = ccb.content.text("We need to abandon this camp."),
            next_topic = "TALK_ABANDON",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
        },
        {
            text = ccb.content.text("Show me what needs to be done at the camp."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_c5904e1a60f2"),
            actions = { "basecamp_mission" },
        },
        {
            text = ccb.content.text("Nothing.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("Nothing.  Let's get back to work."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_SITES",
    line = { special = "list_faction_camp_sites" },
    replies = {
        {
            text = ccb.content.text("Interesting.  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text("Well, until we go there, let's talk about camps more."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Well, then.  Let's get back to work."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_INTRO",
    line = ccb.content.text("The faction camp system allows you to use companions to take over existing buildings or construct new buildings and use them to extend the usefulness of your allies.  When you have a faction camp, you can order your companions to perform missions, such as crafting new items, building up the camp, hunting for food, or recruiting more allies.  Faction camps also simplify some aspects of managing your companions."),
    replies = {
        {
            text = ccb.content.text("Give me an overview of how camps work."),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Tell me more about faction camps and food."),
            next_topic = "TALK_CAMP_TUTORIAL_FOOD",
        },
        {
            text = ccb.content.text("Tell me more about camp missions."),
            next_topic = "TALK_CAMP_TUTORIAL_MISSIONS",
        },
        {
            text = ccb.content.text("Tell me about building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_OVERVIEW",
    line = ccb.content.text("Each faction camp starts with the companion surveying the land and constructing a bulletin board, with the exception of the bare bones camp, where it is up to you to construct the board yourself anywhere within the camp's perimeter.  You can then 'e'xamine the bulletin board to get a list of available missions with descriptions, and to assign a companion to work on a mission.  The bulletin board is the primary way to access the camp.\n  If both you and a companion have two-way radios, you can assign missions to the companion remotely by talking on the radio.\n  When you ask a companion to start a camp they'll survey the land and mark it as a faction camp (visible on the overmap) to establish it.  The companion will also build a bulletin board for all faction camps except the bare bones one.  A faction camp has a central tile where the bulletin board is, and possibly one or more expansions that are in adjacent tiles.\n  All of your faction camps can be stocked with food, and your companions will eat from that food when performing camp missions, or even when they're just hungry and near the camp.\n  Currently, the bare bones faction camp can be created anywhere, while the modular hub ones can be built in fields, and the evac shelter one in all evac shelters.  In addition to those, there are faction camps that can be built in fire stations, mansions, fire lookout towers, helipads, lighthouses, military outposts, pottery cottages, radio towers, and small sealabs, and I may have forgotten some.  You can start a faction camp by talking to a companion who is standing on a suitable terrain, asking about faction camps, and then telling the companion to build a faction camp.  They'll immediately survey the tile and make the bulletin board (bare bones leaves the bulletin board location and construction up to you).  You'll be able to ask the companion for a list of suitable starting sites."),
    replies = {
        {
            text = ccb.content.text("Wait, we can talk with radios?"),
            next_topic = "TALK_ALLY_TUTORIAL_RADIO",
        },
        {
            text = ccb.content.text("Tell me more about faction camps and food."),
            next_topic = "TALK_CAMP_TUTORIAL_FOOD",
        },
        {
            text = ccb.content.text("Tell me more about camp missions."),
            next_topic = "TALK_CAMP_TUTORIAL_MISSIONS",
        },
        {
            text = ccb.content.text("Tell me about building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_FOOD",
    line = ccb.content.text("Faction camps require food, but simplify managing your companions.\n  When you activate a camp's bulletin board, you'll be required to make some zones if you haven't already.  One of those zones must be a camp food zone.  If you drop food in the camp food zone and select the 'Distribute Food' mission, then the food will disappear and be converted into stored kcalories.\n  When you send companions out on camp missions, they'll eat from the stored food when they return at the rate of 2,500 kcalories per day.  Some missions have variable length, and companions will become upset if there isn't enough food when they come back, so try to keep a healthy surplus of food on hand.\n  Companions who aren't on camp missions, but who are following you, will also eat from the camp food stores whenever they're hungry and within 2 overmap tiles of the camp.  This drastically simplifies keeping your followers fed, so it's worthwhile to build a minimal faction camp just for this feature.\n  You can upgrade a camp to include a water well.  If you do, your followers will also drink from the well when they're thirsty."),
    replies = {
        {
            text = ccb.content.text("Tell me more about camp missions."),
            next_topic = "TALK_CAMP_TUTORIAL_MISSIONS",
        },
        {
            text = ccb.content.text("Tell me about building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_MISSIONS",
    line = ccb.content.text("When you assign a companion to a faction camp mission, they'll disappear while they go do whatever you want them to do.  When the duration of the mission has elapsed, you'll see a new mission on the bulletin board to have them return and complete the mission by upgrading your camp, returning their hunting kills, dropping off whatever they were crafting, or whatever else the mission results are.\n  There are all kinds of faction camp missions: building up the camp, recruiting new allies, hunting and trapping game, scrounging for materials, farming, disassembling cars, and more.  Not all activities can be done at every camp - you may need to build some additional buildings, or expand the camp, to get access to some missions.\n  Some faction camp missions can be duplicated by companion activities, but building up the camp can only be done via faction camp missions, as only completion of camp construction missions are recognized as fulfillment of those goals.\n  You assign missions by interacting with the bulletin board.  You'll see a list of available missions for your central camp tile.  If your camp has expansions, you can tab through the expansions to see the available missions at each expansion.\n  Remember, companions on camp missions need to be fed, and will become angry if they complete a mission but there isn't any food in the larder.\n  There is one special mission called 'Emergency Recall'.  You can use this to retrieve any companion on a faction camp mission, but this cancels the mission and wastes any resources used on it.  Only use it to recover allies when something has gone really wrong with your camp and you can't get them to come back any other way."),
    replies = {
        {
            text = ccb.content.text("What do you mean by angry?"),
            next_topic = "TALK_ALLY_TUTORIAL_MUTINY",
        },
        {
            text = ccb.content.text("Tell me more about faction camps and food."),
            next_topic = "TALK_CAMP_TUTORIAL_FOOD",
        },
        {
            text = ccb.content.text("Tell me about building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_BUILDING",
    line = ccb.content.text("Currently, there are three main types of camps that you can start building: bare bones camps, modular field camps, and established building camps which is a wide range of camps adapted to using specific buildings.  The established building list includes fire lookout towers, helipads, lighthouses, light industry, mansions, military outposts, pottery cottages, radio towers, small sealabs, and fire stations.  I may have forgotten something here, as my memory may not be completely up to date.\n  The bare bones camp is the most flexible kind of camp as it can be built anywhere and doesn't mandate any construction.  Modular field camps are the next most flexible kind of camp since you can build them on any field, hay field, farm field, or field dirt road and can locate them to have plenty of space for expansions, but you start with nothing in an open area and have to build every building, so they can require a lot of resources.  Established building camps are faster to set up since you start in an existing building, but you have to establish them in a supported type of existing building and there may be limited or no space for expansions.\n  Each camp location will have a variety of upgrade missions for it, except for the bare bones one where everything is up to you.  The various missions have descriptions.  In general, though, you can expand your camp with expansions whenever you want, assuming there are expansions suitable to the adjacent terrain (the general expansions can only be established on the same kind of open areas as field base camps can be placed on), and some missions such as hunting or recruiting will require that you have some kind of kitchen or office that you can use to help schedule activities.\n  Regardless of what kind of camp you make, you have to start it by asking a companion to build the camp.  If there are more alternatives than just the bare bones camp you'll get a list of the available alternatives."),
    replies = {
        {
            text = ccb.content.text("Tell me about bare bones camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BARE_BONES",
        },
        {
            text = ccb.content.text("Tell me about modular field camps."),
            next_topic = "TALK_CAMP_TUTORIAL_MFC",
        },
        {
            text = ccb.content.text("Tell me about fire station camps."),
            next_topic = "TALK_CAMP_TUTORIAL_FIRE_STATION",
        },
        {
            text = ccb.content.text("Tell me about evac shelter camps."),
            next_topic = "TALK_CAMP_TUTORIAL_EVAC_SHELTER",
        },
        {
            text = ccb.content.text("Tell me about fire lookout tower camps."),
            next_topic = "TALK_CAMP_TUTORIAL_FIRE_LOOKOUT_TOWER",
        },
        {
            text = ccb.content.text("Tell me about helipad camps."),
            next_topic = "TALK_CAMP_TUTORIAL_HELIPAD",
        },
        {
            text = ccb.content.text("Tell me about lighthouse camps."),
            next_topic = "TALK_CAMP_TUTORIAL_LIGHTHOUSE",
        },
        {
            text = ccb.content.text("Tell me about light industry camps."),
            next_topic = "TALK_CAMP_TUTORIAL_LIGHTINDUSTRY",
        },
        {
            text = ccb.content.text("Tell me about mansion camps."),
            next_topic = "TALK_CAMP_TUTORIAL_MANSION",
        },
        {
            text = ccb.content.text("Tell me about military outpost camps."),
            next_topic = "TALK_CAMP_TUTORIAL_OUTPOST",
        },
        {
            text = ccb.content.text("Tell me about pottery cottage camps."),
            next_topic = "TALK_CAMP_TUTORIAL_POTTERY_COTTAGE",
        },
        {
            text = ccb.content.text("Tell me about radio tower camps."),
            next_topic = "TALK_CAMP_TUTORIAL_RADIO_TOWER",
        },
        {
            text = ccb.content.text("Tell me about small sealab camps."),
            next_topic = "TALK_CAMP_TUTORIAL_SEALAB_SMALL",
        },
        {
            text = ccb.content.text("Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_BARE_BONES",
    line = ccb.content.text("The bare bones camp is the most flexible kind of camp as you can build them anywhere while still having access to almost all camp capabilities, leaving it completely up to you how you design them (the missed functionality is tied to the construction of a radio tower).  You start by ordering a companion to build the camp, then construct a bulletin board within it yourself or by ordering your companion to make a zone construction for it, after which you can use the board to order companions to execute camp missions without construction preconditions.  You still have to meet all the usual restrictions for companion crafting missions, such as access to fire, tools, etc, but facilities constructed by you or your companions should be available for crafting provided you have covered them with Camp: Supply zones.  How you want to construct the camp in your chosen location is up to you, with construction zones available should you want to give the task to your companions."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_MFC",
    line = ccb.content.text("The modular field camp is the second most flexible kind of camp, but they require a lot of time and resources to build.  There are actually two different versions with slightly different layouts.  With both versions you start with an empty field which can be a field, hay field, farm field, or dirt road on a field, and build up from nothing.  You have a range of different building materials available from which buildings can be constructed, and different sections can be constructed from different materials to make the most of what you have available.\n  You start by building a lean-to and a bed in the northeast corner of the central camp, and then typically add a cooking facility to it, and expand out until you have a small shelter for two people.  When the first building is complete, you can expand the camp in a variety of ways:\n  1.  Version 1 allows building up to 5 more rooms or shacks with a maximum of 3 on each side of the camp that increases to a total of 8 with version 2.\n  2.  You can build a central building in the south half of the camp, between the rooms in version 1, with version 2 having the central building in the center, shaping the camp into an 'H'.  The central building will act as a command center, allowing your camp to perform hunting, recruiting, and combat patrol missions.\n  3.  In version 1 only you can dig trenches on all sides of the camp, which can possibly connect to the rooms on the sides to minimize the amount of trenching you need to do.\n  4.  You can build various small features such as root cellars to preserve food or a radio tower to make it easier to recruit more companions.\n  With each new construction in a modular camp can being able to be made from a different material you aren't constrained by what you start with.  If limited by resources, tents are a fast alternative way to provide shelter, but fragile and likely to get destroyed by the first zombie stumbling in, however the central building must still be made from a 'real' building material."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_FIRE_STATION",
    line = ccb.content.text("Fire stations make good basecamps.  You start with a brick building with secure metal doors, so you're not going to see your efforts destroyed by zombies.  On the downside, you generally can't build expansions from a fire station.\n  Fire station camps are also very compact.  There isn't much living space, but you can build a small pottery or blacksmithy, a chop shop in one of the garage bays, and even tear up some of the pavement to create a garden.  The existing kitchen makes it easy to cook from the start, though you may need to spruce it up a bit."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_EVAC_SHELTER",
    line = ccb.content.text("You can build a faction camp in any kind of evac shelter.  Evac shelters are everywhere and often have fields surrounding them, so they're a little faster to start than a modular field camp but still make it easy to add expansions.\n  Evac center camps can be built up in several ways.  You basically need to decide between building more bedrooms or adding crafting and cooking space."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_FIRE_LOOKOUT_TOWER",
    line = ccb.content.text("You can build a faction camp in a fire lookout tower.  Fire lookout towers often have fields surrounding them.\n  The base camp starts in an established building, and provides a full set of base camp missions, but the number of construction upgrades is limited to a pair of dual bed rooms, a well, a root cellar, and a radio tower.  This makes it a camp that allows you to get the camp setup done with quickly so you can focus on other things."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_HELIPAD",
    line = ccb.content.text("You can build a faction camp in a helipad facility, where you're provided with water purification and cooking facilities from the beginning and can expand with a root cellar, butchering rack, a radio tower, and 4 beds.  A site specific expansion is into the garage, where you're given access to the available appliances."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_LIGHTHOUSE",
    line = ccb.content.text("You can build a faction camp in a lighthouse, where you're provided with water purification and cooking facilities from the beginning and can expand with a root cellar."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_LIGHTINDUSTRY",
    line = ccb.content.text("You can build a faction camp in a light industry facility, where you're provided with cooking facilities from the beginning and can expand with a root cellar, butchering rack, well, a radio tower, and beds.  One site specific expansion that's always available is the workshop, where you're given access to the available appliances and can add a drop hammer for companion crafting."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_MANSION",
    line = ccb.content.text("You can build a faction camp in a mansion.  You have four different starting positions available, namely the Fountain Garden, Dance Floor Room, Basketball Room, and Garden with Columns.  Depending on where you set up your base, the following site specific expansions may become available: Entrances, Swimming Pools, Bedrooms, Unidentified Room, Kitchens, Library, Bar, and Living Rooms.  The Entrances and Swimming Pool provide farming.  Both the Library, Bar, and Kitchens extend the cooking recipe, with Kitchens having more options than Library, and Bar having its own unique recipe set."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_OUTPOST",
    line = ccb.content.text("You can build a faction camp in a military outpost, of which there are two versions, 'normal' and 'cross'.  They differ in that the normal version can be expanded with two beds, while the cross version can be expanded with four.  Apart from that, they provide you with the ability to build a root cellar, a butchery rack, a water well, farm plots, a radio tower, and repair the reactor's controller."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_POTTERY_COTTAGE",
    line = ccb.content.text("You can build a faction camp in a pottery cottage.  Setting up your base there allows you to use the char kiln and clay kiln for crafting.  You can add a butchery rack to the facilities, as well as build blacksmithing facilities."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_RADIO_TOWER",
    line = ccb.content.text("You can build a faction camp in a radio tower, both the version with and the one without an adjacent building on the ground.  Bedroom shacks can be built to host your companions.  You can build a root cellar, a water well, hook yourself up to the radio tower, and fix the tower to get access to extended capabilities."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_SEALAB_SMALL",
    line = ccb.content.text("You can build a faction camp in a small sealab facility.  This provides you with access to the air compressor and water purifier appliances on site."),
    replies = {
        {
            text = ccb.content.text("I want to go back to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Got it.  Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Can we review how camps work?"),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_EXPANSIONS",
    line = ccb.content.text("A camp can have up to 8 expansions (one for each of the 8 adjacent overmap tiles).  Expansions add to the capabilities of your camp, such as adding a farm field or a manufactory for crafting all kinds of things.\n  Expansion missions show up in separate tabs in the bulletin board, one set of missions per location, and you'll need to hit 'tab' to see them.  Some base camps have dedicated expansions tailored to their specific facilities, and while these might be accessible from other base camps should those be constructed adjacent to one of these, the set of reasonably general expansions are currently all limited to open field locations (field, hay field, farm field, or field dirt road).  The currently available general expansions are:\n  -- Farm: This is a full tile of plowed fields that you can maintain or send companions on missions to maintain.  Plants grow here normally.  This expansion exists in two versions.\n  -- Garage: This is a large building that currently doesn't provide any functionality, and so is of limited use (it used to provide disassembly before that was supported via zones, which can still be placed inside the garage).  This expansion exists in two versions.\n  -- Canteen: This is an expanded kitchen, dining area, and pantry that provides an expanded set of companion cooking recipes.  This expansion exists in two versions.\n  -- Livestock Area: This is a modular set of buildings for holding livestock such as cows, horses, or chickens.  Animals are not included!  This expansion exists in two versions.\n  -- Fabrication Workshop: This is a large expansion for doing all kinds of crafts.  Companions can use some of the furniture in this expansion to craft some items much faster than you can do by yourself by hand.  This expansion exists in two versions.\n  -- Central Storage Building: This is a large building for storing goods.  This expansion exists in two versions, the second of which allows the construction of storage furniture with a larger capacity than storage on the ground.\n  Note that there is nothing stopping you from constructing more than one instance of an expansion, such as multiple farms for more farming, or a second Livestock expansion if you have a lot of animals.  In most cases there is not much value in having more than one of an expansion, though."),
    replies = {
        {
            text = ccb.content.text("Got it.  Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_ADVICE",
    line = ccb.content.text("Starting a camp doesn't take much time, and you can use a faction camp to keep your companions fed without needing to regularly give them food, so it's a good idea to establish a minimal camp anywhere you intend to be for a while.\n  How much you want to expand your camps is up to you.  A modular field camp can be very resource intensive, but building one up allows you to send companions off to hunt and farm for you, so there's quite the pay-off.  What kind of camp (or camps) you want to build depends both on what you intend to focus on and whether you want to be stationary or roaming with stops in areas only for some time before moving on.  If nothing else, you should consider building a water well as soon as you can, which may require you to perform construction prerequisites.\n  If you have access to a fire station or evac shelter, you may want to build your camp in them.  Both of those camps are very compact, but have much of the same functionality as an upgraded field camp without requiring so many resources.\n  If you are adding expansions to your camp, consider starting with a farm, canteen, or fabrication workshop.  The farm makes it easy to grow your own food if you don't have any ready plowed farms nearby, the canteen provides you with a well and root cellars after some upgrades, while the fabrication workshop can allow you to craft some of the resources you need to upgrade your camp.\n  The livestock area and the storage area probably shouldn't be your first expansions, but they both have their uses."),
    replies = {
        {
            text = ccb.content.text("Give me an overview of how camps work."),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("I want to go to the list of possible camps."),
            next_topic = "TALK_CAMP_TUTORIAL_BUILDING",
        },
        {
            text = ccb.content.text("Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Give me some advice on building a camp."),
            next_topic = "TALK_CAMP_TUTORIAL_ADVICE",
        },
        {
            text = ccb.content.text("I know the basics.  Just tell me what changed."),
            next_topic = "TALK_CAMP_TUTORIAL_CHANGES",
        },
        {
            text = ccb.content.text("Never mind, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("Never mind, let's talk about other things you can do."),
            next_topic = "TALK_ALLY_TUTORIAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_CAMP_TUTORIAL_CHANGES",
    line = ccb.content.text("\n1.  Faction camps used to require a second companion to act as overseer and camp manager, but that's been replaced by the bulletin board and two-way radio.\n2.  It used to be impossible to upgrade faction camps if there was a vehicle, even a cart, on the same map.  You can now upgrade camps even if there is a vehicle on the map, as long as the upgrade doesn't change the area under the vehicle.\n3.  Faction camps used to upgrade by completely redrawing the map.  Damage to the camp would be replaced when the camp was upgraded.  Now upgrades only change the actual area being upgraded, and you will have to repair damage to the camp yourself.\n4.  There used to be a single path for upgrading the main camp.  Now, after you have completed the first tent, you will have many options for your next upgrade, and you can have different companions working on different upgrades of the main camp at the same time.\n5.  Companions who are near a camp will feed themselves from the camp's food stores, and if the camp has a well, they'll use it to quench their thirst.\n6.  You can now set up faction camps in select buildings.  The list of available buildings is constantly growing, so you'll have to experiment.\n7.  The oldest type of camp, known as the primitive field camp or \"Old Camp\", is no longer supported and will be removed entirely in the future.\n8.  Most camps abided by a restriction that allowed them to add expansions to the camps only when camp constructions had added a sufficient number of beds to the camp (2 per expansion), but this restriction has been removed from all camps.\n9.  Field base camps and standard expansions used to be available for fields only.  They can now be placed on fields (as before), hay fields, farm fields, and field dirt roads."),
    replies = {
        {
            text = ccb.content.text("Wait, let's go back over from the start."),
            next_topic = "TALK_CAMP_TUTORIAL_INTRO",
        },
        {
            text = ccb.content.text("Give me an overview of how camps work."),
            next_topic = "TALK_CAMP_TUTORIAL_OVERVIEW",
        },
        {
            text = ccb.content.text("Tell me more about faction camps and food."),
            next_topic = "TALK_CAMP_TUTORIAL_FOOD",
        },
        {
            text = ccb.content.text("Tell me about modular field camps."),
            next_topic = "TALK_CAMP_TUTORIAL_MFC",
        },
        {
            text = ccb.content.text("Tell me about fire station camps."),
            next_topic = "TALK_CAMP_TUTORIAL_FIRE_STATION",
        },
        {
            text = ccb.content.text("Tell me about evac shelter camps."),
            next_topic = "TALK_CAMP_TUTORIAL_EVAC_SHELTER",
        },
        {
            text = ccb.content.text("Tell me about expansions."),
            next_topic = "TALK_CAMP_TUTORIAL_EXPANSIONS",
        },
        {
            text = ccb.content.text("Thanks, let's go back to talking about camps."),
            next_topic = "TALK_CAMP_GENERAL",
        },
        {
            text = ccb.content.text("<end_talking_nevermind>  <done_conversation_section>"),
            next_topic = "TALK_FRIEND",
        },
        {
            text = ccb.content.text_without_extraction("<end_talking_later_follower>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_HALLU_CAMP",
    line = ccb.content.text_without_extraction("<hallu_dont_camp>"),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_NONE" } },
}
