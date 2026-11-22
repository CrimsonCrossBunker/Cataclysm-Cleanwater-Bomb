local ccb = require("ccb")

ccb.content.define_item {
    id = "con_mix_foldable",
    name = "concrete mixer",
    description = "A portable concrete mixer.  It is large and heavy, but it can be operated solo.  Unfold to use.",
    symbol = "$",
    color = "dark_gray",
    looks_like = "con_mix",
    mass = "40823 g",
    volume = "250 L",
    length = "118 cm",
    price = "400 USD",
    survival_price = "5 USD",
    flags = { "NO_SALVAGE" },
    materials = { "plastic", "steel" },
    melee_damage = { bash = 15 },
    variables = {
        vehicle_name = "Concrete mixer",
        folded_parts = "[{\"id\": \"frame_concrete_mix\",\"base\":{\"typeid\":\"frame_concrete_mix\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"wheel_mount_concrete_mix\",\"base\":{\"typeid\":\"wheel_mount_concrete_mix\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\": 0,\"mount_dy\": 0},{\"id\":\"wheel_set_concrete_mix\",\"base\":{\"typeid\":\"wheel_set_concrete_mix\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\": 0,\"mount_dy\":0},{\"id\":\"drum_concrete_mix\",\"base\":{\"typeid\":\"30gal_barrel\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"engine_electric_small\",\"base\":{\"typeid\":\"motor_small\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0},{\"id\":\"small_storage_battery\",\"base\":{\"typeid\":\"small_storage_battery\",\"item_tags\":[\"VEHICLE\"]},\"mount_dx\":0,\"mount_dy\":0}]",
    },
    pockets = {
        {
            capacity = "100 L",
            mass_limit = "300 kg",
            rigid = true,
            watertight = true,
            open_container = true,
        },
    },
    qualities = {
        { id = "CONTAIN", level = 1 },
    },
    accuracy = { grip = "bad", length = "long", surface = "line", balance = "clumsy" },
    use_actions = { "UNFOLD_GENERIC" },
    tool = {},
}
