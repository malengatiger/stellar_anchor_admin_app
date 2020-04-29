import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:stellar_anchor_admin_app/ui/mobile/mobile_agent_editor.dart';
import 'package:stellar_anchor_library/models/agent.dart';
import 'package:stellar_anchor_library/util/functions.dart';

class AgentEditor extends StatefulWidget {
  final Agent agent;

  const AgentEditor({Key key, this.agent}) : super(key: key);
  @override
  _AgentEditorState createState() => _AgentEditorState();
}

class _AgentEditorState extends State<AgentEditor> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Agent Editor',
                style: Styles.whiteSmall,
              ),
              backgroundColor: Colors.brown[100],
              bottom: PreferredSize(
                  child: Column(
                    children: <Widget>[
                      Text(
                        widget.agent == null
                            ? ''
                            : widget.agent.personalKYCFields.getFullName(),
                        style: Styles.blackBoldMedium,
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                  preferredSize: Size.fromHeight(60)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ScreenTypeLayout(
                mobile: AgentEditorMobile(agent: widget.agent),
              ),
            )));
  }
}
