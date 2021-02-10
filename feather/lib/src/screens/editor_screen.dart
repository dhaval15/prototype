import 'package:feather/src/framework/framework.dart';
import 'package:feather/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:extras/extras.dart';

class EditorScreen extends StatelessWidget {
  final Color backgroundColor;
  final ContainerBox box = ContainerBox();

  EditorScreen({Key key, this.backgroundColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = this.backgroundColor ?? context.canvas;
    return EditContextProvider(
      key: key,
      child: BoxRenderView(
        box: box,
        builder: (context, viewStream, editorStream) => PrototypeScaffold(
          backgroundColor: backgroundColor,
          title: 'Feather',
          tree: SizedBox(
            width: 240,
            height: context.height,
            child: TreeView(box: box),
          ),
          view: ViewContainer(
            actions: [
              ActionWidget(
                icon: Icons.fullscreen,
                onTap: () {
                  Guideline.toggle();
                },
              ),
              ActionWidget(
                icon: Icons.code,
                onTap: () {
                  final code = Framework.generateCode(box);
                  showDialog(
                    context: context,
                    builder: (context) => FancyDialog(
                      title: 'Code',
                      children: [
                        Text(code),
                      ],
                    ),
                  );
                },
              ),
            ],
            child: StreamBuilder<Widget>(
              stream: viewStream,
              initialData: CircularProgressIndicator().center(),
              builder: (context, snapshot) => Center(child: snapshot.data),
            ),
          ).expand(),
          editor: Container(
            width: 400,
            height: context.height,
            child: StreamBuilder<Widget>(
              stream: editorStream,
              initialData: CircularProgressIndicator().center(),
              builder: (context, snapshot) => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        onTap: () {
                          EditContext.of(context).back();
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                      Text('Properties', style: context.subtitle1),
                      ActionWidget(
                        icon: Icons.add,
                        onTap: () {
                          EditContext.of(context).showAddPropsDialog(context);
                        },
                      ),
                    ],
                  ).padding(all: 8),
                  snapshot.data.padding(all: 16).expand(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
