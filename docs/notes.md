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
