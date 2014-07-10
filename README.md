<h1>App, Where's my Car?</h1>

<h2>Overview</h2>
<p>This is a single-page-app that helps keeps track of where the user parked his car, and provides directions back to that parking spot whenever the user chooses to do so.</p>
<p>In it's current iteration, the app picks up on the user's current GPS location and centers the map at the user's location. The app can then save the user's location by storing the longitude and latitude of where the map is centered. While saving a parking spot to the database, the app also creates a save state using localStorage. This enables the user to turn off the app, and open it up again to get directions back to the parking spot without worry of the app "forgetting" that the user still has a parked spot that needs to be navigated back to.</p>
<p>The map scrolling function is inspired from Lyft's passenger app. The intention is to create a an experience for mobile users such that they can save their parking spots accurately.</p>

<h2>Gems Used</h2>
<ul>
	<li>devise</li>
	<li>coffee-rails</li>
	<li>pry-rails</li>
	<li>pry-byebug</li>
	<li>rspec-rails</li>
	<li>factory_girl_rails</li>
	<li>gon</li>
</ul>

<h2>Technologies Used</h2>
<ul>
	<li>Google Maps Javascript API v3</li>
	<li>HTML5 localStorage</li>
	<li>HTML5 geolocation</li>
</ul>

<h2>Heroku Link</h2>
https://app-wheres-my-car.herokuapp.com/

<h3>Contact</h3>
<li>Github: https://github.com/hhuang2088</li>
<li>LinkedIn: www.linkedin.com/pub/henry-huang/62/aab/b02/</li>

