local ccb = require("ccb")

ccb.content.define_mutable_overmap_special {
    id = "stream_mutable",
    root = "stream_end_n",
    locations = { "field", "forest", "swamp" },
    flags = { "WILDERNESS" },
    occurrences = { 1, 1 },
    priority = 2,
    check_for_locations_area = {
        {
            from = { 1, 1, 0 },
            to = { -1, -1, 0 },
            locations = { "field", "forest" },
        },
    },
    joins = { "stream_to_stream", "stream_to_east", "stream_to_west" },
    overmaps = {
        stream_body = { overmap = "stream_north", north = "stream_to_stream", south = "stream_to_stream" },
        stream_bend_e = { overmap = "stream_corner_east", north = "stream_to_stream", east = "stream_to_west" },
        stream_bend_w = { overmap = "stream_corner_north", north = "stream_to_stream", west = "stream_to_east" },
        stream_bend_start_e = { overmap = "stream_north", north = "stream_to_stream", south = "stream_to_east" },
        stream_bend_start_w = { overmap = "stream_north", north = "stream_to_stream", south = "stream_to_west" },
        stream_corner_e = { overmap = "stream_corner_north", north = "stream_to_stream", west = "stream_to_stream" },
        stream_corner_w = { overmap = "stream_corner_east", north = "stream_to_stream", east = "stream_to_stream" },
        stream_end_n = { overmap = "stream_end_north", south = "stream_to_stream" },
        stream_end_s = { overmap = "stream_end_south", north = "stream_to_stream" },
        stream_end_bend_en = { overmap = "stream_end_north", south = "stream_to_west" },
        stream_end_bend_es = { overmap = "stream_end_south", north = "stream_to_west" },
        stream_end_bend_wn = { overmap = "stream_end_north", south = "stream_to_east" },
        stream_end_bend_ws = { overmap = "stream_end_south", north = "stream_to_east" },
    },
    phases = {
        {
            { overmap = "stream_body", weight = 100 },
            { overmap = "stream_bend_start_e", weight = 1 },
            { overmap = "stream_bend_start_w", weight = 1 },
            { overmap = "stream_bend_e", weight = 120 },
            { overmap = "stream_bend_w", weight = 120 },
            { overmap = "stream_corner_e", weight = 1 },
            { overmap = "stream_corner_w", weight = 1 },
        },
        {
            { overmap = "stream_end_n", max = 1 },
            { overmap = "stream_end_s", max = 1 },
            { overmap = "stream_end_bend_en", max = 1 },
            { overmap = "stream_end_bend_es", max = 1 },
            { overmap = "stream_end_bend_wn", max = 1 },
            { overmap = "stream_end_bend_ws", max = 1 },
        },
    },
}
