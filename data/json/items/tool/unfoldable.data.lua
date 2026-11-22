local ccb = require("ccb")

ccb.content.define_item {
    id = "folded_bicycle",
    copy_from = "generic_folded_vehicle",
    name = "folded Bicycle",
    description = "A folded Bicycle.",
    symbol = "0",
    color = "light_gray",
    mass = "20786 g",
    volume = "18500 ml",
    variables = {
        vehicle_name = "Bicycle",
        folded_parts = "[{\"id\":\"folding_frame\",\"base\":{\"typeid\":\"foldframe\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"saddle\",\"base\":{\"typeid\":\"saddle\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0,\"variant\":\"pedal\"},{\"id\":\"horn_bicycle\",\"base\":{\"typeid\":\"horn_bicycle\",\"item_vars\":{\"magazine_converted\":\"1\"},\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"foot_pedals\",\"base\":{\"typeid\":\"foot_crank\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"folding_frame\",\"base\":{\"typeid\":\"foldframe\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":1,\"mount_dy\":0},{\"id\":\"wheel_mount_light_steerable\",\"base\":{\"typeid\":\"wheel_mount_light\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":1,\"mount_dy\":0},{\"id\":\"wheel_bicycle\",\"base\":{\"typeid\":\"wheel_bicycle\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":1,\"mount_dy\":0},{\"id\":\"folding_frame\",\"base\":{\"typeid\":\"foldframe\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":-1,\"mount_dy\":0},{\"id\":\"wheel_mount_light\",\"base\":{\"typeid\":\"wheel_mount_light\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":-1,\"mount_dy\":0},{\"id\":\"wheel_bicycle\",\"variant\":\"rear\",\"base\":{\"typeid\":\"wheel_bicycle\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":-1,\"mount_dy\":0},{\"id\":\"basketsm\",\"variant\":\"bike_rear\",\"base\":{\"typeid\":\"bike_basket\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":-1,\"mount_dy\":0}]",
    },
    tool = {},
}

ccb.content.define_item {
    id = "folded_wheelchair_generic",
    copy_from = "generic_folded_vehicle",
    name = "folded wheelchair",
    description = "A folded Wheelchair.",
    symbol = "/",
    color = "light_gray",
    mass = "10448 g",
    volume = "12000 ml",
    variables = {
        vehicle_name = "Wheelchair",
        folded_parts = "[{\"id\":\"folding_frame\",\"base\":{\"typeid\":\"foldframe\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"folding_seat\",\"base\":{\"typeid\":\"sheet\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"wheel_mount_light\",\"base\":{\"typeid\":\"wheel_mount_light\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"wheel_wheelchair\",\"base\":{\"typeid\":\"wheel_wheelchair\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"hand_rims\",\"base\":{\"typeid\":\"hand_rims\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"basketsm\",\"base\":{\"typeid\":\"bike_basket\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0,\"variant\":\"wheelchair\"}]",
    },
    tool = {},
}

ccb.content.define_item {
    id = "folded_inflatable_boat",
    copy_from = "generic_folded_vehicle",
    name = "inflatable boat",
    description = "This rubber rowboat (with oars included) is deflated for storage.  Activate it with an air pump in your inventory to inflate and launch it.",
    symbol = "0",
    color = "light_gray",
    mass = "32282 g",
    volume = "7500 ml",
    variables = {
        vehicle_name = "inflatable boat",
        folded_parts = "[{\"id\":\"inflatable_section\",\"base\":{\"typeid\":\"inflatable_section\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"folding_seat\",\"base\":{\"typeid\":\"sheet\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"inflatable_airbag\",\"base\":{\"typeid\":\"inflatable_airbag\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"hand_paddles\",\"base\":{\"typeid\":\"hand_paddles\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"inflatable_section\",\"base\":{\"typeid\":\"inflatable_section\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":1,\"mount_dy\":0},{\"id\":\"inflatable_airbag\",\"base\":{\"typeid\":\"inflatable_airbag\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":1,\"mount_dy\":0},{\"id\":\"inflatable_section\",\"base\":{\"typeid\":\"inflatable_section\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":1,\"mount_dy\":1},{\"id\":\"inflatable_airbag\",\"base\":{\"typeid\":\"inflatable_airbag\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":1,\"mount_dy\":1},{\"id\":\"inflatable_section\",\"base\":{\"typeid\":\"inflatable_section\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":1},{\"id\":\"inflatable_airbag\",\"base\":{\"typeid\":\"inflatable_airbag\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":1}]",
    },
    tool = {},
}

ccb.content.define_item {
    id = "folded_skateboard_generic",
    copy_from = "generic_folded_vehicle",
    name = "skateboard",
    description = "A skateboard.",
    symbol = "/",
    color = "light_gray",
    mass = "2898 g",
    volume = "3750 ml",
    variables = {
        vehicle_name = "Skateboard",
        folded_parts = "[{\"id\":\"frame_wood_deck\",\"base\":{\"typeid\":\"frame_wood_deck\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"wheel_mount_skateboard\",\"base\":{\"typeid\":\"wheel_mount_skateboard\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"wheel_skateboard\",\"base\":{\"typeid\":\"wheel_skateboard\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0}]",
    },
    tool = {},
}
