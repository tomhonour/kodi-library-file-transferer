# kodi-library-file-transferer

Kodi recommends a library structure like so:
```
.
├── Batman Begins (2005)
│   └── Batman Begins (2005).mp4
└── The Dark Knight (2008)
    └── The Dark Knight (2008).mkv
```

This transfer tool moves .mp4 or .mkv files from one location to another and structures them in the above layout. It uses the filename to create the directory name. The tool also lets you rename the files.

## Dependencies
[`fzf`](https://github.com/junegunn/fzf)