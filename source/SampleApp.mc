using Toybox.Application;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.Background;

var counter=0;
var bgdata="none";
var canDoBG=false;
// keys to the object store data
var OSCOUNTER="oscounter";
var OSDATA="osdata";

(:background)
class SampleApp extends Application.AppBase {
	
	function initialize() {
        AppBase.initialize();
    	var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");
    	//you'll see this gets called in both the foreground and background        
        Sys.println("App initialize "+ts);
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
		//register for temporal events if they are supported
    	if(Toybox.System has :ServiceDelegate) {
    		canDoBG=true;
    		Background.registerForTemporalEvent(new Time.Duration(5 * 60));
    	} else {
    		Sys.println("****background not available on this device****");
    	}
        return [ new SampleView() ];
    }
    
    function onBackgroundData(data) {
    	counter++;
    	var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");
        Sys.println("onBackgroundData="+data+" "+counter+" at "+ts);
        bgdata=data;
        App.getApp().setProperty(OSDATA,bgdata);
        Ui.requestUpdate();
    }    

    function getServiceDelegate(){
    	var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");    
    	Sys.println("getServiceDelegate: "+ts);
        return [new sampleServiceDelegate()];
    }
}