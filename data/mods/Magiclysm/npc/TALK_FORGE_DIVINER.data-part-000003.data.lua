local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

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
