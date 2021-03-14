defmodule Todo.Server do
	use GenServer
	require Record
	Record.defrecord(:todo, title: "", description: "")
	@type todo :: record(:todo, title: String.t(), description: String.t())

	# Client

	def start_link(state) when is_list(state) do
		GenServer.start_link(__MODULE__, state)
	end

	def call(pid) do
		GenServer.call(pid, :call)
	end

	def cast(pid) do
		GenServer.cast(pid, :cast)
	end

	def create(pid, title, description) do
		todo = todo(title: title, description: description)
		GenServer.call(pid, {:create, todo})
	end

	# Server

	@impl true
	def init(args) do
		{:ok, args}
	end

	@impl true
	def handle_call({:create, todo}, _from, state) do
		new_state = [todo | state]
		{:reply, new_state, new_state}
	end

	@impl true
	def handle_call(_msg, _from, state) do
		{:reply, :my_reply, state}
	end

	@impl true
	def handle_cast(_msg, state) do
		{:noreply, state}
	end
end