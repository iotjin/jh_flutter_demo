'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "a2d95bdf0b2bbfda81442fe0390c9c11",
"index.html": "df6d5a4c0f8c65c3914ba4837ec5971b",
"/": "df6d5a4c0f8c65c3914ba4837ec5971b",
"main.dart.js": "03d3b3016fc17c17dc05a67444a20e97",
"flutter.js": "1cfe996e845b3a8a33f57607e8b09ee4",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "7a95b8a19c9efd5639c7ad1ee7f4a3fc",
"assets/AssetManifest.json": "28d0f30b2d888f7cbcf68f88e7172128",
"assets/NOTICES": "8f8e211f33929dfb92b9954ff3160963",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/jhtoast/assets/images/toast_success.png": "35c2d9503db54caf521fa42f2dc76620",
"assets/packages/jhtoast/assets/images/toast_error.png": "b9ac5fe507b044775a83a297c19f57d5",
"assets/packages/jhtoast/assets/images/loading.gif": "0e6e0f46d7504242302bc8055ad9c8c2",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/lib/res/wx_motion_top.json": "b4df48d67b734fb22b7184eba0b6668e",
"assets/lib/res/china.json": "981508d9619356a8deca0aa642792c51",
"assets/lib/res/wx_contacts.json": "6681d67db9eacc43d9077413aaab6119",
"assets/lib/res/wx_friends_circle.json": "3e177d6b278dcb6be687625443ffaa2f",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/selectPhoto_add.png": "d901b656b09df42f59d5dd248ce1c625",
"assets/assets/images/ic_more_white.png": "457a529245ecefb78239bdb11d4fa9f8",
"assets/assets/images/ic_about.png": "240fb52343b07a225d4faa9de9868350",
"assets/assets/images/swiper/swiper_gif4.gif": "2865c399b3ab18de5969048150c13cbc",
"assets/assets/images/swiper/swiper_gif5.gif": "bb0a3d0d9dd2061f8f4a18d1482c70a3",
"assets/assets/images/swiper/swiper_gif2.gif": "7f084aaa535f3dd5f94ac4c8ace2c5b3",
"assets/assets/images/swiper/swiper_gif3.gif": "9f0372743b6419294fdaedbacd493e60",
"assets/assets/images/swiper/swiper_gif0.gif": "9ca1119199e4e7e5c8e3607f570fe59d",
"assets/assets/images/swiper/swiper_6.jpeg": "bf6c2200b6cba663805fe230e7f04a7c",
"assets/assets/images/swiper/swiper_4.jpg": "30374e0f0e4f6c40df633f32fd2dc978",
"assets/assets/images/swiper/swiper_5.jpg": "bd3db5dbedaab66a6888af656bc3a462",
"assets/assets/images/swiper/swiper_1.jpg": "9afb77ee84fd42e65a22a9c64ab8580e",
"assets/assets/images/swiper/swiper_0.jpg": "c13dd7d02d2e4a388b2ea63f67a645c7",
"assets/assets/images/swiper/swiper_2.jpg": "e1c077602f4f941d3eb55f8adc9d4d46",
"assets/assets/images/swiper/swiper_3.jpg": "89ab3359a4072a5721a5e7a35e1c3f73",
"assets/assets/images/funcMenu/%25E5%2588%2586%25E7%25B1%25BB.png": "174fdb019a82fb4324ab435226e26eaa",
"assets/assets/images/funcMenu/%25E6%2596%25B0%25E4%25BA%25BA%25E5%258C%2585%25E9%2582%25AE.png": "3a1d2891ef51886611241d9aca751684",
"assets/assets/images/funcMenu/%25E5%25AE%25B6%25E6%25B8%2585%25E5%25AE%25B6%25E5%25B1%2585.png": "1468247fd23b8205e72b7de199aec60d",
"assets/assets/images/funcMenu/%25E5%258E%25A8%25E6%2588%25BF%25E6%2597%25A5%25E7%2594%25A8.png": "7ab84c6649aa5654b00b2bfa100ec119",
"assets/assets/images/funcMenu/%25E7%25B2%25AE%25E6%25B2%25B9%25E7%25B1%25B3%25E9%259D%25A2.png": "9b7c31c25808cfff1c2e0f8bd284b1e3",
"assets/assets/images/funcMenu/%25E9%25A2%2586%25E9%2587%2591%25E5%25B8%2581.png": "4b6cc6d40cd09f01cb12287853ec37d4",
"assets/assets/images/funcMenu/%25E4%25BC%2591%25E9%2597%25B2%25E9%259B%25B6%25E9%25A3%259F.png": "860b61f9030db749e60ffa07a3d012ec",
"assets/assets/images/funcMenu/%25E5%25A4%25A9%25E7%258C%25AB.png": "115ccc34159db14384a5ff6f47d46f94",
"assets/assets/images/funcMenu/%25E6%25AF%258D%25E5%25A9%25B4%25E7%2594%25A8%25E5%2593%2581.png": "1fa632319a574654505cfb0a2a0a69e9",
"assets/assets/images/funcMenu/%25E5%25A4%25A9%25E7%258C%25AB%25E5%259B%25BD%25E9%2599%2585.png": "2f528d86b5f6032a41bbc41513bf2523",
"assets/assets/images/funcMenu/%25E9%25A3%259E%25E7%258C%25AA%25E6%2597%2585%25E8%25A1%258C.png": "25265f4272d8e8e8f70d22622ea62106",
"assets/assets/images/funcMenu/%25E5%25A4%2596%25E5%258D%2596.png": "2879ee48e534bbf684be045ae3da5960",
"assets/assets/images/funcMenu/%25E8%25BF%259B%25E5%258F%25A3%25E5%25A5%25BD%25E8%25B4%25A7.png": "986246bc34dacb9fbadd98d8c6cab390",
"assets/assets/images/funcMenu/%25E6%258B%258D%25E5%258D%2596.png": "22a513086c9cd3ef5792bf63dc7ed1aa",
"assets/assets/images/funcMenu/%25E5%25A4%25A9%25E7%258C%25AB%25E8%25B6%2585%25E5%25B8%2582.png": "9cd9f0a489c105dabf1e9ce1c06f5ef8",
"assets/assets/images/funcMenu/%25E8%2581%259A%25E5%2588%2592%25E7%25AE%2597.png": "6daf00da27a057abd5a74677cec13b5b",
"assets/assets/images/funcMenu/%25E6%2596%25B9%25E4%25BE%25BF%25E9%2580%259F%25E9%25A3%259F.png": "a5e0800a446885e53ba0d53fe0ed798a",
"assets/assets/images/funcMenu/%25E4%25B8%25AA%25E4%25BA%25BA%25E6%258A%25A4%25E7%2590%2586.png": "18895a64bcf27c3f6fd4e2274a73fc88",
"assets/assets/images/funcMenu/%25E5%25A5%25B6%25E5%2593%2581%25E6%25B0%25B4%25E9%25A5%25AE.png": "77bb0be9c7a7cfad106cd5b38c4ff8eb",
"assets/assets/images/funcMenu/%25E5%2585%2585%25E5%2580%25BC%25E4%25B8%25AD%25E5%25BF%2583.png": "f2e21f55a12fe1b0fe70cefbe3668075",
"assets/assets/images/ic_accountSafe.png": "7c2554e566381cc1b18a32baa4babf4e",
"assets/assets/images/ic_pwd_close.png": "bc8a2bf2f7790ee16cae9a839896bafd",
"assets/assets/images/lufei.png": "e6277baa63e45a1d2fb7fbe26562fddd",
"assets/assets/images/ic_nav_add.png": "fb7a80045453900eb06df25b55c69f69",
"assets/assets/images/newFeature/newFeature_0.jpeg": "a68d01fa92b02668b1e7b29b123ee712",
"assets/assets/images/newFeature/ad_background-667h@2x.png": "d6aa378e2fe1a88786d91925d34e874f",
"assets/assets/images/newFeature/newFeature_1.jpeg": "e4055f96db33a2547e3d112e113aec54",
"assets/assets/images/newFeature/newFeature_2.jpeg": "6908901e518116df357b3a0b0949db11",
"assets/assets/images/newFeature/newFeature_3.jpeg": "337fa8c00a024dfb7b6e13c55bedb57a",
"assets/assets/images/newFeature/start-now.jpg": "d082dd30dcdf6c9909df0ec6c5129325",
"assets/assets/images/ic_placeholder2.png": "4cf24fe8401f7ab2eba2c6cb82dffb0e",
"assets/assets/images/ic_placeholder3.png": "7e80fb31ec58b1ca2fb3548480e1b95e",
"assets/assets/images/picture/touxiang_1.jpeg": "bb6bc28b0be236c383c41f3e829bf604",
"assets/assets/images/picture/picture8.jpg": "58372e6b561e7591b8a4a3fe8a90e01a",
"assets/assets/images/picture/picture9.jpg": "9786272abbc4c445b75c2a131ecfd69e",
"assets/assets/images/picture/touxiang_6.jpg": "ad7d6086176250e190bfef42c6b14f82",
"assets/assets/images/picture/picture1.jpeg": "5b581e88bba72f43fbd4779cdc6ea6cb",
"assets/assets/images/picture/picture0.jpeg": "a68d01fa92b02668b1e7b29b123ee712",
"assets/assets/images/picture/touxiang_5.jpeg": "f0ff416ff69efeca389b4a9765418d05",
"assets/assets/images/picture/picture3.jpeg": "454742095ac3cb2e1f2143661f3a674a",
"assets/assets/images/picture/picture2.jpeg": "9bda579f0905cc728f936f631cdacc96",
"assets/assets/images/picture/touxiang_4.jpeg": "55047a82a5a4c38cc1847e409ea76976",
"assets/assets/images/picture/tubiao.png": "53e841a6afa71e656ede1738846c93ba",
"assets/assets/images/picture/touxiang_3.jpeg": "4b7f709c175dfbb0114746ce40fe6757",
"assets/assets/images/picture/touxiang.jpeg": "ddc87fddc47019e69539984737e6e0b9",
"assets/assets/images/picture/picture5.jpeg": "ee6b7ac5cab42a56f571d0c8e38b7fe8",
"assets/assets/images/picture/picture7.jpg": "806658083ccddc6c53231cddd20c7dfa",
"assets/assets/images/picture/picture6.jpg": "4565d5acb7141051b8cf20a0280b7b2e",
"assets/assets/images/picture/touxiang_2.jpeg": "0dc38aa2cc7d614cdb81352eff2b5b50",
"assets/assets/images/tianjiahaoyou.png": "ed8aba5ce2002743fd6c1bd2325c8b5e",
"assets/assets/images/ic_pwd_open.png": "56cff51e28d7e10f12f605aa281986d4",
"assets/assets/images/tab/nav_tab_1_on.png": "3fff155a63c3abbbe8590ad2071dfbf1",
"assets/assets/images/tab/nav_tab_3_on.png": "fd8a91a7afd7e4b8e80c04e36bd1bc5d",
"assets/assets/images/tab/nav_tab_4.png": "e008144173709b7d879026d258e635bc",
"assets/assets/images/tab/nav_tab_3.png": "6e161d717ace9e0b3536836116ea59f6",
"assets/assets/images/tab/nav_tab_2.png": "61feea4c8f93aba679a7990fe229cfff",
"assets/assets/images/tab/nav_tab_2_on.png": "a31185692ce8d25468595523739bf23c",
"assets/assets/images/tab/nav_tab_1.png": "f050c3c2786f412ee150999aa9fed24c",
"assets/assets/images/tab/nav_tab_4_on.png": "17db03eebcdf2f83c09a7f9c01a3574b",
"assets/assets/images/ic_addFriends.png": "abbc4fab57df179c5e1ab26fd7769932",
"assets/assets/images/shezhi.png": "d2c1bfa7c2e7488abaff0b2ac8c50939",
"assets/assets/images/search.png": "bea7a1ef33d8fae8157c32b3e7237893",
"assets/assets/images/set.png": "a84e5751b4efd8f6851a1104d50e9680",
"assets/assets/images/common/ic_arrow_white.png": "9740cfe2485920f336d2f71248d00130",
"assets/assets/images/common/ic_nav_back_black.png": "c116dec8993a4daa1b7fddbb0f262d0b",
"assets/assets/images/common/empty/%25E7%25BD%2591%25E7%25BB%259C%25E9%2594%2599%25E8%25AF%25AF.png": "62e7b6463e71ee5e23d1a5e4fec8793d",
"assets/assets/images/common/empty/ic_netErr.png": "ce556cbcab5d7aa1e60c25adb27b7637",
"assets/assets/images/common/empty/%25E7%25A9%25BA.png": "648fdf753e21368b162406e07293bde4",
"assets/assets/images/common/empty/ic_empty.png": "f558a46577e1554421cf1871fd3aebd8",
"assets/assets/images/common/ic_arrow_black.png": "f7572ac103f29e450bac634137f8f557",
"assets/assets/images/common/ic_nav_back_white.png": "d8865a56f1ba1913375d00c0fd23ca4d",
"assets/assets/images/common/ic_arrow_gray.png": "445a3b818602c241038ba95e9a517d67",
"assets/assets/images/ic_more_black.png": "9114060505a03425fcf7f0bc035b0252",
"assets/assets/images/ic_saoyisao.png": "1361437ff16f849105a2bea43cd399c0",
"assets/assets/images/ic_placeholder.png": "7794f910d106799c55b02cb249c057b0",
"assets/assets/images/ic_comingSoon.png": "697c3cb7ac5f0889bc8e055885989e6b",
"assets/assets/images/update_head.jpg": "670e412faeda9a6481cdf95a1a3e3ea7",
"assets/assets/images/popMenus/ic_add.png": "7122038513f83eb049a46240022be44d",
"assets/assets/images/popMenus/shoufukuan.png": "565dcc78d95a21a5f80873ee9c18e502",
"assets/assets/images/popMenus/ic_scan.png": "db0534957103b9f922f7a9a128e1c203",
"assets/assets/images/popMenus/ic_chat.png": "6eddd83baa93e78497cc0e4481f6cd11",
"assets/assets/images/popMenus/ic_menu_up_arrow.png": "0cf7e5c3a921f457cd055ac11e2325a9",
"assets/assets/images/popMenus/ic_pay.png": "5a4554d0cf11401d348b9d43fee8b888",
"assets/assets/images/ic_gengduo.png": "65bbd1b4f0a10d89ab1ac9071acc2825",
"assets/assets/images/service/bg_service_gongdan.png": "34f59db75c7254020ca6bfd06f2fcbee",
"assets/assets/images/service/lufei.png": "e6277baa63e45a1d2fb7fbe26562fddd",
"assets/assets/images/service/icon_fuwufankui.png": "0659d6f79e89cde30d81c035ca35caf7",
"assets/assets/images/service/icon_baoxiu.png": "e7e3bec87d9e37fccb2c4f2b108e5845",
"assets/assets/images/service/bg_service_baoxiu.png": "8cf7eba05d16925faa8bb98eff3b067e",
"assets/assets/images/service/bg_service_fuwufankui.png": "3ddab9a01b2d1f7a5eee33551e3213c8",
"assets/assets/images/service/icon_gongdan.png": "40c63db1646823f39d2ace9aee113553",
"assets/assets/images/ic_exit.png": "7ec91f12f776759fadd16a464ea12ffb",
"assets/assets/images/demos/symptom_ball_shadow@3x.png": "d685fce75f3f5ab3533719d595f5991d",
"assets/assets/images/demos/symptom_light@3x.png": "c7e5b3b9fe81929d279e6bb772ef4dc5",
"assets/assets/images/demos/symptom_ballwithflare@3x.png": "d8c40a431f32e540d86131a8f067d3be",
"assets/assets/images/selectPhoto_close.png": "2dd3ff3a094158004006a22c56cec996",
"assets/assets/images/ic_demo1.png": "c76d3f3bf6fd128fab12b2d167d9c554",
"assets/assets/images/loading.png": "cb7d85c98815780ec40414520416eed1",
"assets/assets/images/ic_set_gray.png": "e12db7745972a664bd78f283f64aaebb",
"assets/assets/images/PayCode.jpg": "0a7307db616256a19eb88acd838e32cc",
"assets/assets/images/ic_sort.png": "8485ad886cce4d07e83998d4019fee27",
"assets/assets/images/ic_set_black.png": "1b366750734b0ba2b60f820eb0725b0d",
"assets/assets/images/ic_demo2.png": "97e989225d1f2c431e4fed7bc79dc5f5",
"assets/assets/images/xi.png": "1b64b553b72334478c7e0ebbbb3dea6d",
"assets/assets/wechat/home/wechat_game.png": "ac0804715207e9beeb08139a2c139b17",
"assets/assets/wechat/home/ic_about.png": "2b34a48073be95f372f95326292eedb3",
"assets/assets/wechat/home/wechat_motion.png": "8333743d972ed3b2a65b6b94b78a9b5f",
"assets/assets/wechat/home/ic_qrcode_preview_tiny.png": "3e2e8497afd40fe5e4d7364bc44dff90",
"assets/assets/wechat/home/ic_subscription_number.png": "aa44eeb767642c65709819453f491907",
"assets/assets/wechat/home/ic_tx_news.png": "f5a76559a04740d8ac58b23842f9f8ba",
"assets/assets/wechat/home/Ic_email.png": "7a5bed3459a7017158bebd44461dfe9f",
"assets/assets/wechat/home/ic_top.jpg": "aacdab583188ba9e107355bd87cdd244",
"assets/assets/wechat/home/ic_wx_games.png": "5b52ae622fb2bbefde4378981d2bfe21",
"assets/assets/wechat/home/ic_file_transfer.png": "3c1dd7c5645c3fbe09c61ec7c8f43aba",
"assets/assets/wechat/discover/ic_quick_search.png": "88ae0a78071339a4f189f269329496d4",
"assets/assets/wechat/discover/ic_feeds.png": "6d119194ae229621f409f33c03500371",
"assets/assets/wechat/discover/ic_mini_program.png": "97b957265f27bfa06a5056b1dc819ecc",
"assets/assets/wechat/discover/ic_shake_phone.png": "3ba874a7bfeabc7771aed6fd24ddb590",
"assets/assets/wechat/discover/ic_game_entry.png": "380dd8f1d55bfcef27ce1bad57bb19d2",
"assets/assets/wechat/discover/ic_social_circle.png": "4695c4636b7279079b8064d91cdf508d",
"assets/assets/wechat/discover/ic_diandian.png": "0be3c1ad32a23d3e55eabd6b1f17b99b",
"assets/assets/wechat/discover/ic_people_nearby.png": "fe3fab8040ef86d654ba1916c1056141",
"assets/assets/wechat/discover/ic_video_number.png": "b7d5be5e44dd47bc2f75b585336b01c6",
"assets/assets/wechat/discover/friends/wx_img20.JPG": "cb610315591f82bf0ebf144b0c87850b",
"assets/assets/wechat/discover/friends/wx_img5.JPG": "2c31a069c5fd39c281e18c4caf473f6c",
"assets/assets/wechat/discover/friends/wx_img4.JPG": "3466313e5e8ba58c5d112c562bf9df68",
"assets/assets/wechat/discover/friends/wx_img21.JPG": "b1c6f786d0fbd37382b8c9ec4256167e",
"assets/assets/wechat/discover/friends/wx_img23.JPG": "d1bf3e82405f489dc97d5079ce7a7646",
"assets/assets/wechat/discover/friends/wx_img6.JPG": "2accc150f0c2a999b11be3d39700b7c3",
"assets/assets/wechat/discover/friends/wx_img7.JPG": "28650d9b3aa2dc45f0d2f83bdd3f3105",
"assets/assets/wechat/discover/friends/wx_img22.JPG": "caf2de4878f148e0d64d011fa18ecee9",
"assets/assets/wechat/discover/friends/wx_img32.JPG": "983af0ec665ee27f3963420ed9502d8a",
"assets/assets/wechat/discover/friends/wx_img26.JPG": "b472ff315c5e12a48dc55ee9bcf18255",
"assets/assets/wechat/discover/friends/wx_img3.JPG": "0b044cfe6767292b8ebe721f5c87039c",
"assets/assets/wechat/discover/friends/wx_img2.JPG": "4b741edb690a34f86f9c8aa4a49abceb",
"assets/assets/wechat/discover/friends/wx_img27.JPG": "8710ffdbcead925ecc976d444c68fe4f",
"assets/assets/wechat/discover/friends/wx_img33.JPG": "8cd81bc1998b6a68f37d950ade06a41a",
"assets/assets/wechat/discover/friends/wx_img19.JPG": "aabf9f997a9e3a9248379dcbfe761332",
"assets/assets/wechat/discover/friends/wx_img25.JPG": "c33546cff2265c61963dd1f1799091c7",
"assets/assets/wechat/discover/friends/wx_img31.JPG": "c84c66d4e09132f5af9b9519dbf0997a",
"assets/assets/wechat/discover/friends/image1.jpeg": "14875a3e77655f043a03bf23b6709250",
"assets/assets/wechat/discover/friends/wx_img30.JPG": "da3402d18678940c68d7518d873b5213",
"assets/assets/wechat/discover/friends/wx_img24.JPG": "686b6b2d12949415df75a641a77a2123",
"assets/assets/wechat/discover/friends/wx_img18.JPG": "656776d422b186ff128bb4ad9fad685f",
"assets/assets/wechat/discover/friends/wx_bg1.jpg": "38d963680ee3ac77237750890141b6f3",
"assets/assets/wechat/discover/friends/image6.jpeg": "cef632acd0b5f941a45f1df96834ee74",
"assets/assets/wechat/discover/friends/image7.jpeg": "704185e0e8c39aba6083fa8a0b3eff28",
"assets/assets/wechat/discover/friends/wx_bg0.jpeg": "13f55722d3862e6edeefd3ae18b27ddc",
"assets/assets/wechat/discover/friends/img9.jpg": "3f86cdac19dacfcea69e79f5c802c096",
"assets/assets/wechat/discover/friends/img8.jpg": "40bcd910b34fca2ecead6c37072887f6",
"assets/assets/wechat/discover/friends/image8.jpeg": "0ec11d1c057a973062ad2a548d3eb01e",
"assets/assets/wechat/discover/friends/img5.jpg": "0db62e1a758ae10aa00d2e2795105f99",
"assets/assets/wechat/discover/friends/img4.jpg": "92c531ae32e3fea3e7f0e4d3116b7b5c",
"assets/assets/wechat/discover/friends/image4.jpeg": "0d00f1d21a63cb12e976f0ae94001eca",
"assets/assets/wechat/discover/friends/img6.jpg": "61a4748b2f4edb3215b7a3c9a0fb8de0",
"assets/assets/wechat/discover/friends/img7.jpg": "e90dbde77d159f08a2b59812e4fb0834",
"assets/assets/wechat/discover/friends/img3.jpg": "e1a1746610dca31821ffb7b5165df88f",
"assets/assets/wechat/discover/friends/IMG_3362.JPG": "14c89faaa4af42d0a14a0f8ff9a1aaff",
"assets/assets/wechat/discover/friends/img2.jpg": "89ee1dbcbecb6b674ade036d4cb3c083",
"assets/assets/wechat/discover/friends/image5.jpeg": "8b50486e3ede457e466e5eed3993a1cf",
"assets/assets/wechat/discover/friends/img1.jpg": "89849098d4dfc5b4534cb245c0be0777",
"assets/assets/wechat/discover/friends/image9.jpeg": "5095c5dffb7538885086d1a7a0bac06a",
"assets/assets/wechat/discover/friends/wx_img15.JPG": "77c6a434280b8845517da3fd75c3d777",
"assets/assets/wechat/discover/friends/wx_img29.JPG": "8091b2b7a7f0b05a8b4958a6ed7b2ad8",
"assets/assets/wechat/discover/friends/image2.jpeg": "6029e11945a00f71dc002aac54c10f1b",
"assets/assets/wechat/discover/friends/wx_img28.JPG": "d3716b44c1932ec39deb2bb726c1d598",
"assets/assets/wechat/discover/friends/wx_img14.JPG": "a0c2828832ed2dbd14378eede93445ed",
"assets/assets/wechat/discover/friends/wx_img16.JPG": "7db5b7cfcf18406610ec62e1bd474969",
"assets/assets/wechat/discover/friends/wx_img17.JPG": "a70875a080205264d12510dfa0c8b55b",
"assets/assets/wechat/discover/friends/wx_img13.JPG": "ad1f6b9b0a01e32ffcf659f3a9887e1f",
"assets/assets/wechat/discover/friends/wx_img12.JPG": "10d0ea0896e2b7edff70fd212f81b214",
"assets/assets/wechat/discover/friends/img10.jpg": "9d67ef416fd47f1918a44e6418a3030b",
"assets/assets/wechat/discover/friends/wx_img10.JPG": "1c2737eb99bdcd28cea7e818afcdb223",
"assets/assets/wechat/discover/friends/wx_img9.JPG": "d3aa755fa6c379e6303d41ec197e2d70",
"assets/assets/wechat/discover/friends/image3.jpeg": "a36c5bcd5a7e5b1ac49c57c3c6858c6f",
"assets/assets/wechat/discover/friends/wx_img8.JPG": "6aa940e16e93ec96d3dfb9a5b6ecbedf",
"assets/assets/wechat/discover/friends/wx_img11.JPG": "55582fb20d8efafd747cd2f8c3a5fd92",
"assets/assets/wechat/discover/ic_shopping.png": "4e46c3a401c683e231bfac5fd0a04a32",
"assets/assets/wechat/discover/ic_fengchao.png": "65516c1047a2e3e3abaaef25f4e11dd0",
"assets/assets/wechat/discover/ic_xiangji.png": "79db8bacdac08a222d8c298c94d9b88a",
"assets/assets/wechat/discover/ic_quick_scan.png": "1e61b7eb747804df08d86a26ad4c95b7",
"assets/assets/wechat/discover/ic_bottle_msg.png": "e52a8cfa421cf803d95c15972e8be9ba",
"assets/assets/wechat/contacts/ic_tag.png": "89b66d7956f8ef6deea4d63e6dfb3159",
"assets/assets/wechat/contacts/ic_public_account.png": "04f27eafeb83760ef0a58e938bd90c76",
"assets/assets/wechat/contacts/ic_index_bar_bubble_gray.png": "814ae2cd5ecf2e3e598d038be1ab42c8",
"assets/assets/wechat/contacts/ic_group_chat.png": "34e74f99c2cdaf6d8d1f9236fe7dbeca",
"assets/assets/wechat/contacts/ic_favorite.png": "43b3c82a1331d2851d3d9d06d8c4feeb",
"assets/assets/wechat/contacts/add/add_friend_icon_addgroup_36x36_@3x.png": "a2e33e36ed0f0d5ebcd99a3cc283e5a7",
"assets/assets/wechat/contacts/add/add_friend_icon_reda_36x36_@3x.png": "4be53ae5df8b8c42b220793c7102e13d",
"assets/assets/wechat/contacts/add/add_friend_searchicon_36x30_@2x.png": "35f22ac627968c6dc471fcf7f45e2583",
"assets/assets/wechat/contacts/add/add_friend_icon_reda_36x36_@2x.png": "67df4fdefd993cd33c4c20b9e21fb31e",
"assets/assets/wechat/contacts/add/add_friend_icon_addgroup_36x36_@2x.png": "a429356fdc6d852159b85979c4a28744",
"assets/assets/wechat/contacts/add/add_friend_icon_search_wework_40x40_@3x.png": "bffbba64c2ef86ceab2ed3e660617f8c",
"assets/assets/wechat/contacts/add/add_friend_icon_invite_36x36_@3x.png": "13291ebf98be8552299d7ddc40ffac86",
"assets/assets/wechat/contacts/add/add_friend_icon_search_wework_36x36_@1x.png": "76f6718dd5163afd7a052e42cb37cff8",
"assets/assets/wechat/contacts/add/add_friend_myQR_20x20_@2x.png": "546770d251d09312c937cf63b6288c8b",
"assets/assets/wechat/contacts/add/add_friend_icon_invite_36x36_@2x.png": "e80771904b8c23c81dccb6626c18c4f2",
"assets/assets/wechat/contacts/add/add_friend_icon_search_wework_40x40_@2x.png": "338798e7b89f0ef4da44cd0f34359891",
"assets/assets/wechat/contacts/add/add_friend_icon_newgroup_36x36_@2x.png": "e749e608b5d71915701db0a504ff77dd",
"assets/assets/wechat/contacts/add/add_friend_icon_offical_36x36_@3x.png": "fefce32099bec40ea6f27748bc2825f4",
"assets/assets/wechat/contacts/add/add_friend_icon_search_36x36_@2x.png": "384cee884b995bdd61ee48486543a761",
"assets/assets/wechat/contacts/add/add_friend_icon_search_36x36_@3x.png": "7b4cb797b563c426659ecdd493cfea26",
"assets/assets/wechat/contacts/add/add_friend_icon_newgroup_36x36_@3x.png": "f97f8a026f9c3d7e6f696d97f1fa2fa9",
"assets/assets/wechat/contacts/add/add_friend_icon_offical_36x36_@2x.png": "84bec69a8eae358ae02dfb967e45e3b7",
"assets/assets/wechat/contacts/add/add_friend_icon_scanqr_36x36_@3x.png": "623af6d15671bb1d3e86eb5881f4f216",
"assets/assets/wechat/contacts/add/add_friend_icon_contacts_36x36_@2x.png": "abe7e678c5178d0f7b6dce312d95f63d",
"assets/assets/wechat/contacts/add/add_friend_icon_contacts_36x36_@3x.png": "8c1e6f0776243dce47251d798db94fce",
"assets/assets/wechat/contacts/add/add_friend_icon_scanqr_36x36_@2x.png": "9f793757543de9ea899309bc9ef79d8a",
"assets/assets/wechat/contacts/ic_xinxi.png": "f126e59cb375f00835fb5a8d0ea8f151",
"assets/assets/wechat/contacts/ic_new_friend.png": "b9310fb2b83e08f0804ccee84c9ab21f",
"assets/assets/wechat/contacts/contact_index_bar_bubble_0.png": "bf51af51244b57aa8f83de815ad33071",
"assets/assets/wechat/contacts/ic_index_bar_bubble_white.png": "3a428b9603817acb16fc3abcfade936f",
"assets/assets/wechat/contacts/ic_shipintonghua.png": "897ab9d066e6738b5c60e7d3a0ae2e3b",
"assets/assets/wechat/other/AppIcon_29x29_@2x.png": "39cfe5f7e4e9f0f01afd4a50b1a181e4",
"assets/assets/wechat/other/AppIcon_76x76_@2x.png": "00f51d6a299183dcd0d0927eee3d1f91",
"assets/assets/wechat/other/AppIcon_50x50_@2x.png": "ae5212c3b9c274e379a831a7d4215115",
"assets/assets/wechat/other/AppIcon_108x108_@2x.png": "cd80c927cf712207a82e7e504c39f3e5",
"assets/assets/wechat/other/DownVideo_169x137_@2x.png": "04d864f47c57ec0d68e2d25ca0042d6f",
"assets/assets/wechat/other/AppIcon_29x29_@3x.png": "33fdf96ae8c037c669b09aee97189285",
"assets/assets/wechat/other/AppIcon_83x83_@2x.png": "cd6c0df7f6ba9aa7c80fe408283660a8",
"assets/assets/wechat/other/AppIcon_90x90_@2x.png": "7b8614d23b7caeefd40bb63767693bb1",
"assets/assets/wechat/other/AppIcon_98x98_@2x.png": "021b23a811c4748ff47e72a7e7254286",
"assets/assets/wechat/other/AppIcon_1024x1024_@1x.png": "cf93b829248c26504ce47930a0032644",
"assets/assets/wechat/other/AppIcon_27x27_@2x.png": "6c34d599b61982b2f3d82c9da7ea85a4",
"assets/assets/wechat/other/AppIcon_86x86_@2x.png": "7c9d286e483230588047280609cfb417",
"assets/assets/wechat/other/News_VideoSmall_16x16_@2x.png": "c033930c2686eeb2f8c9cf2e8cd49f4e",
"assets/assets/wechat/other/News_VideoBIG_31x31_@2x.png": "71a3162163258125076524d256f6ae99",
"assets/assets/wechat/other/AppIcon_40x40_@2x.png": "3f0bc52ec83ee6d04323a46978333696",
"assets/assets/wechat/other/DeviceRankNoLikeIcon_96x96_@2x.png": "0df910aedc927e0cc3c02d0a27b19f2c",
"assets/assets/wechat/other/AppIcon_24x24_@2x.png": "c9070b9113871e2ce9903fdf1f59108d",
"assets/assets/wechat/other/AppIcon_60x60_@2x.png": "666755d084ed5d4705b44deb0c94527d",
"assets/assets/wechat/other/AppIcon_44x44_@2x.png": "dc473192465e31c2bc2eaf057aae50c3",
"assets/assets/wechat/other/AppIcon_76x76_@1x.png": "67c9b7ad0a04f2c4f1ee825c2fe42084",
"assets/assets/wechat/other/AppIcon_60x60_@3x.png": "7b8614d23b7caeefd40bb63767693bb1",
"assets/assets/wechat/mine/default_nor_avatar.png": "0aee694846b1fc31fa66e16d3fe74201",
"assets/assets/wechat/mine/ic_about.png": "d7dad38a21145981030ee1eae848b84b",
"assets/assets/wechat/mine/About_WeChat_AppIcon_64x64_@3x.png": "4da1f474c63141c3b74d2ed002c9e817",
"assets/assets/wechat/mine/ic_qianbao.png": "ac1809f051ef11ed67177018e04fe99f",
"assets/assets/wechat/mine/ic_album.png": "4bdc222eb678233889676d7c60b8f1ec",
"assets/assets/wechat/mine/ic_emotions.png": "1751e8d86369881397bc0f7b8c4abda1",
"assets/assets/wechat/mine/About_WeChat_AppIcon_64x64_@2x.png": "d294ad18973728ae6b42b2cbd1320439",
"assets/assets/wechat/mine/ic_setting_myQR.png": "aecaadb510ec8113be926ec800b6b6ca",
"assets/assets/wechat/mine/ic_settings.png": "1ed4f98ad01b503b089e8ebdf9246e13",
"assets/assets/wechat/mine/ic_cards_wallet.png": "cd55f1c62928f9980a15a9a2a6328e3c",
"assets/assets/wechat/mine/ic_shoufukuan.png": "20e6b824c97147989c87bdcc8f9761f5",
"assets/assets/wechat/mine/ic_wallet.png": "66f0fb4c7462babf2aba9021fa77eb2b",
"assets/assets/wechat/mine/ic_collections.png": "e1c68203ca9679a87606f65f387c72e6",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
