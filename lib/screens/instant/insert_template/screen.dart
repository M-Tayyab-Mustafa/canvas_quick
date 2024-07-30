import 'dart:developer';
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
    items = widget.items.map((item) => item.copyWith(position: Offset(item.position.dx, item.position.dy - (screenSize.height * 0.3)))).toList();
    selectedTemplate = templates.first;
    template();
    super.initState();
  }

  template() {
    setState(() {
      var height = (screenSize.height - (screenSize.height * 0.3));
      for (var item in items) {
        item.position = Offset(item.position.dx, height);
        selectedTemplate == templates.first ? item.textAlign = TextAlign.left : item.textAlign = TextAlign.center;
      }
    });
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
                            SizedBox(
                              width: screenSize.width - 20,
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Column(
                                    mainAxisAlignment: selectedTemplate == templates.first ? MainAxisAlignment.end : MainAxisAlignment.center,
                                    crossAxisAlignment: selectedTemplate == templates.first ? CrossAxisAlignment.start : CrossAxisAlignment.center,
                                    children: items
                                        .map(
                                          (item) => item.type == EditItemType.text
                                              ? Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Text(
                                                    key: item.key,
                                                    item.text,
                                                    textAlign: item.textAlign,
                                                    style: TextStyle(fontSize: item.fontSize, color: item.color, fontFamily: item.fontFamily, backgroundColor: item.textBackgroundColorIndex != null ? materialColors[item.textBackgroundColorIndex!] : Colors.transparent),
                                                  ),
                                                )
                                              : SizedBox(
                                                  key: item.key,
                                                  width: constraints.maxWidth * 0.65,
                                                  child: CButton(
                                                    enabled: false,
                                                    color: item.color!,
                                                    fontFamily: item.fontFamily,
                                                    selectedShapeIndex: item.selectedButtonShapeIndex!,
                                                    buttonText: item.text,
                                                    fontSize: item.fontSize,
                                                    controller: TextEditingController(text: item.text),
                                                  ),
                                                ),
                                        )
                                        .toList(),
                                  );
                                },
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
                          selectedTemplate = templates[index];
                          template();
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
                  double screenWidth = screenSize.width;
                  double centerX = screenWidth / 2;
                  var totalWidgetHeight = 0.0;
                  var updatedList = <EditItem>[];
                  for (var i = 0; i < items.length; i++) {
                    final RenderBox? renderBox = items[i].key.currentContext?.findRenderObject() as RenderBox?;
                    if (renderBox != null) {
                      totalWidgetHeight += renderBox.size.height;
                    }
                  }
                  if (selectedTemplate == templates.first) {
                    double currentHeight = (screenSize.height * 0.8) - totalWidgetHeight;
                    for (var i = 0; i < items.length; i++) {
                      final RenderBox? renderBox = items[i].key.currentContext?.findRenderObject() as RenderBox?;
                      if (renderBox != null) {
                        double itemHeight = renderBox.size.height;
                        updatedList = updatedList.map((item) => item.copyWith(position: Offset(0, item.position.dy - itemHeight))).toList();
                        updatedList.add(items[i].copyWith(position: Offset(0, currentHeight), textAlign: TextAlign.left));
                        currentHeight += itemHeight;
                      }
                    }
                  } else {
                    double remainingHeight = (screenSize.height * 0.8) - totalWidgetHeight;
                    double currentHeight = (screenSize.height * 0.8) - (remainingHeight * 0.6);
                    for (var i = 0; i < items.length; i++) {
                      final RenderBox? renderBox = items[i].key.currentContext?.findRenderObject() as RenderBox?;
                      if (renderBox != null) {
                        double itemHeight = renderBox.size.height;
                        updatedList.add(items[i].copyWith(position: Offset(centerX - renderBox.size.width / 2, currentHeight), textAlign: TextAlign.center));
                        log('Item $i height: $itemHeight :: Current Height: $currentHeight');
                        updatedList = updatedList.map((item) => item.copyWith(position: Offset(item.position.dx, item.position.dy - itemHeight * 0.5))).toList();
                        currentHeight += itemHeight;
                      }
                    }
                  }

                  /*
                 
                   */
                  Navigator.pop(context, updatedList);
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
            alignment: const Alignment(-0.95, -0.88),
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
