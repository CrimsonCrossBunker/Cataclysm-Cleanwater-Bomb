#!/usr/bin/env python3

import json
import os
import tempfile
import unittest

try:
    from . import tileset_workbook as workbook
except ImportError:
    import tileset_workbook as workbook


class TilesetWorkbookTest(unittest.TestCase):

    def setUp(self):
        self.tempdir = tempfile.TemporaryDirectory()
        self.data_dir = self.tempdir.name

    def tearDown(self):
        self.tempdir.cleanup()

    def write_json(self, name, data):
        path = os.path.join(self.data_dir, name)
        with open(path, 'w', encoding='utf-8') as output:
            json.dump(data, output)
        return path

    @staticmethod
    def row_for(sheets, sheet, gid):
        return next(row for row in sheets[sheet] if row['ID'] == gid)

    def test_inheritance_looks_like_gender_and_vehicle_prefix(self):
        self.write_json('data.json', [
            {
                'type': 'ITEM',
                'abstract': 'armor_base',
                'subtypes': ['ARMOR'],
                'looks_like': 'existing_armor',
            },
            {'type': 'ITEM', 'id': 'inherited_armor', 'copy-from': 'armor_base'},
            {'type': 'ITEM', 'id': 'existing_armor', 'subtypes': ['ARMOR']},
            {'type': 'ITEM', 'id': 'generic_item', 'subtypes': ['GENERIC']},
            {'type': 'MONSTER', 'id': 'test_monster'},
            {'type': 'vehicle_part', 'id': 'test_wheel'},
        ])

        buckets, resolver = workbook.scan_game_data([self.data_dir])
        self.assertIn('inherited_armor',
                      {entity.gid for entity in buckets['items_worn']})
        self.assertIn('generic_item',
                      {entity.gid for entity in buckets['items_wielded']})

        sheets = workbook.build_sheets(buckets, resolver, {
            'existing_armor',
            'overlay_worn_existing_armor',
            'corpse',
            'vp_test_wheel',
        })
        body = self.row_for(sheets, '主贴图-物品', 'inherited_armor')
        male = self.row_for(sheets, '穿戴-男', 'inherited_armor')
        vehicle = self.row_for(sheets, '主贴图-载具部件', 'test_wheel')
        corpse = self.row_for(sheets, '尸体', 'test_monster')

        self.assertEqual(body['当前贴图'], workbook.SPRITE_FALLBACK)
        self.assertEqual(male['当前贴图'], workbook.SPRITE_FALLBACK)
        self.assertEqual(vehicle['当前贴图'], workbook.SPRITE_HAVE)
        self.assertEqual(corpse['当前贴图'], workbook.SPRITE_FALLBACK)

    def test_invalid_json_is_not_silently_skipped(self):
        path = os.path.join(self.data_dir, 'broken.json')
        with open(path, 'w', encoding='utf-8') as output:
            output.write('{')
        with self.assertRaisesRegex(RuntimeError, 'broken.json'):
            workbook.scan_game_data([self.data_dir])


if __name__ == '__main__':
    unittest.main()
