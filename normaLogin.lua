-- Created by limau
guest = true -- true / false
patokan = "asheps"
kelipatan = 3
mulaiBot = 1
banyakBot = 30
proxyList = {
    "proxyente:port",
}
botList = {
    "growid:password",
}
guestList = {}

function login()
    local proxyIndex = 1
    local i = 1
    if guest then
        for i = 1, banyakBot do
            table.insert(guestList, patokan .. (mulaiBot + i - 1))
        end
        while i <= #guestList do
            local guestname = guestList[i]
            local proxy = proxyList[proxyIndex] or ""
            addBot(guestname, true, proxy)
            i = i + 1
            sleep(1000)
            setBool("Auto Reconnect", false)
            sleep(7000)
            if (i - 1) % kelipatan == 0 then
                proxyIndex = proxyIndex + 1
            end
        end
    else
        while i <= #botList do
            local growid, password = string.match(botList[i], "(.+):(.+)")
            local proxy = proxyList[proxyIndex] or ""
            addBot(growid, password, proxy)
            i = i + 1
            sleep(7000)
            if (i - 1) % kelipatan == 0 then
                proxyIndex = proxyIndex + 1
            end
        end
    end
end

sleep(2000)
login()
