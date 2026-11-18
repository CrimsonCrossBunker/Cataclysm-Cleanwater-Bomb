local content = require("ccb").content

do
    local group = content.ItemGroup { id = "bots", kind = "distribution" }
    group:item("bot_grenade_hack", 2)
    group:item("bot_flashbang_hack", 2)
    group:item("bot_gasbomb_hack", 2)
    group:item("bot_rifleturret", 2)
    group:item("bot_antimateriel", 2)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "eyebot", kind = "distribution" }
    group:item("flashlight", 40)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "manhack", kind = "distribution" }
    group:item("spike", 10)
    group:item("scrap", 10)
    group:item("blade", 5)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "skitterbot", kind = "distribution" }
    group:item("tazer", 3)
    group:item("scrap", 9)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "turret", kind = "distribution" }
    group:item("9mm", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "turret_rifle", kind = "distribution" }
    group:item("556", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "turret_bmg", kind = "distribution" }
    group:item("50bmg", 8)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "turret_searchlight", kind = "distribution" }
    group:item("lens", 15)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "turret_speaker", kind = "distribution" }
    group:entry { item = "scrap", count = { 4, 6 } }
    group:entry { item = "e_scrap", count = { 1, 2 } }
    group:entry { item = "plastic_chunk", count = { 0, 2 } }
    group:entry { item = "wood_panel", count = { 1, 1 } }
    group:entry { item = "2x4", count = { 4, 4 } }
    group:entry { item = "nail", charges = { 8, 10 } }
    group:group("cable_roll_part")
    content.add(group)
end
