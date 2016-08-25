#!/usr/bin/env ruby
require 'json'

# https://faq.i3wm.org/question/1281/application-switcher/?answer=3786#post-id-3786


# recursively walk tree to find all containers
# return an array of names followed by [id]
def get_containers tree
    containers = []
    #puts JSON.pretty_generate(tree)
    # try to return only useful containers
    if (tree['nodes']+tree['floating_nodes']).empty? && tree['type'] == 'con' &&
        !(tree['name'] =~ /^i3bar for output/)
        containers << tree['name'] + " [#{tree['id']}]"
    end
    (tree['nodes'] + tree['floating_nodes']).each do |node|
        containers += get_containers(node)
    end
    containers
end

IO.popen(['dmenu', '-i', '-p', 'window jump'], 'r+') do |dmenu|
    tree = `i3-msg -t get_tree`
    json = get_containers(JSON.load(tree))
    p json
    dmenu.puts(json)
    dmenu.close_write
    id = dmenu.read.split(/\[(\d+)\]/)[1]
    exec "i3-msg [con_id=#{id}] focus"
end
