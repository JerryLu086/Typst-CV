#set text(font: "Noto Sans CJK TC")

#let data = yaml("data.yml")

#let button(name, b, t) = box(
  fill: rgb(b),
  radius: 10pt,
  inset: (x: 10pt, y: 8pt),
  text(
    name,
    weight: "bold",
    fill: rgb(t),
    size: 10pt,
  )
)

#text(
  fill: rgb("#1430A0"),
  weight: "bold",
  tracking: 1.5pt,
  size: 9pt
)[SKILLS]

#table(
  columns: (auto, 1fr),
  stroke: none,
  column-gutter: 20pt,
  // align: top + left,
  align: (col, row) => (left + horizon),
  ..data.skills.map(map => {
    let (level, config) = map.pairs().first()
    let skill = config.items
    let colors = config.colors
    (
      text(weight: "bold", fill: rgb("#000000"), size: 11pt)[#level],
      skill.map(s => button(s, colors.at(0), colors.at(1))).join(h(10pt)),
    )
  }).flatten()
)