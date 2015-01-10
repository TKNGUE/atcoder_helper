function! atcoder_helper#init(contest_name)
    if !exists('g:online_jadge_path')
        let g:online_jadge_path = 'oj.py'
    endif
    if !exists('g:atcoder_dir')
        let g:atcoder_dir = '$HOME/atcoder'
    endif
    if !exists('g:atcoder_config')
        let g:atcoder_config = 'setting.json'
    endif
    " if !exists('g:atcoder_browser')
    "     let g:atcoder_browser = 'firefox'
    " endif
    " if !exists('g:atcoder_user_id')
    "     let g:atcoder_user_id = input('USER>')
    " endif
    " if !exists('g:atcoder_password')
    "     let g:atcoder_user_id = inputsecret('PASSWORD>')
    " endif

    let g:atcoder_contest_name = a:contest_name
    let g:atcoder_contest_dir = atcoder_helper#join([expand(g:atcoder_dir), a:contest_name])

    call atcoder_helper#mkdir(g:atcoder_contest_dir, 1)
    call atcoder_helper#mkdir(atcoder_helper#join([g:atcoder_contest_dir, string(1)]), 1)
    call atcoder_helper#mkdir(atcoder_helper#join([g:atcoder_contest_dir, string(2)]), 1)
    call atcoder_helper#mkdir(atcoder_helper#join([g:atcoder_contest_dir, string(3)]), 1)
    call atcoder_helper#mkdir(atcoder_helper#join([g:atcoder_contest_dir, string(4)]), 1)
    execute 'cd '. g:atcoder_contest_dir

    command! -nargs=? AtCoderDownload call atcoder_helper#download('<args>')
    command! -nargs=0 AtCoderCheck    call atcoder_helper#check()
    command! -nargs=0 AtCoderSubmit  call atcoder_helper#submit()
endfunction

function! atcoder_helper#download(num)
    let l:execmd = '!python ' . g:online_jadge_path .' -u '. g:atcoder_config . ' --atcoder -d ' . g:atcoder_contest_name. ' '
    if a:num == ''
        for idx in [1,2,3,4]    
            execute 'cd ' . atcoder_helper#join([g:atcoder_contest_dir, string(idx)])
            call system(execmd . string(idx))
        endfor
    else
        execute 'cd ' . atcoder_helper#join([g:atcoder_contest_dir, string(num)])
        call system(execmd . string(num))
    endif
    cd ../
endfunction

function! atcoder_helper#check()
    execute 'cd ' . expand('%:p:h')
    let l:execmd = 'python ' . g:online_jadge_path .' -u '. g:atcoder_config . ' --atcoder ' . g:atcoder_contest_name. ' '. expand('%:p:h:t') . '  -i '. expand('%:p') 
    let errors = system(l:execmd)
    if v:shell_error
        echomsg 'Failed'
    else
        echomsg 'Passed All Examples'
    endif
endfunction

function! atcoder_helper#submit()
    execute 'cd ' . expand('%:p:h')
    let l:execmd = 'python ' . g:online_jadge_path .' -u '. g:atcoder_config . ' --atcoder ' . g:atcoder_contest_name. ' '. expand('%:p:h:t') . ' -s -i '. expand('%:p') 
    let errors =  system(l:execmd)
    if v:shell_error
        echomsg 'Failed'
    else
        echomsg 'Passed All Examples'
    endif

endfunction

function! atcoder_helper#mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
                \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
        call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
endfunction


function! atcoder_helper#join(parts)
    if type(a:parts) == type([])
        if a:parts[0] == '/'
            return join(a:parts, '/')[1 : -1]
        else
            return join(a:parts, '/')
        endif
    endif
    return ''
endfunction
