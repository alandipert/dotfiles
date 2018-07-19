keywords = {
    ["date"] = function() return os.date("%B %d, %Y") end,
    ["name"] = "my name is MISTER",
    ["zoom"] = "https://zoom.us/j/5550776304"
}

expander = hs.hotkey.bind({"alt"}, "d", nil, function() -- don't start watching until the keyUp -- don't want to capture an "extra" key at the begining
    local what = ""
    local keyMap = require"hs.keycodes".map -- shorthand... in a formal implementation, I'd do the same for all `hs.XXX` references, but that's me
    local keyWatcher
    keyWatcher = hs.eventtap.new({ hs.eventtap.event.types.keyUp, hs.eventtap.event.types.keyDown }, function(ev)
        local keyCode = ev:getKeyCode()
        local eventType = ev:getType()

        if ev:getFlags().cmd then -- it's part of an application hotkey -- abort!
            keyWatcher:stop()
            return false
        end

        if eventType == hs.eventtap.event.types.keyDown then
            -- these might end capturing, so handle them on the key down since it comes first
            if keyCode == keyMap["return"] then
                keyWatcher:stop()
                local output = keywords[what]
                if type(output) == "function" then
                    local _, o = pcall(output)
                    if not _ then
                        print("~~ expansion for '" .. what .. "' gave an error of " .. o)
                        -- could also set o to nil here so that the expansion doesn't occur below, but I think
                        -- seeing the error as the replacement will be a little more obvious that a print to the
                        -- console which I may or may not have open at the time...
                        -- maybe show an alert with hs.alert instead?
                    end
                    output = o
                end
                if output then
                    -- based on the value in `what`, delete over what was typed in and replace it with whatever we want
                    for i = 1, utf8.len(what), 1 do hs.eventtap.keyStroke({}, "delete", 0) end
                    hs.eventtap.keyStrokes(output)
                end
                return true -- don't pass the "return" keystroke on
            elseif keyCode == keyMap["escape"] then
                keyWatcher:stop()
                return true -- don't pass the "escape" keystroke on
            elseif keyCode == keyMap["left"] or keyCode == keyMap["up"] or keyCode == keyMap["down"] or keyCode == keyMap["right"] then -- should others be in here?
                keyWatcher:stop()
                return false -- pass these on
            elseif keyCode == keyMap["delete"] and #what == 0 then -- if what is empty then delete will exit the capture
                keyWatcher:stop()
                return true -- don't pass the "delete" keystroke on in this case
            end
        elseif eventType == hs.eventtap.event.types.keyUp then
            if keyCode == keyMap["delete"] then
                if #what > 0 then
                    -- while `what = what:sub(1, #what)` is simpler, it would choke on utf8 characters... so we do this
                    local t = {}
                    for p, c in utf8.codes(what) do table.insert(t, c) end
                    table.remove(t, #t) -- pop off the last one
                    what = utf8.char(table.unpack(t))
                else
                    -- shouldn't be possible with the test in keyDown, but I've been wrong before, so just in case...
                    keyWatcher:stop()
                    return true
                end
            else
                local c = ev:getCharacters() -- are we sure this will always return nil if it's not a "printable" character?
                if c then what = what .. c end
            end
        end

        -- if we get here, we've either already captured what we wanted/needed or we don't recognize it;
        -- either way, pass the event on to the focused application for its own use
        return false
    end):start()
end)