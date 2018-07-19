hs.loadSpoon('ControlEscape'):start() -- Load Hammerspoon bits from https://github.com/jasonrudolph/ControlEscape.spoon
hs.loadSpoon('WindowHalfsAndThirds')
spoon.WindowHalfsAndThirds:bindHotkeys(spoon.WindowHalfsAndThirds.defaultHotkeys)

dofile("TextExpander.lua")

-- Move Mouse to center of next Monitor
hs.hotkey.bind('cmd shift', ',', function()
	local win = hs.window.focusedWindow()
	local winCenter = hs.geometry.rectMidPoint(win:size())
	local topLeft = win:topLeft();
	hs.mouse.setAbsolutePosition(hs.geometry.point(topLeft.x+winCenter.x, topLeft.y+winCenter.y))
end)
