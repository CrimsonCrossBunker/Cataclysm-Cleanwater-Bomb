local content = require("ccb").content

do
    -- equipment dropped by the XEDRA explorer in the scarlet sea
    local group = content.ItemGroup { id = "xedra_scarlet_sea_set", kind = "collection" }
    group:group("clothing_watch")
    group:item("phase_immersion_suit")
    group:item("phase_immersion_helmet")
    group:item("phase_immersion_cca")
    group:item("military_papr_blower_off")
    content.add(group)
end
