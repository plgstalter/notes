# Tools to make note-taking easier.

## What is that?

I take notes using vim and like to keep things organized. So I enjoy having directories for each subject. I write with vim, and use `pandoc` to render notes into nice pdfs. But that requires little scripts, and they're not fun to write each and every time a new class begins :(

So I've created a little script to ease things a little.

## How to use it?

Here's how it works:

`sh school_dir.sh new_year` will create a directory `new_year` in which all classes will be stored.

Once in that directory, simply write `sh newdir.sh class_1 class_2 class_3` and your classes 1, 2 and 3 will be initialized.

When following a course in class 1, go in that directory and type `sh ../newfile.sh`. This creates a new `.md` file for you to write in. Its name is the date. When finished, type `sh src/run_last/sh` to run pandoc and get your nice pdf. Once class is over, type `python src/orga.py`. This puts all `.md` files in `source`, and all pdfs in `output`. So your notes are great looking and easy to access.

## Required setup

This shell script is written for macs (zsh). So for different shells, there might be errors.

This also uses python and modules `os` and `sys`.

## Remarks

The `header-includes.txt` file is for packages and command in `TeX`. To add new packages or commands, add new lines.

## Structure :

```bash
Example
.
├── Dir1
│   ├── info.txt
│   ├── language.txt
│   ├── output
│   │   └── 04_02.pdf
│   └── source
│       └── 04_02.md
├── Dir2
│   ├── info.txt
│   ├── language.txt
│   ├── output
│   └── source
├── Dir3
│   ├── info.txt
│   ├── language.txt
│   ├── output
│   └── source
├── header-includes.txt
├── lookfor
├── newdir
├── newfile
├── nice_date.py
├── orga
└── run_last
```

### Looking for something

In a given directory,

```bash
../lookup these words
```

Will open the pdfs containing "these words".
