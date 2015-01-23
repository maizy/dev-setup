# MenubarNotes v0.1

Primitive OS X menubar for setting any text note.

## Build

```
/usr/bin/easy_install pip
/usr/bin/pip install rumps  # (use os x bundled python instead of brew/macports version)
/usr/bin/python setup.py py2app
rm -r /Applications/MenubarNotes.app
cp -r dist/MenubarNotes.app /Applications
```
