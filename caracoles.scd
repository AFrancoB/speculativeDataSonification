var caracol1, caracol2, caracol3, caracol4, caracol5, dur=800;

var ts = { |units|  (dur/24)*(units) }; // (timeStep) hardcoded to 24 units

var which = [0,0,1,1,1];
var times = [ts.(6),ts.(4),ts.(14),ts.(1)];
var acc = [55,25,25];

SynthDef(\caracol, { | harm= #[0], amp=0.1, bufnum= 4224, which=0, out=0 |
	var sig1, sig2, env;

	sig1= PlayBuf.ar(2,bufnum, rate: harm)*0.7;
	sig1= sig1+SinOsc.ar(12.midicps*harm, 0, 0.3);
	sig2= sig1 + Pluck.ar(sig1, Impulse.kr(0), 1, (72.midicps*harm).reciprocal, 4.5, 0.5)!2;
	env= EnvGen.kr(Env.perc(0.00001,4.75),doneAction:2);

	Out.ar(out, SelectX.ar(which,[sig1,sig2.distort])*env*amp);
};
).add;

(
SynthDef(\fm, {|freq=100, amp=0.5, out=0|
	var sig, mod, env;

	mod= SinOsc.ar(100, 0, 150, freq);
	sig= SinOsc.ar(mod, 0, 0.5);
	sig= RLPF.ar(sig,freq*Line.kr(8,5,0.3),0.3)!2;
	env= EnvGen.kr(Env.perc(0.01, 0.3),doneAction:2);

	Out.ar(out,sig*env*amp)
}).add
);

caracol1= Pbind(\instrument, \caracol, \amp, 0.09, \harm, [0,5,9].midiratio,
	\bufnum, 4224,   \dur, Penv(acc*1    ,[ts.(20),ts.(5)]), \which, Penv(which,times), \out, Prand((16..32),inf));

caracol2= Pbind(\instrument, \caracol, \amp, 0.08, \harm, [-5,0,4,10,12,16,19].midiratio,
	\bufnum, 4224,   \dur, Penv(acc*(1/3),[ts.(20),ts.(5)]), \which, Penv(which,times), \out, Prand((16..32),inf));

caracol3= Pbind(\instrument, \caracol, \amp, 0.07, \harm, [-5,2,7,11].midiratio,
	\bufnum, 4224,   \dur, Penv(acc*(1/5),[ts.(20),ts.(5)]), \which, Penv(which,times), \out, Prand((16..32),inf));

caracol4= Pbind(\instrument, \caracol, \amp, 0.06, \harm, [-6,-1,3,7,8,12,19].midiratio,
	\bufnum, 4224,   \dur, Penv(acc*(1/7),[ts.(20),ts.(5)]), \which, Penv(which,times), \out, Prand((16..32),inf));

caracol5= Pbind(\instrument, \caracol, \amp, 0.05, \harm, [0,12,5,-7,15,20,23].midiratio,
	\bufnum, 4224,   \dur, Penv(acc*(1/11),[ts.(20),ts.(5)]), \which, Penv(which,times), \out, Prand((16..32),inf));

Pdef(\caracoles,
	Ppar([caracol1,caracol2,caracol3,caracol4,caracol5],1));


/*~fm1= Pbind(\instrument, \fm, \amp, Penv([0,1,1,0],[20,20,20],'welch'), \freq, 50, \dur, 3.0*0.midiratio.reciprocal).play;

~fm2= Pbind(\instrument, \fm, \amp, Penv([0,0.8,0.6,0],[15,25,30],'welch'), \freq, 100, \dur, 3.0*4.midiratio.reciprocal).play;

~fm3= Pbind(\instrument, \fm, \amp, Penv([0,0.7,0.1,0],[35,25,40],'welch'), \freq, 200, \dur, 3.0*7.midiratio.reciprocal).play;

~fm4= Pbind(\instrument, \fm, \amp, Penv([0,0.8,0.6,0],[35,25,50],'welch'), \freq, 300, \dur, 3.0*10.midiratio.reciprocal).play;

~fm5= Pbind(\instrument, \fm, \amp,  Penv([0,1.0,0.2,0.7],[25,15,30],'welch'), \freq, 400, \dur, 3.0*12.midiratio.reciprocal).play;

~fm6= Pbind(\instrument, \fm, \amp,  Penv([0,0.8,0.6,0].scramble,[15,25,30],'welch'), \freq, 500, \dur, 3.0*15.midiratio.reciprocal).play;

~fm7= Pbind(\instrument, \fm, \amp,  Penv([1,0.1,0.8,0],[35,15,20],'welch'), \freq, 600, \dur, 3.0*(5).midiratio.reciprocal).play;

~fm8= Pbind(\instrument, \fm, \amp,  Penv([0,0.8,0.6,0],[15,25,30].scramble,'welch'), \freq, 700, \dur, 3.0*14.midiratio.reciprocal).play;

~fm9= Pbind(\instrument, \fm, \amp, 0.2, \freq, 800, \dur, 3.0*20.midiratio.reciprocal).play;

~fm10= Pbind(\instrument, \fm, \amp, Penv([0.8,1,0,0.5],[20,35,50],'welch'), \freq, 900, \dur, 3.0*24.midiratio.reciprocal).play;

~fm11= Pbind(\instrument, \fm, \amp, Penv([1,0,0.8,0],[30,40,40],'welch'), \freq, 1000, \dur, 3.0*26.midiratio.reciprocal).play;


Pdef(\fm,
	Ppar([~fm1, ~fm2, ~fm3, ~fm4, ~fm5, ~fm6, ~fm7, ~fm8, ~fm9, ~fm10, ~fm11],1));*/

//Pdef(\fm).play





