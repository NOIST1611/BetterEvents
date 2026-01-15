# BetterEvents

**BetterEvents** is a lightweight, fully typed event library for **Retro Gadgets**, designed to replace RG CPU event channels. It allows communication between scripts via custom signals and callbacks, making event-driven programming simpler and more organized.

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
local BetterEvents = require("name of your script where you put Better Events code")
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
local BetterEvents = require("name of your script where you put Better Events code")

local signal = BetterEvents.new("ExampleSignal")

local conn1 = signal:Connect(function(msg)
    print("Conn1 received:", msg)
end)

signal:Once(function(msg)
    print("Once received:", msg)
end)

signal:Fire("Hello")  -- Both callbacks fire
signal:Fire("World")  -- Only conn1 fires

conn1:Disconnect()
signal:Fire("After disconnect")  -- No callbacks fire
signal:Disable()  -- Removes signal completely
```
