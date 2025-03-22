# Creating Operator Mono LT Family

LT = Lighter; i.e., with weights shifted just a bit.

```bash
$ brew install fontforge
$ cd ./src/cargo/assets/fonts/operator-mono-lt/scripts
$ fontforge -script create-lt.ff
```

Expect errors like these, which we'll have to live with, for now.

```txt
The following table(s) in the font have been ignored by FontForge
  Ignoring 'DSIG' digital signature table
```

```txt
Warning: Mac and Windows entries in the 'name' table differ for the
 SubFamily string in the language English (US)
 Mac String: Light Italic
```
