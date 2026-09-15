-- Zindows 11
-- Desktop Environment
-- Version 0.1.3

local W, H = term.getSize()

local window = nil
local running = true

local function refreshSize()
    W, H = term.getSize()
end

local function box(x, y, w, h, bg)
    term.setBackgroundColor(bg)

    for row = y, y + h - 1 do
        if row >= 1 and row <= H then
            term.setCursorPos(x, row)
            term.write(string.rep(" ", math.max(0, math.min(w, W - x + 1))))
        end
    end
end

local function text(x, y, value, fg)
    if y < 1 or y > H then
        return
    end

    term.setCursorPos(x, y)
    term.setTextColor(fg)
    term.write(value)
end

local function centered(y, value, fg)
    local x = math.floor((W - #value) / 2) + 1

    if x < 1 then
        x = 1
    end

    text(x, y, value, fg)
end

local function button(x, y, w, label, bg)
    box(x, y, w, 3, bg)

    local lx = x + math.floor((w - #label) / 2)

    if lx < x + 1 then
        lx = x + 1
    end

    text(lx, y + 1, label, colors.white)
end

local function drawTaskbar()
    box(1, H - 2, W, 3, colors.gray)

    text(2, H - 1, "Z", colors.lightBlue)
    text(5, H - 1, "Zindows", colors.white)

    if W >= 45 then
        text(18, H - 1, "Desktop", colors.lightGray)
    end

    local clock = textutils.formatTime(os.time(), true)

    text(
        W - #clock - 1,
        H - 1,
        clock,
        colors.white
    )
end

local function drawDesktop()
    refreshSize()

    term.setBackgroundColor(colors.blue)
    term.clear()

    -- Top area
    box(1, 1, W, 2, colors.lightBlue)

    text(2, 1, "ZINDOWS 11", colors.white)
    text(W - 8, 1, "v0.1.3", colors.white)

    centered(4, "ZINDOWS 11", colors.white)
    centered(5, "Welcome back", colors.lightBlue)

    -- Desktop icons

    button(3, 8, 18, "[ FILES ]", colors.lightBlue)

    button(3, 12, 18, "[ TERMINAL ]", colors.lightBlue)

    button(3, 16, 18, "[ SETTINGS ]", colors.lightBlue)

    -- Right information panel
    if W >= 55 then
        box(W - 29, 8, 25, 10, colors.lightBlue)

        text(W - 27, 9, "SYSTEM", colors.white)
        text(W - 27, 11, "Zindows 11", colors.white)
        text(W - 27, 12, "Version 0.1.3", colors.lightGray)
        text(W - 27, 14, "CC:Tweaked", colors.lightGray)
        text(W - 27, 16, "System Ready", colors.lime)
    end

    drawTaskbar()
end

local function windowSize()
    local w = math.min(48, W - 4)
    local h = math.min(17, H - 5)

    if w < 20 then
        w = W - 2
    end

    if h < 8 then
        h = H - 3
    end

    return w, h
end

local function drawWindow(title, kind)
    refreshSize()

    local ww, wh = windowSize()

    local wx = math.floor((W - ww) / 2) + 1
    local wy = 3

    -- Shadow
    box(wx + 1, wy + 1, ww, wh, colors.black)

    -- Window
    box(wx, wy, ww, wh, colors.white)

    -- Title bar
    box(wx, wy, ww, 2, colors.lightBlue)

    text(wx + 2, wy, title, colors.white)

    box(wx + ww - 5, wy, 5, 2, colors.red)
    text(wx + ww - 3, wy, "X", colors.white)

    if kind == "files" then
        text(wx + 2, wy + 4, "This PC", colors.blue)

        box(wx + 1, wy + 5, ww - 2, 1, colors.lightGray)

        local files = fs.list("/")
        local line = wy + 7

        if #files == 0 then
            text(wx + 3, line, "No files found.", colors.gray)
        else
            for _, file in ipairs(files) do
                if line < wy + wh - 1 then
                    local prefix = fs.isDir("/" .. file) and "[DIR] " or "[FILE] "

                    text(
                        wx + 3,
                        line,
                        prefix .. file,
                        colors.black
                    )

                    line = line + 1
                end
            end
        end

    elseif kind == "terminal" then
        text(wx + 2, wy + 4, "Zindows Terminal", colors.blue)
        text(wx + 2, wy + 6, "Terminal ready.", colors.black)
        text(wx + 2, wy + 8, "Press T to open CraftOS shell.", colors.gray)

    elseif kind == "settings" then
        text(wx + 2, wy + 4, "System", colors.blue)

        text(wx + 2, wy + 6, "Operating System", colors.gray)
        text(wx + 20, wy + 6, "Zindows 11", colors.black)

        text(wx + 2, wy + 8, "Version", colors.gray)
        text(wx + 20, wy + 8, "0.1.3", colors.black)

        text(wx + 2, wy + 10, "Platform", colors.gray)
        text(wx + 20, wy + 10, "CC:Tweaked", colors.black)

        text(wx + 2, wy + 12, "Status", colors.gray)
        text(wx + 20, wy + 12, "Running", colors.lime)
    end

    return wx, wy, ww, wh
end

local function openWindow(kind)
    window = kind
end

local function closeWindow()
    window = nil
end

local function inside(x, y, bx, by, bw, bh)
    return x >= bx
        and x < bx + bw
        and y >= by
        and y < by + bh
end

local function handleClick(x, y)
    refreshSize()

    if window then
        local title = ""

        if window == "files" then
            title = "File Explorer"
        elseif window == "terminal" then
            title = "Terminal"
        elseif window == "settings" then
            title = "Settings"
        end

        local ww, wh = windowSize()
        local wx = math.floor((W - ww) / 2) + 1
        local wy = 3

        if inside(
            x,
            y,
            wx + ww - 5,
            wy,
            5,
            2
        ) then
            closeWindow()
        end

        return
    end

    if inside(x, y, 3, 8, 18, 3) then
        openWindow("files")
        return
    end

    if inside(x, y, 3, 12, 18, 3) then
        openWindow("terminal")
        return
    end

    if inside(x, y, 3, 16, 18, 3) then
        openWindow("settings")
        return
    end
end

local function render()
    if window == nil then
        drawDesktop()
    elseif window == "files" then
        drawDesktop()
        drawWindow("File Explorer", "files")
    elseif window == "terminal" then
        drawDesktop()
        drawWindow("Terminal", "terminal")
    elseif window == "settings" then
        drawDesktop()
        drawWindow("Settings", "settings")
    end
end

render()

while running do
    local event, p1, p2, p3 = os.pullEvent()

    if event == "mouse_click" then
        local buttonID = p1
        local x = p2
        local y = p3

        if buttonID == 1 then
            handleClick(x, y)
            render()
        end

    elseif event == "key" then
        local key = p2

        if key == keys.q then
            running = false

        elseif window == "terminal" and key == keys.t then
            term.clear()
            term.setCursorPos(1, 1)

            shell.run("shell")

            render()
        end

    elseif event == "term_resize" then
        render()
    end
end

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1, 1)
