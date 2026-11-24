local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

-- The Diviner of the Forge of Wonders.
ccb.content.define_npc {
    id = "forge_lord_diviner",
    unique_name = ccb.content.text("Mary Machen"),
    suffix = ccb.content.text("Diviner"),
    class = "NC_FORGE_LORD_DIVINER",
    attitude = 0,
    mission = "SHOPKEEP",
    gender = "female",
    chat = "TALK_FORGE_LORD_DIVINER",
    faction = "forge_lords",
    on_death = "trigger_forge_lockdown_on_death",
}

-- This is a unique NPC who doesn't get randomly selected background traits
ccb.content.define_npc_class {
    id = "NC_FORGE_LORD_DIVINER",
    name = ccb.content.text("Diviner"),
    job_description = ccb.content.text("I see the past, the present, and the future."),
    traits = {
        { trait = "VAULT_DEFENDER" },
        { trait = "LIBRARY_DEFENDER" },
        { group = "NPC_starting_traits" },
        { group = "Appearance_demographics" },
    },
    common = false,
    intelligence = { one_in = 4 },
    perception = { one_in = 4 },
    worn = "NC_FORGE_LIBRARIAN_clothes",
    skills = {
        {
            skill = "ALL",
            level = {
                mul = { { one_in = 3 }, { sum = { { dice = { 2, 2 } }, { constant = -2 }, { one_in = 4 } } } },
            },
        },
        { skill = "unarmed", bonus = { one_in = 2 } },
        { skill = "melee", bonus = { one_in = 2 } },
        { skill = "gun", bonus = { rng = { 0, 2 } } },
        { skill = "speech", bonus = { rng = { 1, 3 } } },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER",
    line = ccb.content.text("Are you looking for something?  I can help with anything but your own stuff.  You'll have to ask your mother for help with that."),
    replies = {
        {
            text = ccb.content.text("Can you help me find something?"),
            next_topic = "TALK_FORGE_DIVINER_FIND_WHAT",
        },
        {
            text = ccb.content.text("What are you doing here?"),
            next_topic = "TALK_FORGE_DIVINER_DOING",
        },
        { text = ccb.content.text("Well, bye."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_DIVINER_DOING",
    line = ccb.content.text("What are any of us really doing here in this dead and dying world?  I specialize in scrying, and while I wish I could say I'm in it to help lost souls find their way, the collective pockets of a thousand realities is a very good incentive.  I can help you find any number of things, but I take no responsibility for what happens when you find what you're looking for."),
    replies = {
        {
            text = ccb.content.text("Let's talk business then."),
            next_topic = "TALK_FORGE_LORD_DIVINER",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_DIVINER_FIND_WHAT",
    line = ccb.content.text("Perhaps.  What do you seek?"),
    replies = {
        {
            text = ccb.content.text("A dangerous location."),
            next_topic = "TALK_FORGE_LORD_DIVINER_DANGEROUS",
        },
        {
            text = ccb.content.text("A man made structure."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MAN_MADE",
            when = predicates.handler("dlg_p_magiclysm_941728746d69"),
        },
        {
            text = ccb.content.text("A man made structure."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MAN_MADE_INNAWOOD",
            when = predicates.handler("dlg_p_magiclysm_7c2159134cc6"),
        },
        {
            text = ccb.content.text("A geological formation."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GEOLOGY",
        },
        {
            text = ccb.content.text("A plant."),
            next_topic = "TALK_FORGE_LORD_DIVINER_PLANT",
        },
        {
            text = ccb.content.text("An animal."),
            next_topic = "TALK_FORGE_LORD_DIVINER_ANIMAL",
        },
        {
            text = ccb.content.text("A god."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GOD",
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
    id = "TALK_FORGE_LORD_DIVINER_DANGEROUS",
    line = ccb.content.text("A thrill seeker, are you?  So what will it be?"),
    replies = {
        { text = ccb.content.text("An ant nest."), next_topic = "TALK_FORGE_LORD_DIVINER_ANT" },
        {
            text = ccb.content.text("An acid ant nest."),
            next_topic = "TALK_FORGE_LORD_DIVINER_ACID_ANT",
        },
        {
            text = ccb.content.text("A dermatik nest."),
            next_topic = "TALK_FORGE_LORD_DIVINER_DERMATIK",
        },
        { text = ccb.content.text("Spiders."), next_topic = "TALK_FORGE_LORD_DIVINER_SPIDERS" },
        {
            text = ccb.content.text("A fungal growth."),
            next_topic = "TALK_FORGE_LORD_DIVINER_FUNGAL",
        },
        {
            text = ccb.content.text("A mi-go building."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MI_GO",
        },
        {
            text = ccb.content.text("A triffid grove."),
            next_topic = "TALK_FORGE_LORD_DIVINER_TRIFFID",
        },
        { text = ccb.content.text("A kraken cave."), next_topic = "TALK_FORGE_LORD_DIVINER_KRAKEN" },
        { text = ccb.content.text("A slime pit."), next_topic = "TALK_FORGE_LORD_DIVINER_SLIME" },
        { text = ccb.content.text("A goblin camp."), next_topic = "TALK_FORGE_LORD_DIVINER_GOBLIN" },
        {
            text = ccb.content.text("A swamp dragon cave!"),
            next_topic = "TALK_FORGE_LORD_DIVINER_SWAMP_DRAGON",
        },
        { text = ccb.content.text("A balrog mine."), next_topic = "TALK_FORGE_LORD_DIVINER_BALROG" },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_MAN_MADE",
    line = ccb.content.text("Seeking to pick around your civilization's corpse?  You're not the first and you won't be the last."),
    replies = {
        { text = ccb.content.text("A lab."), next_topic = "TALK_FORGE_LORD_DIVINER_LAB" },
        {
            text = ccb.content.text("An Exodii location."),
            next_topic = "TALK_FORGE_LORD_DIVINER_EXODII",
        },
        {
            text = ccb.content.text("A strange temple."),
            next_topic = "TALK_FORGE_LORD_DIVINER_TEMPLE",
        },
        {
            text = ccb.content.text("An attunement altar."),
            next_topic = "TALK_FORGE_LORD_DIVINER_ATTUNEMENT",
        },
        {
            text = ccb.content.text("A magic academy."),
            next_topic = "TALK_FORGE_LORD_DIVINER_ACADEMY",
        },
        { text = ccb.content.text("A wizard tower."), next_topic = "TALK_FORGE_LORD_DIVINER_TOWER" },
        {
            text = ccb.content.text("A druid tower."),
            next_topic = "TALK_FORGE_LORD_DIVINER_DRUID_TOWER",
        },
        { text = ccb.content.text("A goblin city."), next_topic = "TALK_FORGE_LORD_DIVINER_GOBLIN" },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_MAN_MADE_INNAWOOD",
    line = ccb.content.text("This reality does not seem to have a history of being inhabited by humans.  Perhaps humanity never evolved?  Or perhaps they never discovered this continent?  Either way, due to the portal storms, humans are here now.  And so are orcs and goblins.  I should be able to help you find some artificial structures.  What are you looking for?"),
    replies = {
        {
            text = ccb.content.text("A strange temple."),
            next_topic = "TALK_FORGE_LORD_DIVINER_TEMPLE",
        },
        {
            text = ccb.content.text("An attunement altar."),
            next_topic = "TALK_FORGE_LORD_DIVINER_ATTUNEMENT",
        },
        { text = ccb.content.text("A goblin camp."), next_topic = "TALK_FORGE_LORD_DIVINER_GOBLIN" },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_GEOLOGY",
    line = ccb.content.text("Sure.  Looking for a nice spot to watch the world end, perhaps?"),
    replies = {
        { text = ccb.content.text("A river."), next_topic = "TALK_FORGE_LORD_DIVINER_RIVER" },
        { text = ccb.content.text("A clay deposit."), next_topic = "TALK_FORGE_LORD_DIVINER_CLAY" },
        { text = ccb.content.text("A sand deposit."), next_topic = "TALK_FORGE_LORD_DIVINER_SAND" },
        { text = ccb.content.text("A hot spring."), next_topic = "TALK_FORGE_LORD_DIVINER_SPRING" },
        { text = ccb.content.text("A cave."), next_topic = "TALK_FORGE_LORD_DIVINER_CAVE" },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_PLANT",
    line = ccb.content.text("A plant you say?  Which one?"),
    replies = {
        {
            text = ccb.content.text("A magical plant."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MAGIC_PLANT",
        },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

-- TODO: make missions that spawns animals and put them here
ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_ANIMAL",
    line = ccb.content.text("I'm afraid I can't do that right now.  Sorry."),
    replies = {
        { text = ccb.content.text("Fair enough.  About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind then."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
    line = ccb.content.text("I see.  You could get some from trading with the merchants around here.  The librarian is crazy for beech nuts, for example.  I saw her trade away all her money and books for a literal truckload of the things in another reality earlier.  Not sure what she does with them.  You see, she's lined her private rooms with lead which just so happens to block my scrying.  Almost like she doesn't trust me.  Not sure why."),
    replies = { { text = ccb.content.text("Fair enough."), next_topic = "TALK_DONE" } },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_ANT",
    line = ccb.content.text("I see a giant ant cutting down a tree with her mandibles.  Did you know that worker ants are all female?  I see her friends around her as well.  I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_ANTS"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_ACID_ANT",
    line = ccb.content.text("I see a giant ant lobbing globs of acids at a group of unfortunate dogs.  It seems to be quite effective.  I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_ACID_ANTS"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_DERMATIK",
    line = ccb.content.text("Why would you ever want to get close to those creatures?  Don't you know they lay eggs inside of other creatures!?  Including humans!  Well, if you're sure you want to go there, I'll mark the location on your map for one denarius.  But don't come crying to me if you get poked full of dermatik larvae.  Seriously, don't.  I would like to keep my lunch.  If they do give you problems though, you might find that drinking mugwort oil helps.  It's made with, uh, mugwort.  And oil.  I think."),
    replies = {
        {
            text = ccb.content.text("Sure, why not."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_DERMATIK"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("On second <freaking> thought…"),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nope!  Fuck this.  I'm out."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS",
    line = ccb.content.text("Spiders it is then.  But of course, there are several different kinds of spiders out there.  Which type are you interested in?"),
    replies = {
        {
            text = ccb.content.text("Web spinners in a forest."),
            next_topic = "TALK_FORGE_LORD_DIVINER_SPIDERS_WEB",
        },
        {
            text = ccb.content.text("A pit full of spiders."),
            next_topic = "TALK_FORGE_LORD_DIVINER_SPIDERS_PIT",
        },
        {
            text = ccb.content.text("Demonic spiders."),
            next_topic = "TALK_FORGE_LORD_DIVINER_SPIDERS_DEMON",
        },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS_WEB",
    line = ccb.content.text("I see a grove covered in webs.  And legs.  So many legs.  I'll mark the location on your map for one denarius.  Just don't bring any of them back here."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SPIDER_WEB"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS_PIT",
    line = ccb.content.text("There is a burrow not too far away that is absolutely crawling with spiders.  Probably.  I didn't get a close look.  And I don't intend to.  I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SPIDER_PIT"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_SPIDERS_DEMON",
    line = ccb.content.text("Fascinating creatures, really.  They have evolved a way to channel their innate mana into potent fire spells.  Some demonic spider queens collect magical items as well.  Perhaps they have a way of absorbing the mana in them and use it for themselves?  I'll mark the lair of such a queen on your map for one denarius.  You might want to bring fire resistant clothing."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SPIDER_DEMON"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
        },
        {
            text = ccb.content.text("I can't afford that right now."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GET_MONEY",
            when = predicates.negate(predicates.has_item("speaker", "denarius")),
        },
        {
            text = ccb.content.text("No thanks.  Giant fire-breathing spiders are no joke."),
            next_topic = "TALK_NONE",
        },
        {
            text = ccb.content.text("Nevermind."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_FUNGAL",
    line = ccb.content.text("Ah yes, the extradimensional fungal dispersed intelligence known as the Mycus.  Quite a menace to interdimensional travelers, I tell you.  Some see them as a god.  Some see them as an existential threat.  And yet others see them as a good source of plant fibers.  Their cellular structure makes them highly adaptive to a wide variety of levels of reality, much like other fungal lifeforms.  Should you find yourself infected and without antifungal medicine, you can try rubbing sulphur on your skin.  It might not work, and it might irritate your skin, but anything is preferable to letting it run its course.  Should medication fail, don't bother with a bullet through your head.  It won't save you from your impending fate.  Instead, use fire, that's my advice.  Now then, the Mycus have a few different manifestations.  Which one are you interested in?"),
    replies = {
        { text = ccb.content.text("A bloom."), next_topic = "TALK_FORGE_LORD_DIVINER_FUNGAL_BLOOM" },
        { text = ccb.content.text("A tower."), next_topic = "TALK_FORGE_LORD_DIVINER_FUNGAL_TOWER" },
        {
            text = ccb.content.text("Some flowers."),
            next_topic = "TALK_FORGE_LORD_DIVINER_FUNGAL_FLOWERS",
        },
        {
            text = ccb.content.text("On second thought, maybe I'll go for something else…"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("You know what?  Never mind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_FUNGAL_BLOOM",
    line = ccb.content.text("I can almost smell them through the crystal ball.  Disturbing.  I'll mark the location on your map for one denarius.  Good luck.  You might need it."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_FUNGAL_BLOOM"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_FUNGAL_TOWER",
    line = ccb.content.text("Scrying on these things makes me uneasy, but I'll mark the location on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_FUNGAL_TOWER"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_FUNGAL_FLOWERS",
    line = ccb.content.text("I can't even number the times I've scraped this mess off of the forge.  It's like walking into a spider web at an hundred miles an hour, and the web also smells terribly and tries to eat you.  At least the magical torches the forgemaster has installed help a bit.  See, the Mycus fears fire, and for good reasons.  Anyways, I'll mark the location on your map for one denarius.  Don't eat the fruit."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_FUNGAL_FLOWERS"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_MI_GO",
    line = ccb.content.text("Right.  Fungal crustaceans from space.  Mighty unpleasant fellas, if you ask me.  But, uh, don't tell them I said so.  The forge lord says they mean no offense, that cutting people up is just their way of saying 'hi'.  Personally I find it rude, but perhaps that's anthropocentric of me.  But I digress.  Are you interested in an encampment or a scout tower?"),
    replies = {
        {
            text = ccb.content.text("An encampment."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MI_GO_ENCAMPMENT",
        },
        {
            text = ccb.content.text("A scout tower."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MI_GO_TOWER",
        },
        { text = ccb.content.text("On second thought…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_MI_GO_ENCAMPMENT",
    line = ccb.content.text("Have you seen mi-go architecture?  They make these living, organic structures out of resin.  Kind of cool.  And disturbing, I guess.  Of course, they'll cut you to pieces if you gawk at it too long.  I'll mark the location of one of these places on your map for one denarius.  I heard a story, not sure if it was true, but allegedly one guy tried to use the mi-go building resin as armor.  Apparently, it bore into the poor guy's flesh!  Like lichen!  His friends tried to tear it off, but it wouldn't bulge.  He was in so much pain they decided to put him out of his misery.  But they couldn't do it, because the armor was too good!  So I guess that in a sense it worked.  Heh.  The mental image still keeps me awake at night, occasionally.  And now you have it too.  You're welcome."),
    replies = {
        {
            text = ccb.content.text("Uh, sure.  Thanks?  It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_MI_GO_ENCAMPMENT"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_MI_GO_TOWER",
    line = ccb.content.text("The mi-go seem to abduct humans and animals for some alien purpose, and then build these towers for their spaceships to dock with to move the prisoners off-world.  Did I mention they have space ships?  Well, I've never actually seen one dock with a tower, but still.  I'll mark such a tower on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_MI_GO_TOWER"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_TRIFFID",
    line = ccb.content.text("Right.  Extradimensional intelligent plants with a mean streak.  They seem to have a method of traveling from reality to reality without traversing the hazards between.  Interesting, no?  I'd ask them how they do it but I don't think I could get a word in edgewise before they cut me to pieces.  I'll mark one of their groves on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_MI_GO_TOWER"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_KRAKEN",
    line = ccb.content.text("It seems that a group of mutated cephalopods have set up camp in a cave near the water.  I don't know what they're up to, but if you want to go and investigate I'll mark the cave on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_KRAKEN"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_SLIME",
    line = ccb.content.text("Do you like slime?  Do you like living slime that tries to eat you?  Do you wish you were surrounded by lots and lots and lots of it?  Then perhaps this place is the place for you.  I'll mark the place on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SLIME"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_GOBLIN",
    line = ccb.content.text("Good choice.  It seems that shortly before the world started to end, a few of them got it in their heads to just leave civilization alone for a bit and go live in the woods with other goblins.  And wargs.  Not a terrible idea if you ask me.  Anyways, there's a few different types of places they gather, are you looking for an encampment or an outpost?"),
    replies = {
        {
            text = ccb.content.text("An encampment."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GOBLIN_ENCAMPMENT",
        },
        {
            text = ccb.content.text("An outpost."),
            next_topic = "TALK_FORGE_LORD_DIVINER_GOBLIN_OUTPOST",
        },
        { text = ccb.content.text("On second thought…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_GOBLIN_ENCAMPMENT",
    line = ccb.content.text("You've got a long walk deep into the forest ahead of you.  Oh, and did I mention the wargs?  They've got these wargs that are absolutely adorable.  Of course they'll maul you if you try to pet them, but the temptation is always there.  I'll mark one of their camps on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_GOBLIN_ENCAMPMENT"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_GOBLIN_OUTPOST",
    line = ccb.content.text("Contrary to popular belief, goblins are not actually orcs.  Its the other way around.  Orcs are goblins who have taken one too many unlabeled potions and lived to tell the tale.  Sometimes this awakens powers much like my own.  Well, not exactly, if it did I'd be out of a job faster than a Magus could cast Phase Door.  Luckily for you, you shouldn't have to delve too deep into a forest to see for yourself.  I'll mark one of their outposts on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_GOBLIN_OUTPOST"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_SWAMP_DRAGON",
    line = ccb.content.text("Oh, fancy yourself a dragon slayer, eh?  It's my understanding they use a lot of acid, so be ready for that.  And remember that the body parts of dragons are quite valuable.  Even the blood, so you might wanna bring something to keep said blood in, and bleed the corpses before you butcher.  I'll mark it on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_SWAMP_DRAGON"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_BALROG",
    line = ccb.content.text("Now there is not a lot I can tell you about this one.  There is some kind of demonic beast living in this cave.  But it only surfaces occasionally, and the heavy metals in the cave walls interfere with my scrying.  There might be treasure down there, or there might not be.  But there is certain to be danger.  I'll mark it on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_BALROG"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_LAB",
    line = ccb.content.text("Deeply buried secret installations where shady government organizations conducted unethical experiments, free from moral constrains.  Did such places really exist before the Cataclysm, or did humanity's collective mistrust, superstition and conspiracy theories cause the portal storms to dream these places into existence?  I honestly can't tell, but I suppose it doesn't matter now.  These places do exist, and are ripe with mysteries, dangers, and loot.  You'll have to specify which kind you're looking for."),
    replies = {
        {
            text = ccb.content.text("Just a normal one."),
            next_topic = "TALK_FORGE_LORD_DIVINER_LAB_NORMAL",
        },
        {
            text = ccb.content.text("A nether lab."),
            next_topic = "TALK_FORGE_LORD_DIVINER_LAB_NETHER",
        },
        {
            text = ccb.content.text("On second thought, maybe I'll go for something else…"),
            next_topic = "TALK_NONE",
        },
        { text = ccb.content.text("You know what?  Never mind."), next_topic = "TALK_DONE" },
    },
}

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

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_GOD",
    line = ccb.content.text("Valzain is in the back, down in the vault, selling overpriced magical knick-knacks.  Or perhaps there was something else you had in mind?"),
    replies = {
        {
            text = ccb.content.text("Another forge?"),
            next_topic = "TALK_FORGE_LORD_DIVINER_OTHER_FORGE",
        },
        {
            text = ccb.content.text("A Lovecraftian horror."),
            next_topic = "TALK_FORGE_LORD_DIVINER_LOVECRAFTIAN",
        },
        {
            text = ccb.content.text("The Malignance."),
            next_topic = "TALK_FORGE_LORD_DIVINER_MALIGNANCE",
        },
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_OTHER_FORGE",
    line = ccb.content.text("There is only one Forge of Wonders.  It's not like this is a multidimensional franchise opportunity."),
    replies = {
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FORGE_LORD_DIVINER_LOVECRAFTIAN",
    line = ccb.content.text("There are these city-sized creatures called Void Leviathans that live in the vast nether regions between realities.  Sometimes they used to wash up onto Earths that had recently had a Cataclysm.  Caused all kinds of trouble, they did, so Valzain made it so they would spawn underground instead.  I can mark the marooned corpse of one such creature on your map for one denarius."),
    replies = {
        {
            text = ccb.content.text("It's a deal."),
            next_topic = "TALK_DONE",
            when = predicates.has_item("speaker", "denarius"),
            actions = { actions.assign_mission("MISSION_FORGE_DIVINER_LOVECRAFTIAN"), actions.handler("dlg_a_magiclysm_cad85f26d6fa") },
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
    id = "TALK_FORGE_LORD_DIVINER_MALIGNANCE",
    line = ccb.content.text("The Malignance is the cause for much of our woes.  It is the force animating the zombies.  It is responsible for the portal storms, and it seems to be absolutely bursting with hate.  Valzain theorizes that it used to be a fundamental force of nature or perhaps a school of magic that somehow grew conscious, or perhaps had a consciousness imposed on it.  Allegedly, the Mi-Go speak of a time before it existed, or perhaps a time in which it wasn't so dangerous.  By now, it is everywhere on Earth.  As far as I can tell, it builds no structures and has no bases of operation, so there is no place I can point you towards.  Sorry."),
    replies = {
        { text = ccb.content.text("About something else…"), next_topic = "TALK_NONE" },
        { text = ccb.content.text("Nevermind."), next_topic = "TALK_DONE" },
    },
}
