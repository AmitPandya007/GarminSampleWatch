using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System as Sys;
using Toybox.Lang;
using Toybox.Application;
using Toybox.Application as App;

class SampleView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
        
        //read last values from the Object Store
        var temp=App.getApp().getProperty(OSCOUNTER);
        if(temp!=null && temp instanceof Number) {counter=temp;}
        
        temp=App.getApp().getProperty(OSDATA);
        if(temp!=null && temp instanceof String) {bgdata=temp;}
        
        var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");
        Sys.println("From OS: data="+bgdata+" "+counter+" at "+ts);
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
    
    	var clockTime = Sys.getClockTime();
        var timeString = Lang.format("$1$:$2$:$3$", 
        [clockTime.hour, 
        clockTime.min.format("%02d"), 
        clockTime.sec]
        );
        
        var DatePlaceholder = View.findDrawableById("DatePlaceholder");
        DatePlaceholder.setText(timeString);
        
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

	// Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    	var now=Sys.getClockTime();
    	var ts=now.hour+":"+now.min.format("%02d");        
        Sys.println("onHide counter="+counter+" "+ts);    
    	App.getApp().setProperty(OSCOUNTER, counter);    
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
