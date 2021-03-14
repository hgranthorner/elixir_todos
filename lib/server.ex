defmodule Todo.Server do
	use GenServer

	# Client

	def start_link do
		GenServer.start_link(__MODULE__, [])
	end

	def call(pid) do
		GenServer.call(pid, :call)
	end

	def cast(pid) do
		GenServer.cast(pid, :cast)
	end

	# Server

	@impl true
	def init(args) do
		{:ok, args}
	end

	@impl true
	def handle_call(msg, _from, state) do
		{:reply, :my_reply, state}
	end

	@impl true
	def handle_cast(msg, state) do
		{:no_reply, state}
	end
end