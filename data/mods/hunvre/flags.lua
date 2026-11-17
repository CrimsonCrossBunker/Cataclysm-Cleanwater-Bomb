local ccb = require("ccb")
local content = ccb.content

content.add(content.JsonFlag {
    id = "CONTRABAND",
    info = ccb.content.text("Items with this flag are treated as contraband by the contraband scanner."),
})
