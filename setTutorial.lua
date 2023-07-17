-- Created by limau
guestData = {
    {rid = "", mac = ""},
    {rid = "", mac = ""},
    {rid = "", mac = ""}
}

setGuest = {"asepu1", "asepu2", "asepu3"}

function rubah()
    setBool("Auto Reconnect", false)
    disconnect()
    while getRid(getBot().name) ~= guesto.rid do
        setRid(guesto.rid)
        setMac(guesto.mac)
    end
    sleep(4000)
    connect()
    sleep(4500)
    while getBot(getBot().name).status:lower() ~= "online" do
        connect()
        sleep(math.random(4000, 10000))
        if getBot(getBot().name).status:lower() == "suspended" or getBot(getBot().name).status:lower() == "temporary ban" then
            break
        end
    end
    setBool("Auto Reconnect", true)
end

-- custom limau
if getBot().name == setGuest[1] then
    guesto = guestData[1]
elseif getBot().name == setGuest[2] then
    guesto = guestData[2]
elseif getBot().name == setGuest[3] then
    guesto = guestData[3]
else
    say(getBot().name)
end


if string.sub(getBot().world, 1, 10) == "TUTORIAL_1" then
    sleep(1000)
    -- melakukan skip tutor
    load(request("GET","https://raw.githubusercontent.com/rfsyhb/growtufiyahgem/main/skipTutorial.lua"))()
    sleep(1000)
else
    rubah()
end
