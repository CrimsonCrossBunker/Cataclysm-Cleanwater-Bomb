local content = require("ccb").content

-- Only artifact version of matrix crystals spawn
do
    local blacklist = content.Blacklist { kind = "item" }
    for _, id in ipairs {
        "matrix_crystal_biokinesis",
        "matrix_crystal_clairsentience",
        "matrix_crystal_electrokinesis",
        "matrix_crystal_photokinesis",
        "matrix_crystal_pyrokinesis",
        "matrix_crystal_teleportation",
        "matrix_crystal_vitakinesis",
        "matrix_crystal_coruscating",
    } do
        blacklist:entry(id)
    end
    content.add(blacklist)
end
