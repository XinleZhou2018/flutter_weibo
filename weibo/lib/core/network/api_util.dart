/// APP 接口 及 服务器地址配置类
class ApiUtil {
  static const DEBUG_MODE = true;
  static const LOG_DEBUG_MODE = true; //日志log

  static const PROXY_HOST = "8888";
  static const PROXY_URL = "192.168.2.48"; //代理地址(用于charles调试)

  static const PROTOCOL = "http://";


  static const API = "/weibo";

  ///开发环境
  // static const DEBUG_HOST = "47.111.208.192:8005";

  //本地环境
  // static const DEBUG_HOST = "172.16.41.200:8005";

  //Beta环境
  // static const DEBUG_HOST = "47.98.205.31:8005";

  ///测试环境
  // static const DEBUG_HOST = "192.168.3.176:8088";

  static const DEBUG_HOST = "172.16.41.69:8088";
  // static const DEBUG_HOST = "192.168.3.207:8088";

  ///网关环境
  // static const DEBUG_HOST = "121.40.11.202:8036/app";
  static const ONLINE_HOST = "150.158.96.11";

  static const USER_TIMELINE = "/queryWeibo";
}
