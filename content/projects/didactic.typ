#import "@local/akari-macros:0.1.0": *
#show: minimal-setup.with(
  title: "Didactic",
)

= Didactic

This website was originally generated using a tool called Didactic. This was a rust based program
that used #link("https://typst.app")[Typst] and #link("https://github.com/Keats/tera")[Terra] to
generate a static site using Typst's experimental html export. The release of Typst version 0.15.0
included bing changes including bundle export. Using bundles made all of the (admittedly low
quality) code I had originally written basically useless. All the heavy lifting I was using rust
could now be accomplished with a simple shell script.
