from ..write_text import write_text


def parse_named_color(json, origin):
    write_text(json["name"], origin, context="named_color",
               comment="Vehicle paint color name")
