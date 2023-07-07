function mehantam()
    for i = 4, 1, -1 do
        punch(1, 0)
        sleep(500)
    end
end
 
unit = 1
jeans = 48
 
function sekip()
    sendPacket("ftue_start_popup_close", 2)
    findPath(86,30)
    sleep(1800)
    enter()
    sleep(3000)
    findPath(46,23)
    sleep(2000)
    mehantam()
    place(2,1,0)
    sleep(600)
    mehantam()
    collect(3)
    sleep(1240)
    place(3,1,0)
    sleep(2000)
    place(10672,1,0)
    sleep(1000)
    punch(1,0)
    sleep(1000)
    move(1,0)
    collect(2)
    sleep(1000)
    wear(48)
    sleep(1000)
    sendPacket("action|quit_to_exit", 3)
    sleep(1000)
    totTxt = ""
    for i = 15, 1, -1 do
        totTxt = totTxt .. string.char(math.random(97, 122))
    end
    sendPacket("action|join_request\nname|" .. totTxt .. "\ninvitedWorld|0", 3)
    sleep(4000)
 
    -- Menguji untuk memastikan bahwa skip tutor berhasil dilakukan
    disconnect(getBot().name)
    sleep(4000)
    connect(getBot().name)   
    sleep(4000)
    if string.sub(getBot().world, 1, 10) == "TUTORIAL_1" then
        return
    else 
        place(9640, 0, -1)
        sleep(2500)
        text = request("GET", "https://random-word-api.herokuapp.com/word")
        text = text:sub(3, -3)
        say(text)
        sleep(1000)
        collectSet(1)
        sleep(1500)
        while getBot().status:lower() ~= "online" do
            connect()
            sleep(8000)
        end
        sleep(1000)
        sendPacket("action|trash\n|itemID|"..jeans.."", 2)
        sleep(500)
        sendPacket("action|dialog_return\ndialog_name|trash_item\nitemID|"..jeans.."|\ncount|"..unit.."", 2)
        sleep(1000)
    end
end
 
function ewe()
    sleep(2000)
    sekip()
    while getBot().status:lower() ~= "online" do
        sleep(4000)
        while string.sub(getBot().world, 1, 10) == "TUTORIAL_1" do
            sekip()
            sleep(4000)
        end
    end
    sleep(4000)
    while string.sub(getBot().world, 1, 10) == "TUTORIAL_1" do
        sekip()
        sleep(4000)
    end
end
 
if string.sub(getBot().world, 1, 10) == "TUTORIAL_1" then
    ewe()
    sleep(4000)
else
    say(text)
end
