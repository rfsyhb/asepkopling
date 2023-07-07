-- Created by limau
-- upgrade dari setEach.lua dan nyambung sama generatorGuest.lua
-- berapa banyak bot yang ada di app / ingin di-set
namapatokan = "asheps" -- nama patokan bot urut
angkapertamabot = 1 -- misal 2 maka nama yg dicetak dimulai dari "(namapatokan)2" = "asheps2"
guestData = {
    {rid = "", mac = ""},
    {rid = "", mac = ""},
    -- tambah sebanyak yang ente mau
}

setGuest = {}
banyakBot = #guestData

for i = 1, banyakBot do
    table.insert(setGuest, namapatokan .. (angkapertamabot + i - 1))
end

function set()
    local limit = 0
    for i = 1, banyakBot do
        local botName = setGuest[i]
        if getBot().name == botName then
            local guesto = guestData[i]
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
            end
            setBool("Auto Reconnect", true)
            return
        else
            limit = limit + 1
            sleep(4000)
        end

        if limit >= banyakBot then
            return
            error()
        end
    end
end

set()
