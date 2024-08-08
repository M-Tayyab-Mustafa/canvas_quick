import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../model/editing_item.dart';
import '../../../model/template.dart';
import '../../../utils/constants.dart';

class InsertTemplate extends StatefulWidget {
  const InsertTemplate({super.key, this.imageFile, this.backgroundColor, required this.items});
  final File? imageFile;
  final Color? backgroundColor;
  final List<EditItem> items;

  @override
  State<InsertTemplate> createState() => _InsertTemplateState();
}

class _InsertTemplateState extends State<InsertTemplate> {
  late CTemplate selectedTemplate;
  late List<EditItem> items;

  @override
  void initState() {
    items = widget.items;
    selectedTemplate = templates.first;
    for (var item in items) {
      selectedTemplate == templates.first ? item.textAlign = TextAlign.left : item.textAlign = TextAlign.center;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: widget.backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(color: Color.fromARGB(255, 117, 117, 117), blurRadius: 4, offset: Offset(4, 4)),
                      ],
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Stack(
                          children: [
                            if (widget.imageFile != null)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  widget.imageFile!,
                                  fit: BoxFit.fill,
                                  height: constraints.maxHeight,
                                  width: constraints.maxWidth,
                                ),
                              ),
                            Align(
                              alignment: selectedTemplate == templates.first ? Alignment.bottomLeft : Alignment.center,
                              child: SingleChildScrollView(
                                child: SizedBox(
                                  width: constraints.maxWidth,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: selectedTemplate == templates.first ? MainAxisAlignment.end : MainAxisAlignment.center,
                                    crossAxisAlignment: selectedTemplate == templates.first ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                                    children: items
                                        .map(
                                          (item) => item.type == EditItemType.text
                                              ? Padding(
                                                  padding: const EdgeInsets.only(left: 5, bottom: 5),
                                                  child: SizedBox(
                                                    width: item.fontSize * item.text.length > constraints.maxWidth * 0.9
                                                        ? constraints.maxWidth * 0.9
                                                        : item.size!.width > constraints.maxWidth * 0.9
                                                            ? constraints.maxWidth * 0.9
                                                            : null,
                                                    child: Text(
                                                      key: item.key,
                                                      item.text,
                                                      textAlign: item.textAlign,
                                                      style: TextStyle(fontSize: item.fontSize, color: item.textColor, fontFamily: item.fontFamily, backgroundColor: item.textBackgroundColorIndex != null ? materialColors[item.textBackgroundColorIndex!] : Colors.transparent, height: 0.9),
                                                    ),
                                                  ),
                                                )
                                              : Padding(
                                                  padding: const EdgeInsets.only(bottom: 5),
                                                  child: CButton(
                                                    key: item.key,
                                                    enabled: false,
                                                    backgroundColor: item.backgroundColor!,
                                                    textColor: item.textColor!,
                                                    fontFamily: item.fontFamily,
                                                    selectedShapeIndex: item.selectedButtonShapeIndex!,
                                                    buttonText: item.text,
                                                    fontSize: item.fontSize,
                                                    controller: TextEditingController(text: item.text),
                                                  ),
                                                ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              SizedBox(
                height: screenSize.height * 0.22,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: templates.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTemplate = templates[index];
                          });
                          for (var item in items) {
                            selectedTemplate == templates.first ? item.textAlign = TextAlign.left : item.textAlign = TextAlign.center;
                          }
                        },
                        child: Column(
                          children: [
                            Text(
                              templates[index].name,
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFCECECE),
                                  border: Border.all(color: templates[index] == selectedTemplate ? const Color(0xFF919191) : const Color(0xFF27262A), width: 15),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.all(5),
                                width: 120,
                                child: Align(
                                  alignment: templates[index].alignment,
                                  child: SvgPicture.asset('assets/icons/template.svg'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
              GestureDetector(
                onTap: () {
                  double centerX = screenSize.width * 0.5;
                  items = items.reversed.toList();
                  var updatedList = <EditItem>[];
                  //* Calculating Size of the Widgets
                  for (var i = 0; i < items.length; i++) {
                    if (items[i].type == EditItemType.button) {
                      final RenderBox? renderBox = items[i].key.currentContext?.findRenderObject() as RenderBox?;
                      if (renderBox != null) {
                        items[i] = items[i].copyWith(size: Size(renderBox.size.width, renderBox.size.height + 5));
                      }
                    } else {
                      var textSize = calculateTextSize(items[i].text, TextStyle(fontSize: items[i].fontSize, color: items[i].textColor, fontFamily: items[i].fontFamily, backgroundColor: items[i].textBackgroundColorIndex != null ? materialColors[items[i].textBackgroundColorIndex!] : Colors.transparent, height: 0.9));
                      items[i] = items[i].copyWith(size: Size(textSize.width, textSize.height + 5));
                      if (items[i].fontSize * items[i].text.length > screenSize.width * 0.8) {
                        final RenderBox? renderBox = items[i].key.currentContext?.findRenderObject() as RenderBox?;
                        items[i] = items[i].copyWith(size: Size(items[i].size!.width, renderBox!.size.height));
                      }
                    }
                  }

                  //* Alignment Of the Widgets
                  if (selectedTemplate == templates.first) {
                    double dy = editingHeight - 40;
                    for (var i = 0; i < items.length; i++) {
                      updatedList.add(items[i].copyWith(position: Offset(screenSize.width * 0.03, dy - items[i].size!.height), textAlign: TextAlign.left));
                      dy -= items[i].size!.height + 6;
                    }
                  } else {
                    double totalWidgetHeight = 0.0;
                    for (var i = 0; i < items.length; i++) {
                      totalWidgetHeight += items[i].size!.height;
                    }
                    double dy = (editingHeight - 40);
                    for (var i = 0; i < items.length; i++) {
                      double dx = centerX - (items[i].size!.width * 0.5);
                      if (items[i].type == EditItemType.text && items[i].size!.width > screenSize.width * 0.8) {
                        dx = ((screenSize.width * 0.8) * 0.8) - (items[i].size!.width * 0.5);
                      }
                      if (items[i].type == EditItemType.text && items[i].fontSize * items[i].text.length > screenSize.width * 0.8) {
                        dx = centerX - screenSize.width * 0.8 * 0.5;
                      }
                      updatedList.add(items[i].copyWith(position: Offset(dx, dy - items[i].size!.height), textAlign: TextAlign.center));
                      dy -= items[i].size!.height + 6;
                    }

                    var centerList = <EditItem>[];
                    var remainingHeight = (editingHeight - 40) + totalWidgetHeight;
                    dy = remainingHeight * 0.5;
                    for (var index = 0; index < updatedList.length; index++) {
                      centerList.add(updatedList[index].copyWith(position: Offset(updatedList[index].position.dx, dy - updatedList[index].size!.height), textAlign: TextAlign.center));
                      dy -= updatedList[index].size!.height + 6;
                    }
                    updatedList = centerList;
                  }
                  Navigator.pop(context, updatedList.reversed.toList());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: const Color(0xff622CEA),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: screenSize.width * 0.9,
                  child: Center(
                    child: Text(
                      'Select Template',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: const Alignment(-0.955, -0.87),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SvgPicture.asset(
                  'assets/icons/cancel.svg',
                  height: 40,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
