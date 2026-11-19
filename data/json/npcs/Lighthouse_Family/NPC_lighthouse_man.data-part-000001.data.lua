local ccb = require("ccb")

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_Background",
    line = ccb.content.text("I'm just a simple man from a simple family.  Before <the_cataclysm> I had a fishing boat, and I went to sea on it, to catch fish and other marine life.  This is how my grandfather lived, my father lived, and I began to live like that.  I had a large family, 7 children, but not many survived, only my wife and daughter remained…"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_hay",
    line = ccb.content.text("You know, pretty good.  It is cozy here, there is a lot of space, and most importantly, it's safe.  We even started considering this place as our new home.  By the way, while I was fishing, a bottle with a piece of paper came to the shore of our island.  Here, take a look.\", he gave you a piece of paper, something was written on it: '0030045-0030045-35321700', with something similar to lightning scribbled nearby.  \"I wonder what it could mean…"),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_survivors_yes",
    line = ccb.content.text("Good news, <name_g>.  One survivor sailed to us recently."),
}

ccb.content.define_dialogue_topic {
    id = "TALK_lighthouse_man_survivors_no",
    line = ccb.content.text("Nobody came, <name_g>.  I'm beginning to doubt that anyone else has survived besides us…"),
}
