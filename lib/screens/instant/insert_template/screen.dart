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
    items = widget.items.map((item) => item.copyWith(position: Offset(item.position.dx, item.position.dy - (screenSize.height * 0.26)))).toList();
    selectedTemplate = templates.first;
    template();
    super.initState();
  }

  template() {
    var itemsWithNewPositions = <EditItem>[];
    var template = templates.firstWhere((cTemplate) => cTemplate == selectedTemplate);
    if (template == templates.last) {
      template = template.copyWith(position: Offset(((screenSize.width / 2) - (screenSize.width * 0.85) / 2), items.first.position.dy - (screenSize.height * 0.26)));
    }
    items = widget.items.map((item) => item.copyWith(position: Offset(template.position!.dx, item.type == EditItemType.button ? template.position!.dy - screenSize.height * 0.02 : template.position!.dy), textAlign: template.textAlign)).toList();
    if (items.length >= 2) {
      for (var i = 0; i < items.length; i++) {
        itemsWithNewPositions.add(items[i]);
        for (var i = 0; i <= itemsWithNewPositions.length - 1; i++) {
          if (i + 1 <= itemsWithNewPositions.length - 1) {
            var dy = (itemsWithNewPositions[i].position.dy - itemsWithNewPositions[i + 1].size!.height) - 5;
            itemsWithNewPositions[i] = itemsWithNewPositions[i].copyWith(position: Offset(itemsWithNewPositions[i].position.dx, dy));
          }
        }
      }
      items = itemsWithNewPositions;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
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
                              return Stack(
                                children: items
                                    .map(
                                      (item) => Positioned(
                                        top: item.position.dy,
                                        left: item.position.dx,
                                        child: item.type == EditItemType.text
                                            ? SizedBox(
                                                width: constraints.maxWidth * 0.8,
                                                child: Text(
                                                  item.text!,
                                                  textAlign: item.textAlign,
                                                  style: TextStyle(fontSize: item.fontSize, color: item.color, fontFamily: item.fontFamily, backgroundColor: item.isTextBackgroundEnabled == true ? Colors.white : Colors.transparent),
                                                ),
                                              )
                                            : CButton(
                                                enabled: false,
                                                color: item.color!,
                                                fontFamily: item.fontFamily!,
                                                selectedShapeIndex: item.selectedButtonShapeIndex!,
                                                buttonText: item.text!,
                                                fontSize: item.fontSize!,
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
            onTap: () => Navigator.pop(context, items.map((item) => item.copyWith(position: Offset(item.position.dx, item.position.dy + (screenSize.height * 0.15)))).toList()),
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
    );
  }
}
