local ccb = require("ccb")
local content = ccb.content

-- Should be first in the list
content.add(content.ConstructionCategory { id = "ALL", name = ccb.content.text("All") })
content.add(content.ConstructionCategory { id = "APPLIANCE", name = ccb.content.text("Appliances") })
content.add(content.ConstructionCategory { id = "CONSTRUCT", name = ccb.content.text("Constructions") })
content.add(content.ConstructionCategory { id = "FURN", name = ccb.content.text("Furniture") })
content.add(content.ConstructionCategory { id = "DIG", name = ccb.content.text("Digging and Mining") })
content.add(content.ConstructionCategory { id = "REPAIR", name = ccb.content.text("Repairing") })
content.add(content.ConstructionCategory { id = "REINFORCE", name = ccb.content.text("Reinforcing") })
content.add(content.ConstructionCategory { id = "DECORATE", name = ccb.content.text("Decorative") })
content.add(content.ConstructionCategory { id = "FARM_WOOD", name = ccb.content.text("Farming and Woodcutting") })
content.add(content.ConstructionCategory { id = "TOOL", name = ccb.content.text("Tools") })
content.add(content.ConstructionCategory { id = "WINDOWS", name = ccb.content.text("Windows") })
content.add(content.ConstructionCategory { id = "BULK", name = ccb.content.text("Stacks and Piles") })
content.add(content.ConstructionCategory { id = "OTHER", name = ccb.content.text("Others") })
content.add(content.ConstructionCategory { id = "DECONSTRUCT", name = ccb.content.text("Deconstructions") })
-- Should be last in the list
content.add(content.ConstructionCategory { id = "FILTER", name = ccb.content.text("Filter") })
