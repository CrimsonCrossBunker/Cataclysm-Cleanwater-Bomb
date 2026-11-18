local content = require("ccb").content

do
    -- For non-static shotguns (not in stores, closets ).
    local group = content.ItemGroup { id = "sights_shotgun_readied", kind = "distribution" }
    group:group("sights_shotgun", 50)
    group:group("EMPTY_GROUP", 50)
    content.add(group)
end

do
    -- For shotguns that haven't been 'made ready', e.g sitting in a store or garage.
    local group = content.ItemGroup { id = "sights_shotgun_static", kind = "distribution" }
    group:group("sights_shotgun", 20)
    group:group("EMPTY_GROUP", 80)
    content.add(group)
end
