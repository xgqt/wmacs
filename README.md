# Wmacs

<a href=https://alphapapa.github.io/dont-tread-on-emacs/>
   <img src="https://alphapapa.github.io/dont-tread-on-emacs/dont-tread-on-emacs-150.png" align="right">
</a>


## About

This is a rewrite of my Emacs config that I initially did on 24.08.2020 on a Windows VM.


## Install

### Linux

Clone this repo into ~/.emacs.d

`git clone --verbose https://gitlab.com/xgqt/wmacs ~/.emacs.d`

or

install with `bash install.sh`

or

install from myov (Gentoo)

```bash
emerge -av --autounmask app-eselect/eselect-repository
eselect repository enable myov
emerge -av --autounmask wmacs
```

### Windows

copy to `C:\Users\<user>\AppData\Roaming\.emacs.d`


## Run (noinstall)

### Linux

run with `sh ./launch.sh`

### Windows

run with `C:\Emacs\bin\emacs.exe -q --load C:\Emacs\wmacs\init.el `
(assuming those are the correct paths to emacs and wmacs init)
