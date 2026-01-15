# BetterEvents

**BetterEvents** is a fully typed event library for **Retro Gadgets**, designed to replace RG CPU event channels. It allows communication between scripts and basically adds support of events in RG.

---

## Features

- Create **named signals** that can be accessed globally.
- Connect multiple **callbacks** to a single signal.
- **Fire events** with any number of arguments.
- **Once** connections that automatically disconnect after being called.
- Fire **specific connections** by ID.
- **Disconnect** individual connections or destroy the entire signal.
- Fully typed with **Luau types**, for better autocomplete and type safety.

---

# Installation

1. Copy `BetterEvents.lua` code into your gadget assets.
2. Require it where needed:

```lua
local BetterEvents = require("BetterEvents")
```

---

# Usage

# Creating a signal
```lua
local MySignal = BetterEvents.new("TestSignal")
```
# Connecting a callback
```lua
local connection = MySignal:Connect(function(message)
    print("Received:", message)
end)
```
`Connect(fn: callback)` connects a callback to the **signal**
Returns a `Connection` object, which can be disconnected later.

---

# Using Once
```lua
MySignal:Once(function(message)
    print("This will run only once:", message)
end)
```
`Once(fn: callback)` connects a callback that will automatically disconnect after being fired once.

---

# Firing a Signal
```lua
MySignal:Fire("Hello World")
```
`Fire(...)` executes all connected callbacks with the provided arguments.

---

# Firing a Specific Connection
```lua
MySignal:FireSpecificID(connection.id, "Specific call")
```

---

# Disconnecting a Connection
```lua
connection:Disconnect()
```
Disconnects the specific callback from the signal.

---

# Destroying a Signal
```lua
MySignal:Disable()
```

---

# Full Example
```lua
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
```
