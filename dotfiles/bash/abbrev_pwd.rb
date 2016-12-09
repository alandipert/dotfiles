#!/usr/bin/env ruby

def homify(path)
  home = ENV['HOME'].split('/').drop(1)
  if path[0..home.length-1] == home then
    ["~"] + path.drop(home.length)
  else
    path
  end
end

def addslashes(path)
  if path.first == '~' then
    path.join('/')
  else
    '/' + path.join('/')
  end
end

ARGF.each do |cwd|
  dirs    = cwd.strip.split('/').drop(1)
  homedir = ENV['HOME'].split('/').drop(1)

  if dirs == homedir then
    puts '~'
  elsif dirs == [] then
    puts '/'
  else
    homified = homify(dirs)
    abbrev   = homified[0..-2].map{ |s| s[0] }
    puts addslashes(abbrev + [dirs.last])
  end
end

