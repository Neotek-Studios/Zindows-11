-- Zindows 11
-- Desktop Environment
-- Version: 0.1.1

local W, H = term.getSize()

local function centerText(y, text)
    local x = math.floor((W - #text) / 2) + 1
    term.setCursorPos(x, y)
    write(text)
end

local function drawTaskbar()
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.white)

    term.setCursorPos(1, H)
    write(string.rep(" ", W))

    term.setCursorPos(2, H)
    term.setTextColor(colors.lightBlue)
    write("[Z]")

    term.setTextColor(colors.white)
    term.setCursorPos(7, H)
    write("Explorer")

    term.setCursorPos(17, H)
    write("Terminal")

    term.setCursorPos(27, H)
    write("Settings")

    local time = textutils.formatTime(os.time(), true)

    term.setCursorPos(W - #time - 1, H)
    write(time)
end

local function drawDesktop()
    W, H = term.getSize()

    term.setBackgroundColor(colors.blue)
    term.clear()

    term.setTextColor(colors.white)

    centerText(4, "ZINDOWS 11")

    centerText(6, "Welcome to your desktop")

    term.setTextColor(colors.lightBlue)
    centerText(8, "Your computer. Your system.")

    term.setTextColor(colors.white)

    term.setCursorPos(4, 12)
    write("[1] Explorer")

    term.setCursorPos(4, 14)
    write("[2] Terminal")

    term.setCursorPos(4, 16)
    write("[3] Settings")

    term.setCursorPos(4, 18)
    write("[Q] Shutdown")

    drawTaskbar()

    term.setBackgroundColor(colors.blue)
end

local function explorer()
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)

    term.setTextColor(colors.lightBlue)
    print("ZINDOWS EXPLORER")
    term.setTextColor(colors.white)

    print("----------------------------------------")
    print()

    local files = fs.list("/")

    for _, file in ipairs(files) do
        print("  " .. file)
    end

    print()
    print("----------------------------------------")
    print("Press ENTER to return.")

    read()
end

local function terminal()
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)

    term.setTextColor(colors.lightBlue)
    print("ZINDOWS TERMINAL")
    term.setTextColor(colors.white)

    print("----------------------------------------")
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
end

local function settings()
    term.setBackgroundColor(colors.black)
    term.clear()
    term.setCursorPos(1, 1)

    term.setTextColor(colors.lightBlue)
    print("ZINDOWS SETTINGS")
    term.setTextColor(colors.white)

    print("----------------------------------------")
    print()
    print("System")
    print()
    print("OS: Zindows 11")
    print("Version: 0.1.1")
    print("Platform: CC:Tweaked")
    print()
    print("Display: " .. W .. "x" .. H)
    print()
    print("----------------------------------------")
    print("Press ENTER to return.")

    read()
end

while true do
    drawDesktop()

    local event, key = os.pullEvent("key")

    if key == keys.one then
        explorer()

    elseif key == keys.two then
        terminal()

    elseif key == keys.three then
        settings()

    elseif key == keys.q then
        term.setBackgroundColor(colors.black)
        term.clear()
        term.setCursorPos(1, 1)

        term.setTextColor(colors.lightBlue)
        print("Zindows 11 shutting down...")

        sleep(1)

        term.setTextColor(colors.white)
        term.clear()
        term.setCursorPos(1, 1)

        break
    end
end
