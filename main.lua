-- Funktion zum Zeichnen eines Ladebalkens
function drawProgressBar(x, y, width, current, max)
    local ratio = current / max
    local filled = math.floor(ratio * width)
    local bar = ""

    for i = 1, width do
        if i <= filled then
            bar = bar .. "|"
        else
            bar = bar .. " "
        end
    end

    term.setCursorPos(x, y)
    term.write("[" .. bar .. "]")
end

-- Funktion zum Abrufen des symbolischen Energiestands
function getSymbolicEnergy(name)
    local inventory = peripheral.wrap(name)
    if inventory then
        local items = inventory.list()
        local totalItems = 0

        -- Zähle die Anzahl der Items im Inventar
        for slot, item in pairs(items) do
            totalItems = totalItems + item.count
        end

        -- Beispiel: Maximal 64 Items pro Slot, 10 Slots
        local maxItems = 64 * 10
        return totalItems, maxItems
    end
    return 0, 1
end

-- Funktion zum Anzeigen der Energieinformationen
function displayEnergy()
    term.clear()
    term.setCursorPos(1, 1)
    print("Energiespeicher Anzeige:")
    print("------------------------")

    local peripherals = peripheral.getNames()
    local found = false

    for _, name in ipairs(peripherals) do
        if name:find("indrev:") then
            found = true
            local currentEnergy, maxEnergy = getSymbolicEnergy(name)
            print("Speicher: " .. name)
            print("Aktuelle Energie: " .. currentEnergy)
            print("Maximale Energie: " .. maxEnergy)

            -- Zeichne den Ladebalken
            drawProgressBar(1, 5, 20, currentEnergy, maxEnergy)
            print("\n------------------------")
        end
    end

    if not found then
        print("Keine Energiespeicher gefunden.")
    end
end

-- Hauptprogramm
while true do
    displayEnergy()
    sleep(5) -- Aktualisiert die Anzeige alle 5 Sekunden
end