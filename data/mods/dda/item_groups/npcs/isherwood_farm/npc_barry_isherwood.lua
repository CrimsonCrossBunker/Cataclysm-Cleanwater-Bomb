local content = require("ccb").content

do
    -- This is given to him upon returning home, rather than at spawn.
    local group = content.ItemGroup { id = "NC_Isherwood_Barry_equip", kind = "collection" }
    group:item("backpack_leather")
    group:item("jacket_flannel")
    group:item("ammo_pouch")
    group:item("boxer_shorts")
    group:item("tshirt")
    group:item("pants_cargo")
    group:item("leather_belt")
    group:item("gloves_fingerless")
    group:item("cowboy_hat")
    group:item("boots")
    group:item("socks")
    group:entry {
        item = "browning_blr",
        charges = { 4, 4 },
        contents = {
            { group = "NC_ISHERWOOD_rifle_mods" },
        },
    }
    content.add(group)
end
