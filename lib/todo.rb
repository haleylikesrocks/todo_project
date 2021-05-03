# This class represents a todo item and its associated
# data: name and description. There's also a "done"
# flag to show whether this todo item is done.

class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end


# This class represents a collection of Todo objects.
# You can perform typical collection-oriented actions
# on a TodoList object, including iteration and selection.

class TypeError < StandardError; end

class TodoList
  attr_accessor :title, :todos

  def initialize(title)
    @title = title
    @todos = []
  end

  def add(todo)
    rraise TypeError, 'Can only add Todo objects' if todo.class != Todo
    todos << todo
  end

  def <<(todo)
    raise TypeError, 'Can only add Todo objects' if todo.class != Todo
    todos << todo
  end

  def size
    todos.size
  end

  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos
  end

  def done?
    todos.all?{ |todo| todo.done? }
  end

  def item_at(index)
    raise IndexError if index >= todos.size
    todos[index]
  end

  def mark_done_at(index)
    raise IndexError if index >= todos.size
    todos[index].done!
  end

  def mark_undone_at(index)
    raise IndexError if index >= todos.size
    todos[index].undone!
  end

  def done!
    todos.each { |todo| todo.done! }
  end

  alias mark_all_done done!

  def mark_all_undone
    todos.each { |todo| todo.undone! }
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(index)
    raise IndexError if index >= todos.size
    todos.delete_at(index)
  end

  def to_s
    text = "---- #{title} ----\n"
    text << @todos.map(&:to_s).join("\n")
    text
  end

  def each 
    counter = 0
    while counter < todos.size do
      yield(todos[counter])
      counter += 1
    end
    self
  end

  def select
    counter = 0
    ret_list = TodoList.new(title)
    while counter < todos.size
      ret = yield(todos[counter])
      ret_list << todos[counter] if ret
      counter += 1
    end
    ret_list
  end
  
  def mark_done(name)
    each do |todo| 
      totdo.done! if todo.title == name
    end
  end

  def all_done
    select { |todo| todo.done?}
  end

  def all_not_done
    select { |todo| !(todo.done?)}
  end

  def find_by_title(name)
    each do |todo| 
      return totdo if todo.title == name
    end
  end
  # rest of class needs implementation

end


todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

todo1.done!

results = list.select { |todo| todo.done? }    # you need to implement this method

list.mark_all_done

puts list

list.mark_all_undone

puts list

puts results.inspect

puts results.class