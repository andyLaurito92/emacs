Emacs has a powerful rest client mode called [restclient.el](https://github.com/pashky/restclient.el)

Notes so far:

1. Define variables using :name = value
2. `M-x restclient-mode` to enable file; TODO: Add extension to file so it opens automatically
3. If having multiple queries in same file, separate them with # (comment)

## Basic Usage

For starting, just create a new buffer, enable restclient-mode, place the
cursor at the beginning of the query and hit C-c C-c. This will return
the response.

GET https://google.com


*Note:* You can also run C-c C-r to return the raw response instead of a
curated one


### Getting Oauth 2.0 Token

Use the following rest query to get an OAuth 2.0 token


# . In Basic Authentication, the credentials need to be base64-encoded without any additional characters like quotes.
encodedbase64 = echo 'client_id:cliend_secret' | base64

POST https:/url-to-get/v1/token
Content-Type: application/x-www-form-urlencoded
Authorization: Basic encodebase64

grant_type=client_credentials&scope=all-apis

#### Example with microsoft

:app_consumer = another-uuid
:app_provider = some-uuid
:azure_secret = mysecret

:tenant = uuid-tenant

POST https://login.microsoftonline.com/:tenant/oauth2/v2.0/token
Content-type: application/x-www-form-urlencoded

client_id=:app_consumer&client_secret=:azure_secret&grant_type=client_credentials&scope=:app_provider/.default


## Moving around

C-c C-c: Execute query between # (everything between comments is considered part of the query, so watch out w/this!)
C-c C-n: Next query
C-c C-p: Previous query
