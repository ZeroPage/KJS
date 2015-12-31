require "TEsound"
require "Money"

aa=love.filesystem.createDirectory("../KJS")
contents, size = love.filesystem.read("save.sav",100)
toggleBGM=true
money = Money:new({balance = contents})
earning=1
junkyardScale=0
grandmother=0
grandmotherPrice=30
usedcollector=0
usedcollectorPrice=1000
apartment=0
apartmentPrice=45000
function love.load()
    TEsound.playLooping("resource/bgm/bgm.mp3", "bgm")
    bgmOn = love.graphics.newImage("resource/image/bgm_on.png")
    bgmOff = love.graphics.newImage("resource/image/bgm_off.png")
	title = love.graphics.newImage("resource/image/title.png")
    btn_save = love.graphics.newImage("resource/image/save.png")
    btn_reset = love.graphics.newImage("resource/image/reset.png")
	junk1 = love.graphics.newImage("resource/image/junk1.png")
    junk2 = love.graphics.newImage("resource/image/junk2.png")
	moneyImg=love.graphics.newImage("/resource/image/money_image.png")
	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setNewFont("/resource/font/RixHeadB.ttf",20)

end

function love.draw()
    if toggleBGM then 
        love.graphics.draw(bgmOn,750,10)
    else
        love.graphics.draw(bgmOff,750,10)
    end
	love.graphics.draw(title,105,10)
    if junkyardScale == 0 then
        love.graphics.draw(junk1,75,100)
    elseif junkyardScale == 1 then
        love.graphics.draw(junk2,75,100)
    end
	love.graphics.draw(moneyImg,75,425)
	love.graphics.print(math.floor(money:get()),135,437)
    love.graphics.draw(btn_save,100,500)
    love.graphics.draw(btn_reset,100,550)
	love.graphics.print("고물상 크기: "..junkyardScale,400,125)
	love.graphics.print("￦ "..math.pow(10,junkyardScale+5),400,145)
    love.graphics.print("폐지줍는 할머니: "..grandmother,600,125)
    love.graphics.print("￦ "..math.floor(grandmotherPrice),600,145)
    love.graphics.print("안쓰는 가전 삽니다: "..usedcollector,400,185)
    love.graphics.print("￦ "..math.floor(usedcollectorPrice),400,205)
    love.graphics.print("아파트 폐품 수거: "..apartment,600,185)
    love.graphics.print("￦ "..math.floor(apartmentPrice),600,205)
end

function love.mousepressed(x, y, button)
    if button == "l" then
        if x >= 750 and x <= 790 and y >= 10 and y <= 50 and toggleBGM then
            toggleBGM=false
            TEsound.stop("bgm")

        elseif x >= 750 and x <= 790 and y >= 10 and y <= 50 and not toggleBGM then
            toggleBGM=true
            TEsound.playLooping("resource/bgm/bgm.mp3", "bgm")
        end

    	if x>=400 and x<=520 and y>=125 and y<=165 and money:get()>=math.pow(10,junkyardScale+5) and junkyardScale < 5 then
    		money:set(money:get() - math.pow(10,junkyardScale+5))
            earning=earning*2
            junkyardScale=junkyardScale+1
    	end

        if x>=600 and x<=750 and y>=125 and y<=165 and money:get()>=grandmotherPrice then
            money:set(money:get() - grandmotherPrice)
            earning=earning+10
            grandmotherPrice=grandmotherPrice*1.1
            grandmother=grandmother+1
        end

        if x>=400 and x<=570 and y>=175 and y<=215 and money:get()>=usedcollectorPrice then
            money:set(money:get() - usedcollectorPrice)
            earning=earning+200
            usedcollectorPrice=usedcollectorPrice*1.1
            usedcollector=usedcollector+1
        end

        if x >= 600 and x <= 760 and y >= 175 and y <= 215 and money:get() >= apartmentPrice then
            money:set(money:get() - apartmentPrice)
            earning = earning + 9000
            apartmentPrice = apartmentPrice * 1.1
            apartment = apartment + 1
        end
        
        if x>=100 and x<=200 and y>=500 and y<=530 then
            success = love.filesystem.write("save.sav",money:get())
        end

        if x>=100 and x<=200 and y>=550 and y<=580 then
            money:set(money:get()-money:get())
            earning=1
            grandmother=0
            usedcollector=0
            apartment=0
            success = love.filesystem.write("save.sav",money:get())
        end
    end
end

function love.update(dt)
    money:set(money:get()+earning*dt)
    TEsound.cleanup()
end
