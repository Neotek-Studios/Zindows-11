-- Zindows 11
-- Bootloader
-- Version: 0.1.2

local ZINDOWS_DIR = "/zindows"
local DESKTOP = ZINDOWS_DIR .. "/desktop.lua"

term.clear()
term.setCursorPos(1, 1)

term.setTextColor(colors.lightBlue)
print("========================================")
print("              ZINDOWS 11")
print("========================================")
term.setTextColor(colors.white)
print()
print("Starting system...")

if not fs.exists(ZINDOWS_DIR) then
    fs.makeDir(ZINDOWS_DIR)
end

sleep(0.8)

if not fs.exists(DESKTOP) then
    term.setTextColor(colors.red)
    print("ERROR: desktop.lua not found.")
    term.setTextColor(colors.white)
    return
end

term.clear()
term.setCursorPos(1, 1)

shell.run(DESKTOP)
