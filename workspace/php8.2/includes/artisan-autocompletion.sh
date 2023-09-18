#!/bin/bash

# add artisan as an alias function
function artisan() {
    php artisan "$@"
}

_artisan()
{

    local cache commands artisanOutput word

    if [ $(basename "$1") != artisan ] || [ ! -e "$1" ]; then
        return 0;
    fi

    _get_comp_words_by_ref -n : -c word

    cache=/tmp/.artisan_command_cache_$BASHPID
    commands=()

    # enables cache per terminal session
    # calling artisan is too time consuming for each tab press
    if [ -f $cache ];
    then
        commands=$(cat "$cache")
    else
        commands=$(php artisan list --raw | cut -f 1 -d " " | tr "\n" " ")
        printf "%s\n" "${commands[@]}" > "$cache"
    fi

    COMPREPLY=( $(compgen -W "${commands}" -- $word) )

    # remove color from the word breaking list
    __ltrim_colon_completions "$word"

    return 0
}

complete -o default -F _artisan artisan
