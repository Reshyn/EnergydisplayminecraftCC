# This is a sample Python script.

# Press Umschalt+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

-- Funktion zum Abrufen der Energieinformationen
function getEnergyStorages()
    local peripherals = peripheral.getNames()
    local energyStorages = {}

    for _, name in ipairs(peripherals) do
        local type = peripheral.getType(name)
        if type == "energy_storage" then
            local energyStorage = peripheral.wrap(name)
            if energyStorage and energyStorage.getEnergy and energyStorage.getMaxEnergy then
                table.insert(energyStorages, {
                    name = name,
                    energy = energyStorage.getEnergy(),
                    maxEnergy = energyStorage.getMaxEnergy()
                })
            else
                print("Warnung: " .. name .. " unterstützt nicht die benötigten Methoden.")
            end
        end
    end

    return energyStorages
end


-- Funktion zum Anzeigen der Energieinformationen
function displayEnergy()
    term.clear()
    term.setCursorPos(1, 1)
    print("Energiespeicher Anzeige:")
    print("------------------------")

    local energyStorages = getEnergyStorages()

    if #energyStorages == 0 then
        print("Keine Energiespeicher gefunden.")
    else
        for _, storage in ipairs(energyStorages) do
            print("Speicher: " .. storage.name)
            print("Aktuelle Energie: " .. storage.energy)
            print("Maximale Energie: " .. storage.maxEnergy)
            print("------------------------")
        end
    end
end

-- Hauptprogramm
while true do
    displayEnergy()
    sleep(5) -- Aktualisiert die Anzeige alle 5 Sekunden
end