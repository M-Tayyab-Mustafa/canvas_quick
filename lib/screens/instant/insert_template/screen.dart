import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../model/editing_item.dart';
import '../../../model/template.dart';
import '../../../utils/constants.dart';

class InsertTemplate extends StatefulWidget {
  const InsertTemplate({super.key, this.imageFile, this.backgroundColor, required this.items, this.cTemplate});
  final File? imageFile;
  final Color? backgroundColor;
  final List<EditItem> items;
  final CTemplate? cTemplate;

  @override
  State<InsertTemplate> createState() => _InsertTemplateState();
}

class _InsertTemplateState extends State<InsertTemplate> {
  CTemplate? selectedTemplate;
  List<CTemplate> templates = [
    CTemplate(alignment: Alignment.bottomLeft, textAlign: TextAlign.left, name: 'Vermont'),
    CTemplate(alignment: Alignment.center, textAlign: TextAlign.center, name: 'Minimalist'),
  ];
  @override
  void initState() {
    selectedTemplate = widget.cTemplate ?? templates.first;
    super.initState();
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
                        if (selectedTemplate != null)
                          EditItemsWithTemplate(items: widget.items, cTemplate: selectedTemplate!)
                        else
                          SizedBox(
                            width: screenSize.width,
                            child: EditItemsWithOutTemplate(items: widget.items),
                          ),
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
                      setState(() {});
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
            onTap: () => Navigator.pop(context, selectedTemplate),
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
