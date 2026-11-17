local content = require("ccb").content

content.add(content.AmmoEffect { id = "test_sling_payload_explosion" }
    :explosion{ power = 5, distance_factor = 0.75 })
