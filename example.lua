-- example.lua
-- Example usage of BetterEvents library

local BetterEvents = require("BetterEvents")

-- Create a new signal named "TestSignal"
local testSignal = BetterEvents.new("TestSignal")

-- Connect a callback to the signal
local connection1 = testSignal:Connect(function(msg)
    print("Connection1 received:", msg)
end)

-- Connect another callback that triggers only once
local connection2 = testSignal:Once(function(msg)
    print("Once connection received:", msg)
end)

-- Fire the signal with a message
testSignal:Fire("Hello world!")
-- Output:
-- Connection1 received: Hello world!
-- Once connection received: Hello world!

-- Fire the signal again
testSignal:Fire("Second message")
-- Output:
-- Connection1 received: Second message
-- (Once connection doesn't fire again)

-- Fire a specific connection by ID
testSignal:FireSpecificID(connection1.id, "Message to connection1 only")
-- Output:
-- Connection1 received: Message to connection1 only

-- Disconnect a connection manually
connection1:Disconnect()

-- Fire again after disconnecting
testSignal:Fire("After disconnect")
-- Output:
-- (No output, all connections removed)

-- Disable the signal completely
testSignal:Disable()

-- Trying to fire after disable
testSignal:Fire("Should do nothing")
-- Output:
-- (No output, signal is disabled)
