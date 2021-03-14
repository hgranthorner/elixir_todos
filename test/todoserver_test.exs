defmodule TodoServerTest do
	use ExUnit.Case, async: true
	doctest Todo.Server
	alias Todo.Server

	setup do
		{:ok, pid} = Server.start_link()
		[pid: pid]
	end

	test "exists", %{pid: p} do
		res = Server.call(p)
		assert res == :my_reply
	end
end