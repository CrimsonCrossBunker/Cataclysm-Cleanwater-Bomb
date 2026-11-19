local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_past",
    line = ccb.content.gendered_line("You're creepy.  I'm sorry for your lack of friends but, like, I'm literally a kid.  Everyone on Earth turned into a zombie, we're running out of toilet paper and everything, and my parents are gone.  I know they're still alive and they're looking for me.  I miss them.  Is that enough personal stuff for you?", { "speaker" }),
    on_enter = {
        {
            actions = { actions.set_actor_value("interlocutor", "told_backstory_second_attempt", "yes") },
        },
    },
    replies = {
        {
            text = ccb.content.text("I'm sorry for your loss.  <done_conversation_section>"),
            next_topic = "TALK_GODCO_chloe",
        },
        { text = ccb.content.text("Yeah, that's enough for me."), next_topic = "TALK_DONE" },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_past_2",
    line = ccb.content.text("Well, I grew up in the city.  My parents were always out of town on some business meeting or another, so I had plenty of time to myself.  They're great people; mom's a wonderful cook, she makes an amazing fish casserole.  Dad's a hot shot for military contracts, he handled business deals for DARPA and whatnot.  He's an ex-marine, and taught me how to defend myself with a knife."),
    replies = {
        {
            text = ccb.content.text("Where do you think your parents are now?"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_backstory", "yes") },
            next_topic = "TALK_GODCO_chloe_parents_where",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_chloe_sonia",
    line = ccb.content.text("I was home alone during the ongoing riots.  My parents chose the worst possible time to reconnect, which sucks, but I'm also kinda happy for them.  Anyway, they were part of the NECC people, so they knew about this place and their plans and all.  Thing is, it was, like, really far away.  I kinda didn't want to go alone but I also didn't want the rioters to eat me, so I asked Sonia - my neighbor - to evacuate with me, I guess.  So that was fun; escaping my hometown, walking down the country road, waiting for a horror to ambush us.  Spoiler alert: we were attacked.  So this zombie shambles in front of us and Sonia whacks it real hard with her guitar!  Its brain splatters all over the pavement, I threw up 'cause it was so disgusting.  We got here soon after that.  My parents weren't here, obviously.  Oh man, they must worry about me so much…"),
    replies = {
        {
            text = ccb.content.text("Aren't you a bit young to be carrying a knife?"),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_about_sonia", "yes") },
            next_topic = "TALK_GODCO_chloe_knife",
        },
        {
            text = ccb.content.text("Thanks for the info.  Let's chat about something else."),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_about_sonia", "yes") },
            next_topic = "TALK_GODCO_chloe_idle_chat",
        },
        {
            text = ccb.content.text("Thanks for the info."),
            actions = { actions.set_actor_value("interlocutor", "general_meeting_told_about_sonia", "yes") },
            next_topic = "TALK_DONE",
        },
    },
}
