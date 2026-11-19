from ..write_text import write_text


def parse_wound(json, origin):
    ident = json["abstract"] if "abstract" in json else json["id"]
    write_text(json.get("name"), origin, plural=True,
               comment=f"Name of wound '{ident}'")
    write_text(json.get("description"), origin,
               comment=f"Description of wound '{ident}'")


def parse_wound_fix(json, origin):
    ident = json["abstract"] if "abstract" in json else json["id"]
    write_text(json.get("name"), origin,
               comment=f"Name of wound treatment '{ident}'")
    write_text(json.get("description"), origin,
               comment=f"Description of wound treatment '{ident}'")
    write_text(json.get("success_msg"), origin,
               comment=f"Message after successful wound treatment '{ident}'")
