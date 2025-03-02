-- Funktion zum Anzeigen der Inventarinformationen
function displayInventory()
    local peripherals = peripheral.getNames()
    local found = false

    for _, name in ipairs(peripherals) do
        if name:find("indrev:") then
            local inventory = peripheral.wrap(name)
            if inventory then
                found = true
                print("Inventar von " .. name .. ":")
                local items = inventory.list()
                for slot, item in pairs(items) do
                    print("Slot " .. slot .. ": " .. item.name .. " x" .. item.count)
                end
                print("------------------------")
            end
        end
    end

    if not found then
        print("Keine Inventar-Peripheriegeräte gefunden.")
    end
end

-- Hauptprogramm
while true do
    displayInventory()
    sleep(5) -- Aktualisiert die Anzeige alle 5 Sekunden
end