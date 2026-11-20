local ccb = require("ccb")

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
