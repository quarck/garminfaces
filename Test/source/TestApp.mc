import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Complications;

class TestApp extends Application.AppBase {

    protected var mComplicationId;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {

        mComplicationId = new Complications.Id(Complications.COMPLICATION_TYPE_NOTIFICATION_COUNT);
        Complications.registerComplicationChangeCallback(
                self.method(:onComplicationChanged)
            );
        Complications.subscribeToUpdates(mComplicationId);
    }

    function onComplicationChanged(complicationId as Toybox.Complications.Id) as Void {

        // Identify the complication being updated
        if (complicationId == mComplicationId) {
            WatchUi.requestUpdate();
        }
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as [Views] or [Views, InputDelegates] {
        return [ new TestView() ];
    }

}

function getApp() as TestApp {
    return Application.getApp() as TestApp;
}