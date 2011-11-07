/**
 * \file MixiConstants.h
 * \brief 共通で使用される定数を定義します。
 *
 * Created by Platform Service Department on 11/06/29.
 * Copyright 2011 mixi Inc. All rights reserved.
 */

#include "MixiErrorCodes.h"

//__START__REMOVE_WHEN_RELEASED__
//#define DEV
//#define STAGING
//__END__REMOVE_WHEN_RELEASED__

/** SDKのバージョン番号 */
#define kMixiSDKVersion @"1.1"

/** mixi公式アプリのID */
#define kMixiApplicationId @"jp.co.mixi.iphone"

/** mixi公式アプリが使用するURIスキーム */
#define kMixiAppScheme @"mixi-connect"

/** mixi公式アプリからクライアントシークレットを取得するためのURI */
#define kMixiAppTokenUri (kMixiAppScheme @"://token")

/** mixi公式アプリで認可状態を解除するためのURI */
#define kMixiAppRevokeUri (kMixiAppScheme @"://revoke")

/** エラー時にmixi公式アプリを呼び出すためのURI */
#define kMixiAppErrorUri (kMixiAppScheme @"://error")

/** mixi公式アプリで実行したAPIが認可処理 */
#define kMixiAppApiTypeToken @"token"

/** mixi公式アプリで実行したAPIが認可解除処理 */
#define kMixiAppApiTypeRevoke @"revoke"

/** mixi公式アプリにOAuthクライアントIDを渡すためのキー */
#define kMixiSDKClientIdKey @"key"

/** mixi公式アプリにスコープを渡すためのキー */
#define kMixiSDKPermissionsKey @"permissions"

/** mixi公式アプリに結果受け取り用のURLスキームを渡すためのキー */
#define kMixiSDKReturnSchemeKey @"return_scheme"

/** mixi公式アプリにトークンを渡すためのキー */
#define kMixiSDKTokenKey @"token"

/** mixi API呼び出しのベースURL */
//__START__REMOVE_WHEN_RELEASED__
#ifdef DEV
#  define kMixiApiBaseUrl @"http://api.mixi-platform.com.dvm108.lo.mixi.jp:8080/2"
#elif defined (STAGING)
#  define kMixiApiBaseUrl @"http://cx4z-1854-vm09.st.mixi.jp/2"
#else
// __END__REMOVE_WHEN_RELEASED__
#  define kMixiApiBaseUrl @"http://api.mixi-platform.com/2"
// __START__REMOVE_WHEN_RELEASED__
#endif
//__END__REMOVE_WHEN_RELEASED__

/** トークンリフレッシュのためのエンドポイント */
//__START__REMOVE_WHEN_RELEASED__
#ifdef DEV
#  define kMixiApiRefreshTokenEndpoint (kMixiApiBaseUrl @"/token")
#elif defined (STAGING)
#  define kMixiApiRefreshTokenEndpoint (kMixiApiBaseUrl @"/token")
#else
// __END__REMOVE_WHEN_RELEASED__
#  define kMixiApiRefreshTokenEndpoint @"https://secure.mixi-platform.com/2/token"
// __START__REMOVE_WHEN_RELEASED__
#endif
//__END__REMOVE_WHEN_RELEASED__

/** 認可状態解除のためのエンドポイント */
#define kMixiApiRevokeEndpoint @"/authorize/revoke"

/** UU測定のためのエンドポイント */
#define kMixiApiPingEndpoint @"/apps/user/count/all"

/** mAPのためのエンドポイント */
#define kMixiApiMapEndpoint @"/apps/user/count"

/** 
 * SDKの使用するUserAgentのサフィックス。実際のUserAgentは
 * UIWebViewのUA + " " + kMixiSDKUserAgentSuffix
 * になります。
 */
#define kMixiSDKUserAgentSuffix (@"mixi-phone-ios/" kMixiSDKVersion)

/** KeychainのID */
#define kMixiSDKKeychainIdentifier @"kMixiSDKKeychainIdentifier"

/** mixi公式アプリのダウンロードページURL */
//__START__REMOVE_WHEN_RELEASED__
#ifdef STAGING
#  define kMixiOfficialAppDownloadURL [NSURL URLWithString:@"http://cx4z-1850-vm09.st.mixi.jp/official_app_introduction.pl"]
#else
// __END__REMOVE_WHEN_RELEASED__
#  define kMixiOfficialAppDownloadURL [NSURL URLWithString:@"http://mixi.jp/official_app_introduction.pl"]
// __START__REMOVE_WHEN_RELEASED__
#endif
//__END__REMOVE_WHEN_RELEASED__
