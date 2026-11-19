local ccb = require("ccb")

-- These are all random people you met in a bar once, the fact that they don't have names is meant to emphasize the transient nature of the conversations you have with them
ccb.content.define_npc {
    id = "BEM_gunrunner",
    unique_name = ccb.content.text("the enterprising gunrunner"),
    class = "NC_BEM_GUNRUNNER",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_GUNRUNNER_1",
    faction = "robofac_auxiliaries",
}

-- EOC-specific, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "BEM_prototype_cyborg_with_yonked_bionics",
    suffix = ccb.content.text("cyborg rescue"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BGSS_CYBORG_1_STORY1",
    faction = "your_followers",
}

-- EOC-specific, should not spawn outside of trigger events.
ccb.content.define_npc {
    id = "BEM_prototype_cyborg_with_bionics",
    suffix = ccb.content.text("kicking cyborg"),
    class = "NC_CYBORG_RESCUE",
    attitude = 0,
    mission = "GUARD",
    chat = "BGSS_CYBORG_1_STORY1",
    faction = "your_followers",
}

ccb.content.define_npc {
    id = "BEM_silent_veteran",
    unique_name = ccb.content.text("the drinking veteran"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_CHATTING_VETERANS_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_chatting_veteran",
    unique_name = ccb.content.text("the drinking veteran"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_CHATTING_VETERANS_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_drugrunner",
    unique_name = ccb.content.text("the pill pusher"),
    class = "NC_BEM_DRUGRUNNER",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_DRUGRUNNER_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_jabberwock",
    unique_name = ccb.content.text("the traumatized traveler"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_JABBERWOCK_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_human_sample",
    unique_name = ccb.content.text("the shady mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_HUMAN_SAMPLE_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_anchor_seller",
    unique_name = ccb.content.text("the disconsolate mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_ANCHOR_SELLER_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_template_seller",
    unique_name = ccb.content.text("the cheerful mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_TEMPLATE_SELLER_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_keycard_seller",
    unique_name = ccb.content.text("the ID forger"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_KEYCARD_SELLER_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_hireable",
    suffix = ccb.content.text("Mercenary"),
    class = "NC_ANCILLA_GRUNT",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_HIREABLE_1",
    faction = "robofac_auxiliaries",
}

ccb.content.define_npc {
    id = "BEM_exodii_hunter",
    unique_name = ccb.content.text("the decorated hunter"),
    class = "NC_BEM_EXODII_HUNTER",
    attitude = 0,
    mission = "GUARD",
    chat = "BEM_EXODII_HUNTER_1",
    faction = "robofac_auxiliaries",
}
