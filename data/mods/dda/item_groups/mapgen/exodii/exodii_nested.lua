local content = require("ccb").content

do
    local group = content.ItemGroup { id = "EXODII_Workshop_Damaged", kind = "distribution" }
    group:entry { item = "brogyeki", damage = { 1, 4 }, probability = 20 }
    group:entry { item = "brogyaga", damage = { 1, 4 }, probability = 5 }
    group:entry { item = "pamd68", damage = { 1, 4 }, probability = 60 }
    group:entry { item = "pamd71z", damage = { 1, 4 }, probability = 10 }
    group:entry { item = "sapra", damage = { 1, 4 }, probability = 10 }
    group:entry { item = "armor_lorica", damage = { 1, 4 }, probability = 20 }
    group:entry { item = "helmet_corinthian", damage = { 1, 4 }, probability = 60 }
    group:entry { item = "armor_thessalonian", damage = { 1, 4 }, probability = 80 }
    group:entry { item = "leggings_thessalonian", damage = { 1, 4 }, probability = 80 }
    group:entry { item = "sword_xiphos", damage = { 1, 4 }, probability = 50 }
    group:entry { item = "spear_dory", damage = { 1, 4 }, probability = 30 }
    content.add(group)
end
