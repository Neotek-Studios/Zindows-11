-- Zindows 11
-- Window Manager
-- Version: 0.1.3

local monitor = peripheral.find("monitor")

if not monitor then
    print("ERROR: Monitor not found.")
    return
end

monitor.setTextScale(0.5)

local W, H = monitor.getSize()

local currentWindow = nil

local windows = {
    files = {
        title = "File Explorer",
        x = 8,
        y = 5,
        w = math.min(32, W - 4),
        h = math.min(13, H - 4)
    },

    terminal = {
        title = "Terminal",
        x = 10,
        y = 6,
        w = math.min(38, W - 4),
        h = math.min(13, H - 4)
    },

    settings = {
        title = "Settings",
        x = 12,
        y = 5,
        w = math.min(30, W - 4),
        h = math.min(13, H - 4)
    }
}

local function fill(x, y, w, h, bg)
    monitor.setBackgroundColor(bg)

    for row = y, y + h - 1 do
        monitor.setCursorPos(x, row)
        monitor.write(string.rep(" ", w))
    end
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

local function drawDesktop()
    monitor.setBackgroundColor(colors.blue)
    monitor.clear()

    -- Top bar
    fill(1, 1, W, 2, colors.lightBlue)

    text(2, 1, "ZINDOWS 11", colors.white)
    text(W - 9, 1, textutils.formatTime(os.time(), true), colors.white)

    -- Logo
    center(4, "ZINDOWS 11", colors.white)
    center(5, "Desktop", colors.lightBlue)

    -- Desktop icons
    fill(3, 8, 14, 2, colors.lightBlue)
    text(5, 8, "[ FILES ]", colors.white)

    fill(3, 12, 14, 2, colors.lightBlue)
    text(4, 12, "[ TERMINAL ]", colors.white)

    fill(3, 16, 14, 2, colors.lightBlue)
    text(4, 16, "[ SETTINGS ]", colors.white)

    -- Taskbar
    fill(1, H - 1, W, 2, colors.gray)

    text(2, H, "[Z]", colors.lightBlue)
    text(8, H, "Zindows 11", colors.white)

    if currentWindow then
        text(25, H, windows[currentWindow].title, colors.lightBlue)
    end
end

local function drawWindow(name)
    local win = windows[name]

    if not win then
        return
    end

    -- Window shadow
    fill(
        win.x + 1,
        win.y + 1,
        win.w,
        win.h,
        colors.black
    )

    -- Window body
    fill(
        win.x,
        win.y,
        win.w,
        win.h,
        colors.white
    )

    -- Title bar
    fill(
        win.x,
        win.y,
        win.w,
        2,
        colors.lightBlue
    )

    text(
        win.x + 2,
        win.y,
        win.title,
        colors.white
    )

    text(
        win.x + win.w - 3,
        win.y,
        "X",
        colors.white
    )

    if name == "files" then
        text(win.x + 2, win.y + 4, "This PC", colors.blue)

        local files = fs.list("/")

        local line = win.y + 6

        for _, file in ipairs(files) do
            if line < win.y + win.h - 1 then
                text(
                    win.x + 3,
                    line,
                    ">" .. file,
                    colors.black
                )

                line = line + 1
            end
        end

    elseif name == "terminal" then
        text(
            win.x + 2,
            win.y + 4,
            "Zindows Terminal",
            colors.blue
        )

        text(
            win.x + 2,
            win.y + 6,
            "Ready.",
            colors.black
        )

        text(
            win.x + 2,
            win.y + 8,
            "Use keyboard input.",
            colors.black
        )

    elseif name == "settings" then
        text(
            win.x + 2,
            win.y + 4,
            "System",
            colors.blue
        )

        text(
            win.x + 2,
            win.y + 6,
            "Zindows 11",
            colors.black
        )

        text(
            win.x + 2,
            win.y + 7,
            "Version 0.1.3",
            colors.black
        )

        text(
            win.x + 2,
            win.y + 8,
            "CC:Tweaked",
            colors.black
        )
    end
end

local function render()
    drawDesktop()

    if currentWindow then
        drawWindow(currentWindow)
    end
end

local function inside(x, y, bx, by, bw, bh)
    return x >= bx
        and x < bx + bw
        and y >= by
        and y < by + bh
end

local function handleTouch(x, y)
    if currentWindow then
        local win = windows[currentWindow]

        -- Close button
        if inside(
            x,
            y,
            win.x + win.w - 4,
            win.y,
            4,
            2
        ) then
            currentWindow = nil
            render()
            return
        end

        -- Clicking outside does nothing
        return
    end

    -- Files
    if inside(x, y, 3, 8, 14, 2) then
        currentWindow = "files"
        render()
        return
    end

    -- Terminal
    if inside(x, y, 3, 12, 14, 2) then
        currentWindow = "terminal"
        render()
        return
    end

    -- Settings
    if inside(x, y, 3, 16, 14, 2) then
        currentWindow = "settings"
        render()
        return
    end
end

render()

while true do
    local event, side, x, y = os.pullEvent()

    if event == "monitor_touch" then
        handleTouch(x, y)
    end

    if event == "key" and x == keys.q then
        break
    end
end

monitor.setBackgroundColor(colors.black)
monitor.setTextColor(colors.white)
monitor.clear()
