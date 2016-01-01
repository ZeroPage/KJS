require "TEsound"
require "Money"
local anim = require"anim"

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
factory=0
factoryPrice=100000
import=0
importPrice=3000000
ocean=0
oceanPrice=100000000
space=0
spacePrice=1800000000

local grandma_anims = {}

function love.load()
    TEsound.playLooping("resource/bgm/bgm.mp3", "bgm")
    bgmOn = love.graphics.newImage("resource/image/bgm_on.png")
    bgmOff = love.graphics.newImage("resource/image/bgm_off.png")
    trash = love.graphics.newImage("resource/image/trash1.png")
	title = love.graphics.newImage("resource/image/title.png")
    btn_save = love.graphics.newImage("resource/image/save.png")
    btn_reset = love.graphics.newImage("resource/image/reset.png")
	moneyImg=love.graphics.newImage("/resource/image/money_image.png")
	grandma1=love.graphics.newImage("/resource/image/grandma1.png")
	grandma2=love.graphics.newImage("/resource/image/grandma2.png")
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
	love.graphics.draw(moneyImg,75,425)
    love.graphics.draw(trash,75,125)
	love.graphics.print(math.floor(money:get()),135,437)
    love.graphics.draw(btn_save,100,500)
    love.graphics.draw(btn_reset,100,550)
	love.graphics.print("고물상 크기: "..junkyardScale,400,125)
	love.graphics.print("￦ "..math.pow(10,junkyardScale+5),400,150)
    love.graphics.print("폐지줍는 할머니: "..grandmother,600,125)
    love.graphics.print("￦ "..math.floor(grandmotherPrice),600,150)
    love.graphics.print("안쓰는 가전 삽니다: "..usedcollector,400,190)
    love.graphics.print("￦ "..math.floor(usedcollectorPrice),400,215)
    love.graphics.print("아파트 폐품 수거: "..apartment,600,190)
    love.graphics.print("￦ "..math.floor(apartmentPrice),600,215)
    love.graphics.print("공업단지 고철 수거: "..factory,400,255)
    love.graphics.print("￦ "..math.floor(factoryPrice),400,280)
    love.graphics.print("해외 고철 수입: "..import,600,255)
    love.graphics.print("￦ "..math.floor(importPrice),600,280)
    love.graphics.print("해양 쓰레기 수거: "..ocean,400,320)
    love.graphics.print("￦ "..math.floor(oceanPrice),400,345)
    love.graphics.print("우주 쓰레기 수거: "..space,600,320)
    love.graphics.print("￦ "..math.floor(spacePrice),600,345)


    for key,value in pairs(grandma_anims) do
        grandma_anims[key]:draw(400,584)
    end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
        if x >= 750 and x <= 790 and y >= 10 and y <= 50 and toggleBGM then
            toggleBGM=false
            TEsound.stop("bgm")

        elseif x >= 750 and x <= 790 and y >= 10 and y <= 50 and not toggleBGM then
            toggleBGM=true
            TEsound.playLooping("resource/bgm/bgm.mp3", "bgm")
        end

    	if x>=400 and x<=520 and y>=125 and y<=170 and money:get()>=math.pow(10,junkyardScale+5) and junkyardScale < 5 then
    		money:set(money:get() - math.pow(10,junkyardScale+5))
            earning=earning*1.5
            junkyardScale=junkyardScale+1
    	end

        if x>=600 and x<=750 and y>=125 and y<=170 and money:get()>=grandmotherPrice then
            money:set(money:get() - grandmotherPrice)
            earning=earning+10
            grandmotherPrice=grandmotherPrice*1.1
            grandmother=grandmother+1
	    grandma_anim = anim.newAnimation(0.1,true,grandma1,grandma2)
	    table.insert(grandma_anims,grandma_anim)
        end

        if x>=400 and x<=570 and y>=190 and y<=235 and money:get()>=usedcollectorPrice then
            money:set(money:get() - usedcollectorPrice)
            earning=earning+200
            usedcollectorPrice=usedcollectorPrice*1.1
            usedcollector=usedcollector+1
        end

        if x>=600 and x<=760 and y>=190 and y<=235 and money:get()>=apartmentPrice then
            money:set(money:get() - apartmentPrice)
            earning = earning + 9000
            apartmentPrice = apartmentPrice * 1.1
            apartment = apartment + 1
        end

        if x>=400 and x<=570 and y>=255 and y<=300 and money:get()>=factoryPrice then
            money:set(money:get() - factoryPrice)
            earning = earning + 20000
            factoryPrice = factoryPrice * 1.1
            fatory = factory + 1
        end

        if x>=600 and x<=735 and y>=255 and y<=300 and money:get()>=importPrice then
            money:set(money:get() - importPrice)
            earning = earning + 600000
            importPrice = importPrice * 1.1
            import = import + 1
        end

        if x>=400 and x<=550 and y>=320 and y<=365 and money:get()>=oceanPrice then
            money:set(money:get() - moneyPrice)
            earning = earning + 20000000
            oceanPrice = oceanPrice * 1.1
            ocean = ocean + 1
        end
        
        if x>=600 and x<=760 and y>=320 and y<=365 and money:get()>=spacePrice then
            money:set(money:get() - spacePrice)
            earning = earning + 360000000
            spacePrice = spacePrice * 1.1
            space = space + 1
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
    for key,value in pairs(grandma_anims) do
        grandma_anims[key]:update(dt)
    end
end
