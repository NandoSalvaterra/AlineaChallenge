import SwiftUI

// MARK: - EmbossedTextRenderer
// A TextRenderer that applies a three-pass embossed metallic effect:
// 1. Drop shadow — dark offset blur beneath the glyphs
// 2. Flat fill — solid light-gray fill across the glyph interior
// 3. Metallic border — thin gradient outline around each glyph edge

struct EmbossedTextRenderer: TextRenderer {

    // MARK: - Properties

    var isEmpty: Bool

    // MARK: - Constants

    private enum Shadow {
        static let dx: CGFloat    = 2
        static let dy: CGFloat    = 3
        static let blur: CGFloat  = 4
        static let color          = Color(red: 0.04, green: 0.04, blue: 0.10, opacity: 0.85)
    }

    private static let colorSpace = CGColorSpaceCreateDeviceRGB()

    private static let fillColor = Color(red: 227/255, green: 227/255, blue: 227/255)

    private static let borderColors: [CGColor] = [
        UIColor(white: 1.00, alpha: 1).cgColor,
        UIColor(white: 0.85, alpha: 1).cgColor,
        UIColor(white: 0.55, alpha: 1).cgColor,
        UIColor(white: 0.40, alpha: 1).cgColor,
        UIColor(white: 0.60, alpha: 1).cgColor,
        UIColor(white: 0.75, alpha: 1).cgColor,
    ]
    private static let borderLocations: [CGFloat] = [0.0, 0.20, 0.45, 0.60, 0.78, 1.0]

    // Eight cardinal + diagonal unit offsets used to build the outer stroke mask.
    private static let borderOffsets: [(CGFloat, CGFloat)] = [
        ( 1.0,  0.0), (-1.0,  0.0),
        ( 0.0,  1.0), ( 0.0, -1.0),
        ( 0.7,  0.7), (-0.7,  0.7),
        ( 0.7, -0.7), (-0.7, -0.7),
    ]

    // MARK: - TextRenderer

    func draw(layout: Text.Layout, in context: inout GraphicsContext) {
        var bounds = CGRect.null
        for line in layout {
            for run in line {
                bounds = bounds.union(run.typographicBounds.rect)
            }
        }

        guard !bounds.isNull, bounds.width > 0, bounds.height > 0 else { return }

        if isEmpty {
            drawPlaceholder(layout: layout, bounds: bounds, in: &context)
            return
        }

        drawShadow(layout: layout, in: &context)
        drawFill(layout: layout, bounds: bounds, in: &context)
        drawBorder(layout: layout, bounds: bounds, in: &context)
    }

    // MARK: - Passes

    private func drawPlaceholder(layout: Text.Layout, bounds: CGRect, in context: inout GraphicsContext) {
        context.drawLayer { gc in
            gc.clipToLayer { mc in
                for line in layout { mc.draw(line) }
            }
            gc.fill(Path(bounds), with: .color(.placeholderText))
        }
    }

    private func drawShadow(layout: Text.Layout, in context: inout GraphicsContext) {
        context.drawLayer { sc in
            sc.addFilter(.blur(radius: Shadow.blur))
            sc.addFilter(.colorMultiply(Shadow.color))
            sc.translateBy(x: Shadow.dx, y: Shadow.dy)
            for line in layout { sc.draw(line) }
        }
    }

    private func drawFill(layout: Text.Layout, bounds: CGRect, in context: inout GraphicsContext) {
        context.drawLayer { gc in
            // Clip to the glyph shapes so the fill covers only the text interior
            gc.clipToLayer { mc in
                for line in layout { mc.draw(line) }
            }
            gc.fill(Path(bounds), with: .color(Self.fillColor))
        }
    }

    private func drawBorder(layout: Text.Layout, bounds: CGRect, in context: inout GraphicsContext) {
        context.drawLayer { gc in
            // Build an outer stroke mask by rendering each glyph shifted 1px
            // in 8 directions, then punching out the original shape — leaving
            // only the 1px fringe around each glyph edge.
            gc.clipToLayer { maskContext in
                for (dx, dy) in Self.borderOffsets {
                    var ec = maskContext
                    ec.translateBy(x: dx, y: dy)
                    for line in layout { ec.draw(line) }
                }
                // Erase the fill area — only the border fringe remains
                maskContext.blendMode = .destinationOut
                for line in layout { maskContext.draw(line) }
            }
            gc.withCGContext { ctx in
                drawVerticalGradient(
                    in: ctx,
                    colors: Self.borderColors,
                    locations: Self.borderLocations,
                    bounds: bounds
                )
            }
        }
    }

    // MARK: - Helpers

    private func drawVerticalGradient(
        in ctx: CGContext,
        colors: [CGColor],
        locations: [CGFloat],
        bounds: CGRect
    ) {
        guard let gradient = CGGradient(
            colorsSpace: Self.colorSpace,
            colors: colors as CFArray,
            locations: locations
        ) else { return }

        ctx.drawLinearGradient(
            gradient,
            start: CGPoint(x: bounds.midX, y: bounds.minY),
            end: CGPoint(x: bounds.midX, y: bounds.maxY),
            options: [.drawsBeforeStartLocation, .drawsAfterEndLocation]
        )
    }
}

// MARK: - View Extension

extension View {
    func embossed(isEmpty: Bool = false) -> some View {
        textRenderer(EmbossedTextRenderer(isEmpty: isEmpty))
    }
}
