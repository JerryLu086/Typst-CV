#set text(font: "Noto Sans CJK TC")

#let data = yaml("data.yml")

// Stolen link color straight from official Typst wiki.
#let linkRGB = rgb("#007AFF")

#let button(name, b, t) = box(
  fill: rgb(b),
  radius: 10pt,
  inset: (x: 10pt, y: 8pt),
  text(
    name,
    weight: "bold",
    fill: rgb(t),
    size: 10pt,
  ),
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


#text[

]
#v(1.5em)

#text(
  fill: rgb("#1430A0"),
  weight: "bold",
  tracking: 1.5pt,
  size: 9pt,
)[SKILLS]

#table(
  columns: (auto, auto),
  stroke: none,
  column-gutter: 20pt,
  align: (col, row) => (left + horizon),
  ..data.skills.map(map => {
    let (level, config) = map.pairs().first()
    let skill = config.items
    let colors = config.colors
    (
      text(weight: "bold", fill: rgb("#000000"), size: 11pt)[#level],
      skill.map(s => button(s, colors.at(0), colors.at(1))).join(h(10pt)),
    )
  }).flatten(),
)