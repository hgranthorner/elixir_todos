defmodule Todo.AgentTest do
	use ExUnit.Case, async: true
	doctest Todo.Agent

	setup do
		pid = start_supervised!(Todo.Agent)
		[pid: pid]
	end

	test "can create a todo", %{pid: p} do
		todo = Todo.Agent.upsert(p, "my title", "my description") |> IO.inspect()
		todos = Todo.Agent.get_todos(p)
		assert length(Map.keys(todos)) == 1
		assert Todo.Agent.todo(todo, :title) == "my title"
		assert Todo.Agent.todo(todo, :description) == "my description"
	end

	test "can create another todo without sharing state", %{pid: p} do
		todo = Todo.Agent.upsert(p, "my title", "my description")
		todos = Todo.Agent.get_todos(p)
		assert length(Map.keys(todos)) == 1
		assert Todo.Agent.todo(todo, :title) == "my title"
		assert Todo.Agent.todo(todo, :description) == "my description"
	end

	test "can get all todos", %{pid: p} do
		todo = Todo.Agent.upsert(p, "my title", "my description")
		assert Todo.Agent.get_todos(p) == %{Todo.Agent.todo(todo, :id) => todo}
	end
end