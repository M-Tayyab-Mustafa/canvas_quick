/// HSV(HSB)/HSL Color Picker example
///
/// You can create your own layout by importing `picker.dart`.

library hsv_picker;

import 'package:flutter/material.dart';
import 'palette.dart';
import 'utils.dart';

/// The default layout of Color Picker.
class ColorPicker extends StatefulWidget {
  const ColorPicker({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.pickerHsvColor,
    this.onHsvColorChanged,
    this.paletteType = PaletteType.hsvWithHue,
    this.displayThumbColor = false,
    this.portraitOnly = false,
    this.colorPickerWidth = 300.0,
    this.pickerAreaHeightPercent = 1.0,
    this.pickerAreaBorderRadius = const BorderRadius.all(Radius.zero),
    this.hexInputController,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final HSVColor? pickerHsvColor;
  final ValueChanged<HSVColor>? onHsvColorChanged;
  final PaletteType paletteType;
  final bool displayThumbColor;
  final bool portraitOnly;
  final double colorPickerWidth;
  final double pickerAreaHeightPercent;
  final BorderRadius pickerAreaBorderRadius;
  final TextEditingController? hexInputController;

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  HSVColor currentHsvColor = const HSVColor.fromAHSV(0.0, 0.0, 0.0, 0.0);
  List<Color> colorHistory = [];

  @override
  void initState() {
    currentHsvColor = (widget.pickerHsvColor != null) ? widget.pickerHsvColor as HSVColor : HSVColor.fromColor(widget.pickerColor);
    // If there's no initial text in `hexInputController`,
    if (widget.hexInputController?.text.isEmpty == true) {
      // set it to the current's color HEX value.
      widget.hexInputController?.text = colorToHex(
        currentHsvColor.toColor(),
      );
    }
    // Listen to the text input, If there is an `hexInputController` provided.

    super.initState();
  }

  @override
  void didUpdateWidget(ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentHsvColor = (widget.pickerHsvColor != null) ? widget.pickerHsvColor as HSVColor : HSVColor.fromColor(widget.pickerColor);
  }

  void colorPickerTextInputListener() {
    // It can't be null really, since it's only listening if the controller
    // is provided, but it may help to calm the Dart analyzer in the future.
    if (widget.hexInputController == null) return;
    // If a user is inserting/typing any text — try to get the color value from it,
    // and interpret its transparency, dependent on the widget's settings.
    final Color? color = colorFromHex(widget.hexInputController!.text);
    // If it's the valid color:
    if (color != null) {
      // set it as the current color and
      setState(() => currentHsvColor = HSVColor.fromColor(color));
      // notify with a callback.
      widget.onColorChanged(color);
      if (widget.onHsvColorChanged != null) widget.onHsvColorChanged!(currentHsvColor);
    }
  }

  @override
  void dispose() {
    widget.hexInputController?.removeListener(colorPickerTextInputListener);
    super.dispose();
  }

  Widget colorPickerSlider(TrackType trackType) {
    return ColorPickerSlider(
      trackType,
      currentHsvColor,
      (HSVColor color) {
        // Update text in `hexInputController` if provided.
        widget.hexInputController?.text = colorToHex(color.toColor());
        setState(() => currentHsvColor = color);
        widget.onColorChanged(currentHsvColor.toColor());
        if (widget.onHsvColorChanged != null) widget.onHsvColorChanged!(currentHsvColor);
      },
      displayThumbColor: widget.displayThumbColor,
    );
  }

  void onColorChanging(HSVColor color) {
    widget.hexInputController?.text = colorToHex(color.toColor());
    setState(() => currentHsvColor = color);
    widget.onColorChanged(currentHsvColor.toColor());
    if (widget.onHsvColorChanged != null) widget.onHsvColorChanged!(currentHsvColor);
  }

  Widget colorPicker() {
    return ClipRRect(
      borderRadius: widget.pickerAreaBorderRadius,
      child: Padding(
        padding: EdgeInsets.all(widget.paletteType == PaletteType.hueWheel ? 10 : 0),
        child: ColorPickerArea(currentHsvColor, onColorChanging, widget.paletteType),
      ),
    );
  }

  Widget sliderByPaletteType() {
    switch (widget.paletteType) {
      case PaletteType.hsv:
      case PaletteType.hsvWithHue:
      case PaletteType.hsl:
      case PaletteType.hslWithHue:
        return colorPickerSlider(TrackType.hue);
      case PaletteType.hsvWithValue:
      case PaletteType.hueWheel:
        return colorPickerSlider(TrackType.value);
      case PaletteType.hsvWithSaturation:
        return colorPickerSlider(TrackType.saturation);
      case PaletteType.hslWithLightness:
        return colorPickerSlider(TrackType.lightness);
      case PaletteType.hslWithSaturation:
        return colorPickerSlider(TrackType.saturationForHSL);
      case PaletteType.rgbWithBlue:
        return colorPickerSlider(TrackType.blue);
      case PaletteType.rgbWithGreen:
        return colorPickerSlider(TrackType.green);
      case PaletteType.rgbWithRed:
        return colorPickerSlider(TrackType.red);
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: widget.colorPickerWidth,
          height: widget.colorPickerWidth * widget.pickerAreaHeightPercent,
          child: colorPicker(),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 5.0, 10.0, 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => setState(() {}),
                child: ColorIndicator(currentHsvColor),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 40.0, width: widget.colorPickerWidth - 75.0, child: sliderByPaletteType()),
                    SizedBox(
                      height: 40.0,
                      width: widget.colorPickerWidth - 75.0,
                      child: colorPickerSlider(TrackType.alpha),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ColorPickerInput(
          currentHsvColor.toColor(),
          (Color color) {
            setState(() => currentHsvColor = HSVColor.fromColor(color));
            widget.onColorChanged(currentHsvColor.toColor());
            if (widget.onHsvColorChanged != null) widget.onHsvColorChanged!(currentHsvColor);
          },
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
