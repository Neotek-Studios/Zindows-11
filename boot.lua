-- Zindows 11
-- Bootloader
-- Version: 0.1.3

local DIR = "/zindows"
local DESKTOP = DIR .. "/desktop.lua"

term.setBackgroundColor(colors.black)
term.setTextColor(colors.white)
term.clear()
term.setCursorPos(1, 1)

print("ZINDOWS 11")
print("Starting system...")

if not fs.exists(DIR) then
    fs.makeDir(DIR)
end

sleep(0.5)

if not fs.exists(DESKTOP) then
    term.setTextColor(colors.red)
    print("ERROR: desktop.lua not found.")
    term.setTextColor(colors.white)
    return
end

term.clear()
shell.run(DESKTOP)
