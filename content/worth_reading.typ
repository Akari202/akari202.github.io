#import "@local/akari-macros:0.1.0": *
#show: minimal-setup.with(
  title: "The Sacred Jedi Texts",
  date: datetime(year: 2026, month: 2, day: 19),
)

#title()

#if compile-host == "didactic" {
  html.elem("link", attrs: (
    rel: "stylesheet",
    href: "burn.css",
    type: "text/css",
  ))
}

This is going to be\u{2122} a collection of things I've enjoyed reading or found impactful. It
remains to be seen if I will manage to continue updating.
