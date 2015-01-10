

function! atcoder_helper#init(contest_name)
    if exists('g:online_jadge_path')
        let g:online_jadge_path = ''
    endif
    if exists('g:dir_atcoder')
        let g:dir_atcoder = ''
    endif

    call atcoder_helper#mkdir(g:dir_atcoder, 1)
    call atcoder_helper#mkdir(atcoder_helper#join(g:dir_atcoder, 'A'))
    call atcoder_helper#mkdir(atcoder_helper#join(g:dir_atcoder, 'B'))
    call atcoder_helper#mkdir(atcoder_helper#join(g:dir_atcoder, 'C'))
endfunction

function! atcoder_helper#mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction

function! atcoder_helper#join(parts)
    if type(a:parts) == type([])
        if !s:windows_compatible && a:parts[0] == '/'
            return join(a:parts, '/')[1 : -1]
        else
            return join(a:parts, '/')
        endif
    endif
    return ''
endfunction
