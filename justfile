set shell := ["nu","-c"]

default: watch-build

build: 
    nu compile.nu
watch-build:
    watchexec --watch fnl nu compile.nu

