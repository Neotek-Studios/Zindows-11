-- Zindows 11
-- Bootloader
-- Version: 0.1.0

local ZINDOWS_DIR = "/zindows"
local DESKTOP = ZINDOWS_DIR .. "/desktop.lua"

term.clear()
term.setCursorPos(1, 1)

print("================================")
print("          ZINDOWS 11")
print("================================")
print()
print("Starting system...")

if not fs.exists(ZINDOWS_DIR) then
    fs.makeDir(ZINDOWS_DIR)
end

sleep(1)

if not fs.exists(DESKTOP) then
    print()
    print("ERROR")
    print("desktop.lua was not found.")
    print()
    print("System cannot start.")
    return
end

term.clear()
term.setCursorPos(1, 1)

shell.run(DESKTOP)
