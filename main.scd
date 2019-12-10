(
var path = thisProcess.nowExecutingPath.dirname;
var synths = path ++ "/synths/Synths.sc";
var data = path ++ "/data/data.scd";
var caracoles = path ++ "/caracoles.scd";
~visuales = path ++ "/visuals.scd";
s.options.numBuffers = 1024 * 16;
Server.default.options.memSize= 512000*20;
Server.default.options.maxNodes=128*1024;
Server.default.options.numWireBufs= 512;

Server.default.options.device = "ASIO : MOTU Pro Audio";
Server.default.options.numOutputBusChannels = 64;
Server.default.options.sampleRate = 48000;
s.boot;

s.waitForBoot({

	path.postln;
	synths.load.postln;
	data.load.postln;
	caracoles.load.postln;

});

);

(
// THIS IS THE ONE
Tdef(\deep_is_the_well_of_Time).play;
~visuales.load;
)


