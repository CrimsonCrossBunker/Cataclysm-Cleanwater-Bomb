local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_FABRICATE",
    line = ccb.content.gendered_line("Sure.  After what you did for me, I'd equip an army for you.  I'll need some money to negotiate with the caravans and scavengers that come by.  What level of protection are you thinking?  I can do 2mm, 4mm, and 6mm suits depending on how much you want to resemble a tank, or I can make you a suit of chainmail instead if you want a little more flexibility.  Materials costs are 300 merch to pay for the food I need to do the labor plus 100 merch per 2mm or 50 merch for the chainmail.  Whatever I save in non-scaling bits like the chain and leather, I get gouged in looking for so much bulk metal.", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Forget it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        {
            text = ccb.content.text("[350 merch, 1.2mm] I'd prefer to just have chainmail."),
            next_topic = "TALK_BLACKSMITH_FABRICATE_TYPE",
            actions = { actions.handler("dlg_a_dda_db2166a6ab20") },
        },
        {
            text = ccb.content.text("[400 merch, 2mm] I like to stay light."),
            next_topic = "TALK_BLACKSMITH_FABRICATE_TYPE",
            actions = { actions.handler("dlg_a_dda_97b074dc81c4") },
        },
        {
            text = ccb.content.text("[500 merch, 4mm] A middle ground would be good."),
            next_topic = "TALK_BLACKSMITH_FABRICATE_TYPE",
            actions = { actions.handler("dlg_a_dda_3786795f0a8c") },
        },
        {
            text = ccb.content.text("[600 merch, 6mm] Never skimp on protection."),
            next_topic = "TALK_BLACKSMITH_FABRICATE_TYPE",
            actions = { actions.handler("dlg_a_dda_0cd5a7b2ebaa") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_FABRICATE_TYPE",
    line = {
        joined = {
            ccb.content.text("Alright, <u_val:number_artisans_blacksmith_thickness>mm, so the next question is time.  Currently, it's the classic problem: if you want quality, you gotta wait.  Two processes I could offer that you would be hard-pressed to find anywhere else are either really great high carbon steel, or I can go through the lengthy process of tempering.  High carbon will take three weeks to process and do the work, and tempering will take me four."),
            {
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting_EXODII" } }),
            yes = ccb.content.text("  For five I could, I think, create a suit of that nomad armor.  It would incorporate climate control, help you support more weight, and it'll have a jumpsuit built in, but you won't be able to wear normal clothes with it."),
            no = "",
        },
        },
    },
    replies = {
        {
            text = ccb.content.text("[3 weeks, great protection] High steel sounds great."),
            next_topic = "TALK_BLACKSMITH_FABRICATE_MEASUREMENTS",
            actions = { actions.handler("dlg_a_dda_bde9f93a7629") },
        },
        {
            text = ccb.content.text("[4 weeks, exceptional protection] I'll wait for the best you can do."),
            next_topic = "TALK_BLACKSMITH_FABRICATE_MEASUREMENTS",
            actions = { actions.handler("dlg_a_dda_ca27ab412f95") },
        },
        {
            text = ccb.content.text("[5 weeks, CBM-integrated protection] I'd like nomad armor."),
            next_topic = "TALK_BLACKSMITH_FABRICATE_MEASUREMENTS",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_has_exodii_items" } }),
            actions = { actions.handler("dlg_a_dda_316a3462afa6") },
        },
        {
            text = ccb.content.text("Forget it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_FABRICATE_MEASUREMENTS",
    line = {
        when = predicates.handler("dlg_p_dda_b9a36d7530d8"),
        yes = ccb.content.text("Alright, so it'll be <u_val:number_artisans_blacksmith_thickness>mm armor made of the best high steel a woman can scavenge.  If you're good with that, I'll take the merch up front and we can start taking some very invasive measurements."),
        no = {
            when = predicates.handler("dlg_p_dda_b595ec4ab494"),
            yes = ccb.content.text("Alright, so it'll be <u_val:number_artisans_blacksmith_thickness>mm armor made with some of the best fabrication techniques the world has ever seen.  If you're good with that, I'll take the merch up front and we can start taking some very invasive measurements."),
            no = ccb.content.text("Alright, so it'll be <u_val:number_artisans_blacksmith_thickness>mm armor made with some of the best fabrication techniques the world has ever seen, as well as help from some extradimensional friends.  I'd be lying if I said I wasn't excited.  If you're good with that, I'll take the merch up front and we can start taking some very invasive measurements."),
        },
    },
    replies = {
        {
            text = ccb.content.text("[<u_val:number_artisans_blacksmith_armor_cost> merch] Sounds good.  See you in <u_val:number_artisans_blacksmith_wait> weeks."),
            next_topic = "TALK_DONE",
            when = predicates.handler("dlg_p_dda_4d44d70c6ce3"),
            actions = { actions.handler("dlg_a_dda_5861f17f7748"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "armor"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.handler("dlg_a_dda_40a7125572e6") },
            switch = true,
        },
        {
            text = ccb.content.text("Um… wait, I don't have that kind of money right now."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            switch = true,
        },
        {
            text = ccb.content.text("Forget it."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_ARMOR_READY",
    line = {
        when = predicates.handler("dlg_p_dda_409771bcffe0"),
        yes = ccb.content.text("It's all done!  Sorry for the long wait; hopefully it's worth it.  If you need it refitted, let me know."),
        no = ccb.content.text("Still working on it."),
    },
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.handler("dlg_p_dda_409771bcffe0"),
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "no"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "none"), actions.handler("dlg_a_dda_eea221b4f115"), actions.clear_actor_value("speaker", "number_artisans_blacksmith_wait"), actions.clear_actor_value("speaker", "number_artisans_blacksmith_thickness"), actions.clear_actor_value("speaker", "number_artisans_blacksmith_armor_cost"), actions.clear_actor_value("speaker", "timer_artisans_u_waiting_on_armor") },
            switch = true,
        },
        {
            text = ccb.content.text("See you when it's done."),
            next_topic = "TALK_DONE",
            switch = true,
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PROTOTYPE_EXODII",
    line = {
        choices = {
            ccb.content.text("Oh wow, this is really interesting, huh?  The way they balance weight for travel is genius.  If you wanted a real suit of armor for a traveling warrior, I think I could do it with this.  I'll need one of each of these wire kits, though, for each set I make.  Bring some to me if you want me to use them."),
        },
    },
    on_enter = {
        { actions = { actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting_EXODII", "yes") } },
    },
    replies = {
        {
            text = ccb.content.text("I have some right now.  [Hand over a CBM interface wire kit and an external climate control kit.]"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_EXODII_ITEMS_READY",
            when = predicates.all({ predicates.has_item("speaker", "exodii_ac_kit"), predicates.has_item("speaker", "exodii_wire_kit") }),
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_has_exodii_items", "yes"), actions.handler("dlg_a_dda_30d1c7bc6287") },
        },
        {
            text = ccb.content.text("I'll try and find some."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PROTOTYPE_EXODII_ITEMS",
    line = ccb.content.gendered_line("Yeah; the designs you showed me call for 'em.  Not sure what they are myself, but the pictures are real descriptive about how to use them.  To make anything, I'll need one of each of those wire kits.  Got any?", { "speaker" }),
    replies = {
        {
            text = ccb.content.text("Here you go.  [Hand over a CBM interface wire kit and an external climate control kit.]"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_EXODII_ITEMS_READY",
            when = predicates.all({ predicates.has_item("speaker", "exodii_ac_kit"), predicates.has_item("speaker", "exodii_wire_kit") }),
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_has_exodii_items", "yes"), actions.handler("dlg_a_dda_30d1c7bc6287") },
        },
        {
            text = ccb.content.text("Not right now."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PROTOTYPE_EXODII_ITEMS_READY",
    line = ccb.content.gendered_line("Thanks, sugar!  If you ever have me make some armor, just let me know if you want me to use these in it.", { "speaker" }),
}
