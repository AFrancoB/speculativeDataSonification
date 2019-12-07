//Server.default.options.device = "ASIO : MOTU Pro Audio";
Server.default.options.numOutputBusChannels = 64;
//Server.default.options.sampleRate = 48000;

s.meter;

SynthDef(\space, { |in=100, out= 0, level=1, fadeIn=1, fadeOut=1, gate=0|
	var sig, env;
	sig= In.ar(in);
	env= EnvGen.kr(Env.asr(fadeIn, level, fadeOut),gate);
	Out.ar(out,sig*env)
}).add;

//         [Int],  [Float]  [Float],  [Int]
~spaceIn= {|busses, fadeIns, fadeOuts, gates|
	var array, size, fadeInsMod, fadeOutsMod, gatesMod;
	size= busses.size;
	fadeInsMod= busses.collect({|j,i|    fadeIns[i%(fadeIns.size)] });
	fadeOutsMod= busses.collect({|j,i|    fadeOuts[i%(fadeOuts.size)] });
	gatesMod= busses.collect({|j,i|    gates[i%(gates.size)] });

	array= Array.newClear(size).collect({|j, i|
		Synth(\space,
			[\out, busses[i], \fadeIn, fadeInsMod[i], \fadeOuts, fadeOutsMod[i], \gate, gatesMod])
	});

	//data:
	busses.size.do{|i| ("bus: " ++ busses[i] ++ if(gatesMod[i]==1, {"; On"}, {" Off"}) ++ "; fadeIn: " ++  fadeInsMod[i] ++ " secs").postln};
	array
};

~spaceOut= {|group, fOut, gates|
	var fOutM= group.collect({|j,i|    fOut[i%(fOut.size)] });
	var gatesM= group.collect({|j,i|    gates[i%(gates.size)] });

	group.collect({|j,i|   j.set(\fadeOut, fOutM[i], \gate, gatesM[i]) }) };


(
// creates a group of buses with a specific name (~test), fadetimes and gates
~test= ~spaceIn.([17,18,19,20], [3,5,4], [7,7], [1,1,0]);
{Out.ar(100,WhiteNoise.ar(0.1))}.play; // test sound, 100 is the node of the space synth
);

~transition.(~test, [4,4,4], [0,0,0])  // changes

(
Tdef(\spaceSequence, {
	1.do{
		// initialise
		~test2= ~spaceIn.([20,21,22,23], [3,5,4]*10, [7,7], [0,0,0,0]);
		~test1= ~spaceIn.([16,17,18,19], [3,5,4]*10, [7,7], [1,1,1,1]);
		2.wait;
		{Out.ar(100,WhiteNoise.ar(0.1))}.play; // test sound, 100 is the node of the space synth
		5.wait;
		~spaceOut.(~test1, [4,4,4], [0]);  // changes
		~spaceOut.(~test2, [4,4,4], [1])
	}}).play;
)


