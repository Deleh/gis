function _gis_completion {
    args=" --help --path "
    commands=" fetch pull "
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}

    # Handle path completion
    if [[ ${prev} == -p ]] || [[ ${prev} == --path ]]; then
        OLDIFS=$IFS
        IFS='
'
        COMPREPLY=( $(compgen -d -- "${cur}") )
        IFS=$OLDIFS
        return
    fi

    # Complete only one command
    for word in ${COMP_WORDS[*]}; do
        if [[ "$commands" == *" ${word} "* ]]; then
            COMPREPLY=( $(compgen -W "${args}" -- "${cur}") )
            return
        fi
    done
    COMPREPLY=( $(compgen -W "${commands} ${args}" -- "${cur}") )
}

complete -o filenames -F _gis_completion gis
