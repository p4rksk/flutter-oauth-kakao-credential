import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("카카오 로그인")),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              try {
                OAuthToken token = await UserApi.instance
                    .loginWithKakaoAccount();
                print('카카오톡으로 로그인 성공 ${token.accessToken}');
              } catch (error) {
                print('카카오톡으로 로그인 실패 $error');
              }
            },
            child: Text("카카오 로그인"),
          )
        ],
      ),
    );
  }
}