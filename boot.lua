-- Zindows 11
-- Bootloader
-- Version: 0.1.3

term.clear()
term.setCursorPos(1, 1)

term.setBackgroundColor(colors.black)
term.setTextColor(colors.lightBlue)

print("================================")
print("          ZINDOWS 11")
print("================================")

term.setTextColor(colors.white)
print()
print("Starting Zindows...")
sleep(1)

local desktop = "/zindows/desktop.lua"

if not fs.exists(desktop) then
    term.setTextColor(colors.red)
    print()
    print("ERROR")
    print("desktop.lua not found.")
    term.setTextColor(colors.white)
    return
end

term.clear()

-- IMPORTANT:
-- Zindows uses the computer's own terminal.
-- No monitor peripheral is required.

shell.run(desktop)
