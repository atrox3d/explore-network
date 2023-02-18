#!/bin/bash

for v in one two three four
do
    case $v in
        on*|t*)
            echo 1 2
            ;;
        t*|f*)
            echo 3 4
            ;;
    esac
done
