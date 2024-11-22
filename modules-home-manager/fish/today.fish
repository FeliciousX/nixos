if test (count $argv) -lt 1
    set date $(date)
else
    set date $argv[1]
end

echo $date
