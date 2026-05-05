#import "@local/akari-macros:0.1.0": *
#import constants: gravitational-constant
#import units: g
#show: setup.with(
  title: "Astrodynamics Notes",
  bib: true,
  header-center: "Astrodynamics",
  show-title: true,
  numbering: (equation: true, section: true),
  date: datetime(year: 2026, month: 5, day: 1),
)

= Introduction
My notes from reading @bate1971

== Symbols
=== Astronomer's Symbols
#let planets = (
  sym: (
    "sun",
    "mercury",
    "venus",
    "earth",
    "mars",
    "jupiter",
    "saturn",
    "uranus",
    "neptune",
  ),
  symb: (
    "moon",
    "pluto",
  ),
)
#for (i, j) in planets.pairs() {
  for k in j {
    [#eval(i + "." + k, mode: "code", scope: (symb: symb)) - #k\ ]
  }
}


= Two Body Mechanics
== Kepler's Laws
+ The oribit of each planet is an ellipse, with the sun at a focus.
+ The line joining the planet to the sun sweeps out equal areas in equal times.
+ The square of the perion of a planet is proportional to the cube of its mean distance from the
  sun.
These laws only describe the result with no explanation as to the *why*.

== Newton's Laws
+ An object in motion stays in motion unless otherwise acted upoun.
+ The acceleration of an object depends on the mass of the object and the amount of force applied.
+ Every action has an equal and opposite reaction.

== Newton's Law of Universal Gravitation
Any two bodies attract one another with a force proportional to the product of their masses and
inversely proportional to the square of the distance between them.
$ ab(F)_(10) = -G (m_0 m_1) / norm(ab(r)_(10))^3 ab(r)_(10) $<eq:gravitation>
Where $ab(F)_(10)$ is the force vector acting on mass 1 by mass 0, $G$ is the gravitational constant
$G = #gravitational-constant$, $m_0$ and $m_1$ are the masses of the two objects respectively, and
$ab(r)_(10)$ is the vector between the center of masses from mass 1 to mass 0.

Newton's law only applies if the bodies are idealized, spherical and uniform#footnote[In earth's
  vicinity this imprecision is on the order of $10^(-3)#g$.]. This can be generalized to an n-body
problem where the total force acting on mass $m_i$ by all other masses,
$m_k forall k in [0, n] inter ZZ$, is:
$ ab(F)_g = -G m_i sum^n_(j=0 \ j!=i) m_j / norm(ab(r)_(j i))^3 ab(r)_(j i) $<eq:gravnbody>

Applying Newton's second law the general equation of motion for the $i^"th"$ body can be found.
$ ddb(r)_i = (ab(F)_g + ab(F)_"other") / m_i - db(r)_i dot(m)_i / m_i $
Where $ab(F)_g$ is the total gravitational force and $ab(F)_"other"$ is all other external forces.
$dot(m)_i$ is needed to account for changing mass due to relativistic effects or mass expulsion for
thrust etc.

== Two Body Problem
Assuming some arbitrary inertial reference frame the relative motion of two bodies with solely
gravitational effects can be derived.
$ ddb(r) = - (G m_0 m_1) / norm(ddb(r))^3 bold(r) $<eq:twobodypedantic>
Where $bold(r) = bold(r)_1 - bold(r)_0$. For the less general but far more common case where
$m_0 >> m_1$ it makes sense to define $mu$ to be the gravitational parameter
$mu equiv G m_0 approx G(m_0 + m_1)$ thus simplifying @eq:twobodypedantic:
$ ddb(r) + mu / norm(ddb(r))^3 bold(r) = 0 $<eq:twobody>

== Polar Conic Sections and Trajectory
#todo

== Summary
+ The only possible curves for an orbit in a two body system are conic sections.
+ The focus of the conic orbit must be located at the center of the central body.
+ The mechanical energy of a satellite does not change as the satellite orbits. Gravity is a
  conservative force so energy must be exchanged between potential and kinetic forms. I.e. a
  satellite must slow down as it's altitude increases or speed up as it's altitude decreases.
+ Orbital motion takes place within a plane fixed in inertial space.
+ The angular momentum of a satellite remains constant.


