local content = require("ccb").content

local filter = content.Blacklist { kind = "scenario" }
filter:entry("evacuee")
filter:entry("fungal_start")
filter:entry("hunted_start")
filter:entry("lab_cargo_staff_1")
filter:entry("medieval")
filter:entry("migo_prisoner")
filter:entry("Mine_bottom")
filter:entry("mutant")
filter:entry("portal_dependent")
filter:entry("quick_portal_storm_base")
filter:entry("strong_portal_storm_base")
filter:entry("strong_portal_storm")
filter:entry("aircraft_carrier_start")
filter:entry("overrun")
filter:entry("infested_shelter_start")
content.replace(filter)
