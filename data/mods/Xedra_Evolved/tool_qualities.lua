local ccb = require("ccb")
local content = ccb.content

content.add(content.ToolQuality { id = "DREAM_HAMMER", name = ccb.content.text("hammer of dreams") })
-- provide a support in organizing huge amount of informations
content.add(content.ToolQuality { id = "AI_TOOL", name = ccb.content.text("intelligent agent") })
-- a place to convert one type of magic to another via sacrificing it to elder powers
content.add(content.ToolQuality { id = "SACRIFICE", name = ccb.content.text("sacrificial altar") })
-- For when you're one of the Fair Folk and what kind of hammer you use on your gear matters
content.add(content.ToolQuality { id = "FEY_HAMMER", name = ccb.content.text("non-iron hammering") })
