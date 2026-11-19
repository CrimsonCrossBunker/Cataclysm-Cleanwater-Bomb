local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_intro",
    line = ccb.content.text("This is the New England Community Church, I should say it's one of their old retreats.  I'm Simon, the head chef around here."),
    replies = {
        { text = ccb.content.text("What's your story?"), next_topic = "TALK_GODCO_chef_past" },
        { text = ccb.content.text("Thanks for the info."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chef_past",
    line = ccb.content.text("I used to volunteer as a cook in a homeless shelter.  I met the church through that job; their missionaries would come by every so often and hand out essentials to people living there, then give a sermon in one of the back rooms.  Katherine and I wound up going to one of their sermons, and we've stayed connected since.  Working in that shelter taught me to cook on a shoestring budget; that's really useful these days, ya know."),
    replies = {
        {
            text = ccb.content.text("Where's your family now?"),
            next_topic = "TALK_GODCO_chef_family",
        },
        { text = ccb.content.text("Thanks, <name_g>.  See you around."), next_topic = "TALK_DONE" },
    },
}
