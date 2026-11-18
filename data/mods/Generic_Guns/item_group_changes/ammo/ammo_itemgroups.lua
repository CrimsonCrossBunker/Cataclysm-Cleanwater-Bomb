local content = require("ccb").content

do
    -- Ammo that spawns inside of boxes, with no loose ammo with it.  Meant mainly for gunstores.
    local group = content.ItemGroup { id = "ammo_common_boxed", kind = "distribution" }
    group:group("boxed_pistol", 10)
    group:group("boxed_pistol_tiny", 20)
    group:group("boxed_magnum", 1)
    group:group("boxed_rifle", 5)
    group:group("boxed_shot", 5)
    content.replace(group)
end

do
    -- Ammo that spawns inside of boxes, with either some extra loose ammo with it, or lacking some ammo.  Meant mainly for civilian ammo ownership, or lightly looted places.
    local group = content.ItemGroup { id = "ammo_common_boxed_used", kind = "distribution" }
    group:group("boxed_pistol_used", 10)
    group:group("boxed_pistol_tiny_used", 20)
    group:group("boxed_magnum_used", 1)
    group:group("boxed_rifle_used", 5)
    group:group("boxed_shot_used", 5)
    content.replace(group)
end

do
    -- Ammo that spawns inside of boxes that are very low in number. Meant for civilian ammo ownership, and looted locations.
    local group = content.ItemGroup { id = "ammo_common_boxed_looted", kind = "distribution" }
    group:group("boxed_pistol_looted", 10)
    group:group("boxed_pistol_tiny_looted", 20)
    group:group("boxed_magnum_looted", 1)
    group:group("boxed_rifle_looted", 5)
    group:group("boxed_shot_looted", 5)
    content.replace(group)
end
