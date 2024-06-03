import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../../_core/http.dart';

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
              kakaoLogin();
            },
            child: Text("카카오 로그인"),
          )
        ],
      ),
    );
  }
}

void kakaoLogin() async{
  try {
    // 1. 크리덴셜 로그인 - 토근 받기
    OAuthToken token = await UserApi.instance
        .loginWithKakaoAccount();
    // qRR-UeowO-LEp0_KXAGH41vyG64QiCkJAAAAAQopyV8AAAGP3Jb1gxamEcnPBcmr
    print('카카오톡으로 로그인 성공 ${token.accessToken}');

    // 2. 토큰(카카오)을 스프링 서버에 전달하기 (스프링 서버에게 나 인증했어! 라고 알려주는 과졍)
    final response = await dio.get("/oauth/callback", queryParameters: {"accessToken":token.accessToken});

    // 3. 토큰(스프링 서버) 응답 받기
    final blogAccessToken = response.headers["Authorization"]!.first;
    print("blogAccessToken : ${blogAccessToken}");


    // 4. 시큐어 스토리지에 저장
    secureStorage.write(key: blogAccessToken, value: blogAccessToken);
  } catch (error) {
    print('카카오톡으로 로그인 실패 $error');
  }
}