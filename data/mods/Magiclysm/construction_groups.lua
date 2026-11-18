local ccb = require("ccb")
local content = ccb.content

content.add(content.ConstructionGroup { id = "build_translocator_gate", name = ccb.content.text("Build Translocator Gate") })
content.add(content.ConstructionGroup { id = "build_greater_translocator_gate", name = ccb.content.text("Build Translocator Portal") })
content.add(content.ConstructionGroup { id = "build_everburning_torch_candelabra", name = ccb.content.text("Set up Everburning Candelabra") })
content.add(content.ConstructionGroup { id = "build_magiclysm_magic_circle", name = ccb.content.text("Inscribe Magic Circle") })
content.add(content.ConstructionGroup { id = "place_everburning_sconce", name = ccb.content.text("Attach Everburning Sconce") })
content.add(content.ConstructionGroup { id = "build_magiclysm_magic_circle_2", name = ccb.content.text("Enhance existing Magic Circle") })
content.upsert_construction_group(content.ConstructionGroup { id = "build_standing_alembic", name = ccb.content.text("Build Standing Alembic") })
content.add(content.ConstructionGroup { id = "build_orrery", name = ccb.content.text("Place Orrery") })
content.add(content.ConstructionGroup { id = "build_druid_chair", name = ccb.content.text("Place a gnarled chair") })
content.add(content.ConstructionGroup { id = "build_weaver", name = ccb.content.text("Put Wildwood Weaver down to build a shelter") })
