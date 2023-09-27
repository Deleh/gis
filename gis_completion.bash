function _gis_completion {
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    if [[ ${prev} == -p ]] || [[ ${prev} == --path ]]; then
        OLDIFS=$IFS
        IFS='
'
        COMPREPLY=( $(compgen -d -- "${cur}") )
        IFS=$OLDIFS
    else
        args="--help --path fetch pull"
        COMPREPLY=( $(compgen -W "${args}" -- "${cur}") )
    fi
}

complete -o filenames -F _gis_completion gis
