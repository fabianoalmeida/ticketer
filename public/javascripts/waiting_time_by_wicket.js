function WaitingTimeByWicketD3(params){
	
	if(params.data == null || params.element == null){
		if(params.data == null){
			alert('Nenhum registro encontrado para as datas selecionadas');
			return null;
		}
		return null;
	};
		
	// Options defaults 
	var settings = {
			map     : params.data,
			element : params.element,
			format  : d3.time.format("%d/%m/%Y"),
			print   : d3.time.format("%d/%m"),
			w       : 700,
			h       : 400,
			margin  : 20
	};
	
	var init = function(){
		extract = extractDataAndKey(settings.map);
		settings.map     = extract.map;
		settings.times   = extract.times;
		settings.data    = extract.data;
		settings.wickets = extract.wickets;
		settings.acount  = extract.acount;
		settings.y       = d3.scale.linear()
									.domain([0, d3.max(settings.times)])
									.range([0 + settings.margin, settings.h - settings.margin]);
		settings.x       = d3.time.scale()
									.domain([d3.min(settings.data), d3.max(settings.data)])
									.range([0 + settings.margin, settings.w - settings.margin]);

		$.extend(this,settings);
		buildGraph();
	}
	
	
	/*
		Private methods 
	*/
	
	var extractDataAndKey = function(hash) {
		var times   = new Array(),
			data    = new Array(),
			wickets = new Array(),
			acount  = new Array(),
			graphs  = new Array(),
			map     = new Array(),
			colors  = d3.scale.category10();
			
			
		for (var index = hash.length - 1; index >= 0; index--){
			
			graphs.push({
				name : hash[index][0],
				id : hash[index][1][0], 
				list : hash[index][1],
				color : colors(index)
			});
			
			list = hash[index][1];
			
			map = map.concat(list);
			
			for (var x = list.length -1 ; x >= 0; x--){
				data.push(settings.format.parse(list[x].wicket.data));
				times.push(list[x].wicket.time);
				acount.push(list[x].wicket.total);
			};
		};
		
		return{ times : times, 
				data : data, 
				wickets : graphs, 
				acount : acount, 
				map : map };
	};
	
	var buildGraph = function(){
		var vis            = buildVisualization(), 
		    rule           = buildRule(vis), 
		    lineHorizontal = buildLineHorizontal(rule),
		    lineVertical   = buildLineVertical(rule), 
			textVertical   = buildTextVertical(rule),
			textHorizontal = buildTextHorizontal(rule);
			// legend         = buildLegend(vis, "red");
			
		for (var i = wickets.length - 1; i >= 0; i--){
				drawGraph(vis,wickets[i].list, wickets[i].color );
		};
	};
	
	var buildLegend = function(d3Object, element, callback){
		var legend  = d3Object.selectAll('g:legend')
								  .enter()
								  .append.svg.symbol()
								  .type("square")
								  .style("stroke", element)
								  
	};
	
	var buildRule = function(d3Object, callback){
		var objectReturn = d3Object.selectAll("g.rule")
								.data(x.ticks(d3.time.days, 1))
								.enter()
								.append("svg:g")
								.attr("class", "rule");

		if(callback) callback(objectReturn);

		return objectReturn;
	};

	
	
	var drawGraph = function(d3Object, map, color, callback){
		var line		 = d3.svg.line(map)
							 .x(function(d) { return x(format.parse(d.wicket.data)); })
							 .y(function(d) { return -1 * y(d.wicket.time); }),

		   objectReturn  = d3Object.append("svg:path")
								    .style("stroke", color )
								    .attr("d", line(map));
						
		if(callback) callback(objectReturn);

		return objectReturn;
		
	};
	
	var buildVisualization = function(callback){
		var objectReturn=  d3.select(element)
							 .html("")
							 .append("svg:svg")
						  	 .attr("width", w + margin * 2)
							 .attr("height", h + margin * 2)
							 .append("svg:g")
							 .attr("transform", "translate("+margin+","+h+")");
				
		if(callback) callback(objectReturn);

		return objectReturn;
	};
	

	var buildLineHorizontal = function(d3Object, callback){
		var objectReturn = d3Object.append("svg:line")
								   .attr("class","x")
								   .attr("x1", x)
								   .attr("x2", x)
								   .attr("y1", 0 )
								   .attr("y2", -1 * y(d3.max(data)) )
								   .attr("text-anchor", "middle");
					
		if(callback) callback(objectReturn);

		return objectReturn;
		
	};
	
	var buildLineVertical = function(d3Object, callback){
		var objectReturn = d3Object.append("svg:line")
								   .data(y.ticks(4)) 
								   .attr("class", function(d) { return d ? null : "axis"; })
								   .attr("y1",function(d) { return -1 * y(d) })
								   .attr("y2", function(d) { return -1 * y(d) })
								   .attr("x1", 0 + margin )
								   .attr("x2", x(d3.max(data)) - margin)
								   .attr("text-anchor", "middle");
					
		if(callback) callback(objectReturn);

		return objectReturn;
	};

	var buildTextVertical = function(d3Object, callback){
		var objectReturn = d3Object.append("svg:text")
								   .data(y.ticks(4)) 
								   .attr("y", function(d) { return -1 * y(d) })
								   .attr("x", 0)
								   .attr("dx", "-.4em")
								   .attr("text-anchor", "right")
								   .text(String);
					
		if(callback) callback(objectReturn);

		return objectReturn;
	};

	var buildTextHorizontal = function(d3Object, callback){
		var objectReturn = d3Object.append("svg:text")
								   .attr("x", x)
			       				   .attr("y", 3)
								   .attr("dy", ".1em")
								   .attr("text-anchor", "middle")
								   .text(print);
								
		if(callback) callback(objectReturn)
		
		return objectReturn;
	};
	
	init();
}

$('a.medium' ).click( function() {
	var form = $('form');
	var param = form.serializeArray();
	$.ajax({
		url: "/relatorios/tempo_de_espera_por_guiche",
		dataType: 'json',
		data: param,
		success: function(data){
			new WaitingTimeByWicketD3({element : "#graph", data : data});
		}
	});
});
