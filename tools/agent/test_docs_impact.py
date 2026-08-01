import unittest

from check_docs_impact import (
    documentation_field_warnings,
    impacts,
    validate_pr_body,
)


class DocsImpactTest(unittest.TestCase):
    def setUp(self):
        self.rules = [
            {
                "id": "lua",
                "patterns": ["data/lua/*", "src/catalua_ui_*"],
                "documentation_ids": ["reference.lua"],
                "generated_reference_impact": True,
            }
        ]

    def test_matches_only_relevant_paths(self):
        result = impacts(
            ["src/game.cpp", "data/lua/manifest.schema.json"], self.rules
        )
        self.assertEqual(
            ["data/lua/manifest.schema.json"], result[0]["matched_files"]
        )

    def test_unrelated_path_has_no_impact(self):
        self.assertEqual([], impacts(["src/game.cpp"], self.rules))

    def test_pr_body_requires_real_responsible_human(self):
        body = """#### Responsible human
@maintainer
#### Documentation impact
None
#### Related CCB-Docs PR
None
#### Affected documentation IDs
None
#### Generated reference impact
None
"""
        self.assertEqual([], validate_pr_body(body))
        self.assertTrue(
            validate_pr_body(body.replace("@maintainer", "@username"))
        )

    def test_documentation_fields_are_advisory_in_phase_zero(self):
        body = """#### Responsible human
@maintainer
"""
        self.assertEqual(validate_pr_body(body), [])
        self.assertEqual(len(documentation_field_warnings(body)), 4)

    def test_responsible_human_cannot_be_none_or_a_bot(self):
        self.assertTrue(validate_pr_body("#### Responsible human\nNone\n"))
        self.assertTrue(
            validate_pr_body("#### Responsible human\n@automation[bot]\n")
        )


if __name__ == "__main__":
    unittest.main()
