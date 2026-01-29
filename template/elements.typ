
/// Create a dot rating component.
/// -> content
#let dot-ratings(
  /// Number of active dots to show
  /// -> int
  selected,
  /// Number of dots in total
  /// -> int
  total,
  /// Size of each dot (diameter)
  /// -> length
  size: 12pt,
  /// Spacing between dots
  /// -> length
  spacing: 5pt,
  /// Color of active dots
  /// -> color
  color-active: color.blue,
  /// Color of inactive dots
  /// -> color
  color-inactive: color.gray,
) = {
  let dots = ()

  for value in range(total) {
    let color = if value < selected { color-active } else { color-inactive }
    dots += (
      box(
        rect(
          width: size,
          height: size,
          fill: color,
        ),
      ),
    )
  }

  grid(
    columns: total,
    column-gutter: spacing,
    ..dots,
  )
}
