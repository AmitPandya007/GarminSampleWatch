using Toybox.WatchUi as Ui;

class Background extends Ui.Drawable {
	hidden var topColor, bottomColor;	
	
    function initialize(params) {
        Drawable.initialize(params);

        topColor = params.get(:topColor);
        bottomColor = params.get(:bottomColor);       
    }

    function draw(dc) {
    	var halfOfHeight = dc.getHeight() / 2;
		var deviceWidth = dc.getWidth();					
            
       
    }
}