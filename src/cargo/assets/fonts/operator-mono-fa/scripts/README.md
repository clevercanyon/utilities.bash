# Merging FontAwesome

```bash
$ brew install fontforge
$ cd ./src/cargo/assets/fonts/operator-mono-fa/scripts
$ fontforge -script merge-fa.ff
```

Expect errors like these, which we'll have to live with, for now.

```txt
The glyph named ring is mapped to U+F70B.
But its name indicates it should be mapped to U+02DA.
```

```txt
Lookup subtable contains unused glyph 2 making the whole subtable invalid
Lookup subtable contains unused glyph 1 making the whole subtable invalid
Lookup subtable contains unused glyph 3 making the whole subtable invalid
Lookup subtable contains unused glyph 2 making the whole subtable invalid
```
