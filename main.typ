#set text(font: "微軟正黑體")

#let data = yaml("data.yml")

// Stolen link color straight from official Typst wiki.
#let linkRGB = rgb("#007AFF")

#let button(name, b, t, filled: true) = box(
  fill: if filled { rgb(b) } else { none },
  stroke: if filled { none } else { 1.5pt + rgb(b) },
  radius: 10pt,
  inset: (x: 10pt, y: 8pt),
  text(
    name,
    weight: "bold",
    fill: rgb(t),
    size: 10pt,
  ),
)

#let makeTitle(name) = {
  text(
    fill: rgb("#1430A0"),
    weight: "bold",
    tracking: 1.5pt,
    size: 9pt,
  )[#name]
  v(1.5em)
}

#let inlineIcon(path, size) = box(
  baseline: 20%,
  height: size,
  image(path, height: 100%)
)

#align(left)[
  #set par(leading: 1.25em)
  #text(size: 30pt, fill: rgb("#1430A0"))[#data.name] \
  #text(size: 15pt, fill: rgb("#7F7F7F"), style: "italic")[#data.dep]
]
#v(0.5em)

// Inspired by: https://youtu.be/G47JjN4F_hE
#align(right)[
  #text(size: 10pt)[
    #data.contact.pairs().map(((label, url)) => {
      if url != none {
        link(url)[
          #underline(stroke: linkRGB)[
            #text(fill: linkRGB, weight: "bold")[#label]
          ]
        ]
      } else {
        label
      }
    }).join(" | ")
  ]
]
#v(1.5em)

// #makeTitle("HIGHLIGHTS")

#grid(
  columns: (1fr, 9fr),
  ..data.highlights.enumerate().map(((i, desc)) => (
    box(
      inset: (y: 15pt),
      width: 100%,
      text(
        fill: rgb("#2D7CAD"),
        weight: "bold",
        size: 11pt,
        if i < 9 { "0" + str(i + 1) } else { str(i + 1) }
      )
    ),
    box(
      inset: (y: 15pt),
      stroke: (bottom: 0.5pt + rgb("#7F7F7F")),
      width: 100%,
      text(
        size: 10pt,
        fill: rgb("#1D3557"),
        desc
      )
    )
  )).flatten()
)
#v(1.5em)

#makeTitle("SKILLS")

#table(
  columns: (auto, auto),
  stroke: none,
  column-gutter: 20pt,
  align: (col, row) => (left + horizon),
  ..data.skills.map(map => {

    let (level, config) = map.pairs().first()

    let colors = config.at("colors", default: ("#AAAAAA", "#000000"))
    let colorsFallback = if colors != none { colors } else { ("#2D7CAD", "#FFFFFF") }

    let languages = config.at("languages", default: none)
    let tools = config.at("tools", default: none)

    (
      text(weight: "bold", fill: rgb("#000000"), size: 11pt)[#level],
      (
        (if languages != none { languages.map(s => button(s, colorsFallback.at(0), colorsFallback.at(1))) } else { () })
        +
        (if tools != none { tools.map(s => button(s, colorsFallback.at(0), colorsFallback.at(1), filled: false)) } else { () })
      ).join(h(10pt)),
    )
  }).flatten(),
)
#v(1.5em)

#makeTitle("PORTFOLIO")

#grid(
  columns: (1fr, 9fr),
  gutter: 10pt,
  align: horizon,
  ..data.portfolio.map(map => {
    let (title, config) = map.pairs().first()
    let thumbnail = config.at("thumbnail", default: none)
    (
      box(
        radius: 10pt,
        clip: true,
        grid.cell(
          image(if thumbnail != none { "assets/" + thumbnail + ".png" } else { none }, width: 100%),
        ),
      ),
      box(
        inset: (y: 15pt),
        stroke: (bottom: 0.5pt + rgb("#7F7F7F")),
        width: 100%,
      )[
        #text(size: 14pt, fill: rgb("#1D3557"))[#title] \
        #text(size: 10pt, fill: rgb("#7F7F7F"))[
          #link(config.curseforge.link)[
            #inlineIcon("assets/curseforge.png", 10pt) #config.curseforge.downloads
          ]#h(0.2em)|#h(0.2em)#link(config.modrinth.link)[
            #inlineIcon("assets/modrinth.png", 10pt) #config.modrinth.downloads
          ]
        ] \
        #text(size: 12pt, fill: rgb("#1D3557"))[#config.desc]
      ],
    )
  }).flatten()
)
#v(1.5em)

#block(breakable: false)[

  #makeTitle("EXPERIENCE")

  #align(left)[
    #for (title, desc) in data.experience.pairs() [
      #text(size: 11pt, weight: "bold", fill: rgb("#2D7CAD"))[#title] \
      #v(0.3em)
      #text(size: 10pt)[#desc]
      #v(1em)
    ]
  ]
  #v(1.5em)

]

#block(breakable: false)[

  #makeTitle("LEARNING PLAN")

  #align(left)[
    #for (title, desc) in data.plan.pairs() [
      #text(size: 11pt, weight: "bold", fill: rgb("#2D7CAD"))[#title] \
      #v(0.3em)
      #list(..desc)
      #v(1em)
    ]
  ]
  #v(1.5em)

]

#align(center)[
  #let url = "https://github.com/JerryLu086/Typst-CV"
  #text(size: 8pt)[
    Made with Typst: #link(url)[#underline(stroke: linkRGB)[#text(fill: linkRGB, weight: "bold")[#url]]]
  ]
]

