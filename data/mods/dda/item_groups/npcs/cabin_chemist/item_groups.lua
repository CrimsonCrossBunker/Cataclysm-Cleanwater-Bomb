local content = require("ccb").content

do
    local group = content.ItemGroup { id = "cabin_chemist_sell", kind = "distribution" }
    group:group("chem_lab")
    group:group("harddrugs", 70)
    group:group("full_1st_aid", 80)
    content.add(group)
end
