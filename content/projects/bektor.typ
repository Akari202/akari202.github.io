#import "@local/akari-macros:0.1.0": *
#show: minimal-setup.with(
  title: "Bektor",
  description: "Vector and quaternion utilities library for Rust and Python"
)

= Bektor (vec-utils)

A Rust create for 3D vector math, quaternions, geometry, complex numbers, and angles. Python bindings are also available for much of the library.

- `f64` precision
- Many matrix operations are zero copy and generic

== Modules

- `vec3d`: 3D vector operations
- `quat`: Quaternion operations
- `matrix`: Matrix operations
    - `complex`: A complex valued matrix
    - `generic`: Generic 2d matrx of any size or type
    - `real`: A real valued matrix
- `geometry`: Geometry operations
    - `circle`, `plane`, `sphere`: Geometry primitives
    - `intersection`: Calculate intersections between geometry objects
- `complex`: Complex numbers
- `angle`: Angles in degrees and radians

== Features

- `std`: standard library support across all active dependencies (default)
- `matrix`: matrix multiplicaiton and other operations, still missing a lot of features
- `rand`: Random generation of types (default)
- `nalgebra`: interop with `nalgebra` types
- `glam`: interop with `glam` types
- `rkyv`: zero-copy serialization
- `serde`: serialization/deserialization

== License
GPL-3.0-only
