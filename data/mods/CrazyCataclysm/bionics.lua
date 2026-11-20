local ccb = require("ccb")
local content = ccb.content

-- Native bionic definitions
content.add(content.Bionic {
    id = "bio_chest_gun",
    name = ccb.content.text("Ionic Overload Generator"),
    description = ccb.content.text("A powerful ion energy generator is implanted on your chest.  Fires a powerful, ever-expanding energy blast.  The resulting blast ignites oxygen creating fires as it moves and an explosion on impact.  Close range use is highly discouraged."),
    fake_weapon = "bio_ion_gun",
    flags = { "BIONIC_GUN" },
    occupied_bodyparts = { { bodypart = "torso", slots = 20 } },
})
