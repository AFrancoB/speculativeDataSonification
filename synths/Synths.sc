//Synths
// execute here to compile every function and synthdef

//load wavetable catalogue;
var path = thisProcess.nowExecutingPath.dirname;
var wavsCatalogue = path++"/wavetable";
var drumKit = path++"/drumKits/IAMM_Kits/Kit_1/*";

~w= Array.new(43);

~wavList = ["_aguitar","_altosax","_birds","_bitreduced","_blended","_bw_saw","_bw_sawbright","_bw_sawgap","_bw_sawrounded","_bw_sin","_bw_sq","_bw_sqrounded","_bw_tri","_c604","_cello","_clarinett","_clavinet","_dbass","_distorted","_ebass","_eguitar","_eorgan","_epiano","_flute","_fmsynth","_granular","_hdrawn","_hvoice","_oboe","_oscchip","_overtone","_piano","_pluckalgo","_raw","_sinharm","_snippets","_stereo","_stringbox","_symetric","_theremin","_vgame","_vgamebasic","violin"];

~wavList.size.do{|i|
	var akwf= "/AKWF", list= ~wavList;

	(wavsCatalogue++akwf++list[i]++"/*").postln;
	if(i==0,
		{~w.insert(i,SoundFile.collectIntoBuffers(wavsCatalogue++akwf++"/*"))},
		{~w.insert(i,SoundFile.collectIntoBuffers(wavsCatalogue++akwf++list[i]++"/*",s))}
	);

};

~drumKit = SoundFile.collectIntoBuffers(drumKit,s);

~bufs= {| array |    array.linlin(0,100, 2000, 2000).round   };

~kps= {
	arg freq, amp, att, dur, rel, gate;

	var synth= {
		var sig, env, freqEnv;

		freqEnv= EnvGen.kr(Env(freq, ((dur/(freq.size-1))!(freq.size-1))));
		env= EnvGen.ar(Env([0,1,1,0], [att,dur*1.01,rel], [0.9,0.5,0.5]),gate, doneAction:2);
		sig= Pluck.ar(Pulse.ar(30),Impulse.kr(freqEnv), 1, (freqEnv*30).reciprocal, 0.3);

		sig*env
	};
	synth.play
};

~waveShape= {
	arg gate=1, out=0, ibuf= ~w[0].bufnum, offset=0.65,
	freq=[200], amp=1, dur=10,
	amp1=0.25, amp2=0.25, amp3=0.4,
	att=40, rel= 20,
	attF= 0.03, decF=1.2, susFLv= 0.07, relF= 1,
	rq= 0.1,
	which= 0,
	lfoFreq=35, lfoWidth= 1;

	var synth= {

		var osc1, osc2, osc3, osc4, osc5, osc6;
		var lfo;
		var waveshape;
		var sig, sig2, env, env_filt, freq1, freq2, freq3, cutOff;
		var whichEnv;
		var ibufEnv;

//		note = EnvGen.kr(Env(freq, (freq.size-1)));
//		note = 100;

		env = EnvGen.ar(Env([0,1,1,0], [att,dur*1.01,rel], [0.9,0.5,0.5]),gate, doneAction:2);
		env_filt = EnvGen.ar(Env.adsr(attF, decF, susFLv, relF, 1, -2),gate);
		cutOff = env_filt;

		lfo = SinOsc.kr(lfoFreq)*lfoWidth;

		whichEnv= EnvGen.kr(Env(which, ((dur/(which.size-1))!(which.size-1))));
		ibufEnv= EnvGen.kr(Env(ibuf, ((dur/(ibuf.size-1))!(ibuf.size-1))));

		freq1= EnvGen.kr(Env(freq, ((dur/(freq.size-1))!(freq.size-1))));
		freq2= EnvGen.kr(Env(freq*0.5+lfo, ((dur/freq.size-1)!(freq.size-1))));
		freq3= EnvGen.kr(Env(freq*2, ((dur/freq.size-1)!(freq.size-1))));

		osc1 = Saw.ar(freq1)*amp1;
		osc2 = Saw.ar(freq2)*amp2;
		osc3 = VOsc3.ar(ibuf+offset, freq3+[0,1],freq3+[0.37,1.1],freq3+[0.43, -0.29], 0.333333)*amp3;
		osc4 = Pulse.ar(freq1)*amp1;
		osc5 = Pulse.ar(freq2)*amp2;
		osc6 = BPF.ar(WhiteNoise.ar(100),freq2, rq, 1000).distort.distort*amp1;


		sig = SelectX.ar(whichEnv,[Mix([osc1, osc2, osc3]), Mix([osc4, osc5, osc3]), Mix([osc1, osc2, osc6]), Mix([osc4, osc5, osc6]), Mix([osc1, osc5, osc3]), Mix([osc1, osc5, osc6]), Mix([osc4, osc2, osc3]), Mix([osc4, osc2, osc6]), Mix([osc3, osc6, osc1, osc5]), Mix([osc3, osc6])]);

		Out.ar(out, Mix(sig.distort*env*amp*0.5));
	};

	synth.play

};


"(synths loaded and ready to go)".postln;







