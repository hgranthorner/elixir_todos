defmodule Todo.Agent do
	use Agent
	require Record
	Record.defrecord(:todo, id: UUID.uuid4(), title: "", description: "")
	@type todo :: record(:todo, id: UUID.t(), title: String.t(), description: String.t())

	def start_link(_initial_value) do
		Agent.start_link(fn -> %{} end)
	end

	def get_todos(pid) do
		Agent.get(pid, fn x -> x end)
	end

	def upsert(pid, todo) when Record.is_record(todo, :todo) do
		id = todo(todo, :id)
		Agent.update(pid, fn todos -> Map.put(todos, id, todo) end)
		Agent.get(pid, fn todos -> Map.get(todos, id) end)
	end

	def upsert(pid, title, description) do
		todo = todo(id: UUID.uuid4(), title: title, description: description)
		id = todo(todo, :id)
		Agent.update(pid, fn todos -> Map.put(todos, id, todo) end)
		Agent.get(pid, fn todos -> Map.get(todos, id) end)
	end
end