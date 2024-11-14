import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:schedule/common/utils/logger_utils.dart';

import '../../../manager/onnx_manager.dart';
import '../../../manager/request_manager.dart';
import '../schedule_user_api.dart';

class ScheduleUserApiV2 {
  ScheduleUserApiV2._privateConstructor();

  static final ScheduleUserApiV2 _instance =
      ScheduleUserApiV2._privateConstructor();

  factory ScheduleUserApiV2() {
    return _instance;
  }

  // 网络管家
  final _request = RequestManager();
  // 验证码ocr
  final _ocr = OnnxManager();

  /// 获取验证码数据
  Future<String> getCaptcha() async {
    Random random = Random();
    double t = random.nextDouble();

    Options options =
        _request.cacheOptions.copyWith(policy: CachePolicy.noCache).toOptions();
    options.responseType = ResponseType.stream;
    return await _request
        .get("/verifycode.servlet?t=$t", options: options)
        .then((value) async {
      final stream = await (value.data as ResponseBody).stream.toList();
      final result = BytesBuilder();
      for (Uint8List subList in stream) {
        result.add(subList);
      }

      return await _ocr.recognizeImage(result.takeBytes());
    });
  }

  /// 登录api
  Future<ScheduleUserStatus> autoLoginEducationalSystem({
    required String userAccount,
    required String userPassword,
  }) async {
    Options options =
        _request.cacheOptions.copyWith(policy: CachePolicy.noCache).toOptions();
    options.followRedirects = false;
    options.validateStatus = (status) {
      return status! < 500;
    };
    options.contentType = "application/x-www-form-urlencoded";

    Map<String, dynamic> data = {
      "userAccount": userAccount,
      "userPassword": "",
      "loginMethod": "LoginToXk",
      "userlanguage": 0,
    };

    // base64加密
    String userAccountBase64 = base64Encode(utf8.encode(userAccount));
    String userPasswordBase64 = base64Encode(utf8.encode(userPassword));
    Response res = await _request
        .get(
      "http://jwxt.hut.edu.cn/jsxsd/",
      options: _request.cacheOptions
          .copyWith(policy: CachePolicy.noCache)
          .toOptions(),
    )
        .timeout(const Duration(seconds: 10), onTimeout: () {
      return Response(data: "", requestOptions: RequestOptions());
    });

    if(res.data == ""){
      return ScheduleUserStatus.fail;
    }

    String htmlStr = res.data;
    // 正则表达式匹配 scode = "()"; 中()内的数据
    String scode;
    RegExp regExp = RegExp(r'scode = "(.*?)";');
    Match? match = regExp.firstMatch(htmlStr);
    if (match != null) {
      scode = match.group(1)!;
    } else {
      return ScheduleUserStatus.fail;
    }

    String sxh;
    regExp = RegExp(r'sxh = "(.*?)";');
    match = regExp.firstMatch(htmlStr);
    if (match != null) {
      sxh = match.group(1)!;
      // logger.i(sxh);
    } else {
      return ScheduleUserStatus.fail;
    }
    var code = "$userAccountBase64%%%$userPasswordBase64";
    var encoded = "";
    for (var i = 0; i < code.length; i++) {
      if (i < 20) {
        encoded = encoded +
            code.substring(i, i + 1) +
            scode.substring(0, int.parse(sxh.substring(i, i + 1)));
        scode =
            scode.substring(int.parse(sxh.substring(i, i + 1)), scode.length);
      } else {
        encoded = encoded + code.substring(i, code.length);
        i = code.length;
      }
    }
    data["encoded"] = encoded;

    return await _request
        .post("/jsxsd/xk/LoginToXk", data: data, options: options)
        .then((value) {
      // logger.i(value.data);
      bool status = value.data == "";
      switch (status) {
        case true:
          return ScheduleUserStatus.success;
        case false:
          return ScheduleUserStatus.fail;
      }
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      return ScheduleUserStatus.loginTimeOut;
    });
  }

  /// 登录api
  Future<ScheduleUserStatus> loginEducationalSystem(
      {required String userAccount, required String userPassword}) async {
    Response res = await _request.get(
      "/",
      options: _request.cacheOptions
          .copyWith(policy: CachePolicy.noCache)
          .toOptions(),
    );

    res = await _request.post(
      "/Logon.do?method=logon&flag=sess",
      options: _request.cacheOptions
          .copyWith(policy: CachePolicy.noCache)
          .toOptions(),
    );

    String dataStr = res.data;
    var scode = dataStr.split("#")[0];
    var sxh = dataStr.split("#")[1];
    var code = "$userAccount%%%$userPassword";
    var encoded = "";
    for (var i = 0; i < code.length; i++) {
      if (i < 20) {
        encoded = encoded +
            code.substring(i, i + 1) +
            scode.substring(0, int.parse(sxh.substring(i, i + 1)));
        scode =
            scode.substring(int.parse(sxh.substring(i, i + 1)), scode.length);
      } else {
        encoded = encoded + code.substring(i, code.length);
        i = code.length;
      }
    }

    // 登录失败次数
    int failCount = 0;
    while (failCount < 5) {
      // 获取验证码
      String messageCode = await getCaptcha();
      Map<String, dynamic> params = {
        "userAccount": userAccount,
        "userlanguage": 0,
        "userPassword": "",
        "encoded": encoded,
        "loginMethod": "logon",
        "RANDOMCODE": messageCode,
      };

      Options options =
      _request.cacheOptions.copyWith(policy: CachePolicy.noCache).toOptions();
      options.validateStatus = (status) {
        return status! < 500;
      };
      options.followRedirects = false;
      options.contentType = "application/x-www-form-urlencoded";

      res = await _request.post("/Logon.do?method=logon",
          params: params, options: options);

      bool status = res.data == "";
      switch (status) {
        case true:
          String url = res.headers.value("location")!;
          url = url.split("/jsxsd")[1];
          url = "/jsxsd$url";
          res = await _request.get(url, options: options);
          url = res.headers.value("location")!;
          url = url.split("/jsxsd")[1];
          url = "/jsxsd$url";
          res = await _request.get(url, options: options);
          return ScheduleUserStatus.success;
        case false:
          failCount++;
      }
    }

    return ScheduleUserStatus.fail;
  }

  /// 获取个人信息
  Future<Map<String, dynamic>> userInfo({CachePolicy? cachePolicy}) async {
    Options options = _request.cacheOptions
        .copyWith(policy: cachePolicy ?? CachePolicy.refresh)
        .toOptions();

    return await _request
        .get("/jsxsd/framework/xsMainV_new.htmlx?t1=1", options: options)
        .then((value) async {
      Document document = parse(value.data);
      Element? userinfo =
          document.getElementsByClassName("qz-infoContent").firstOrNull;

      if (userinfo != null) {
        List<Element> infoListTitle =
            userinfo.getElementsByClassName("infoContentTitle qz-ellipse");
        List<Element> infoListBody =
            userinfo.getElementsByClassName("qz-rowlan qz-flex-row qz-ellipse");

        String name = infoListTitle[0].text.trim().split("-")[0];
        String studentId = infoListTitle[0].text.trim().split("-")[1];
        String academyName = infoListBody[1].text.trim().split("：")[1];
        String professionalName = infoListBody[2].text.trim().split("：")[1];
        String className = infoListBody[3].text.trim().split("：")[1];

        Map<String, dynamic> result = {
          "name": name,
          "studentId": studentId,
          "academyName": academyName,
          "professionalName": professionalName,
          "className": className,
        };
        return result;
      } else {
        return {};
      }
    });
  }
}
