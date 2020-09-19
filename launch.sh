#!/bin/sh


initdir="$(dirname "${0}")"

if  [ -f "${initdir}"/init.el ]
then
    emacs -q --load "${initdir}"/init.el "${@}"
fi
