local content = require("ccb").content

do
    local group = content.ItemGroup { id = "NC_ANCILLA_GRUNT_CHOP_SHOP_worn", kind = "collection" }
    group:group("military_ballistic_vest_pristine")
    group:entry {
        item = "legpouch_large",
        contents = {
            { group = "army_mags_m4" },
        },
    }
    group:group("NC_BOUNTY_HUNTER_pants")
    group:item("pants_army")
    group:group("NC_BOUNTY_HUNTER_coat")
    group:item("boots_combat")
    group:item("slingpack")
    group:item("under_armor")
    group:item("under_armor_shorts")
    group:item("holster")
    group:entry { item = "survivor_machete_qt", container = "scabbard" }
    group:item("gloves_fingerless_mod")
    content.add(group)
end

do
    local group = content.ItemGroup { id = "NC_ANCILLA_GRUNT_CHOP_SHOP_wield", kind = "collection" }
    group:group("longguns_cop_loaded")
    content.add(group)
end
