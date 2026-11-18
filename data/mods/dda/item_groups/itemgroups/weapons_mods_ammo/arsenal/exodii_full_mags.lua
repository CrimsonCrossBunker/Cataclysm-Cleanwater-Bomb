local content = require("ccb").content

do
    local group = content.ItemGroup { id = "full_exodiiBRmag", kind = "distribution", container = "exodiiBRmag" }
    group:entry { item = "123ln", charges = { 60, 60 }, probability = 7 }
    group:entry { item = "123ln_ap", charges = { 60, 60 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_exodiiBRmag_153", kind = "distribution", container = "exodiiBRmag_153" }
    group:entry { item = "123ln", charges = { 153, 153 }, probability = 7 }
    group:entry { item = "123ln_ap", charges = { 153, 153 }, probability = 3 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "full_exodiiBRmag_26", kind = "distribution", container = "exodiiBRmag_26" }
    group:entry { item = "123ln", charges = { 26, 26 }, probability = 3 }
    group:entry { item = "123ln_ap", charges = { 26, 26 }, probability = 7 }
    content.add(group)
end
