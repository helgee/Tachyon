using JSON

if !isempty(ARGS)
    workers = parse(Int, ARGS[1])
    addprocs(workers)
else
    addprocs()
end

print("Julia is starting with $(nprocs()) processes.")

while !eof(STDIN)
    buf = readavailable(STDIN)
    req = JSON.parse(String(buf))
    id = req["id"]
    line = req["line"]
    print("$id: $line")
end
