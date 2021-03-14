defmodule TodoServerTest do
	use ExUnit.Case, async: true
	doctest Todo.Server
	alias Todo.Server

	setup do
		pid = start_supervised!(Server)
		[pid: pid]
	end

	test "can call", %{pid: p} do
		res = Server.call(p)
		assert res == :my_reply
	end

	test "can cast", %{pid: p} do
		Server.cast(p)
		assert :ok == :ok
	end

	test "can create a todo", %{pid: p} do
		todos = Server.create(p, "my title", "my description")
		[todo] = todos
		assert length(todos) == 1
		assert Server.todo(todo, :title) == "my title"
		assert Server.todo(todo, :description) == "my description"
	end

	test "can create another todo without sharing state", %{pid: p} do
		todos = Server.create(p, "my title", "my description")
		[todo] = todos
		assert length(todos) == 1
		assert Server.todo(todo, :title) == "my title"
		assert Server.todo(todo, :description) == "my description"
	end
end