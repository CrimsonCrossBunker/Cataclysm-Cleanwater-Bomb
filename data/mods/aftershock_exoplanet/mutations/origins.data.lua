local ccb = require("ccb")

ccb.content.define_mutation {
    id = "AFS_BKGR_ABSTRACT",
    name = ccb.content.text("Unknown background"),
    points = 0,
    description = ccb.content.text("You have no idea where you came from, or what you were doing before you ended up in the frontier."),
    types = { "ORIGIN_HOBBY" },
    valid = false,
    purifiable = false,
}

-- Multiple origins are Earthlings, so this one doesn't conflict with other origins.
ccb.content.define_mutation {
    id = "BKGR_EARTH",
    name = ccb.content.text("Earthling"),
    copy_from = "AFS_BKGR_ABSTRACT",
    description = ccb.content.text("Your mannerisms and accent are a dead giveaway that you were raised on Earth.  Whatever your thoughts about the homeworld might be, the simple fact that you can call it home is likely to affect relationships with people liable to care about such things."),
    types = {},
}

ccb.content.define_mutation {
    id = "BKGR_NOETIC_SCION",
    name = ccb.content.text("Noetic Scion"),
    copy_from = "AFS_BKGR_ABSTRACT",
    description = ccb.content.text("Your appearance and distinctive tattoos mark you as a noetic scion, a member of one of the powerful families who maintained and even strengthened their esper powers through and after the Discontinuity by means of careful breeding programs.  Others may react to you with caution or seek to use you, despite that as a \"skip\", your family's powers have not been passed down to you.  Their legacy, however, remains in your genes."),
}

ccb.content.define_mutation {
    id = "BKGR_SPACER",
    name = ccb.content.text("Spacer"),
    copy_from = "AFS_BKGR_ABSTRACT",
    cancels = { "BKGR_EARTH" },
    description = ccb.content.text("You have lived most of your life aboard starships and stations.  Seeing the horizon still makes you uneasy."),
    points = 0,
}

ccb.content.define_mutation {
    id = "BKGR_CORPORATE",
    copy_from = "AFS_BKGR_ABSTRACT",
    name = ccb.content.text("Corporate Aspirant"),
    description = ccb.content.text("You were born and raised within a corporate creche, where your every action was monitored to asses your value."),
}

ccb.content.define_mutation {
    id = "BKGR_UICA",
    copy_from = "AFS_BKGR_ABSTRACT",
    name = ccb.content.text("UICA Veteran"),
    description = ccb.content.text("You once fought within the ground assault forces of the United Interstellar Coordination Authority, the dominant government of the age.  Most of that was keeping watch over spaceports, but you do have some combat experience to your name.  Shared experiences with other veterans may help you find allies."),
}

ccb.content.define_mutation {
    id = "BKGR_INSURGENT",
    copy_from = "AFS_BKGR_ABSTRACT",
    name = ccb.content.text("Exiled Insurgent"),
    cancels = { "BKGR_EARTH" },
    description = ccb.content.text("When Earth came to crush your dreams of freedom underfoot, you were one of the few wise enough to flee into the deep frontier.  You have lived as a fugitive and pariah ever since, wanted by the law and rejected by your own people."),
}

ccb.content.define_mutation {
    id = "BKGR_REDISCOVERED_TRIBAL",
    name = ccb.content.text("Rediscovered Tribal"),
    copy_from = "AFS_BKGR_ABSTRACT",
    description = ccb.content.text("During the centuries of the discontinuity, several nominally-habitable worlds maintained human life but lost all technologically advanced civilization.  Even today, most of them remain \"underdeveloped\" you were born in one such world."),
}

ccb.content.define_mutation {
    id = "BKGR_PERIPHERY",
    copy_from = "AFS_BKGR_ABSTRACT",
    name = ccb.content.text("Survivor"),
    description = ccb.content.text("You are well acquainted with the hardships of life on the frontier, and with the dangers and promises of the ancient ruins within."),
}

ccb.content.define_mutation {
    id = "BKGR_UPPER_CLASS",
    copy_from = "AFS_BKGR_ABSTRACT",
    name = ccb.content.text("Shielded Youth"),
    description = ccb.content.text("You remember the great luxury of your childhood, the endless parties underneath diamond-glass domes, the great entourages of servants and companions, and the backdoor plays and plots against your peers for the future of humanity.  How little they must think of you now, if they even remember you at all."),
}

ccb.content.define_mutation {
    id = "AFS_BRUTAL_STRENGTH",
    name = ccb.content.text("Vatgrown Strength"),
    copy_from = "AFS_BKGR_ABSTRACT",
    description = ccb.content.text("Genetic tampering made your body incredibly strong.  Strength + 7."),
    points = 2,
    cancels = { "STR_UP" },
    enchantments = { "INLINE_ENCH_AFS_BRUTAL_STRENGTH_0" },
}
