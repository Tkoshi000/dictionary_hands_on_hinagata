import 'package:flutter/material.dart';
//⑤dictionaryをインポートする
import '../UI/dictionary.dart';

class DrawerMenu extends StatelessWidget {
  @override
  build(BuildContext context) {
    //①Drawerを生成
    return Drawer(
      //②メニューが複数個になったことを考えてListViewで作成
      child: ListView(
        //childrenはWidget型の配列
        children: <Widget>[

//////////////////////////////////////////////
          //③Userアカウント
          //マジックストリングスはよしなに変更可能
          UserAccountsDrawerHeader(
            accountName: Text('お問い合わせは以下まで'),
            accountEmail: Text('freelancer@y-onishi.net'),
          ),
//////////////////////////////////////////////
//////////////////////////////////////////////
          //④メニュー用のリストタイル
          //マジックストリングスはよしなに変更可能
          ListTile(
            title: Text('ワード一覧'),
            //////////////////////////////////////////////
            //⑤Tapイベント時の挙動
            onTap: () {
              //画面遷移の設定
              Navigator.push(
                context,//flutter どの画面に移動したか持っている
                MaterialPageRoute(
                  builder: (BuildContext context) => Dictionary(),
                ),
              );
            },
//////////////////////////////////////////////
          ),
//////////////////////////////////////////////
        ],
      ),
    );
  }
}