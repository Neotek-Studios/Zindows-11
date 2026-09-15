-- Zindows 11
-- Graphical Desktop
-- Version: 0.1.2

local monitor = peripheral.find("monitor")

if not monitor then
    term.clear()
    term.setCursorPos(1, 1)

    print("ZINDOWS 11")
    print()
    print("ERROR: No monitor found.")
    print()
    print("Connect a CC:Tweaked monitor")
    print("to the computer and restart Zindows.")

    return
end

monitor.setTextScale(0.5)

local W, H = monitor.getSize()

local function clear(color)
    monitor.setBackgroundColor(color)
    monitor.clear()
end

local function text(x, y, value, color)
    monitor.setCursorPos(x, y)
    monitor.setTextColor(color)
    monitor.write(value)
end

local function center(y, value, color)
    local x = math.floor((W - #value) / 2) + 1
    text(x, y, value, color)
end

local function button(x, y, width, label)
    monitor.setBackgroundColor(colors.lightBlue)
    monitor.setTextColor(colors.white)
    monitor.setCursorPos(x, y)

    local spaces = string.rep(" ", width)
    monitor.write(spaces)

    local labelX = x + math.floor((width - #label) / 2)

    monitor.setCursorPos(labelX, y)
    monitor.write(label)
end

local function drawDesktop()
    clear(colors.blue)

    -- Header
    monitor.setBackgroundColor(colors.lightBlue)
    monitor.setCursorPos(1, 1)
    monitor.write(string.rep(" ", W))

    text(2, 1, "Zindows 11", colors.white)

    -- Desktop title
    center(3, "ZINDOWS 11", colors.white)
    center(4, "Desktop", colors.lightBlue)

    -- Applications
    button(3, 7, 18, "FILES")
    button(3, 10, 18, "TERMINAL")
    button(3, 13, 18, "SETTINGS")

    -- Information panel
    monitor.setBackgroundColor(colors.lightBlue)

    local panelX = math.max(25, math.floor(W / 2))
    local panelWidth = W - panelX - 1

    if panelWidth > 10 then
        for y = 7, 15 do
            monitor.setCursorPos(panelX, y)
            monitor.write(string.rep(" ", panelWidth))
        end

        text(panelX + 2, 8, "Zindows 11", colors.white)
        text(panelX + 2, 10, "Version 0.1.2", colors.white)
        text(panelX + 2, 12, "CC:Tweaked", colors.white)
    end

    -- Taskbar
    monitor.setBackgroundColor(colors.gray)
    monitor.setCursorPos(1, H)
    monitor.write(string.rep(" ", W))

    text(2, H, "[Z]", colors.lightBlue)
    text(7, H, "Files", colors.white)
    text(14, H, "Terminal", colors.white)
    text(24, H, "Settings", colors.white)

    local time = textutils.formatTime(os.time(), true)

    if #time + 2 < W then
        text(W - #time - 1, H, time, colors.white)
    end
end

local function drawFiles()
    clear(colors.black)

    text(2, 2, "ZINDOWS FILES", colors.lightBlue)

    monitor.setBackgroundColor(colors.gray)
    monitor.setCursorPos(1, 4)
    monitor.write(string.rep(" ", W))

    text(2, 4, "Name", colors.white)

    local files = fs.list("/")

    local y = 6

    for _, file in ipairs(files) do
        if y < H - 2 then
            text(3, y, file, colors.white)
            y = y + 2
        end
    end

    text(2, H - 1, "Touch/click anywhere to return", colors.lightGray)
end

local function drawTerminal()
    clear(colors.black)

    text(2, 2, "ZINDOWS TERMINAL", colors.lightBlue)

    text(2, 4, "Terminal is ready.", colors.white)
    text(2, 6, "Use the computer keyboard", colors.white)
    text(2, 7, "to interact with the terminal.", colors.white)

    text(2, H - 1, "Touch/click anywhere to return", colors.lightGray)
end

local function drawSettings()
    clear(colors.black)

    text(2, 2, "ZINDOWS SETTINGS", colors.lightBlue)

    text(3, 5, "System", colors.white)
    text(3, 7, "Zindows 11", colors.lightGray)
    text(3, 8, "Version 0.1.2", colors.lightGray)
    text(3, 9, "Platform: CC:Tweaked", colors.lightGray)

    text(2, H - 1, "Touch/click anywhere to return", colors.lightGray)
end

drawDesktop()

while true do
    local event, side, x, y = os.pullEvent()

    if event == "monitor_touch" then
        if y >= 7 and y <= 8 and x >= 3 and x <= 21 then
            drawFiles()

        elseif y >= 10 and y <= 11 and x >= 3 and x <= 21 then
            drawTerminal()

        elseif y >= 13 and y <= 14 and x >= 3 and x <= 21 then
            drawSettings()

        else
            drawDesktop()
        end
    end

    if event == "key" and side == keys.q then
        break
    end
end

monitor.setBackgroundColor(colors.black)
monitor.setTextColor(colors.white)
monitor.clear()
