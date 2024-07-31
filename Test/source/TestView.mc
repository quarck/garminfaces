import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

using Toybox.System;
using Toybox.Time.Gregorian;
using Toybox.System;
using Toybox.Time;
using Toybox.Time.Gregorian;


class TestView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Get and show the current time
        var clockTime = System.getClockTime();

        var now = Time.now();
        var info = Gregorian.utcInfo(now, Time.FORMAT_SHORT);

        (View.findDrawableById("HourLabel") as Text).setText(
            Lang.format("$1$", [clockTime.hour])            
        );
        (View.findDrawableById("MinuteLabel") as Text).setText(
            Lang.format("$1$", [clockTime.min.format("%02d")])
        );

        var weekDayName = "??";
        switch (info.day_of_week)
        {
            case 1: weekDayName = "Sun";
            case 2: weekDayName = "Mon";
            case 3: weekDayName = "Tue";
            case 4: weekDayName = "Wed";
            case 5: weekDayName = "Thr";
            case 6: weekDayName = "Fri";
            case 7: weekDayName = "Sat";        
        }

        (View.findDrawableById("CurrentDate") as Text).setText(
            Lang.format("$3$ $1$/$2$", [info.day.format("%02u"), info.month.format("%02u"), weekDayName])
        );

        var complication = Complications.getComplication(
            new Complications.Id(Complications.COMPLICATION_TYPE_NOTIFICATION_COUNT)
        );        
        var notificationString = Lang.format("$1$", [complication.value]);
        if (complication.value == 0)
        {
            notificationString = "";
        }
        (View.findDrawableById("NotificationCount") as Text).setText(notificationString);

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
