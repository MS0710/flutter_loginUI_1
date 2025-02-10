import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginSample(),
    );
  }
}

class LoginSample extends StatefulWidget{
  const LoginSample({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginSample();
  }

}

class _LoginSample extends State<LoginSample>{

  final GlobalKey _formKey = GlobalKey<FormState>();
  late String _email, _password;
  bool _isObscure = true;
  Color _eyeColor = Colors.grey;

  final List _loginMethod = [
    {
      "title": "facebook",
      "icon": Icons.facebook,
    },
    {
      "title": "google",
      "icon": Icons.fiber_dvr,
    },
    {
      "title": "twitter",
      "icon": Icons.account_balance,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    const title = Padding(
        padding: EdgeInsets.all(8.0),
      child: Text("Login",style: TextStyle(fontSize: 42.0),),
    );

    var titleUnderline = Padding(
        padding: const EdgeInsets.only(left: 12.0, top: 4.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            color: Colors.black,
            width: 40,
            height: 2,
          ),
        ));

    var userNameTextField = TextFormField(
      decoration: const InputDecoration(
        labelText: 'Email Address',
          prefixIcon: Icon(Icons.lock),
      ),
      validator: (v){
        var emailReg = RegExp(
            r"[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?");

        if(!emailReg.hasMatch(v!)){
          return '请输入正確的信箱地址';
        }
      },
      onSaved: (v) => _email = v!,
    );

    var passwordTextField = TextFormField(
      obscureText: _isObscure,
      decoration:  InputDecoration(
        labelText: 'Password',
        prefixIcon: const Icon(Icons.email),
        suffixIcon: IconButton(
          onPressed: (){
            setState(() {
              _isObscure = !_isObscure;
              _eyeColor = (_isObscure
                  ? Colors.grey
                  : Theme.of(context).iconTheme.color)!;
            });
          },
          icon: Icon(
            Icons.email,
            color: _eyeColor,),
        ),
      ),
      validator: (v){
        if(v!.isEmpty){
          return '请输入密碼';
        }
      },
      onSaved: (v) => _password = v!,
    );

    var btn_forgetPwd = Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {  },
        child: const Text("忘記密碼?",style: TextStyle(color: Colors.black,),)
      ),
    );

    var btn_login = Align(
      child: SizedBox(
        width: 270,
        height: 45,
        child: ElevatedButton(
          onPressed: () {
            if((_formKey.currentState as FormState).validate()){
              (_formKey.currentState as FormState).save();
              print("email = "+_email);
              print("password = "+_password);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("email = $_email"),
                      Text("password = $_password"),
                    ],
                  ),
                  action: SnackBarAction(
                    label: '取消',
                    onPressed: () {  },
                  ),
                ),
              );
            }
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all(const StadiumBorder(
                  side: BorderSide(style: BorderStyle.none),),),
          ),
          child: const Text("登入",style: TextStyle(color: Colors.black)),
        ),
      ),
    );

    var txt_otherlogin = Container(
      alignment: Alignment.center,
        child: Text("其他帳號登入"),
    );

    var btn_buttonBar = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod.map((item) => Builder(builder: (context){
        return IconButton(
            onPressed: (){
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(item['title']+"登入"),
                    action: SnackBarAction(
                      label: '取消',
                      onPressed: () {  },
                    ),
                  ),
              );
            },
            icon: Icon(item["icon"]),
        );
      })).toList(),
    );

    var txt_register = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("沒有帳號?"),
        TextButton(
            onPressed: (){
              print("點擊註冊");
            },
            child: const Text("點擊註冊"),
        ),
      ],
    );





    final widget = Scaffold(
      body: Form(
        /// 設置globalKey，用於獲取後面FormStat
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: <Widget>[
            ///距離頂部一個工具欄的高度
            const SizedBox(height: kToolbarHeight),
            ///標題
            title,
            titleUnderline,
            const SizedBox(height: 50.0,),
            ///輸入欄
            userNameTextField,
            const SizedBox(height: 30),
            passwordTextField,
            ///忘記密碼
            btn_forgetPwd,
            const SizedBox(height: 50),
            ///登入按鈕
            btn_login,
            const SizedBox(height: 30),
            ///其他登入
            txt_otherlogin,
            btn_buttonBar,
            txt_register,
          ],
        ),
      ),
    );
    return widget;
  }
}