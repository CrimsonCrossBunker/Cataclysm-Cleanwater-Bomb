local ccb = require("ccb")

ccb.content.define_mutation {
    id = "PrepNet",
    name = ccb.content.text_without_extraction("PrepNet Tag"),
    points = 0,
    valid = false,
    description = ccb.content.text_without_extraction("NPC trait that makes monsters see it as a PrepNet.  It is a bug if you have it."),
    player_display = false,
    threshold = true,
}

ccb.content.define_mutation {
    id = "PROF_SYSTEM_SECURITY",
    name = ccb.content.text("Local System Security"),
    points = 0,
    description = ccb.content.text("You are a duly sworn law enforcement officer, with jurisdiction that technically extends to the Salus System.  Whether you can find anyone who that matters to is questionable."),
    valid = false,
    purifiable = false,
    profession = true,
}

ccb.content.define_mutation {
    id = "PROF_PINKERTON",
    name = ccb.content.text("Pinkerton"),
    points = 0,
    description = ccb.content.text("You are an UICA affiliated private-security professional, with jurisdiction that technically extends to the Salus System.  Whether you can find anyone who that matters to is questionable."),
    valid = false,
    purifiable = false,
    profession = true,
}

ccb.content.define_mutation {
    id = "PROF_TRAVELING_DOCTOR",
    name = ccb.content.text("MD"),
    points = 0,
    description = ccb.content.text("You're a doctor who went out to space and has somehow ended up out on the frontier in the Salus System.  At least out here you get a lot more hands on life or death work compared to the core UICA worlds."),
    valid = false,
    purifiable = false,
    profession = true,
}

ccb.content.define_mutation {
    id = "PROF_UICA_INSPECTOR",
    name = ccb.content.text("UICA Inspector"),
    points = 0,
    description = ccb.content.text("You are a UICA Inspector from a civilized part of space.  You have the authority to investigate under a variety of different legal frameworks, UICA, planetary, corporate, system, pre-Discontinuity legal systems for worlds that have only recently been re-discovered.  All of this means that you are nearly a law unto yourself, though you wonder how much that matters in a place like Salus IV outside of maybe Port Augustmoon."),
    valid = false,
    purifiable = false,
    profession = true,
}

ccb.content.define_mutation {
    id = "PROF_UICA_SECRET_POLICE",
    name = ccb.content.text("UICA Astrographic and Gatepoint Agent"),
    points = 0,
    description = ccb.content.text("As a member of the Astrographic and Gatepoint Division you are responsible for spreading the boundaries of the Frontiers and protecting interstellar travel.  This gives you wide ranging latitude when it comes to addressing threats to interstellar travel.  Does this technically make you a member of UICA's very own secret police?  Yes, yes it does."),
    cancels = { "PROF_HUB01_ANCILLIARY" },
    valid = false,
    purifiable = false,
    profession = true,
}
