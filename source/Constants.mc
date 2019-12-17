// General constants used in the app
module Constants {
    const PROVIDER_URL = "http://connect.garmin.com/oauthConfirm";
    const REDIRECT_URL = "http://connectapi.garmin.com/oauth-service-1.0/oauth/access_token";
}

// Keys for the object store
module Properties {
    enum {
        AUTHENTICATION_TOKEN,
        APP_VERSION
    }
}