(
var path = thisProcess.nowExecutingPath.dirname;
var synths = path ++ "/synths/Synths.sc";
var data = path ++ "/data/data.scd";
var caracoles = path ++ "/caracoles.scd";
s.options.numBuffers = 1024 * 16;
Server.default.options.memSize= 512000*20;
Server.default.options.maxNodes=128*1024;
Server.default.options.numWireBufs= 512;

//Server.default.options.device = "ASIO : MOTU Pro Audio";
Server.default.options.numOutputBusChannels = 64;
//Server.default.options.sampleRate = 48000;
s.boot;

s.waitForBoot({

	path.postln;
	synths.load.postln;
	data.load.postln;
//	caracoles.load.postln;

});

);

(
// THIS IS THE ONE
~datafy.("total", ~nFacts, 1994, 2018, 20.midicps, 80.midicps,x: 0.5,y: 0.75, "wave");
Pdef(\caracoles).play;
Pdef(\fm).play
)

~datafy.("total", ~nFacts, 1994, 2018, 20.midicps, 80.midicps, 0.5, 0.75, "wave", 0);
~datafy.("hombre", ~nFacts, 1994, 2018, 20.midicps, 80.midicps, 0.5, 0.75, "wave", 0);
~datafy.("mujer", ~nFacts, 1994, 2018, 20.midicps, 80.midicps, 0.5, 0.75, "wave", 0);


~datafy.("total", ~nFacts, 1994, 2018, 0.1, 10, 0.5, 0.75, "kps", 0);
~datafy.("mujer", ~nFacts, 1994, 2018, 0.1, 10, 0.5, 0.75, "kps", 0);
~datafy.("hombre", ~nFacts, 1994, 2018, 0.1, 10, 0.5, 0.75, "kps", 0);

s.meter
