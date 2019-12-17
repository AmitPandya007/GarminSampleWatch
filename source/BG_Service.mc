using Toybox.Background;
using Toybox.System as Sys;
using Toybox.Communications;
using Toybox.WatchUi;

// The Service Delegate is the main entry point for background processes
// our onTemporalEvent() method will get run each time our periodic event
// is triggered by the system.

(:background)
class sampleServiceDelegate extends Toybox.System.ServiceDelegate {
	
	function initialize() {
		Sys.ServiceDelegate.initialize();

	}
	
    //A callback method that is triggered in the background when time-based events occur.
    function onTemporalEvent() {
    
    	System.println(" on temperal event() ");
		 //make a connection call to garmin
         Communications.registerForOAuthMessages(method(:onOAuthComplete));
         Communications.makeOAuthRequest(
         "http://connect.garmin.com/oauthConfirm", 
         {"redirectUrl" => "http://connectapi.garmin.com/oauth-service-1.0/oauth/access_token"}, 
         "http://connectapi.garmin.com/oauth-service-1.0/oauth/access_token", 
         Communications.OAUTH_RESULT_TYPE_URL, 
         {"token" => "token", "errorMessage" => "errorMessage"}
         );
         
        var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");
        Sys.println("bg exit: "+ts);
        //just return the timestamp
        //Background.exit(ts);
    }
    
    // Callback for OAuth completion
    function onOAuthComplete(data) {
        // If OK, store the token. Otherwise show the error.
        System.println(" response code: " + data.data);
         System.println(" response code data: " + data.toString());
        if ((data.responseCode == 200) && (data.data != null)) {
            var token = data.data["token"];
            if (token != null) {
                Application.getApp().setProperty(Properties.AUTHENTICATION_TOKEN, token);
                WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            }
             System.println(" token value: " + token);
        } else if (data.data != null) {
            var message = "IF Unable to get token:\n" + data.data["errorMessage"];
            //WatchUi.switchToView(new ErrorView(message), null, WatchUi.SLIDE_IMMEDIATE);
            System.println(message);
        } else {
            var message = "ELSE Unable to get token:\n No physical device found.";
            //WatchUi.switchToView(new ErrorView(message), null, WatchUi.SLIDE_IMMEDIATE);
            System.println(message);
        }

        Communications.registerForOAuthMessages(null);
    }
}