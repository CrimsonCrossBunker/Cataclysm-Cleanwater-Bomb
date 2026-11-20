local ccb = require("ccb")
local content = ccb.content

-- Native bionic migrations
do
do
local definition = content.Migration {
    kind = "bionic",
    from = "bn_bio_solar",
    to = "bio_microgen",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "bionic",
    from = "bio_forcefield_bash_cut_weak",
    to = "bio_shield_weak",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "bionic",
    from = "bio_forcefield_bash_cut_medium",
    to = "bio_shield_medium",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "bionic",
    from = "bio_forcefield_bash_cut_heavy",
    to = "bio_shield_heavy",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "bionic",
    from = "bio_forcefield_ballistic_weak",
    to = "bio_shield_weak",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "bionic",
    from = "bio_forcefield_ballistic_medium",
    to = "bio_shield_medium",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "bionic",
    from = "bio_forcefield_ballistic_heavy",
    to = "bio_shield_heavy",
}
content.add(definition)
end
end

-- Native overmap-terrain migrations
do
do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_roof_north",
    to = "afs_modular_habitat_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_roof_south",
    to = "afs_modular_habitat_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_roof_east",
    to = "afs_modular_habitat_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_roof_west",
    to = "afs_modular_habitat_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof2_north",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof2_south",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof2_east",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof2_west",
    to = "open_air",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof_north",
    to = "afs_modular_habitat_roof_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof_south",
    to = "afs_modular_habitat_roof_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof_east",
    to = "afs_modular_habitat_roof_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_roof_west",
    to = "afs_modular_habitat_roof_west",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_north",
    to = "afs_modular_habitat_greenhouse_control_ramp_north",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_south",
    to = "afs_modular_habitat_greenhouse_control_ramp_south",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_east",
    to = "afs_modular_habitat_greenhouse_control_ramp_east",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "afs_modular_habitat_greenhouse_control_room_1s_west",
    to = "afs_modular_habitat_greenhouse_control_ramp_west",
}
content.add(definition)
end
end
do
do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_west",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_roof_north",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_roof_south",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_roof_east",
    to = "field",
}
content.add(definition)
end

do
local definition = content.Migration {
    kind = "oter",
    from = "s_gas_roof_west",
    to = "field",
}
content.add(definition)
end
end
