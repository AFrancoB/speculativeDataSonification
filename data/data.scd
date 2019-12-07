var limits, limites;

var path = thisProcess.nowExecutingPath.dirname;
var hom = path++"/INEGI_hom";
// defuncion por homicidio
//                              2018
var homicidios2018 = CSVFileReader.read(hom++"/INEGI_hom_2018.csv");
//                              2017
var homicidios2017 = CSVFileReader.read(hom++"/INEGI_hom_2017.csv");
//                              2016
var homicidios2016 = CSVFileReader.read(hom++"/INEGI_hom_2016.csv");
//                              2015
var homicidios2015 = CSVFileReader.read(hom++"/INEGI_hom_2015.csv");
//                              2014
var homicidios2014 = CSVFileReader.read(hom++"/INEGI_hom_2014.csv");
//                              2013
var homicidios2013 = CSVFileReader.read(hom++"/INEGI_hom_2013.csv");
//                              2012
var homicidios2012 = CSVFileReader.read(hom++"/INEGI_hom_2012.csv");
//                              2011
var homicidios2011 = CSVFileReader.read(hom++"/INEGI_hom_2011.csv");
//                              2010
var homicidios2010 = CSVFileReader.read(hom++"/INEGI_hom_2010.csv");
//                              2009
var homicidios2009 = CSVFileReader.read(hom++"/INEGI_hom_2009.csv");
//                              2008
var homicidios2008 = CSVFileReader.read(hom++"/INEGI_hom_2008.csv");
//                              2007
var homicidios2007 = CSVFileReader.read(hom++"/INEGI_hom_2007.csv");
//                              2006
var homicidios2006 = CSVFileReader.read(hom++"/INEGI_hom_2006.csv");
//                              2005
var homicidios2005 = CSVFileReader.read(hom++"/INEGI_hom_2005.csv");
//                              2004
var homicidios2004 = CSVFileReader.read(hom++"/INEGI_hom_2004.csv");
//                              2003
var homicidios2003 = CSVFileReader.read(hom++"/INEGI_hom_2003.csv");
//                              2002
var homicidios2002 = CSVFileReader.read(hom++"/INEGI_hom_2002.csv");
//                              2001
var homicidios2001 = CSVFileReader.read(hom++"/INEGI_hom_2001.csv");
//                              2000
var homicidios2000 = CSVFileReader.read(hom++"/INEGI_hom_2000.csv");
//                              1999
var homicidios1999 = CSVFileReader.read(hom++"/INEGI_hom_1999.csv");
//                              1998
var homicidios1998 = CSVFileReader.read(hom++"/INEGI_hom_1998.csv");
//                              1997
var homicidios1997 = CSVFileReader.read(hom++"/INEGI_hom_1997.csv");
//                              1996
var homicidios1996 = CSVFileReader.read(hom++"/INEGI_hom_1996.csv");
//                              1995
var homicidios1995 = CSVFileReader.read(hom++"/INEGI_hom_1995.csv");
//                              1994
var homicidios1994 = CSVFileReader.read(hom++"/INEGI_hom_1994.csv");


var yearData = { |field|
	switch ( field,
		2018, {homicidios2018},
		2017, {homicidios2017},
		2016, {homicidios2016},
		2015, {homicidios2015},
		2014, {homicidios2014},
		2013, {homicidios2013},
		2012, {homicidios2012},
		2011, {homicidios2011},
		2010, {homicidios2010},
		2009, {homicidios2009},
		2008, {homicidios2008},
		2007, {homicidios2007},
		2006, {homicidios2006},
		2005, {homicidios2005},
		2004, {homicidios2004},
		2003, {homicidios2003},
		2002, {homicidios2002},
		2001, {homicidios2001},
		2000, {homicidios2000},
		1999, {homicidios1999},
		1998, {homicidios1998},
		1997, {homicidios1997},
		1996, {homicidios1996},
		1995, {homicidios1995},
		1994, {homicidios1994},
	)
};


var genero = { |field|
	switch ( field,
		"total", {1},
		"hombre", {2},
		"mujer", {3},
		"noEspecificado", {4}
	)
};

var edad = { |field|
	switch ( field,
		"totalEdad", {5},
		"0-1", {6},
		"1-4", {7},
		"5-9", {8},
		"10-14", {9},
		"15-19", {10},
		"20-24", {11},
		"25-29", {12},
		"30-34", {13},
		"35-39", {14},
		"40-44", {15},
		"45-49", {16},
		"50-54", {17},
		"55-59", {18},
		"60-64", {19},
		"65-69", {20},
		"70-74", {21},
		"75-79", {22},
		"80-84", {23},
		"84-", {24},
		"noEspecificado", {25}
	)
};

// number of data points in every file, 4 year age groups of the defunct
~nFacts= edad.("noEspecificado") - edad.("totalEdad") + 1;

// find the boundaries of the overall data
// first Total

//10.do{|i| (yearData.(1994 + i)).postln   };

limits= {| gender, nFacts, from, to |
	var array;
	var fromTo = (min: from, max: to);
	var years = fromTo.max - fromTo.min;
	var limits;

	array= [Array.fill(nFacts, { | i | (yearData.(from)[edad.("totalEdad")+i][genero.(gender)]).asInt }).collect({|j| if(j== "", {0}, {j}) })];
	array= array ++
	Array.fill(years, { |yearIndex|
		Array.fill(nFacts, { | i | (yearData.(from+yearIndex+1)[edad.("totalEdad")+i][genero.(gender)]).asInt })
		.collect({|j| if(j== "", {0}, {j}) })});
	array= array.flatten;
	limits= (min: array.minItem, max: array.maxItem);

};


limites= (
	max:
	[
		limits.("hombre", ~nFacts, 1994, 2018).max,
		limits.("mujer", ~nFacts, 1994, 2018).max,
		limits.("total", ~nFacts, 1994, 2018).max,
		limits.("noEspecificado", ~nFacts, 1994, 2018).max
	].maxItem,

	min:
	[
		limits.("hombre", ~nFacts, 1994, 2018).min,
		limits.("mujer", ~nFacts, 1994, 2018).min,
		limits.("total", ~nFacts, 1994, 2018).min,
		limits.("noEspecificado", ~nFacts, 1994, 2018).min
	].minItem;
);

(
//           year -> gender -> ageCount ->  minVal -> maxVal -> [homicidesPerAge]
~sonify = {| year, gender, ageCount, min, max,  minTranspVal, maxTranspVal |
	var array, bounds;

	array= Array.fill(ageCount, { | i | (yearData.(year)[edad.("0-1")+i+1][genero.(gender)]).asInt });
	array= array.collect({|j, index| if(j== "", {0}, {j}) });
	bounds= (min: array.minItem, max: array.maxItem);

	array.linlin(bounds.min, bounds.max, minTranspVal, maxTranspVal);
};
);

~datafy= {| gender, nFacts, from, to, minVal, maxVal, x, y, synth, busOut=0 |
	var array;
	var fromTo = (min: from, max: to);
	var years = fromTo.max - fromTo.min;
	var limits, transposed, env;

	array= [Array.fill(nFacts, { | i | (yearData.(from)[edad.("totalEdad")+i][genero.(gender)]).asInt }).collect({|j| if(j== "", {0}, {j}) })];
	array= array ++
	Array.fill(years, { |yearIndex|
		Array.fill(~nFacts, { | i | (yearData.(from+yearIndex+1)[edad.("totalEdad")+i][genero.(gender)]).asInt })
		.collect({|j| if(j== "", {0}, {j}) })});
	array= array.collect({|j| j[0]});
	limits= (min: limites.min, max: limites.max);
	transposed= array.linlin(limits.min,limits.max, minVal, maxVal);

	if( synth=="wave", {
		~waveShape.(freq: transposed, amp: 0.3, dur: 800,
			gate:1, out: busOut, ibuf: [10,1000,20,400,500,10,300,700,330], offset: 0.65,
			amp1: 0.25, amp2: 0.25, amp3: 0.4,
			att: 20, rel:20,
			attF: 0.03, decF: 1.2, susFLv: 0.07, relF: 1,
			rq: 0.1, which: [0,9,2,7,4],
			lfoFreq: 0.07, lfoWidth: 5
		);
	},
	{
		~kps.(freq: transposed, amp:0.1, att: 0.1, dur: 800, rel: 0.1, gate: 1);

	}
	);

	array.plot(name:
		if(gender=="mujer", {"Número de mujeres asesinadas entre los años "}, {
			if(gender=="hombre", {"Número de hombres asesinadas entre los años "}, {
				if(gender=="total", {"Personas asesinadas entre los años "}, {"Asesinatos sin género especificado entre los años "})
			})
		}) ++ from.asString ++ "-" ++ to.asString,
		bounds: Rect(x.linlin(0,1,0,900),y.linlin(0,1,0,500), 500, 300),
		minval: limits.min, maxval: limits.max
	);
};


// THIS IS THE ONE
//~datafy.("total", ~nFacts, 1994, 2018, 20.midicps, 80.midicps, 0.5, 0.75);

"data loaded".postln;