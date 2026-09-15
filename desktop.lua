-- Zindows 11
-- Desktop
-- Version: 0.1.0

term.clear()
term.setCursorPos(1, 1)

local function drawDesktop()
    term.clear()
    term.setCursorPos(1, 1)

    print("================================================")
    print("                    ZINDOWS 11")
    print("================================================")
    print()
    print("              Welcome to Zindows!")
    print()
    print("   [1] Explorer")
    print("   [2] Terminal")
    print("   [3] Settings")
    print("   [Q] Shutdown")
    print()
    print("================================================")
    print(" Zindows 11 v0.1.0")
    print("================================================")
end

while true do
    drawDesktop()

    write("> ")
    local input = read()

    if input == "1" then
        term.clear()
        term.setCursorPos(1, 1)
        print("ZINDOWS EXPLORER")
        print()
        print("Files:")
        print()

        local files = fs.list("/")

        for _, file in ipairs(files) do
            print("  " .. file)
        end

        print()
        print("Press ENTER to return.")
        read()

    elseif input == "2" then
        term.clear()
        term.setCursorPos(1, 1)
        print("ZINDOWS TERMINAL")
        print()
        print("Type 'exit' to return.")
        print()

        while true do
            write("C:\\> ")
            local command = read()

            if command == "exit" then
                break
            end

            if command ~= "" then
                shell.run(command)
            end
        end

    elseif input == "3" then
        term.clear()
        term.setCursorPos(1, 1)
        print("ZINDOWS SETTINGS")
        print()
        print("System")
        print("Version: 0.1.0")
        print("Platform: CC:Tweaked")
        print()
        print("Press ENTER to return.")
        read()

    elseif input == "q" or input == "Q" then
        term.clear()
        term.setCursorPos(1, 1)
        print("Shutting down Zindows 11...")
        sleep(1)
        term.clear()
        term.setCursorPos(1, 1)
        break
    end
end
