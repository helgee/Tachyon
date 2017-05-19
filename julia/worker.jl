using JSON

# print("Julia is starting.")

# @async begin
    # while isopen(STDIN)
    #     req = JSON.parse(readline(STDIN))
    #     id = req["id"]
    #     line = req["line"]
    #     println("$id: $line")
    #     flush(STDOUT)
    # end
# end

try
    while true
        line = readline(STDIN)
        # req = JSON.parse(readline(STDIN))
        # id = req["id"]
        # line = req["line"]
        # print("$id: $line")
        print(line)
        print(line)
    end
catch err
    println(err)
    exit(1)
end

println("Julia is exiting.")
