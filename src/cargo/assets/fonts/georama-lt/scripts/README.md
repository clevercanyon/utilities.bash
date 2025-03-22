# Creating Georama LT Family

LT = Lighter; i.e., with weights shifted just a bit.

```bash
$ brew install fontforge
$ cd ./src/cargo/assets/fonts/georama-lt/scripts
$ fontforge -script create-lt.ff
```

Expect errors like these, which we'll have to live with, for now.

```txt
The following table(s) in the font have been ignored by FontForge
  Ignoring 'STAT' style attributes table
```
