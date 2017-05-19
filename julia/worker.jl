using JSON

print("Julia is starting.")

try
    while !eof(STDIN)
        buf = readavailable(STDIN)
        req = JSON.parse(String(buf))
        id = req["id"]
        line = req["line"]
        print("$id: $line")
    end
catch err
    print(err)
    exit(1)
end
