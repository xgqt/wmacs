#!/bin/sh


if  [ -f ./init.el ]; then
    emacs -q --load ./init.el
fi
