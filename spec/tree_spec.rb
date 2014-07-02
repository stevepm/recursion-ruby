require 'tree'
require 'support/tree_helper'

describe Tree do

  it "can print all of the names recursively" do
    trystan = build_tree "Trystan" do
      add_child "Peggie"
      add_child "Sierra" do
        add_child "Giuseppe"
        add_child "Orval"
      end
    end

    tree = Tree.new

    result = capture { tree.print_names(trystan) }

    expect(result).to eq("Trystan\nPeggie\nSierra\nGiuseppe\nOrval\n")
  end

  it "can return an array of all names recursively" do
    trystan = build_tree "Trystan" do
      add_child "Peggie"
      add_child "Sierra" do
        add_child "Giuseppe"
        add_child "Orval"
      end
    end

    node_walker = Tree.new

    actual = node_walker.names(trystan)
    expect(actual).to eq(["Trystan", "Peggie", "Sierra", "Giuseppe", "Orval"])
  end

  it "can return an array of all names recursively, with each new level indented by two spaces" do
    trystan = build_tree "Trystan" do
      add_child "Peggie"
      add_child "Sierra" do
        add_child "Giuseppe" do
          add_child "Orval"
        end
      end
    end

    node_walker = Tree.new

    actual = node_walker.names_with_indentation(trystan)
    expect(actual).to eq(["Trystan", "  Peggie", "  Sierra", "    Giuseppe", "      Orval"])
  end

  it "can return an array of names in a nested hash" do
    trystan = build_tree "Trystan" do
      add_child "Peggie"
      add_child "Sierra" do
        add_child "Giuseppe" do
          add_child "Orval"
        end
      end
    end

    node_walker = Tree.new

    actual = node_walker.to_hash(trystan)
    expect(actual).to eq({
      "Trystan" => {
        "Peggie" => {},
        "Sierra" => {
          "Giuseppe" => {
            "Orval" => {}
          }
        }
      }
    })
  end

end