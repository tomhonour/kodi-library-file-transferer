# kodi-library-file-transfer-tool
## Demo
[![demo](https://asciinema.org/a/GsMBSGa3Im7t6L6Fc4ORT5e6i.svg)](https://asciinema.org/a/GsMBSGa3Im7t6L6Fc4ORT5e6i?autoplay=1)

Kodi recommends a library structure like so:
```
.
├── Batman Begins (2005)
│   └── Batman Begins (2005).mp4
└── The Dark Knight (2008)
    └── The Dark Knight (2008).mp4
```

This transfer tool moves .mp4 or .mkv files from one location to another and structures them in the above layout. It uses the filename to create the directory name.

## Dependencies
fzf