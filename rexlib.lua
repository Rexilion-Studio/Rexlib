-- rexlib.lua
local rexlib = {}
--other important values
rexlib.activeWatchers = {}
--other functions rexlib depends on
local function updatecoroutines()
    for i = #rexlib.activeWatchers, 1, -1 do
        local co = rexlib.activeWatchers[i]
        if coroutine.status(co) == "dead" then
            table.remove(rexlib.activeWatchers, i)
        end
    end
end

local function runcoroutines()
    while true do
        for i,v in pairs(rexlib.activeWatchers) do
            coroutine.resume(v)
        end
    end
end

local co = coroutine.create(updatecoroutines)
local co2 = coroutine.create(runcoroutines)

--rexlib functions
function rexlib.inPercent(value,maxvalue)
    local percentage = (value/maxvalue)*100
    return percentage
end

function rexlib.cloneTable(TableName)
    if type(TableName) == "table" then
        local clonetable = {}
        for i, v in pairs(TableName) do
            if v then
                clonetable[i] = v
            end
        end
        return clonetable
    else
        return print("NOT A TABLE!")
    end
end

function rexlib.wait(t)
    if type(t) ~= "number" then return end
    local start = os.clock()
    local thread, isMain = coroutine.running()


    if isMain or thread == nil then
        while (os.clock() - start) < t do

        end
    else
            
        while (os.clock() - start) < t do
            coroutine.yield()
            end
    end
end

function rexlib.filter(t,condition)
    if type(t) ~= "table" then end
    local metcondition = {}
    for i,v in pairs(t) do
        if condition(v) then
            table.insert(metcondition,v)
        end
    end
    return metcondition
end

function rexlib.repeatFunction(fun,ammount)
    if type(fun) ~= "function" then return print("Not A Function") end
    if type(ammount) ~= "number" then return print("Not A Number") end

    rexlib.runinBackground(function ()
    if ammount ~= -1 then
        for i = 1,ammount do
            fun()
            rexlib.wait(2.5)
        end
    elseif ammount == -1 then
        while  true do
           rexlib.wait(2.5)
            fun()
            end
        end
    end)
end

function rexlib.removeFromTable(t,remove)
if type(t) == "table" and type(remove) == "table" then
  local toRemove = {}
    for _, v in pairs(remove) do toRemove[v] = true end

    for i = #t, 1, -1 do
        if toRemove[t[i]] then
            table.remove(t, i)
            end
        end
    end
end

function rexlib.listTable(t)
    for i,v in pairs(t) do
        print(v)
    end
end

function rexlib.runinBackground(f)
    if type(f) == "function" then
     local c =  coroutine.create(f)
        table.insert(rexlib.activeWatchers,c)
        coroutine.resume(c)
        return c
    end
end

function rexlib.getValue(V)
    if V then
        return V
    end
end

function rexlib.changed(getvalueF)
    local haschangedtable = { haschanged = false }
    local co = coroutine.create(function ()

    if type(getvalueF) == "function" and type(haschangedtable.haschanged) == "boolean" then
    local oldvalue = getvalueF()
    local currentV = getvalueF()

    while true do
         currentV = getvalueF()
        if currentV ~= oldvalue then
            haschangedtable.haschanged = true
            return
            end
            rexlib.wait(.2)
        end
     end
    end)

    table.insert(rexlib.activeWatchers,co)
    coroutine.resume(co)
     return haschangedtable
end

function rexlib.Discount(percentage,value)
    if type(percentage) ~= "number" or type(percentage) ~= "string" then return end
    if type(value) ~= "number" or type(value) ~= "string" then return end
    if value <=0 then return end
    if percentage <=0 then return end
    local calc = (value/100) * percentage 
    value = value - calc
    return value
end

--rexlib manipulation functions
function rexlib.clearWatchers()
    for i = #rexlib.activeWatchers, 1,-1 do
        table.remove(rexlib.activeWatchers,i)
    end
end

function rexlib.removeWatcher(toremove)
    for i,v in pairs(rexlib.activeWatchers) do
        if toremove == v then
            table.remove(rexlib.activeWatchers,v)
        end
    end
end

--breathing
coroutine.resume(co)
coroutine.resume(co2)

return rexlib