local content = require("ccb").content

do
    local group = content.ItemGroup { id = "defense_caravan_ranged", kind = "collection" }
    group:item("crossbow")
    group:item("marlin_9a")
    group:item("hk_mp5")
    group:group("modular_deagle_44")
    group:item("m1911")
    group:item("hk_ump45")
    group:item("fn_p90")
    group:item("remington_870")
    group:item("browning_blr")
    group:item("ak47")
    group:group("modular_m4a1")
    group:item("hk_g3")
    group:item("hk_g80")
    group:item("exodii_plasma_projectile")
    group:item("compbow")
    content.add(group)
end
