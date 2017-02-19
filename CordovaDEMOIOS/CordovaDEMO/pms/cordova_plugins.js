cordova.define('cordova/plugin_list', function(require, exports, module) {
               module.exports = [
                                 {
                                 "file": "plugins/org.apache.cordova.webview/www/WebViewRequest.js",
                                 "id": "com.Cordova.Plugin.WebViewRequest",
                                 "merges": [
                                            "cdv.webview"
                                            ]
                                 },
                                 {
                                 "file": "plugins/org.apache.cordova.ajax/www/AjaxRequest.js",
                                 "id": "com.example.yangxiaoguang.cordovademo.Cordova.Plugin.AjaxRequest",
                                 "merges": [
                                            "cdv.ajax"
                                            ]
                                 },
                                 {
                                 "file": "plugins/iAppRevisionPlugin/iAppRevision.js",
                                 "id": "com.Cordova.Plugin.iAppRevision",
                                 "merges": [
                                            "cdv.sign"
                                            ]
                                 },
                                 
                                 //40 插件
                                 {
                                 "file": "plugins/cordova-plugin-app-version/www/AppVersionPlugin.js",
                                 "id": "AppVersionPlugin",
                 
                                 },
                                 
                                 ];
               module.exports.metadata = 
               // TOP OF METADATA
               {
 
               }
               // BOTTOM OF METADATA
               });
