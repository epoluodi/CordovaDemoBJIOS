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
                                 {
                                 "file": "plugins/cordova-plugin-camera/www/Camera.js",
                                 "id": "Camera",
                                 },
                                 {
                                 "file": "plugins/cordova-plugin-device/www/device.js",
                                 "id": "device",
                                 },
                                 {
                                 "file": "plugins/cordova-plugin-statusbar/www/statusbar.js",
                                 "id": "statusBar",
                                 },
                                 ];
               module.exports.metadata = 
               // TOP OF METADATA
               {
 
               }
               // BOTTOM OF METADATA
               });
