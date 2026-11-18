local content = require("ccb").content

do
    -- Current military specification magazines.
    local group = content.ItemGroup { id = "mags_milspec", kind = "distribution" }
    group:item("m107a1mag", 5)
    group:item("tac50mag", 1)
    group:item("ai_338mag", 1)
    group:item("ai_338mag_10", 1)
    group:item("m2010mag", 15)
    group:item("scarhmag", 20)
    group:item("stanag30")
    group:item("stanag30ranger", 10)
    group:item("hk417mag_20rd", 20)
    group:item("m14mag", 5)
    group:entry { item = "belt223", charges = { 1, 200 }, probability = 20 }
    group:item("p320mag_17rd_9x19mm", 30)
    group:item("p226mag_15rd_9x19mm", 1)
    content.add(group)
end

do
    -- Collections of magazines for guns that ignore magazine limits.  Shouldn't be found in places such as gunstores, and should only be found in private areas like homes.  Weighted by caliber.
    local group = content.ItemGroup { id = "mags_common", kind = "distribution" }
    group:group("common_magazines_9mm", 209)
    group:group("common_magazines_10mm", 9)
    group:group("common_magazines_22lr", 204)
    group:group("common_magazines_30_carbine", 1)
    group:group("common_magazines_32", 44)
    group:group("common_magazines_38", 34)
    group:group("common_magazines_40sw", 40)
    group:group("common_magazines_44", 15)
    group:group("common_magazines_45", 49)
    group:group("common_magazines_57", 4)
    group:group("common_magazines_223", 125)
    group:group("common_magazines_303", 19)
    group:group("common_magazines_308", 25)
    group:group("common_magazines_380", 48)
    group:group("common_magazines_762", 34)
    group:group("common_magazines_762R", 4)
    group:group("common_magazines_3006", 8)
    group:group("common_magazines_450", 1)
    group:group("common_magazines_12", 8)
    group:group("uncommon_magazines", 3)
    group:group("magazines_ak74", 1)
    group:item("500_speedloader5", 1)
    group:item("ruger_pr_mag", 1)
    group:item("454_speedloader5", 25)
    group:item("50beowulf_ar15mag", 2)
    group:item("m1911mag_10rd_38super", 2)
    content.add(group)
end
