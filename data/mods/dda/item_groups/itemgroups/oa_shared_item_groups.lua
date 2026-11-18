local content = require("ccb").content

do
    local group = content.ItemGroup { id = "oa_discarded_news", kind = "distribution" }
    group:group("newspaper", 60)
    group:item("news_regional", 20)
    group:item("mag_news", 20)
    content.add(group)
end
