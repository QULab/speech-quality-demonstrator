Speech Quality Demonstrator (SQuiD) - Documentation
===========================

(c) Dennis Guse (dennis.guse@alumni.tu-berlin.de) and Henrique Orefice (h.orefice@gmail.com), 2014

The Speech Quality Demonstrator was presented in „Die lange Nacht der Wissenschaften 2014“ (http://www.langenachtderwissenschaften.de) with the purpose to demonstrate how disturbs sound, for example during a phone call. The project consists in the implementation of an interactive webpage and a poster by Friedemann Köster, Dennis Guse and Henrique Orefice.
It was developed at Quality and Usability // Telekom Innovation Laboratories // TU Berlin (http://www.qu.tu-berlin.de).


The following degradations are included:
* codecs
* packet loss
* noise
* echo
* frequency range

Uses for conversion of audio files:
* libav
* sox
* ITU-T Recommendation G.191 (03/10): http://www.itu.int/rec/T-REC-G.191-201003-I/en

and jquery (at the moment 2.1.0) for the webpage.

Audio files are not included (available on request).

Details
—————
###Design
	
The design of the webpage consisted in small buttons in the shape of speakers around each of the five greater titles spread all over the screen, which explained the modification to the original sound in a more general level. Through specific names attached to each speaker, the user could achieve the desired intensity or more specific type of disturb. For example, the „2%“ and „10%“ speakers that belongs to the greater text „Netzwerkstörung“ would call the function to play the original sound with the desired packet loss. Also, in the middle of the screen there is a layer, which title is „Original“, in order to give the user the capacity to change the original sound, hence the person could listen to two different songs or speeches with the disturbs and compare them.
	
###Features
	
The main functions behind the webpage are the progress bar, a tiny blue circle around each speaker that disappeared progressively according to the current time of the playing audio, the selector of the audio-file, which selects the correct audio file to play according to the button selected by the user, and the ContentFlow, which enable the swipe function and displayed icons in the main frame. Also worth mentioning was the fact that these functions were designed so that the user could naturally navigate through the page without having to worry about undesired responses. All this work tried to achieve a high user-friendly interface through the addition in the main frame of well-representative icons and swipe capability to change the original sounds, as well as functions well integrated to act right with the expected response from the users. For example, when a sound is playing and the user wants to switch to another, it’s not needed to stop it and start a new one, the user could simple type on the desired button and hear the new sound or change the selected icon in the „Original“ layer and have the current audio stopped so that the user could then simple select a new one to play.
	
###Structure
	
When idle, the webpage consists on the design previously explained with some divs to subdivide and organize the content on the screen. Each div has its position set relatively or absolutely, which means if the are associated with the parent element or not. See code below:
(Note that in all elements the functions and styles are hidden for better visualization).
´´´html
<body>
	<!— License layer —>
	<div id=„license“>…</div>

	<!— Original/Main frame —>		
	<div id=„original“>				
		<h1>Original</h1>
		<div id=„ContentFlow“>…</div>
		<div class=„voice“>…</div>
	</div>
	
	<!— Contains all around it’s title as any other div from balls class. —>
	<div id=„echo“ class=„balls“>			
		<h1>Echo</h1>

		<!— Position its content relatively inside the parent layer. —>
		<div style=„position:relative“>
			<!— Contains image (speaker button), audio player and progress bar. —>
			<div class=„voice“>
				<— Image is a speaker and also the trigger to call the function playStimuli. —>
				<img>…</img>
				<audio>…</audio>
			</div>
			<!— Subtitles —>
			<h2>100ms</h2>
		</div>
		<!— Positioning again the elements relatively in the parent layer —>
		<div style=„position:relative“>…</div>
	</div>

	<!— All remaining divs are similar from echo in its structure —>
	<div id=„rauschen“ class=„balls“>…</div>		
	<div id=„frequenzband“ class=„balls“>…</div>	
	<div id=„codecs“ class=„balls“>…</div>
	<div id=„packets“ class=„balls“>…</div>
</body>
´´´
###Functions
	
About the implementation of the functionalities, it’s worth mentioning the functions which makes the whole page work and how they are connected (see diagram file).

load() - Let’s start with the „load“. It is a function called after the page loads and initializes the ContentFlow and also duplicates, modifies some attributes, such as visibility, and inserts the progress bar inside each div which class is „voice“.


playStimuli() - After that comes the function „playStimuli“ which attaches event listeners and does what is needed until the audio player starts playing, such as changing the static icon to a playing icon, stop playing if the same element which called the function is already playing and selecting the right audio source thought searching for the attribute „name“ in the parent div of the audio player and in the main frame, specifically in the object which the actual class is „active“.

onStimuliSomething () - These event listeners are called „onStimuli“ + status which simply display messages according to the status, such as „error“ or „progress“, except for two of them.

onStimuliEnded () - The first one is the „onStimuliEnded“ which do the opposite from the playStimuli and make all the work so that every element is back to its idle state waiting for the a new stimulus, for example: changing back the icon, updating the progress bar at the end of the audio, setting the current time form the audio player to zero and pausing it.

onStimuliTimeUpdate () - The second one is the „onStimuliTimeUpdate“ which calls the „updatePieValue“ function and they together update the status from the progress bar of the playing element and also log the current time and duration from the audio player.