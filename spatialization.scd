SynthDef(\space, { |in=100, out= 0, level=1, fadeIn=1, fadeOut=1, gate=0|
	var sig, env;
	sig= In.ar(in);
	env= EnvGen.kr(Env.asr(fadeIn, level, fadeOut),gate);
	Out.ar(out,sig*env)
}).add;

//         [Int],  [Float]  [Float],  [Int]
~spaceIn= {|busses, fadeIns, fadeOuts, gates, inBus|
	var array, size, fadeInsMod, fadeOutsMod, gatesMod;
	size= busses.size;
	fadeInsMod= busses.collect({|j,i|    fadeIns[i%(fadeIns.size)] });
	fadeOutsMod= busses.collect({|j,i|    fadeOuts[i%(fadeOuts.size)] });
	gatesMod= busses.collect({|j,i|    gates[i%(gates.size)] });

	array= Array.newClear(size).collect({|j, i|
		Synth(\space,
			[\in, inBus, \out, busses[i], \fadeIn, fadeInsMod[i], \fadeOuts, fadeOutsMod[i], \gate, gatesMod])
	});

	//data:
	busses.size.do{|i| ("bus: " ++ busses[i] ++ if(gatesMod[i]==1, {";   ,m On"}, {" Off"}) ++ "; fadeIn: " ++  fadeInsMod[i] ++ " secs").postln};
	array
};

~spaceOut= {|group, fOut, gates|
	var fOutM= group.collect({|j,i|    fOut[i%(fOut.size)] });
	var gatesM= group.collect({|j,i|    gates[i%(gates.size)] });

	group.collect({|j,i|   j.set(\fadeOut, fOutM[i], \gate, gatesM[i]) }) };



~fadeTime= [30,20];
Tdef(\deep_is_the_well_of_Time, {
	1.do{
		// initialise
		~traj1_Total= [
			~spaceIn.([16,17], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([18,19], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([20,21], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([22,23,31,24], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([25,26], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([27,28,33,45], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([29,30], [~fadeTime[0]], [~fadeTime[0]], [0], 100)
		];
		~traj1_hombres= [
			~spaceIn.([42,43], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([39,40,47], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([38,37], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([35,34,46], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([33,45,46], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([33,45], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([30,32,44], [~fadeTime[0]], [~fadeTime[0]], [0], 101)
		];
		~traj1_mujeres= [
			~spaceIn.([53,54], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([52,54], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([51,55], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([50,63,56], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([49,62,57], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([48,61,58], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([61,59,60], [~fadeTime[0]], [~fadeTime[0]], [0], 102)
		];
		~traj2_Total= [
			~spaceIn.([23,31], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([43,48], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([39,47,51,31], [~fadeTime[0]], [~fadeTime[0]], [0], 100),
			~spaceIn.([60,44], [~fadeTime[0]], [~fadeTime[0]], [0], 100)
		];
		~traj2_hombres= [
			~spaceIn.([22,24], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([42,61,62], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([63,38], [~fadeTime[0]], [~fadeTime[0]], [0], 101),
			~spaceIn.([59,32], [~fadeTime[0]], [~fadeTime[0]], [0], 101)
		];
		~traj2_mujeres= [
			~spaceIn.([21,25], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([41,49], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([35,54], [~fadeTime[0]], [~fadeTime[0]], [0], 102),
			~spaceIn.([33,58], [~fadeTime[0]], [~fadeTime[0]], [0], 102)
		];

		0.1.wait;
		~datafy.("total", ~nFacts, 1994, 2018, 20.midicps, 80.midicps, 0.5, 0.75, "wave", 100);
		~datafy.("hombre", ~nFacts, 1994, 2018, 20.midicps, 80.midicps, 0.5, 0.75, "wave", 101);
		~datafy.("mujer", ~nFacts, 1994, 2018, 20.midicps, 80.midicps, 0.5, 0.75, "wave", 102);
		Pdef(\caracoles).play;
		0.1.wait;
		1.do{                      // 0:00"
			~spaceOut.(  ~traj1_Total[0], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_hombres[0], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_mujeres[0], [~fadeTime[0]], [1]);
			(~fadeTime[0]*3).wait; // 1:30"
			~spaceOut.(  ~traj1_Total[1], [~fadeTime[0]], [1]);
			~spaceOut.(  ~traj1_Total[0], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_hombres[1], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_hombres[0], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_mujeres[1], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_mujeres[0], [~fadeTime[0]], [0]);
			(~fadeTime[0]*3).wait; // 3:00"
			~spaceOut.(  ~traj1_Total[2], [~fadeTime[0]], [1]);
			~spaceOut.(  ~traj1_Total[1], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_hombres[2], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_hombres[1], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_mujeres[2], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_mujeres[1], [~fadeTime[0]], [0]);
			(~fadeTime[0]*3).wait; // 4:30"
			~spaceOut.(  ~traj1_Total[3], [~fadeTime[0]], [1]);
			~spaceOut.(  ~traj1_Total[2], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_hombres[3], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_hombres[2], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_mujeres[3], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_mujeres[2], [~fadeTime[0]], [0]);
			(~fadeTime[0]*3).wait; // 6:00"
			~spaceOut.(  ~traj1_Total[4], [~fadeTime[0]], [1]);
			~spaceOut.(  ~traj1_Total[3], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_hombres[4], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_hombres[3], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_mujeres[4], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_mujeres[3], [~fadeTime[0]], [0]);
			(~fadeTime[0]*3).wait; // 7:30"
			~spaceOut.(~traj1_Total[5], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_Total[4], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_hombres[5], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_hombres[4], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_mujeres[5], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_mujeres[4], [~fadeTime[0]], [0]);
			(~fadeTime[0]*3).wait; // 9:00"
			~spaceOut.(~traj1_Total[6], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_Total[5], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_hombres[6], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_hombres[5], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_mujeres[6], [~fadeTime[0]], [1]);
			~spaceOut.(~traj1_mujeres[5], [~fadeTime[0]], [0]);
			(~fadeTime[0]*3).wait; // 10:30"
			~spaceOut.(  ~traj1_Total[6], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_hombres[6], [~fadeTime[0]], [0]);
			~spaceOut.(~traj1_mujeres[6], [~fadeTime[0]], [0]);

			~spaceOut.(  ~traj2_Total[0], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_hombres[0], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_mujeres[0], [~fadeTime[1]], [1]);
			(~fadeTime[1]*3).wait; // 11:30"
			~spaceOut.(  ~traj2_Total[0], [~fadeTime[1]], [0]);
			~spaceOut.(  ~traj2_Total[1], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_hombres[0], [~fadeTime[1]], [0]);
			~spaceOut.(~traj2_hombres[1], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_mujeres[0], [~fadeTime[1]], [0]);
			~spaceOut.(~traj2_mujeres[1], [~fadeTime[1]], [1]);
			(~fadeTime[1]*3).wait; // 12:30"
			~spaceOut.(  ~traj2_Total[1], [~fadeTime[1]], [0]);
			~spaceOut.(  ~traj2_Total[2], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_hombres[1], [~fadeTime[1]], [0]);
			~spaceOut.(~traj2_hombres[2], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_mujeres[1], [~fadeTime[1]], [0]);
			~spaceOut.(~traj2_mujeres[2], [~fadeTime[1]], [1]);
			(~fadeTime[1]*3).wait; // 13:30"
			~spaceOut.(  ~traj2_Total[2], [~fadeTime[1]], [0]);
			~spaceOut.(  ~traj2_Total[3], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_hombres[2], [~fadeTime[1]], [0]);
			~spaceOut.(~traj2_hombres[3], [~fadeTime[1]], [1]);
			~spaceOut.(~traj2_mujeres[2], [~fadeTime[1]], [0]);
			~spaceOut.(~traj2_mujeres[3], [~fadeTime[1]], [1]);


		}
}});

"spatialization loaded".postln;