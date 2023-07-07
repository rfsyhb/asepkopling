-- Created by limau
-- login bot untuk skip tutor, kemudian mengganti ke bot berikutnya
infotambahan = "14.25"
generatorenable = true -- generator guest (true) / login (false)
namagenerator = "aseprungkad"

-- jika login bot
namapatokan = "asheps" -- nama patokan bot
mulailogin = 1 -- mulai bot
banyaklogin = 99 -- tentukan banyaknya untuk login
kelipatanlogin = 3 -- batas bot pada satu socks5
maksimalercon = 15 -- maksimal try untuk dicap ercon

-- others
urlhook = "" -- discord webhook
guests = {} -- mendeklarasikan tabel kosong
ercon = 0 -- tidak usah dirubah

proxyList = {
    "",
    "",
}

function ingpo(logger)
    local script = [[
            $w = "]] .. urlhook .. [["
    
            [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    
            $Body = [PSCustomObject]@{
                content = ']] .. logger .. [['
            }
    
            Invoke-RestMethod -Uri $w -Body ($Body | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
        ]]

    local pipe = io.popen("powershell -command -", "w")
    pipe:write(script)
    pipe:close()
end

function save(text)
    local file = io.open("daftar.txt", "a") -- Membuka file "daftar.txt" dalam mode "a" (append)
    if not file then
        file = io.open("daftar.txt", "w") -- Membuka file "daftar.txt" dalam mode "w" (write) jika file tidak ada
    end
    file:write(text.."\n") -- Menulis teks ke file "daftar.txt"
    file:close() -- Menutup file setelah selesai
end

function guest()
    -- insert nama urut guest pada guest
    for i = 1, banyaklogin do
        table.insert(guests, namapatokan .. (mulailogin + i - 1))
    end

    local proxyIndex = 1
    local i = 1
    local banyakguest = 0
    while i <= #guests do
        local guestname = guests[i] -- mengambil nama bot dari daftar guest
        local proxy = proxyList[proxyIndex] or "" -- mengambil proxy sesuai index

        -- melakukan login hingga menemukan guest error
        addBot(guestname, true, proxy)
        i = i + 1
        sleep(8000)

        -- guest error atau ercon
        while getBot(getBot().name).status:lower() ~= "guest error" do
            -- jika ercon
            if ercon >= maksimalercon then -- jika ercon sudah mencapai atau lebih dari 5
                break -- keluar dari loop
            end
            connect()
            ercon = ercon + 1
            sleep(6000)

            -- jika ada guest error instan stop loop
            if getBot(getBot().name).status:lower() == "guest error" then
                sleep(3000)
                break
            end

            -- jika sukses dan berada di tutorial
            if string.sub(getBot().world, 1, 10) == "TUTORIAL_1" then
                save('{rid = "'..getRid()..'", mac = "'..getMac()..'"}')
                sleep(1000)
                -- melakukan skip tutor
                load(request("GET","https://rentry.org/tutorpunyaasep/raw"))()
                sleep(1000)
                while string.sub(getBot().world, 1, 10) ~= "TUTORIAL_1" do
                    load(request("GET","https://rentry.org/tutorpunyaasep/raw"))()
                end
                save('tutor? don')
                -- memastikan proxy
                if (i - 1) % kelipatanlogin == 0 then
                    proxyIndex = proxyIndex + 1
                end
                sleep(3000)
                -- berhenti loop
                break
            end
        end

        -- menghitung guest error
        if getBot(getBot().name).status:lower() == "guest error" then
            if (i - 1) % kelipatanlogin == 0 then
                proxyIndex = proxyIndex + 1
            end
            banyakguest = banyakguest + 1
        end
        
        -- jika ercon
        if getBot(getBot().name).status:lower() == "suspended" or ercon == maksimalercon
        or getBot(getBot().name).status:lower() == "temporary ban" then
            -- Mencetak informasi apa yang membuat kondisi menjadi benar
            if ercon == maksimalercon then
                ingpo("[".. proxy .."] ercon!")
            end

            if getBot(getBot().name).status:lower() == "suspended" then
                ingpo("[".. proxy .."] suspend!")
            end

            if getBot(getBot().name).status:lower() == "temporary ban" then
                ingpo("[".. proxy .."] tempo!")
            end
            sleep(1000)
            -- menghapus bot
            removeBot(getBot().name)
            i = i - 1 -- mengembalikan nilai i
            proxyIndex = proxyIndex + 1 -- pindah ke next proxy
            -- periksa apakah sudah menggunakan semua proxy
            if proxyIndex > #proxyList then
                return -- exit the function
            end
            ercon = 0 -- mengembalikan nilai ercon ke semula
        else
            ingpo("[".. proxy .."] aman!")
        end
        
        -- memastikan guest sesuai dengan banyaklogin
        if banyakguest == banyaklogin then
            return
        end

        setBool("Auto Reconnect", false)
        disconnect()
        sleep(3000)
    end
end

function generator()
    local i = 1
    while i <= #proxyList do
        local botname = namagenerator
        addBot(botname, true, proxyList[i])
        -- i = i + 1
        sleep(1000)
        -- memastikan bot online
        disconnect(getBot().name)
        sleep(2000)
        connect()
        sleep(5000)

        -- menguji ercon
        while getBot(getBot().name).status:lower() == "offline" do
            if ercon >= maksimalercon then -- jika ercon sudah mencapai atau lebih dari maksimalercon
                break -- keluar dari loop
            end
            connect()
            ercon = ercon + 1
            sleep(5500)
        end

        -- jika guest error
        if getBot(getBot().name).status:lower() == "guest error" or getBot(getBot().name).status:lower() == "suspended" 
         or getBot(getBot().name).status:lower() == "temporary ban" or ercon == maksimalercon then
            removeBot(getBot().name) -- menghapus bot dari aplikasi
            i = i + 1
            ercon = 0 -- mengembalikan nilai ercon ke semula
        end

        -- jika sukses dan berada di tutorial
        if string.sub(getBot().world, 1, 10) == "TUTORIAL_1" then
            save('{rid = "'..getRid()..'", mac = "'..getMac()..'"}')
            sleep(1000)
            -- melakukan skip tutor
            load(request("GET","https://rentry.org/tutorpunyaasep/raw"))()
            save('tutor? don')
            -- jika sudah tutor maka remove lagi
            sleep(1000)
            removeBot(getBot().name)
            sleep(1000)
        end
        sleep(1000)
    end
end

function mulai()
    if generatorenable then
        ingpo("memulai generator guest! ".. infotambahan .."")
        generator()
        ingpo("generator don")
    else
        ingpo("memulai login untuk guest error! ".. infotambahan .."")
        guest()
        ingpo("login don")
    end
end

mulai()
