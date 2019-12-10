var w, h = 1000, v = 1500,x=1200,y=0, run = true, image;
w = Window("Calendario", Rect(x, y, v, h), true);
w.onClose = { run = false }; // stop the thread on close
w.front;
u= UserView(w, Rect(0, 0, v, h));
~years= Array.newClear(2118-2008+1).collect({|j,i|  2008 + i}).ceil;
image = Image.open("/home/alejandro/Documents/plot.jpg");
w.view.backgroundImage_(image, 5, 1.0, Rect(10,10,v,h));
u.background = Color(0.15,0.15,0.15, 1.0);
//image.do(_.plot("data",bounds: Rect(0,1200,1500,1000)));
~intro=
		"
¿Escucharon? Es el sonido de su mundo derrumbándose.
Es el del nuestro resurgiendo.

Are you listening? It is the sound of their world collapsing.
It is the sound of our world re-emerging.

vosotros caqui? In tsatsilistli
tlalticpac - mundo

uetsi - derrumbar

cueponi - surgir brotar florecer
";

~string= ~intro;
~size= 0;

Tdef(\calendario, {
	1.do{
		~string= ~intro;
		5.wait;
		~size= 1;
		111.do{|i|
			~years[i].postln;
			~string= ~years[i];
			((800/110)).wait;
		};
		2.wait;
	}

}).play;

Tdef(\alpha, { 1.do{  805.wait; 100.do{|i| ~alpha=(~alpha-(0.01)).postln; 0.07.wait}  }   }).play;
~alpha=1.0;
u.drawFunc = {

	Pen.width = 2;
	Pen.font = Font( "Helvetica-Bold", if(~size==0, {15}, {150}) );
	Pen.stringCenteredIn(~string.asString,Rect(0,0,v*0.88,h*0.5),color: Color(0.5,0.5,0.5));
	Pen.stroke;
	u.background = Color(0.15,0.15,0.15, ~alpha);
};
u.animate;
// fork a thread to update 20 times a second, and advance the phase each time
{ while { run } { w.refresh; 0.05.wait; } }.fork(AppClock);
CmdPeriod.doOnce({if(w.isClosed.not, {w.close; Tdef(\calendario).stop})});
