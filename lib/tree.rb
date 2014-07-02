require 'node'

class Tree
  def initialize
    @level = 0
  end

  def print_names(nodes)
    hash = children(nodes)
    puts hash.keys.join("\n")
  end

  def children(nodes, hash = {}, parent = nil, level = 0)
    hash[nodes.name] = {level: @level, parent: parent}
    parent = nodes.name unless parent
    nodes.children.each do |node|
      if node.children.empty?
        @level += 1
        hash[node.name] = {level: @level, parent: parent}
        @level -= 1
      else
        @level+=1
        hash[node.name] = {level: @level, parent: parent}
        children(node, hash, hash[node.name][:parent])
      end
    end
    @level = 0
    hash
  end

  def names(nodes)
    hash = children(nodes)
    p hash.keys
  end

  def names_with_indentation(nodes)
    hash = children(nodes)
    array = []
    space = "  "
    hash.each do |name, level|
      array << space * level[:level] + name
    end
    array
  end

  def to_hash(nodes)
    hash = {}
    hash[nodes.name] = {}
    nodes.children.each do |child|
      hash[nodes.name].merge!(to_hash(child))
    end
    hash
  end

end