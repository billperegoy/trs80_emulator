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
