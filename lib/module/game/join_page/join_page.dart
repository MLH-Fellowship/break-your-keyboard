import 'package:flutter/material.dart';

import '../../../core/dependency_injection/setup_locator.dart';
import '../../../core/service/api/database_i.dart';
import '../../../core/service/router/router_i.dart';
import '../../../core/service/utils/misc.dart';
import '../../../presentation/buttons/button_bordered.dart';
import '../../../presentation/buttons/full_color_blue_button.dart';
import '../../../presentation/dimensions.dart';
import '../../../presentation/inputs/text_field_outlined.dart';
import '../../../presentation/text_styles.dart';

class JoinPage extends StatefulWidget {
  static const route = 'join_page';

  const JoinPage({Key key}) : super(key: key);

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final _joinCodeController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _isJoinLoading = false;

  @override
  void dispose() {
    super.dispose();
    _joinCodeController.dispose();
    _nicknameController.dispose();
  }

  void goBack() {
    getIts<RouterI>().pop();
  }

  void setLoading(bool value) {
    setState(() {
      _isJoinLoading = value;
    });
  }

  Future<void> joinGame(BuildContext ctx) async {
    setLoading(true);
    final joinCode = _joinCodeController.text;

    if (joinCode == '') {
      Misc.showSnackbar(ctx, 'Provide a join code!');
      setLoading(true);
      return;
    }
    final roomExists = await getIts<DatabaseI>().roomExists(joinCode);
    setLoading(false);
    if (!roomExists) {
      Scaffold.of(ctx).showSnackBar(const SnackBar(
        content: Text('Room does not exist!'),
      ));
      return;
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (ctx) => Padding(
          padding: AppDimensions.allPagePadding,
          child: Center(
            child: Column(
              mainAxisAlignment: AppDimensions.containerMainAxisAlignment,
              children: [
                const Text(
                  'JOIN A GAME',
                  style: AppTextStyles.headerTextStyle,
                ),
                const SizedBox(height: 150),
                TextFieldOutlined(
                  hintText: 'Nickname',
                  controller: _nicknameController,
                ),
                const SizedBox(height: 15),
                TextFieldOutlined(
                  hintText: 'Join code',
                  controller: _joinCodeController,
                ),
                const SizedBox(height: 35),
                FullColorBlueButton(
                    onClick: () async => joinGame(ctx),
                    isEnable: !_isJoinLoading,
                    buttonLabel: _isJoinLoading ? 'Loading...' : 'Join'),
                const SizedBox(height: 15),
                BorderedButton(onClick: goBack, buttonLabel: 'Back'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
