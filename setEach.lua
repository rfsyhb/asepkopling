-- Created by limau
-- set RID dan set MAC for guest account
-- only for a selected account not select all!
guesto = {rid = "01CFF4040C6EE61300FDBAFC26CDEB6D", mac = "55:B7:D5:FE:5F:EC"}

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
