#set text(font: "Noto Sans CJK TC")

#let data = yaml("data.yml")

#let button(name) = box(
  fill: rgb("#E5E5E5"),
  radius: 10pt,
  inset: (x: 10pt, y: 8pt),
  text(
    name,
    weight: "bold",
    fill: rgb("#7F7F7F"),
    size: 10pt,
  )
)

#text(
  fill: rgb("#56AAFF"),
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
  ..data.skills.map(items => {
    let (level, skill) = items.pairs().first()
    (
      text(weight: "bold", fill: rgb("#000000"), size: 11pt)[#level],
      skill.map(s => button(s)).join(h(10pt)),
    )
  }).flatten()
)