#let _target = sys.inputs.at("target", default: "paged")

#show math.equation: it => if _target == "html" {
  html.frame(it)
} else {
  it
}

#let image(src, alt: "", width: auto, class: "") = {
  if _target == "html" {
    let attrs = if width != auto {
      let px_width = str(width.pt()) + "px"
      (
        src: src,
        alt: alt,
        title: alt,
        class: class,
        width: px_width,
      )
    } else {
      (
        src: src,
        alt: alt,
        title: alt,
        class: class,
      )
    }
    html.elem("img", attrs: attrs)
  } else {
    std.image(src, width: width, alt: alt)
  }
}

#set document(title: "The Sacred Jedi Texts", date: datetime(year: 2026, month: 2, day: 19))

#title()

This is going to be\u{2122} a collection of things I've enjoyed reading or found impactful. It
remains to be seen if I will manage to continue updating.
