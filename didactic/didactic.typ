#import "@local/akari-macros:0.1.0": *

#let tree-data = read("../tree").trim().split("\n")

#let extract-title(file-path, default-name) = {
  let content = read("../" + file-path)

  let title-match = content.match(
    regex(
      "(?:#show\: minimal-setup|#show\: setup|#set document)(?:[^)]*?)\btitle:\s*\"([^\"]+)\"",
    ),
  )
  if title-match != none { return title-match.captures.at(0) }
  return "Title Match Error"
}

#let make-nav-directories(tree-data, current-file) = {
  let root-dir = "content/"
  let nav-excluded-titles = ("Error 404", "Wishlist")

  let current-dir = current-file.replace(regex("[^/]+\.typ$"), "")
  let active-steps = ()
  let running-path = ""
  for segment in current-dir.split("/") {
    if segment == "" { continue }
    running-path += segment + "/"
    if running-path.starts-with(root-dir) {
      active-steps.push(running-path)
    }
  }

  let levels-nav = ()

  for target-dir in active-steps {
    let level-dict = (:)

    for path in tree-data {
      if not path.ends-with(".typ") { continue }

      if path.starts-with(target-dir) {
        let remaining = path.slice(target-dir.len())
        let parts = remaining.split("/")

        if parts.len() == 1 {
          let filename = parts.at(0)

          if filename == "index.typ" and target-dir != root-dir { continue }

          let name = filename.replace(".typ", "")
          let title = extract-title(path, name)
          if title in nav-excluded-titles {
            continue
          }
          level-dict.insert(
            title,
            path.replace(regex("^content\/"), "").replace(regex("\.typ$"), "").replace("/", "-"),
          )
        } else if parts.len() > 1 {
          let dir-name = parts.at(0)
          let index-path = target-dir + dir-name + "/index.typ"

          if index-path in tree-data {
            let title = extract-title(index-path, dir-name)
            if title in nav-excluded-titles {
              continue
            }
            level-dict.insert(
              title,
              index-path
                .replace(regex("^content\/"), "")
                .replace(regex("\.typ$"), "")
                .replace("/", "-"),
            )
          }
        }
      }
    }

    levels-nav.push(level-dict)
  }

  return levels-nav
}

#for i in tree-data {
  let output = i.replace(regex("^content\/"), "")
  if i.ends-with("typ") {
    let nav-tree = make-nav-directories(tree-data, i)
    [
      #document(
        output.replace(regex("typ$"), "html"),
        format: "html",
        author: "Akari202",
      )[
        #html.head()[
          #html.link(
            rel: "stylesheet",
            type: "text/css",
            href: "https://cdn.jsdelivr.net/gh/dreampulse/computer-modern-web-font@master/fonts.css",
          )
          #html.link(rel: "stylesheet", type: "text/css", href: "/style.css")
          #html.link(rel: "icon", type: "image/x-icon", href: "/favicon.ico")
          #html.link(rel: "author", href: "/humans.txt")
          #html.meta(
            name: "robots",
            content: "index, follow, nosnippet, nocache, noarchive, noimageindex",
          )
        ]
        #html.header()[
          #html.nav()[
            #(
              nav-tree
                .map(i => {
                  i
                    .pairs()
                    .map(j => {
                      if (
                        j.at(1) == output.replace(regex("\.typ$"), "").replace("/", "-")
                      ) {
                        link(label(j.at(1)), underline(j.at(0)))
                      } else {
                        link(label(j.at(1)), j.at(0))
                      }
                    })
                    .join(" | ")
                })
                .join(html.br())
            )
          ]
        ]

        #include "../" + i

        #html.footer()[
          #html.hr()
          #html.elem("small", attrs: (
            style: "display: flex; justify-content: space-between;",
          ))[
            #html.span()[
              Generated on #get-now().display("[year]-[month]-[day] at [hour]:[minute]")
            ]
            #html.span()[
              By #context { document.author.join(", ") }
            ]
          ]
        ]
      ]
      #label(output.replace(regex("\.typ$"), "").replace("/", "-"))]
  } else {
    asset(output, read("../" + i, encoding: none))
  }
}


