require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require 'simplecov'
SimpleCov.start

require_relative '../lib/todo'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(@list.size, 3)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    assert_equal(@todo1, @list.shift)
    assert_equal(2, @list.size)
  end

  def test_pop
    assert_equal(@todo3, @list.pop)
    assert_equal(2, @list.size)
  end
  # Your tests go here. Remember they must start with "test_"
  def test_done?
    assert_equal(false, @list.done?)
  end

  def test_typeerror
    assert_raises(NoMethodError){@list.add(5)}
  end

  def test_arrowadd
    @list << @todo1
    assert_equal(4, @list.size)
  end

  def test_add
    @list.add(@todo1)
    assert_equal(4, @list.size)
  end

  def test_item_at
    assert_equal(@todo1, @list.item_at(0))
    assert_raises(IndexError){ @list.item_at(50) }
  end

  def test_mark_done_at
    @list.mark_done_at(0)
    assert_equal(true, @list.item_at(0).done?)
    assert_raises(IndexError){ @list.mark_done_at(50) }
  end

  def test_mark_undone_at
    @list.mark_done_at(0)
    assert_equal(true, @list.item_at(0).done?)
    @list.mark_undone_at(0)
    assert_equal(false, @list.item_at(0).done?)
    assert_raises(IndexError){ @list.mark_undone_at(50) }
  end

  def test_done!
    @list.done!
    assert_equal(true, @list.item_at(2).done?)
  end

  def test_remove_at
    assert_raises(IndexError){ @list.remove_at(50) }
    assert_equal(@todo2, @list.remove_at(1))
    assert_equal(2, @list.size)
  end

  def test_to_s
    @list.done!
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  # def test_each
  #   counter = 0
  #   @list.each do |todo|
  #     assert_equal(@list.item_at(counter), todo)
  #     counter += 1
  #   end
  # end

  def test_each
    new_list = @list.each { }
    assert_equal(new_list, @list)
  end

  def test_select
    @list.mark_done_at(1)
    new_list = @list.select do |todo|
      todo.done?
    end
    assert_equal(new_list.size, 1)
  end
end
