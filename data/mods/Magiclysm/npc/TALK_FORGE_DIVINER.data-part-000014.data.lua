local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_LAB_NORMAL",
    line = ccb.content.text("Right.  Probably a good call.  I'll mark one on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_LAB"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_LAB_NETHER",
    line = ccb.content.text("Here it seems like the scientists managed to break through the walls of reality to the nether.  Of course, they didn't bother to do it correctly, so the whole place is a mess.  Be ready for flaming eyes if you go there.  I'll mark it on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_LAB_NETHER"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_EXODII",
    line = ccb.content.text("Fellow travelers between realities, those ones.  At first I thought they would be competition, but they seem to have little interest in the things we at the forge value.  Nowadays we barely interact with them, except in the rare occasions when we find a group of them marooned in between the worlds.  Poor things are almost always driven completely insane by the time we can mount a rescue.  Nevertheless, it's the law of the sea out there, as far as Valzain is concerned.  They seem to have set up shop not too far from here.  I'll mark it on your map for one denarius.  You might wanna check the magic item store for an Amulet of Comprehend Languages before you go.  Then again, we might be out of that right now."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_EXODII"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_TEMPLE",
    line = ccb.content.text("Yes, a strange location indeed, buried mostly underground.  Was it really built by humans?  I find that rather unlikely.  I can't see very deep into the structure, but there is a strange power somewhere below the entrance.  I'll mark it on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_TEMPLE"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_ATTUNEMENT",
    line = ccb.content.text("You know, if you've got the aptitude, you should go visit an attunement altar.  They help you combine your skills with different classes of magic to incredible effect.  I'll mark one on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_ATTUNEMENT"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_ACADEMY",
    line = ccb.content.text("This place used to teach magic before the whole Malignance business.  There are probably still spell scrolls and magical items to find there.  And golems.  Can't forget about the golems.  I'll mark one on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_ACADEMY"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_TOWER",
    line = ccb.content.text("Seems like an eccentric wizard once lived here.  Not that there are any other kind of wizards, am I right?  But, uh, don't tell Valzain I said so.  Or any other wizards for that matter.  But you know it's true.  Anyways, I'll mark the building on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.handler("dlg_a_magiclysm_b142e0f93d05") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_DRUID_TOWER",
    line = ccb.content.text("Poor druids, they were hit hardest by the rise of technology.  Magi, technomancers, animists, they can just close the windows and keep their chanting low so to not bother the neighbors.  Even earthshapers can just go into the backyard, but druids had to move out to the middle of nowhere.  That's where their tower will be, mind.  There won't be a road there, so you're in for quite the trip.  I'll mark one on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("I could use a nice walk."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_DRUID_TOWER"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_RIVER",
    line = ccb.content.text("Rivers.  Water, sand, clay, fish, giant mutant bugs.  Generally pretty big.  If you're still having trouble finding one, I'll mark one on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_RIVER"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_CLAY",
    line = ccb.content.text("Digging clay is quintessential of the Earthshaper.  Forming it into useful tools is quintessential of the Technomancer.  Showing you where you can find it is quintessential of me. For one denarius of course."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_CLAY"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_SAND",
    line = ccb.content.text("If you're looking for something rough and coarse that gets everywhere, I'll mark a large sand patch on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SAND"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_SPRING",
    line = ccb.content.text("The water there is scolding hot.  Perhaps it could help you survive the cold winter months?  I'll mark one on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SPRING"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_CAVE",
    line = ccb.content.text("If you're interested in the neolithic housing market, I'll mark a cave on your map for one denarius.  Just be warned that the place might already be occupied."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_magiclysm_280f5b89c85b"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_CAVE"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_magiclysm_627fa3dba5e2"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_CAVE_INNAWOOD"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_MAGIC_PLANT",
    line = ccb.content.text("Looking for potion ingredients?  I know a place where the leylines converge and such plants grows plentiful.  I'll mark it on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_MAGIC_PLANT"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("About something else…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}
