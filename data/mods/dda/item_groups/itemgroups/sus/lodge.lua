local content = require("ccb").content

do
    -- items found in a shotgun hunting space
    local group = content.ItemGroup { id = "hunting_lodge_weapons", kind = "distribution" }
    group:group("guns_shotgun_common", 30)
    group:group("SUS_hunting_rifle", 20)
    group:group("SUS_hunting_archery", 15)
    content.add(group)
end

do
    -- items found in a most dangerous game space
    local group = content.ItemGroup { id = "cannibal_weapons", kind = "distribution" }
    group:group("guns_shotgun_common", 30)
    group:group("SUS_hunting_rifle", 20)
    content.add(group)
end

do
    -- items found in a rifle hunting space
    local group = content.ItemGroup { id = "SUS_hunting_rifle", kind = "collection" }
    group:entry { group = "modular_ar15", charges = { 0, 30 } }
    group:entry { item = "marlin_9a", charges = { 0, 19 }, probability = 20 }
    group:entry { item = "remington700_270", charges = { 0, 4 }, probability = 10 }
    group:entry { item = "remington_700", charges = { 0, 4 }, probability = 40 }
    group:entry { item = "ruger_1022", charges = { 0, 10 }, probability = 70 }
    group:entry { item = "ruger_mini", charges = { 0, 5 }, probability = 10 }
    group:entry { item = "win70", charges = { 0, 3 }, probability = 20 }
    group:entry { item = "henry_big_boy", charges = { 0, 10 }, probability = 2 }
    group:entry { item = "weatherby_5", charges = { 0, 3 }, probability = 2 }
    group:entry { item = "varmint_airgun", charges = { 0, 1 }, probability = 20 }
    group:item("single_sling", 10)
    content.add(group)
end

do
    local group = content.ItemGroup { id = "cannibal_food", kind = "collection" }
    group:item("machete", 20)
    group:entry {
        item = "meat_salted",
        components = {
            "human_flesh",
            "salt",
        },
        probability = 30,
    }
    group:group("preserved_food", 20)
    group:group("dry_goods", 30)
    group:entry {
        item = "meat_smoked",
        components = {
            "human_flesh",
        },
        probability = 60,
    }
    group:group("SUS_pantry", 10)
    content.add(group)
end
