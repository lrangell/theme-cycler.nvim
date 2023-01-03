
mkdir lua

let filesToCompile = (ls ./fnl/themeCycler | where ($it.name !~ "macro" ) | select name)

def compile-fennel-file [fnlFile] {
    let out = ($fnlFile | str replace -a "fnl" "lua")
    fennel --add-macro-path fnl/themeCycler/macros.fnl -c $fnlFile | save -f $out
    $"compiled to ($out)"
}

$filesToCompile | each {|it| compile-fennel-file $it.name}
