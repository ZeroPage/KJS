require "TEsound"
require "Money"
local anim = require"anim"
local JSON = require "JSON"

--Initialize save file components
aa=love.filesystem.createDirectory("../KJS")
contents, size = love.filesystem.read("save.sav",5000)
money = Money:new({balance = 0})

--Initialize animation components
local grandma_anims = {}
local tv_anims = {}
local can_anims = {}
local industry_anims = {}
local global_anims = {}
local ocean_anims = {}
local satellite_anims = {}

--Default item values
init_grandmotherPrice=30
init_junkyardPrice=100000
init_usedcollectorPrice=1000
init_apartmentPrice=45000
init_factoryPrice=100000
init_importPrice=3000000
init_oceanPrice=100000000
init_spacePrice=1800000000

--Data loading source
if type(size)=='number'  then
    print("load successful!")
    loadData=JSON:decode(contents)
    reset_bonus=loadData['reset_bonus']
    print(loadData['money']['balance'])
    money:set(14574534464756)
    grandmother=loadData['grandmother']
    grandmotherPrice=loadData['grandmotherPrice']
    earning=tonumber(loadData['earning'])
    junkyardScale=loadData['junkyardScale']
    junkyardPrice=loadData['junkyardPrice']
    usedcollector=loadData['usedcollector']
    usedcollectorPrice=loadData['usedcollectorPrice']
    apartment=loadData['apartment']
    apartmentPrice=loadData['apartmentPrice']
    factory=loadData['factory']
    factoryPrice=loadData['factoryPrice']
    import=loadData['import']
    importPrice=loadData['importPrice']
    ocean=loadData['ocean']
    oceanPrice=loadData['oceanPrice']
    space=loadData['space']
    spacePrice=loadData['spacePrice']
--[[
    grandma_anims = loadData['grandma_anims']
    tv_anims = loadData['tv_anims']
    can_anims = loadData['can_anims']
    industry_anims = loadData['industry_anims']
    global_anims = loadData['global_anims']
    ocean_anims = loadData['ocean_anims']
    satellite_anims = loadData['satellite_anims']
]]--

else
    print("load failed!")
    reset_bonus=0
    grandmother=0
    init_grandmotherPrice=30
    grandmotherPrice=init_grandmotherPrice
    earning=1
    junkyardScale=0
    junkyardPrice=init_junkyardPrice
    usedcollector=0
    usedcollectorPrice=init_usedcollectorPrice
    apartment=0
    apartmentPrice=init_apartmentPrice
    factory=0
    factoryPrice=init_factoryPrice
    import=0
    importPrice=init_importPrice
    ocean=0
    oceanPrice=init_oceanPrice
    space=0
    spacePrice=init_spacePrice
end
toggleBGM=true

--Load game resources
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
	tv1=love.graphics.newImage("/resource/image/tv1.png")
	tv2=love.graphics.newImage("/resource/image/tv2.png")
	can1=love.graphics.newImage("/resource/image/can1.png")
	can2=love.graphics.newImage("/resource/image/can2.png")
	industry1=love.graphics.newImage("/resource/image/industry1.png")
	industry2=love.graphics.newImage("/resource/image/industry2.png")
	global1=love.graphics.newImage("/resource/image/global1.png")
	global2=love.graphics.newImage("/resource/image/global2.png")
	ocean1=love.graphics.newImage("/resource/image/ocean1.png")
	ocean2=love.graphics.newImage("/resource/image/ocean2.png")
	satellite1=love.graphics.newImage("/resource/image/satellite1.png")
	satellite2=love.graphics.newImage("/resource/image/satellite2.png")

	love.graphics.setBackgroundColor(0,0,0)
	love.graphics.setNewFont("/resource/font/SeoulHangangB.ttf",20)

end

--Drawing game resources
function love.draw()
    --Drawing BGM toggles
    if toggleBGM then 
        love.graphics.draw(bgmOn,750,10)
    else
        love.graphics.draw(bgmOff,750,10)
    end
    --Drawing buttons
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

    --Drawing animations
    for key,value in pairs(grandma_anims) do
        grandma_anims[key]:draw(400,584)
    end
    for key,value in pairs(tv_anims) do
        tv_anims[key]:draw(400,584)
    end
    for key,value in pairs(can_anims) do
        can_anims[key]:draw(400,584)
    end
    for key,value in pairs(industry_anims) do
        industry_anims[key]:draw(400,584)
    end
    for key,value in pairs(global_anims) do
        global_anims[key]:draw(400,584)
    end
    for key,value in pairs(ocean_anims) do
        ocean_anims[key]:draw(400,584)
    end
    for key,value in pairs(satellite_anims) do
        satellite_anims[key]:draw(400,584)
    end
end

--Mouse press actions
function love.mousepressed(x, y, button, istouch)
    --BGM toggles
    if button == 1 then
        if x >= 750 and x <= 790 and y >= 10 and y <= 50 and toggleBGM then
            toggleBGM=false
            TEsound.stop("bgm")

        elseif x >= 750 and x <= 790 and y >= 10 and y <= 50 and not toggleBGM then
            toggleBGM=true
            TEsound.playLooping("resource/bgm/bgm.mp3", "bgm")
        end
        --Junkyard scale item part
    	if x>=400 and x<=520 and y>=125 and y<=170 and money:get()>=junkyardPrice and junkyardScale < 5 then
    		money:set(money:get() - junkyardPrice)
            earning=earning*1.5
            junkyardScale=junkyardScale+1
            junkyardPrice=math.pow(10,junkyardScale+5)
    	end

        --Grandma item part
        if x>=600 and x<=750 and y>=125 and y<=170 and money:get()>=grandmotherPrice then
            money:set(money:get() - grandmotherPrice)
            earning=earning+10
            grandmotherPrice=grandmotherPrice*1.1
            grandmother=grandmother+1
	    	grandma_anim = anim.newAnimation(0.1,true,grandma1,grandma2)
	    	table.insert(grandma_anims,grandma_anim)
        end

        --Usedcollector item part
        if x>=400 and x<=570 and y>=190 and y<=235 and money:get()>=usedcollectorPrice then
            money:set(money:get() - usedcollectorPrice)
            earning=earning+200
            usedcollectorPrice=usedcollectorPrice*1.1
            usedcollector=usedcollector+1
            tv_anim = anim.newAnimation(0.1,true,tv1,tv2)
            table.insert(tv_anims,tv_anim)
        end

        --Apartment item part
        if x>=600 and x<=760 and y>=190 and y<=235 and money:get()>=apartmentPrice then
            money:set(money:get() - apartmentPrice)
            earning = earning + 9000
            apartmentPrice = apartmentPrice * 1.1
            apartment = apartment + 1
            can_anim = anim.newAnimation(0.1,true,can1,can2)
            table.insert(can_anims,can_anim)
        end

        --Factory item part
        if x>=400 and x<=570 and y>=255 and y<=300 and money:get()>=factoryPrice then
            money:set(money:get() - factoryPrice)
            earning = earning + 20000
            factoryPrice = factoryPrice * 1.1
            factory = factory + 1
            industry_anim = anim.newAnimation(0.1,true,industry1,industry2)
            table.insert(industry_anims,industry_anim)
        end

        --Import item part
        if x>=600 and x<=735 and y>=255 and y<=300 and money:get()>=importPrice then
            money:set(money:get() - importPrice)
            earning = earning + 600000
            importPrice = importPrice * 1.1
            import = import + 1
            global_anim = anim.newAnimation(0.1,true,global1,global2)
            table.insert(global_anims,global_anim)
        end

        --Ocean item part
        if x>=400 and x<=550 and y>=320 and y<=365 and money:get()>=oceanPrice then
            money:set(money:get() - oceanPrice)
            earning = earning + 20000000
            oceanPrice = oceanPrice * 1.1
            ocean = ocean + 1
            ocean_anim = anim.newAnimation(0.1,true,ocean1,ocean2)
            table.insert(ocean_anims,ocean_anim)
        end
            
        --Space item part
        if x>=600 and x<=760 and y>=320 and y<=365 and money:get()>=spacePrice then
            money:set(money:get() - spacePrice)
            earning = earning + 360000000
            spacePrice = spacePrice * 1.1
            space = space + 1
            satellite_anim = anim.newAnimation(0.1,true,satellite1,satellite2)
            table.insert(satellite_anims,satellite_anim)
        end

        --Game save part
        if x>=100 and x<=200 and y>=500 and y<=530 then
	    saveData = {}
	    saveData['reset_bonus']=reset_bonus
	    saveData['money']=money 
	    saveData['prev_earning']=prev_earning
	    saveData['earning']=earning
	    saveData['junkyardScale']=junkyardScale
	    saveData['junkyardPrice']=junkyardPrice
	    saveData['grandmother']=grandmother
	    saveData['grandmotherPrice']=grandmotherPrice
	    saveData['usedcollector']=usedcollector
	    saveData['usedcollectorPrice']=usedcollectorPrice
	    saveData['apartment']=apartment
	    saveData['apartmentPrice']=apartmentPrice
	    saveData['factory']=factory
	    saveData['factoryPrice']=factoryPrice
	    saveData['import']=import
	    saveData['importPrice']=importPrice
	    saveData['ocean']=ocean
	    saveData['oceanPrice']=oceanPrice
	    saveData['space']=space
	    saveData['spacePrice']=spacePrice

--[[
	    saveData['grandma_anims']=grandma_anims
	    saveData['tv_anims']=tv_anims
	    saveData['can_anims']=can_anims
	    saveData['industry_anims']=industry_anims
	    saveData['global_anims']=global_anims
	    saveData['ocean_anims']=ocean_anims
	    saveData['satellite_anims']=satellite_anims
]]--
	    saveString = JSON:encode(saveData)

            success = love.filesystem.write("save.sav",saveString)
        end

        --Game reset part
        if x>=100 and x<=200 and y>=550 and y<=580 then
        	reset_bonus=reset_bonus+math.floor(money:get()/10000000000000)
            money:set(money:get()-money:get())
            prev_earning=earning
            earning=1
            junkyardScale=0
            junkyardPrice=init_junkyardPrice
            grandmother=0
            grandmotherPrice=init_grandmotherPrice
            usedcollector=0
            usedcollectorPrice=init_usedcollectorPrice
            apartment=0
            apartmentPrice=init_apartmentPrice
            factory=0
            factoryPrice=init_factoryPrice
            import=0
            importPrice=init_importPrice
            ocean=0
            oceanPrice=init_oceanPrice
            space=0
            spacePrice=init_spacePrice

            for key,value in pairs(grandma_anims) do
            	grandma_anims[key]=nil
            end
            for key,value in pairs(tv_anims) do
            	tv_anims[key]=nil
            end
            for key,value in pairs(can_anims) do
            	can_anims[key]=nil
            end
            for key,value in pairs(industry_anims) do
            	industry_anims[key]=nil
            end
            for key,value in pairs(global_anims) do
            	global_anims[key]=nil
            end
            for key,value in pairs(ocean_anims) do
            	ocean_anims[key]=nil
            end
            for key,value in pairs(satellite_anims) do
            	satellite_anims[key]=nil
            end

            saveData = {}
            saveData['reset_bonus']=reset_bonus
            saveData['money']=money
            saveData['prev_earning']=prev_earning
            saveData['earning']=earning
            saveData['junkyardScale']=junkyardScale
            saveData['junkyardPrice']=junkyardPrice
            saveData['grandmother']=grandmother
            saveData['grandmotherPrice']=grandmotherPrice
            saveData['usedcollector']=usedcollector
            saveData['usedcollectorPrice']=usedcollectorPrice
            saveData['apartment']=apartment
            saveData['apartmentPrice']=apartmentPrice
            saveData['factory']=factory
            saveData['factoryPrice']=factoryPrice
            saveData['import']=import
            saveData['importPrice']=importPrice
            saveData['ocean']=ocean
            saveData['oceanPrice']=oceanPrice
            saveData['space']=space
            saveData['spacePrice']=spacePrice

            saveString = JSON:encode(saveData)

            success = love.filesystem.write("save.sav",saveString)

        end
    end
end

--Update frame at each second
function love.update(dt)
    money:set(money:get()+(earning*dt)+(earning*reset_bonus*0.01))
    TEsound.cleanup()
    for key,value in pairs(grandma_anims) do
        grandma_anims[key]:update(dt)
    end
    for key,value in pairs(tv_anims) do
        tv_anims[key]:update(dt)
    end
    for key,value in pairs(can_anims) do
        can_anims[key]:update(dt)
    end
    for key,value in pairs(industry_anims) do
        industry_anims[key]:update(dt)
    end
    for key,value in pairs(global_anims) do
        global_anims[key]:update(dt)
    end
    for key,value in pairs(ocean_anims) do
        ocean_anims[key]:update(dt)
    end
    for key,value in pairs(satellite_anims) do
        satellite_anims[key]:update(dt)
    end
end
