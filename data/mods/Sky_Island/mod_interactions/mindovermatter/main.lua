local content = require("ccb").content
local text = content.text

content.patch_profession("psi_teleporter_slider", {
    name_male = text("Itzcuāuhtli Corps Liaison, Yohualli Ehēcatl Division", "profession_male"),
    name_female = text("Itzcuāuhtli Corps Liaison, Yohualli Ehēcatl Division", "profession_female"),
    remove_flags = { "SCEN_ONLY" },
})
