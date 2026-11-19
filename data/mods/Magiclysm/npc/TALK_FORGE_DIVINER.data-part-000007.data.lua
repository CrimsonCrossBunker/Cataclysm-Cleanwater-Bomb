local ccb = require("ccb")

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
