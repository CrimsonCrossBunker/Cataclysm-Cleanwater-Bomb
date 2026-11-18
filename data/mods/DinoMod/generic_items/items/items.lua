local ccb = require("ccb")
local content = ccb.content

do
    local item = content.Item {
        id = "report_dino_exploration",
        copy_from = "log_immersion27",
        looks_like = "log_immersion27",
        name = ccb.content.plural_text("PRELIMINARY REPORT: IMMERSION-30D", "PRELIMINARY REPORT: IMMERSION-30Ds"),
        snippet_category = "dino-reports",
    }
    content.add(item)
end
