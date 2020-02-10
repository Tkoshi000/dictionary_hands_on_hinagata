import 'package:flutter/material.dart';
//////////////////////////////////////////////
//①firestoreインポート
import 'package:cloud_firestore/cloud_firestore.dart';
//////////////////////////////////////////////
//①Form用の構造体を用意
class FormData {
  //typeの初期値
  String type = "en";
  String word = "";
}

class InputForm extends StatefulWidget {
  InputForm();

  @override
  MyInputFormState createState() => MyInputFormState();
}

class MyInputFormState extends State<InputForm> {
  //////////////////////////////////////////////
  //②firestore用にリファレンス用意
  DocumentReference mainReference =
  Firestore.instance.collection('dictionary').document();
  //③form用のkeyを用意
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  //////////////////////////////////////////////

  FormData data = FormData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ワード登録'),

//////////////////////////////////////////////
        //②保存用のボタンを設定
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              //本来保存処理が入るはずだが今はまだ画面を閉じる機能だけ
              //////////////////////////////////////////////
              //④保存時処理
              //validate＆save(テキストフィールドのsave処理が走る)＆firestore保存処理
              if (formKey.currentState.validate()) {
                formKey.currentState.save();
                mainReference.setData(
                  {
                    'type': data.type,
                    'word': data.word,
                    'created_at': DateTime.now(),
                  },
                );
                Navigator.pop(context);
//////////////////////////////////////////////

              }
            },
          ),
        ],
//////////////////////////////////////////////

      ),
      //////////////////////////////////////////////
      //③Formを設定
      body: SafeArea(//デバイスごとの依存吸収
        child: Form(
          //////////////////////////////////////////////
          //⑤formにkey設定
          key: formKey,
//////////////////////////////////////////////
          //////////////////////////////////////////////
          //④Formは複数ウィジェットの組み合わせなのでListViewを利用
          child: ListView(
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              //////////////////////////////////////////////
              //⑤英和用Radioボタン
              RadioListTile(
                value: "en",
                //data構造体を利用して和英と状態を共有
                groupValue: data.type,
                //ラジオボタン横に表示されるテキスト
                title: Text("英和"),
                onChanged: (String value) {
                  //変更時のイベント挙動
                  setState(
                        () {
                      //構造体のtypeの値をvalue(en)に設定
                      data.type = value;
                    },
                  );
                },
              ),
              //⑥和英用Radioボタン
              RadioListTile(
                value: "ja",
                groupValue: data.type,
                title: Text("和英"),
                onChanged: (String value) {
                  setState(
                        () {
                      data.type = value;
                    },
                  );
                },
              ),
//////////////////////////////////////////////
              //////////////////////////////////////////////
              //⑦ワード入力用テキストフィールド
              TextFormField(
                //テキストフィールドのデコレーション
                decoration: InputDecoration(
                  icon: Icon(Icons.library_books),
                  hintText: 'ワード',
                  labelText: 'word',
                ),
                //保存時のイベント挙動
                onSaved: (String value) {
                  setState(
                        () {
                      data.word = value;
                    },
                  );
                },
                //バリデーション時の挙動
                validator: (value) {
                  if (value.isEmpty) {
                    return 'ワードは必須入力項目です';
                  }
                  //バリデーションクリアのときはreturn nullしないとワーニング
                  return null;
                },
                initialValue: data.word,
              ),
//////////////////////////////////////////////
            ],
          ),
//////////////////////////////////////////////
        ),
      ),
//////////////////////////////////////////////
    );
  }
}