-- Zindows 11
-- Computer Terminal Desktop
-- Version: 0.1.3

local running = true
local window = nil

local function draw()
    local w, h = term.getSize()

    term.setBackgroundColor(colors.blue)
    term.clear()

    -- Header
    term.setBackgroundColor(colors.lightBlue)
    term.setCursorPos(1, 1)
    term.clearLine()
    term.write(" ZINDOWS 11")

    term.setCursorPos(w - 7, 1)
    term.write("0.1.3 ")

    -- Welcome
    term.setBackgroundColor(colors.blue)
    term.setTextColor(colors.white)

    term.setCursorPos(2, 3)
    term.write("Welcome to Zindows 11")

    term.setTextColor(colors.lightBlue)
    term.setCursorPos(2, 4)
    term.write("Your computer. Your system.")

    -- Files
    term.setBackgroundColor(colors.lightBlue)
    term.setCursorPos(3, 7)
    term.write("                ")

    term.setCursorPos(5, 8)
    term.setTextColor(colors.white)
    term.write("FILES")

    -- Terminal
    term.setCursorPos(3, 11)
    term.setBackgroundColor(colors.lightBlue)
    term.write("                ")

    term.setCursorPos(5, 12)
    term.setTextColor(colors.white)
    term.write("TERMINAL")

    -- Settings
    term.setCursorPos(3, 15)
    term.setBackgroundColor(colors.lightBlue)
    term.write("                ")

    term.setCursorPos(5, 16)
    term.setTextColor(colors.white)
    term.write("SETTINGS")

    -- Taskbar
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.white)

    term.setCursorPos(1, h - 1)
    term.clearLine()

    term.setCursorPos(2, h - 1)
    term.write("[Z]")

    term.setCursorPos(7, h - 1)
    term.write("Zindows")

    local clock = textutils.formatTime(os.time(), true)

    term.setCursorPos(w - #clock - 1, h - 1)
    term.write(clock)

    -- Window
    if window then
        drawWindow(w, h)
    end
end

function drawWindow(w, h)
    local ww = math.min(42, w - 4)
    local wh = math.min(12, h - 5)

    local x = math.floor((w - ww) / 2) + 1
    local y = 4

    -- Window body
    term.setBackgroundColor(colors.white)

    for row = y, y + wh do
        term.setCursorPos(x, row)

        if row == y then
            term.setBackgroundColor(colors.lightBlue)
        else
            term.setBackgroundColor(colors.white)
        end

        term.write(string.rep(" ", ww))
    end

    -- Title
    term.setBackgroundColor(colors.lightBlue)
    term.setTextColor(colors.white)

    term.setCursorPos(x + 2, y)
    term.write(window)

    -- Close button
    term.setBackgroundColor(colors.red)
    term.setCursorPos(x + ww - 4, y)
    term.write(" X ")

    -- Content
    term.setBackgroundColor(colors.white)
    term.setTextColor(colors.black)

    if window == "FILES" then
        term.setCursorPos(x + 3, y + 3)
        term.write("File Explorer")

        term.setCursorPos(x + 3, y + 5)
        term.write("Computer")

        term.setCursorPos(x + 3, y + 6)
        term.write("  /")

        term.setCursorPos(x + 3, y + 8)
        term.write("Zindows system ready.")

    elseif window == "TERMINAL" then
        term.setCursorPos(x + 3, y + 3)
        term.write("Zindows Terminal")

        term.setCursorPos(x + 3, y + 5)
        term.write("Type commands in the terminal.")

        term.setCursorPos(x + 3, y + 7)
        term.write("Press T to open CraftOS.")

    elseif window == "SETTINGS" then
        term.setCursorPos(x + 3, y + 3)
        term.write("Zindows Settings")

        term.setCursorPos(x + 3, y + 5)
        term.write("System")

        term.setCursorPos(x + 3, y + 6)
        term.write("Version: 0.1.3")

        term.setCursorPos(x + 3, y + 7)
        term.write("Platform: CC:Tweaked")

        term.setCursorPos(x + 3, y + 9)
        term.setTextColor(colors.lime)
        term.write("System Ready")
    end
end

local function click(x, y)
    local w, h = term.getSize()

    if window then
        local ww = math.min(42, w - 4)
        local wx = math.floor((w - ww) / 2) + 1
        local wy = 4

        if x >= wx + ww - 5
            and x <= wx + ww
            and y == wy then

            window = nil
            draw()
            return
        end

        return
    end

    if x >= 3 and x <= 18 and y >= 7 and y <= 8 then
        window = "FILES"
        draw()
        return
    end

    if x >= 3 and x <= 18 and y >= 11 and y <= 12 then
        window = "TERMINAL"
        draw()
        return
    end

    if x >= 3 and x <= 18 and y >= 15 and y <= 16 then
        window = "SETTINGS"
        draw()
        return
    end
end

draw()

while running do
    local event, a, b, c = os.pullEvent()

    if event == "mouse_click" then
        click(b, c)

    elseif event == "key" then
        if a == keys.q then
            running = false

        elseif a == keys.one then
            window = "FILES"
            draw()

        elseif a == keys.two then
            window = "TERMINAL"
            draw()

        elseif a == keys.three then
            window = "SETTINGS"
            draw()

        elseif a == keys.t and window == "TERMINAL" then
            term.clear()
            term.setBackgroundColor(colors.black)
            term.setTextColor(colors.white)
            term.setCursorPos(1, 1)

            shell.run("shell")

            draw()
        end

    elseif event == "term_resize" then
        draw()
    end
end

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1, 1)
