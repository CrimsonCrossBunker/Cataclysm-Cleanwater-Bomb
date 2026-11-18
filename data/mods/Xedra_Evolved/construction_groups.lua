local ccb = require("ccb")
local content = ccb.content

content.add(content.ConstructionGroup { id = "bed_upgrades", name = ccb.content.text("Bed of Restful Repose") })
content.upsert_construction_group(content.ConstructionGroup { id = "build_standing_alembic", name = ccb.content.text("Build Standing Alembic") })
content.add(content.ConstructionGroup { id = "build_chair_treesung", name = ccb.content.text("Place a treesung wooden chair") })
content.add(content.ConstructionGroup { id = "build_wardrobe_treesung", name = ccb.content.text("Place a treesung wardrobe") })
content.add(content.ConstructionGroup { id = "place_treesung_table", name = ccb.content.text("Place a treesung table") })
content.add(content.ConstructionGroup { id = "build_bed_treesung", name = ccb.content.text("Build treesung bed") })
content.add(content.ConstructionGroup { id = "build_down_bed_treesung", name = ccb.content.text("Build treesung down bed") })
