local ccb = require("ccb")
local predicates = ccb.content.dialogue_predicates
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PROTOTYPE",
    line = {
        choices = {
            ccb.content.text("Sure, what would you like to know more about?"),
        },
    },
    replies = {
        {
            text = ccb.content.text("Can you work on one of these projects for me?"),
            next_topic = "TALK_BLACKSMITH_BUSY",
            when = predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } }),
        },
        {
            text = ccb.content.text("[Motion to the picture of some kind of rifle.] What's the 'OBREZ'?"),
            next_topic = "TALK_BLACKSMITH_OBREZ",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })),
        },
        {
            text = ccb.content.text("Is the Obrez finished?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_ONGOING",
            when = predicates.handler("dlg_p_dda_9928daec618a"),
        },
        {
            text = ccb.content.text("Is the Obrez finished?"),
            next_topic = "TALK_BLACKSMITH_OBREZ_COMPLETE",
            when = predicates.handler("dlg_p_dda_a37af3e3e24f"),
        },
        {
            text = ccb.content.text("[Motion to the picture of a switchblade.] What's the 'PRESSIN'?"),
            next_topic = "TALK_BLACKSMITH_PRESSIN",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })),
        },
        {
            text = ccb.content.text("Is the Pressin finished?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_ONGOING",
            when = predicates.handler("dlg_p_dda_01614f70a4ef"),
        },
        {
            text = ccb.content.text("Is the Pressin finished?"),
            next_topic = "TALK_BLACKSMITH_PRESSIN_COMPLETE",
            when = predicates.handler("dlg_p_dda_bb43aaaa8cd6"),
        },
        {
            text = ccb.content.text("[Motion to the picture of a mace styled with fire on the head.] What's the 'LOUVERTURE'?"),
            next_topic = "TALK_BLACKSMITH_LOUVERTURE",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })),
        },
        {
            text = ccb.content.text("Is the Louverture finished?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_ONGOING",
            when = predicates.handler("dlg_p_dda_2ed50ba0e45a"),
        },
        {
            text = ccb.content.text("Is the Louverture finished?"),
            next_topic = "TALK_BLACKSMITH_LOUVERTURE_COMPLETE",
            when = predicates.handler("dlg_p_dda_a3da54055121"),
        },
        {
            text = ccb.content.text("[Motion to the picture of a sledge hammer with a piston jutting from one face of the head.] What's the 'DISORDER'?"),
            next_topic = "TALK_BLACKSMITH_DISORDER",
            when = predicates.negate(predicates.any_equal({ "yes", { scope = "speaker", key = "dialogue_artisans_blacksmith_crafting" } })),
        },
        {
            text = ccb.content.text("Is the Disorder finished?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE_ONGOING",
            when = predicates.handler("dlg_p_dda_589176981e2b"),
        },
        {
            text = ccb.content.text("Is the Disorder finished?"),
            next_topic = "TALK_BLACKSMITH_DISORDER_COMPLETE",
            when = predicates.handler("dlg_p_dda_585fcebeaadb"),
        },
        {
            text = ccb.content.text("<end_talking_nevermind>"),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_OBREZ",
    line = ccb.content.text("The Obrez is a classic Mosin-Nagant that someone has cut down and removed the stock of.  The idea was that in some parts of the world a surplus rifle was easier than finding a pistol to conceal.  Way I see it, a sturdy classic gun like that with a bit of reinforcement could make a great mace.  You find me a functioning Mosin - any variant will do - and 50 merch for parts, and I can get this one working in a week."),
    replies = {
        {
            text = ccb.content.text("[Mosin-Nagant M44, 50 merch] See you in a week."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.all({ predicates.has_inventory("speaker", "mosin44", 1), predicates.has_inventory("speaker", "FMCNote", 50) }),
            actions = { actions.handler("dlg_a_dda_08be531f0d9f"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_37df5b1b43c7"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "obrez") },
        },
        {
            text = ccb.content.text("[Mosin-Nagant 1891/30, 50 merch] See you in a week."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.all({ predicates.has_inventory("speaker", "mosin91_30", 1), predicates.has_inventory("speaker", "FMCNote", 50) }),
            actions = { actions.handler("dlg_a_dda_3aaefcbaf2dc"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_37df5b1b43c7"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "obrez") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_OBREZ_COMPLETE",
    line = ccb.content.text("The gun is done, looking pretty sleek if you ask me.  All loaded and ready to cave in a zombie."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "none"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "no"), actions.handler("dlg_a_dda_65d478d2c372") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PRESSIN",
    line = ccb.content.text("The Pressin was a self defense weapon for politicians in Spain.  It was a small breach loaded handheld pistol that could fit in a glasses case and be fired subtly.  I figure that we can improve on the design by adding a retracting blade while keeping the surprise shots.  To get this working I'm gonna need a .32 gun like a LWS Seecamp, or a Walther PPK.  I'll also need a switchblade, 20 merch, and a week."),
    replies = {
        {
            text = ccb.content.text("[PPK, switchblade, 20 merch] See you in a week."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.all({ predicates.has_inventory("speaker", "walther_ppk", 1), predicates.has_inventory("speaker", "switchblade", 1), predicates.has_inventory("speaker", "FMCNote", 20) }),
            actions = { actions.handler("dlg_a_dda_983c2a6eee35"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_37df5b1b43c7"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "pressin") },
        },
        {
            text = ccb.content.text("[LWS, switchblade, 20 merch] See you in a week."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.all({ predicates.has_inventory("speaker", "lws32", 1), predicates.has_inventory("speaker", "switchblade", 1), predicates.has_inventory("speaker", "FMCNote", 20) }),
            actions = { actions.handler("dlg_a_dda_8433ca3fd914"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_37df5b1b43c7"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "pressin") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_PRESSIN_COMPLETE",
    line = ccb.content.text("The gun's done.  Mind the safety on the side, this guy is pretty dangerous."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "none"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "no"), actions.handler("dlg_a_dda_31bf1034fb5b") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_LOUVERTURE",
    line = ccb.content.text("Oh, that's one of my sillier ideas.  Jay is convinced it'll never work but I really want to give it a shot.  A traditional mace with gas-venting ports and an ignition system for mini bursts of fire.  Maybe I've just played too many RPGs, but it seems worth a shot.  To get this one working I'm gonna need a real deal mace -  something that can handle the pressure - as well as a military grade flamethrower.  Fabrication will definitely take two weeks on this one."),
    replies = {
        {
            text = ccb.content.text("[Mace, flamethrower] See you in 2 weeks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.all({ predicates.has_inventory("speaker", "flamethrower", 1), predicates.has_inventory("speaker", "mace", 1) }),
            actions = { actions.handler("dlg_a_dda_e0047564db97"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_37df5b1b43c7"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "LOUVERTURE") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_LOUVERTURE_COMPLETE",
    line = ccb.content.text("The mace is done.  It honestly works pretty great too.  Hope you get some good use out of it."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "none"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "no"), actions.handler("dlg_a_dda_85290486bb5f") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_DISORDER",
    line = ccb.content.text("The Disorder is already kind of a real thing.  I got the idea from a viral video I saw of a guy making something similar with a baseball bat for hitting home runs.  Takes a sledge hammer with a center mounted piston that you can arm with .22 caliber blanks.  When you hit a zombie with that sweet spot… boom.  The blank goes off and sends the piston straight down into whatever poor fucker you hit it with.  I'll need a sledge hammer, 80 merch, and at least 20 .22 LR rounds.  Fabrication will definitely take two weeks on this one."),
    replies = {
        {
            text = ccb.content.text("[Sledge hammer, 80 merch, 20 .22 LR] See you in 2 weeks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            when = predicates.all({ predicates.has_inventory("speaker", "hammer_sledge", 1), predicates.has_inventory("speaker", "FMCNote", 80), predicates.has_inventory("speaker", "22_lr", 20) }),
            actions = { actions.handler("dlg_a_dda_0fa0528165b4"), actions.adjust_faction_trust(1), actions.handler("dlg_a_dda_37df5b1b43c7"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "yes"), actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "DISORDER") },
        },
        {
            text = ccb.content.text("What about another project?"),
            next_topic = "TALK_BLACKSMITH_PROTOTYPE",
        },
        {
            text = ccb.content.text("<done_conversation_section>"),
            next_topic = "TALK_BLACKSMITH_SERVICES",
        },
        {
            text = ccb.content.text("I'll check in later."),
            next_topic = "TALK_DONE",
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_BLACKSMITH_DISORDER_COMPLETE",
    line = ccb.content.text("The beast is done!  Really heavy-duty, but really packs a punch.  Be careful with your fingers.  I'm serious, this thing could tear 'em off."),
    replies = {
        {
            text = ccb.content.text("Thanks."),
            next_topic = "TALK_BLACKSMITH_SERVICES",
            actions = { actions.set_actor_value("speaker", "dialogue_artisans_u_current_project", "none"), actions.set_actor_value("speaker", "dialogue_artisans_blacksmith_crafting", "no"), actions.handler("dlg_a_dda_2ddd12328402") },
        },
    },
}
