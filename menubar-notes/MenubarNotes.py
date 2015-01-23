#!/usr/bin/python
# coding: utf-8
from __future__ import unicode_literals
import sys
import json

import rumps


DEFAULT_NOTE = "set me"

class MenubarNotesApp(rumps.App):

    def __init__(self, *args, **kwargs):
        super(MenubarNotesApp, self).__init__(*args, **kwargs)
        self.title = unicode(self.get_settings().get('last_note', DEFAULT_NOTE))

    def get_settings(self):
        try:
            with self.open('settings.json', 'rb') as f:
                res = json.load(f)
        except Exception:
            res = {}
        return res

    def save_settings(self, settings):
        try:
            with self.open('settings.json', 'wb') as f:
                res = json.dump(settings, f)
        except Exception:
            res = {}
        return res

    def update_settings(self, new_settings):
        settings = self.get_settings()
        settings.update(new_settings)
        self.save_settings(settings)

    @rumps.clicked("Set note ...")
    def set_text(self, _):
        window = rumps.Window(
            message='Note',
            title='Set new note',
            default_text=unicode(self.title) if self.title else '',
            dimensions=(340, 25),
        )
        res = window.run()
        note = unicode(res.text)
        self.title = note
        self.update_settings({'last_note': note})

if __name__ == "__main__":
    MenubarNotesApp("MenubarNotes").run()
