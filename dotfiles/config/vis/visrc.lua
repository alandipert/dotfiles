require('vis')
require('ctags')

-- global configuration options
vis.events.subscribe(vis.events.INIT, function()
	vis:command('map normal <F2> <vis-redraw>')
end)

-- per window configuration options
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set number')
	vis:command('set cursorline')
	vis:command('set tabwidth 2')
	vis:command('set autoindent')
	-- If we're in an rstudio project, uses spaces for indentation instead of tabs.
	if win.file.path and string.match(win.file.path, '^/Users/alandipert/github/rstudio') then
		vis:info('expanding tabs')
		vis:command('set expandtab')
	end
end)

vis:command_register("alan-fzf", function(argv, force, cur_win, selection, range)
	local out = io.popen("fzf"):read()
	if out then
		vis:command(string.format('open %s', out))
	end
	vis:feedkeys("<vis-redraw>")
end)

vis:command_register("alan-only", function(argv, force, cur_win, selection, range)
	for win in vis:windows() do
		if win ~= cur_win then
			win:close(force)
		end
	end
end)

vis:command_register("alan-x", function(argv, force, cur_win, selection, range)
	if cur_win.file.modified then
		vis:command(':w')
	end
	vis:command(':q')
end)

-- Mappings to my functions
vis:map(vis.modes.NORMAL, ";l", ":alan-fzf<Enter>")
vis:map(vis.modes.NORMAL, ";wm", ":alan-only<Enter>")
vis:map(vis.modes.NORMAL, ";zz", ":alan-x<Enter>")

-- Mappings to builtins
vis:map(vis.modes.NORMAL, ";;", "<vis-window-next>")
