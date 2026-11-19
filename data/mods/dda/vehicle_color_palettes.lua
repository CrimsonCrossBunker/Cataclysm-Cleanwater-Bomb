local ccb = require("ccb")
local content = ccb.content

-- Native vehicle color palettes
do
local definition = content.VehicleColorPalette {
    id = "car_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Jet black", 10 },
    { "Cataclysm Red", 10 },
    { "Cataclysm Green", 10 },
    { "Signal brown", 10 },
    { "Sapphire blue", 10 },
    { "Purple violet", 10 },
    { "Azure blue", 10 },
    { "Silver grey", 10 },
    { "Black grey", 10 },
    { "Bright red orange", 10 },
    { "Grass green", 10 },
    { "Golden yellow", 10 },
    { "Light blue", 10 },
    { "Telemagenta", 10 },
    { "Pastel blue", 10 },
    { "Traffic white", 10 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "cargo_standard",
}
definition:group({ "board", "windshield", "door", "roof", "inflate", "trunk_flat", "hatch" }, {
    { "White aluminium", 8 },
    { "Silver grey", 8 },
    { "Grey aluminium", 8 },
    { "Black brown", 8 },
    { "Beige", 8 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "visibility_standard",
}
definition:group({ "board", "windshield", "door", "roof", "inflate", "trunk_flat", "hatch" }, {
    { "Capri Blue", 12 },
    { "Cataclysm Red", 20 },
    { "Orange brown", 4 },
    { "Yellow orange", 2 },
    { "Green grey", 4 },
    { "Yellow orange", 4 },
    { "Telemagenta", 4 },
    { "Traffic Purple", 4 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "military_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Pine Green", 20 },
    { "Brown grey", 10 },
    { "Black grey", 10 },
    { "Olive Grey", 5 },
    { "Sand Yellow", 5 },
    { "Traffic Purple", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "military_fighter",
}
definition:group({ "board", "wing", "propeller", "windshield", "door", "roof", "trunk_flat", "trunk_carbon_flat", "hatch" }, {
    { "Telegrey 1", 20 },
    { "Pastel turquoise", 10 },
    { "Black grey", 10 },
    { "Brilliant blue", 10 },
    { "Capri blue", 5 },
    { "Traffic Purple", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "military_heli",
}
definition:group({ "board", "wing", "rotor", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Cataclysm Green", 20 },
    { "Black grey", 10 },
    { "Pastel turquoise", 5 },
    { "White aluminium", 5 },
    { "Traffic Purple", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "military_boat",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Cataclysm Green", 20 },
    { "Grey aluminium", 10 },
    { "Black grey", 10 },
    { "Yellow Olive", 5 },
    { "Traffic Purple", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "police_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Black grey", 10 },
    { "Silver grey", 10 },
    { "Steel Blue", 5 },
    { "Pastel blue", 2 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "swat_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Black grey", 10 },
    { "Steel Blue", 5 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "construction_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Traffic Yellow", 10 },
    { "Yellow Orange", 5 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "farm_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Flame Red", 10 },
    { "Pearl Green", 10 },
    { "Traffic Blue", 2 },
    { "Traffic Orange", 2 },
    { "Lemon Yellow", 2 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "firetruck_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Flame Red", 20 },
    { "White aluminium", 5 },
    { "Broom Yellow", 5 },
    { "Yellow Green", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "ems_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "White aluminium", 20 },
    { "Flame Red", 10 },
    { "Traffic Yellow", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "bus_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Traffic Yellow", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "wienermobile_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Yellow Orange", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "limo_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Black grey", 10 },
    { "White aluminium", 10 },
    { "Traffic Purple", 1 },
    { "Ultramarine Blue", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "sneaky_standard",
}
definition:group({ "board", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Grey aluminium", 10 },
    { "Black grey", 10 },
    { "Traffic Purple", 5 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "aircraft_standard",
}
definition:group({ "board", "wing", "rotor", "propeller", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "Pigeon Blue", 10 },
    { "Black grey", 5 },
    { "Red Orange", 5 },
    { "Pure Orange", 5 },
    { "Traffic Yellow", 5 },
    { "Pearl Green", 5 },
    { "Light Blue", 5 },
    { "Ultramarine Blue", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "aircraft_commercial",
}
definition:group({ "board", "wing", "rotor", "propeller", "windshield", "door", "roof", "trunk_flat", "hatch" }, {
    { "White aluminium", 15 },
    { "Gentian blue", 10 },
    { "Red Orange", 10 },
    { "Lemon Yellow", 5 },
    { "Turquoise Green", 5 },
    { "Ultramarine Blue", 1 }
})
content.add(definition)
end
do
local definition = content.VehicleColorPalette {
    id = "wooden_standard",
}
definition:group({ "woodboard", "woodhalfboard", "boat_board", "raft_board", "wing_wood", "propeller_wood", "windshield", "wood box", "travois", "seat_wood", "wooden_aisle", "door_wood", "roof_wood" }, {
    { "Green beige", 5 },
    { "Beige", 5 },
    { "Brown beige", 5 },
    { "Broom yellow", 5 },
    { "Brown red", 5 },
    { "Beige red", 5 },
    { "Olive grey", 5 },
    { "Beige grey", 5 },
    { "Khaki grey", 5 },
    { "Green brown", 5 },
    { "Ochre brown", 5 },
    { "Clay brown", 5 },
    { "Olive brown", 5 },
    { "Nut brown", 5 },
    { "Sepia brown", 5 },
    { "Chestnut brown", 5 },
    { "Mahogany brown", 5 },
    { "Chocolate brown", 5 },
    { "Beige brown", 5 }
})
definition:group({ "clothboard", "cloth_halfboard", "roof_cloth", "cargo_bag" }, {
    { "Oyster white", 5 },
    { "Ivory", 5 },
    { "Light ivory", 5 },
    { "Grey beige", 5 },
    { "Grey blue", 5 },
    { "Silver grey", 5 },
    { "Beige grey", 5 },
    { "Black grey", 5 },
    { "Light grey", 5 },
    { "Cream", 5 },
    { "Grey white", 5 },
    { "Papyrus white", 5 },
    { "Flame red", 5 }
})
content.add(definition)
end
