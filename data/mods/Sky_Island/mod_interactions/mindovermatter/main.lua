local ccb = require("ccb")
local content = ccb.content

content.patch_profession("psi_teleporter_slider", {
    name_male = ccb.content.text("Itzcuāuhtli Corps Liaison, Yohualli Ehēcatl Division", "profession_male"),
    name_female = ccb.content.text("Itzcuāuhtli Corps Liaison, Yohualli Ehēcatl Division", "profession_female"),
    remove_flags = { "SCEN_ONLY" },
})
