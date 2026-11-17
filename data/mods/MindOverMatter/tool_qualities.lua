local ccb = require("ccb")
local content = ccb.content

content.add(content.ToolQuality { id = "MATRIX_FOCUS", name = ccb.content.text("matrix alignment") })
content.add(content.ToolQuality { id = "MATRIX_CHANNEL", name = ccb.content.text("matrix concentration") })
