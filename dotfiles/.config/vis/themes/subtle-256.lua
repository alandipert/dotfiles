-- Solarized color codes Copyright (c) 2011 Ethan Schoonover
local lexers = vis.lexers

local colors = {
	['white']   = '#f8f8f2',
	['base03']  = '#002b36',
	['base02']  = '#465457',
	['base01']  = '#586e75',
	['base00']  = '#657b83',
	['base0']   = '#839496',
	['base1']   = '#93a1a1',
	['base2']   = '#eee8d5',
	['base3']   = '#fdf6e3',
	['yellow']  = '#b58900',
	['pink']    = '#f92672',
	['orange']  = '#fd971f',
	['green']   = '#a6e22e',
	['purple']  = '#ae81ff',
	['beige']   = '#e6db74',
	['blue']    = '#66d9ef',
} 

lexers.colors = colors
-- dark
local fg = ',fore:'..colors.white..','
local bg = ',back:'..colors.base03..','
-- light
-- local fg = ',fore:'..colors.base03..','
-- local bg = ',back:'..colors.base3..','

lexers.STYLE_DEFAULT = bg..fg
lexers.STYLE_NOTHING = bg
lexers.STYLE_CLASS = 'fore:yellow'
lexers.STYLE_COMMENT = 'fore:'..colors.base00
lexers.STYLE_CONSTANT = 'fore:'..colors.blue
lexers.STYLE_DEFINITION = 'fore:'..colors.blue
lexers.STYLE_ERROR = 'fore:'..colors.pink..',italics'
lexers.STYLE_FUNCTION = 'fore:'..colors.blue
lexers.STYLE_KEYWORD = 'fore:'..colors.green
lexers.STYLE_LABEL = 'fore:'..colors.green
lexers.STYLE_NUMBER = 'fore:'..colors.blue
lexers.STYLE_OPERATOR = 'fore:'..colors.green
lexers.STYLE_ASSIGNMENT = 'fore:'..colors.pink
lexers.STYLE_REGEX = 'fore:green'
lexers.STYLE_STRING = 'fore:'..colors.purple
lexers.STYLE_PREPROCESSOR = 'fore:'..colors.orange
lexers.STYLE_TAG = 'fore:'..colors.pink
lexers.STYLE_TYPE = 'fore:'..colors.yellow
lexers.STYLE_VARIABLE = 'fore:'..colors.blue
lexers.STYLE_WHITESPACE = ''
lexers.STYLE_EMBEDDED = 'back:blue'
lexers.STYLE_IDENTIFIER = fg

lexers.STYLE_LINENUMBER = fg
lexers.STYLE_CURSOR = 'fore:'..colors.base03..',back:'..colors.base0
lexers.STYLE_CURSOR_PRIMARY = lexers.STYLE_CURSOR..',back:yellow'
lexers.STYLE_CURSOR_LINE = 'back:'..colors.base02
lexers.STYLE_COLOR_COLUMN = 'back:'..colors.base02
lexers.STYLE_SELECTION = 'back:'..colors.base02
