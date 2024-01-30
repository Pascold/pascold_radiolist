CreateThread(function() 
    while true do
        local channel = exports['pma-voice']:getRadioChannel()
        local count = exports['pma-voice']:GetRadioCount()
        local kanal = tostring(channel)
        if tostring(channel) == "0" then
            sleep = 1500 -- co ile sprawdza czy jesteś na radiu (1.5 sekundy)
            SendNUIMessage({
                type = 'HideUI'
            })    
        elseif kanal == "1" or kanal == "2" or kanal == "3" or kanal == "4" or kanal == "5" or kanal == "6" or kanal == "7" or kanal == "8" or kanal == "9" or kanal == "10" then
            if tostring(channel) == "1" then
                channel = 'LSPD'
            elseif tostring(channel) == "2" then
                channel = 'Taktyczny #1'
            elseif tostring(channel) == "3" then
                channel = 'Taktyczny #2'
            elseif tostring(channel) == "4" then
                channel = 'Taktyczny #3'
            elseif tostring(channel) == "5" then
                channel = 'Taktyczny #4'
            elseif tostring(channel) == "6" then
                channel = 'EMS'
            elseif tostring(channel) == "7" then
                channel = 'LSFD #1'
            elseif tostring(channel) == "8" then
                channel = 'LSFD #2'
            elseif tostring(channel) == "9" then
                channel = 'LSCM'
            elseif tostring(channel) == "10" then
                channel = 'DOJ'
            end
            local players = lib.callback.await('piotreq_radiolist:GetUsers')
            sleep = 0 -- co ile odświeża ui gdy jesteś na radiu (0.5 sekundy)
            SendNUIMessage({
                type = 'ShowUI',
                channel = channel,
                count = count,
                players = players,
            })  
        elseif tostring(channel) > "10" then
            local players = lib.callback.await('piotreq_radiolist:GetUsers2')
            sleep = 0 -- co ile odświeża ui gdy jesteś na radiu (0.5 sekundy)
            SendNUIMessage({
                type = 'ShowUI',
                channel = channel,
                count = count,
                players = players,
            })   
        end    
        Citizen.Wait(sleep)
    end
end)