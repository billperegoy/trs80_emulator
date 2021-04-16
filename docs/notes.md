# Development Notes
## Data Structures
I'm attempting to use Elixir binaries to represent the actual bit lengths in the
real Z80 hardware. Elixir is great here in that you can use pattern matching,
but the syntax is a little less concise and simple than it would be in `C` or
Rust. I'm curious how this feels when I get deeper into emulating the internal
math of the processor.

## Development Approach
I'm trying to work right from the spec and build this up using test driven
design. I'm wondering if I can build a solid representation of what the hardware
does that can be simulated and maybe later synthesized into an FPGA.

## Pattern matching Caveats
When you pattern match on binaries, it's easy to get mixed up and forget that
when pattern matching multi-byte binaries, the matched values are simple Elixir
integers. You then may accidentally compare binaries and integers with bad
results. The lack of strong type checking makes this more difficult than I wish
it would be.

## Possible solutions to the above
If I can generalize all of the 8/16 bit math into one library, this may make the
above easier to deal with. I'll try this out when I design the accumulator logic
and need more general math than the simple program counter increments.

## Current State
* Register state defined
* Reset pin emulated
* Simple tick function defined that fetches an instruction

## Next Goal
Get a simple linear instruction fetch working and then decode a couple of simple
instructions.

I'm noticing as I'm doing this that my code structure is feeling a bit
object-oriented. I'm delegating functions at the trs80 level to those at the z80
level. Right now, I'm not sure if that's a bad pattern or not.

# Hooking up the Front End
This will be the first prrof of concept
* We need to store the TRS80 state in a genserver
* When the FE connects, it will create a new genserver instance and store
  initial empty state
* FE will have a `reset` and a `tick` button which will advance the counter
* These actions will trigger a REST POST which will update the genserver state
  and return the new state to the FE

# Genserver basics
```
# Each new user should initialze computer state like this.
# This PID should be held by the client and passed in when
# we nake API calls. This will allow each cleint to have a unique
# set of state.
#
{:ok, pid} = Trs80Emulator.Trs80.Server.start_link()


# We can then fetch the state like this
#
Trs80Emulator.Trs80.Server.fetch_state()
```

# Emulating basic login behavior
Rather than  build out a real auth system, I just want a simple login and logout
that will create a new genserver process on login and destroy/forget it on
logout.

I added the buttons and state to the Elm code and now need to access the correct
instance based on the login pid.
