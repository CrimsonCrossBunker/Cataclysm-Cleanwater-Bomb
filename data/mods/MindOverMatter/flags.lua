local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "LIFESHIELD",
    info = ccb.content.text("You are immune to life drain."),
})

-- Immune to telekinetic damage
content.upsert_json_flag(content.JsonFlag { id = "TELEKIN_SHIELD" })

content.upsert_json_flag(content.JsonFlag {
    id = "TEEPSHIELD",
    info = ccb.content.text("You are immune to telepathy."),
})

content.add(content.JsonFlag {
    id = "TELESTOP",
    info = ccb.content.text("You are immune to forcible teleportation."),
})

content.add(content.JsonFlag {
    id = "PSYSHIELD_PROTECT",
    info = ccb.content.text("You are protected against telepathic attack.  Sometimes."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_BIOKINESIS",
    info = ccb.content.text("This is a matrix crystal attuned to biokinesis."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_CLAIRSENTIENCE",
    info = ccb.content.text("This is a matrix crystal attuned to clairsentience."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_ELECTROKINESIS",
    info = ccb.content.text("This is a matrix crystal attuned to electrokinesis."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_PHOTOKINESIS",
    info = ccb.content.text("This is a matrix crystal attuned to photokinesis."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_PYROKINESIS",
    info = ccb.content.text("This is a matrix crystal attuned to pyrokinesis."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_TELEKINESIS",
    info = ccb.content.text("This is a matrix crystal attuned to telekinesis."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_TELEPATHY",
    info = ccb.content.text("This is a matrix crystal attuned to telepathy."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_TELEPORTATION",
    info = ccb.content.text("This is a matrix crystal attuned to teleportation."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_VITAKINESIS",
    info = ccb.content.text("This is a matrix crystal attuned to vitakinesis."),
})

content.add(content.JsonFlag {
    id = "MATRIX_CRYSTAL_CORUSCATING",
    info = ccb.content.text("This is a matrix crystal with an unclear attunement."),
})

content.add(content.JsonFlag { id = "PHOTOKINETIC" })

-- Immune to photokinetic damage
content.add(content.JsonFlag { id = "PHOTOKIN_CHAR_IMMUNE" })

-- Used to tag foods to be radiation sterilized
content.add(content.JsonFlag { id = "PHOTOKIN_IRRADIATION_READY" })

content.add(content.JsonFlag { id = "FIFTH_SUN_TECHNOLOGY" })
content.add(content.JsonFlag { id = "MOM_SHADOW_URGE_CHOICE" })
