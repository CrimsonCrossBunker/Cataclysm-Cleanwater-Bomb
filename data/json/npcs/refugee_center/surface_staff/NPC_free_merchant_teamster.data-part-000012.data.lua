local ccb = require("ccb")
local actions = ccb.content.dialogue_actions

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Success",
    line = ccb.content.text("*looks over the papers for a moment, before pocketing them.  \"I'd say this is sufficient, here's some money for your trouble.  I'll get somebody on this.\""),
    replies = {
        {
            text = ccb.content.text("Glad to help."),
            next_topic = "TALK_DONE",
            actions = { actions.handler("dlg_a_dda_8224d2ff1410"), actions.clear_actor_value("speaker", "general_trade_u_think_suspicious_price"), actions.handler("dlg_a_dda_9d4a5a864597"), actions.transfer_items("godcotrader_accounting_records_dirty") },
        },
    },
}

ccb.content.define_dialogue_topic {
    id = "TALK_FREE_MERCHANT_TEAMSTER_Godco_Trader_Mission_Fail",
    line = ccb.content.text("*looks over the papers for a moment, before pocketing them.  \"This seems perfectly alright to me.  I don't know what you have against them, but give it up and quit wasting our time.\""),
    replies = {
        {
            text = ccb.content.text("Alright then, <name_b>.  I guess that's what I get for my troubles."),
            next_topic = "TALK_DONE",
            actions = { actions.clear_actor_value("speaker", "general_trade_u_think_suspicious_price"), actions.finish_mission("MISSION_INVESTIGATE_TRADER", { success = false }), actions.transfer_items("godcotrader_accounting_records_clean") },
        },
    },
}

ccb.content.define_mission {
    id = "directions_isherwood",
    name = ccb.content.text("Check out that farm"),
    description = ccb.content.text("Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "Isherwood Farm Mutable", terrain = "farm_isherwood_1", reveal_radius = 5 },
        handler = "set_teamster_mission_directions_to_isherwood",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
        offer = ccb.content.text("Ran into a bunch of farmers.  They don't want much to do with our caravans, but someone like you they might be OK with."),
        accepted = ccb.content.text("Nice."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Be careful.  It's rough out there."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("It is what it is."),
    },
}

ccb.content.define_mission {
    id = "directions_hub01",
    name = ccb.content.text("Check out that lab"),
    description = ccb.content.text("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "hub_01", terrain = "robofachq_surface_entrance", reveal_radius = 5 },
        handler = "set_teamster_mission_directions_to_hub01",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it."),
        offer = ccb.content.text("There's been rumors.  Folks talkin' about some kind of secret lab, out in the wilds, with survivors in it."),
        accepted = ccb.content.text("Nice."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Be careful.  It's rough out there."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("It is what it is."),
    },
}

ccb.content.define_mission {
    id = "directions_exodii",
    name = ccb.content.text("Check out that scrap metal castle"),
    description = ccb.content.text("A few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { terrain = "exodii_base_x0y3z0", special = "exodii_base", reveal_radius = 5 },
        handler = "set_teamster_mission_directions_to_exodii",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("A few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
        offer = ccb.content.text("A few of my caravans have come back now talkin' about this giant metal castle on top of a rock, in the middle of nowhere.  They ain't been crazy enough to check it out, but you could if you want."),
        accepted = ccb.content.text("Your funeral."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Be careful.  Seems like a rough place to me."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("Seems reasonable."),
    },
}

ccb.content.define_mission {
    id = "directions_artisans",
    name = ccb.content.text("Check out that bullet bank"),
    description = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea, but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
    goal = "MGOAL_GO_TO",
    difficulty = 2,
    value = 0,
    start = {
        target = { special = "isolated_road", terrain = "isolated_house_farm_gunsmith", reveal_radius = 2 },
        handler = "set_teamster_mission_directions_to_artisans",
    },
    origins = { "ORIGIN_SECONDARY" },
    dialogue = {
        describe = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea, but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
        offer = ccb.content.text("A few of my people have come back now talkin' about some yuppie trying to start a bank that uses bullets for money.  Silly idea, but the lad lives on a homestead with a woman who wouldn't let my guys leave without a full belly."),
        accepted = ccb.content.text("Hopefully they are still around."),
        rejected = ccb.content.text("Seems reasonable."),
        advice = ccb.content.text("Don't worry about the turrets they seem friendly to people."),
        inquire = ccb.content.text("How is the search going?"),
        success = ccb.content.text("Huh, go figure."),
        success_lie = ccb.content.text("Huh, go figure."),
        failure = ccb.content.text("Seems reasonable."),
    },
}
