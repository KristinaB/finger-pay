// Range beacons screen.
;(function(app)
{
	app.startRangingBeacons = function()
	{

		function onRange(beaconInfo)
		{
			displayBeconInfoThrottled(beaconInfo);
		}

		function onError(errorMessage)
		{
			console.log('Range error: ' + errorMessage);
		}

		function displayBeconInfo(beaconInfo)
		{
			// Clear beacon HTML items.
			$('#id-screen-range-beacons .style-item-list').empty();

			// Sort beacons by distance.
			beaconInfo.beacons.sort(function(beacon1, beacon2) {
				return beacon1.distance > beacon2.distance; });

			// Generate HTML for beacons.
			$.each(beaconInfo.beacons, function(key, beacon)
			{
				// console.log("dist", beacon.distance)// todo copy code from other example

				// TODO get BEACON_MAJ and min values from config
				if (beacon.distance < 0.6 && beacon.major ==  11245 && beacon.minor == 58301) {
					console.log("BEACON NEAR (dist) < 0.6")
					$("body").trigger("beacon_near")
				}

				var element = $(createBeaconHTML(beacon));
				$('#id-screen-range-beacons .style-item-list').append(element);
			});
		};

		var displayBeconInfoThrottled = _.throttle(displayBeconInfo, 500)


		function createBeaconHTML(beacon)
		{
			var colorClasses = app.beaconColorStyle(beacon.color);
			var htm = '<div class="' + colorClasses + '">'
				+ '<table><tr><td>Major</td><td>' + beacon.major
				+ '</td></tr><tr><td>Minor</td><td>' + beacon.minor
				+ '</td></tr><tr><td>RSSI</td><td>' + beacon.rssi
			if (beacon.proximity)
			{
				htm += '</td></tr><tr><td>Proximity</td><td>'
					+ app.formatProximity(beacon.proximity)
			}
			if (beacon.distance)
			{
				htm += '</td></tr><tr><td>Distance</td><td>'
					+ app.formatDistance(beacon.distance)
			}
			htm += '</td></tr></table></div>';
			return htm;
		};

		// Show screen.
		app.showScreen('id-screen-range-beacons');
		$('#id-screen-range-beacons .style-item-list').empty();

		// Request authorisation.
		estimote.beacons.requestAlwaysAuthorization();

		// Start ranging.
		estimote.beacons.startRangingBeaconsInRegion(
			{}, // Empty region matches all beacons.
			onRange,
			onError);
	};

	app.stopRangingBeacons = function()
	{
		estimote.beacons.stopRangingBeaconsInRegion({});
		app.showHomeScreen();
	};

})(app);
