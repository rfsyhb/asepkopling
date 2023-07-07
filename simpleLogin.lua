-- Biasanya dipakai buat check socks
proxyList = {
    "",
    -- tambah sesuka ente, jangan lupa #proxyList = #names
}

names = {
    "",
    -- growid
}

-- password dari seluruh cid (hanya 1 pass, tidak support multi password)
paswot = ""

for i = 1, #names do
    addBot(names[i], paswot, proxyList[i])
    sleep(5000)
end
