require('vis')
require('ctags')

-- global init
prev_win_title = nil
vis.events.subscribe(vis.events.INIT, function()
--	vis:command('map normal <F2> <vis-redraw>')
--	prev_win_title = io.popen("tmux display-message -p '#W'"):read()
end)

-- per window open
vis.events.subscribe(vis.events.WIN_OPEN, function(win)
	vis:command('set number')
	vis:command('set cursorline')
	vis:command('set tabwidth 2')
	vis:command('set autoindent')
	--vis:command('set expandtab on')
	if win.file.path then
		filename = string.match(win.file.path, ".*/(.*)$")
		if filename == "Jenkinsfile" then
			vis:command('set syntax groovy')
		elseif filename == "Makefile" then
			vis:command('set expandtab off')
		elseif string.find(filename, ".md.m4") then
			vis:command('set syntax markdown')
		end
	end
	vis:command('set theme subtle-256')
	-- If we're in an rstudio project, uses spaces for indentation instead of tabs.
	if win.file.path and string.match(win.file.path, '^/Users/alandipert/github/rstudio') then
		vis:info('expanding tabs')
		vis:command('set expandtab')
	end
end)

-- per window close
last_closed_file = nil
last_closed_line = nil
vis.events.subscribe(vis.events.WIN_CLOSE, function(win)
	last_closed_file = win.file.path
	last_closed_line = win.selection.line
end)

vis:command_register("alan-reopen-last", function(argv, force, cur_win, selection, range)
	if last_closed_file then
		vis:command(string.format('e %s', last_closed_file))
		vis:command(string.format('%s', last_closed_line))
	end
end)

vis:command_register("alan-fzf", function(argv, force, cur_win, selection, range)
	local old = cur_win
	local out = io.popen("fzf"):read()
	if out then
		vis:command(string.format('open %s', out))
		if argv[1] then
			old:close(force)
		end
		vis:feedkeys("<vis-redraw>")
	end
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


vis:map(vis.modes.NORMAL, ";l", function()
	vis:command('alan-fzf')
end)

vis:map(vis.modes.NORMAL, ";o", function()
	vis:command('alan-fzf true')
end)

vis:map(vis.modes.NORMAL, ";wm", ":alan-only<Enter>")
vis:map(vis.modes.NORMAL, ";wc", ":q<Enter>")
vis:map(vis.modes.NORMAL, ";zz", ":alan-x<Enter>")
vis:map(vis.modes.NORMAL, ";r", ":alan-reopen-last<Enter>")

-- Mappings to builtins
vis:map(vis.modes.NORMAL, ";;", "<vis-window-next>")
