local content = require("ccb").content

do
    -- Drugs not contained within any other category
    local group = content.ItemGroup { id = "drugs_misc", kind = "distribution" }
    group:group("bfipowder_bottle_plastic_5_60")
    group:group("any_cough_syrup_in_bottle")
    group:entry { item = "flu_shot", count = { 1, 10 }, container = "null", probability = 50 }
    content.add(group)
end

do
    local group = content.ItemGroup { id = "harddrugs", kind = "distribution" }
    group:group("harddrugs_residential", 133)
    group:item("flu_shot", 5)
    content.add(group)
end
