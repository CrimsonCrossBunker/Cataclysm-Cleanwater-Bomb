local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_precata_job",
    line = {
        choices = {
            ccb.content.text("I used to work for the U.S Postal Service, I was a mail carrier.  Delivered all the letters, packages, and mail orders to the residents of <city>, door-to-door.  It was pretty hard at times, but it kept me fit and on the road."),
        },
    },
    replies = {
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Do you have any hobbies?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_hobbies",
    line = {
        choices = {
            ccb.content.text("I really like to draw things, I primarily did landscapes in my spare time.  I like paper-and-pencil sketches, but I have worked with watercolors and oil canvases.  Never could get my head around the digital stuff, though, too complex for me and I never had a good free hand with a stylus.  I also shot a bit, went hunting a few times.  I mainly went to the gun range though, shotguns were always my forte.  Besides that, I watched some TV and regular ol' stuff.  I also like to read quite a bit, too."),
        },
    },
    replies = {
        {
            text = ccb.content.text("I guess those shooting skills come in handy these days."),
            next_topic = "TALK_GODCO_guard_food_gunskills_inhandy",
        },
        {
            text = ccb.content.text("You must be a very good artist then.  Do you still have time to draw?"),
            next_topic = "TALK_GODCO_guard_food_art",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_gunskills_inhandy",
    line = {
        choices = {
            ccb.content.text("I guess they will.  I pray to God that I won't have to shoot someone, I never want to be forced into deciding between life or death."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about your hobbies again?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_GODCO_guard_food_art",
    line = {
        choices = {
            ccb.content.text("I'm alright at it, I guess.  I'm no Van Gough or Botticelli, but I get along with it and do my best.  I've started using the desk up here to work on these days, I just need to keep my firearm close and one eye on the door."),
        },
    },
    replies = {
        {
            text = ccb.content.text("What did you do for a job before <the_cataclysm>?"),
            next_topic = "TALK_GODCO_guard_food_precata_job",
        },
        {
            text = ccb.content.text("Do you have any family?"),
            next_topic = "TALK_GODCO_guard_food_family",
            when = predicates.handler("dlg_p_dda_f98058ef3692"),
        },
        {
            text = ccb.content.text("Could you tell me about your hobbies again?"),
            next_topic = "TALK_GODCO_guard_food_hobbies",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_GODCO_guard_food_idlechat",
        },
        {
            text = ccb.content.text("<end_talking_leave>  <end_talking_bye>"),
            next_topic = "TALK_DONE",
        },
    },
}
