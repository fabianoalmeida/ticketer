function WaitingTimeByClientD3(params){
	
	if(params == null || params.data == null || 
		params.element == null || params.kind == null){
		return null;
	};
		
	// Options defaults 
	var settings = {
			map     : params.data,
			element : params.element,
			kind    : params.kind, 
			w       : 700,
			h       : 400,
			margin  : 30
	};
	
	var init = function(){
		
		kindSettings();
		extract = extractors[params.kind].call(this,settings.map);
		settings.keys = extract.keys,
		settings.data = extract.data,
		settings.y    = d3.scale.linear().domain([0, d3.max(settings.data)]).range([0 + settings.margin, settings.h - settings.margin]),
		settings.x    = d3.time.scale().domain([d3.min(settings.keys), d3.max(settings.keys)]).range([0 + settings.margin, settings.w - settings.margin]),
		$.extend(this,settings);
		buildGraph();
	}
	
	
	/*
		Private methods 
	*/
	
	var kindSettings = function() {
		if(settings.kind == "day"){
			settings.format = d3.time.format("%d/%m/%Y");
			settings.tick = d3.time.days;
			settings.print  = d3.time.format("%d/%m");
		}else if(settings.kind == "month"){
			settings.format = d3.time.format("%m/%Y");
			settings.tick = d3.time.months;
			settings.print  = d3.time.format("%m/%Y");
		}
	};
	
	var extractors = {
		
		day : function(hash) {
			
			var keys = new Array(),
			
			data = new Array();
			
			for (var index = hash.length - 1; index >= 0; index--){
				keys.push(settings.format.parse(hash[index].data));
				data.push(Math.round(hash[index].time));
			};
		
			return{ keys : keys, data : data};
		},
		month : function(hash) {
			var keys = new Array(),
			
			data = new Array();
			
			for (var index = hash.length - 1; index >= 0; index--){
				var canAdd = true, 
					date   = settings.format.parse(hash[index].data);
				keys.forEach(function(el) {if (settings.print(el) == settings.print(date) ) canAdd = false; })
				if( canAdd ) keys.push(date);
				//keys.push(settings.format.parse(hash[index].call_history.data));
				data.push(Math.round(hash[index].time));
			};
		
			return{ keys : keys, data : data};
		}
	}
	var extractDataAndKey = function(hash) {
	}
	
	var buildGraph = function(){
		var vis            = buildVisualization(), 
		    ruleVertical   = buildRule(vis, x.ticks(tick, 1), "vrule"), 
			ruleHorizontal = buildRule(vis, y.ticks(4), "hrule"),
		    lineHorizontal = buildLineHorizontal(ruleHorizontal),
			lineVertical   = buildLineVertical(ruleVertical), 
			textVertical   = buildTextVertical(ruleVertical),
			textHorizontal = buildTextHorizontal(ruleHorizontal),
	
			pathLine       = drawGraph(vis);
	}
	
	var drawGraph = function(d3Object, callback){
		var line		 =  d3.svg.line(map)
							.x(function(d) { return x(format.parse(d.data)); })
							.y(function(d) { return -1 * y(d.time); }),
		   objectReturn =   d3Object.append("svg:path")
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
	
	var buildRule = function(d3Object, _data, _class, callback){
		var objectReturn = d3Object.selectAll("g."+ _class)
								.data(_data)
								.enter()
								.append("svg:g")
								.attr("class", _class);

		if(callback) callback(objectReturn);

		return objectReturn;
	};
	
	
	var buildLineVertical = function(d3Object, callback){
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
	
	var buildLineHorizontal = function(d3Object, callback){
		var objectReturn = d3Object.append("svg:line")
								   // .data(y.ticks(6)) 
								   .attr("class", function(d) { return d ? null : "axis"; })
								   .attr("y1",function(d) { return -1 * y(d) })
								   .attr("y2", function(d) { return -1 * y(d) })
								   .attr("x1", 0 + margin )
								   .attr("x2", x(d3.max(keys)))
								   .attr("text-anchor", "middle");
					
		if(callback) callback(objectReturn);

		return objectReturn;
	};

	var  buildTextHorizontal  = function(d3Object, callback){
		var objectReturn = d3Object.append("svg:text")
								   // .data(y.ticks(6)) 
								   .attr("y", function(d) { return -1 * y(d) })
								   .attr("x", 0)
								   .attr("dx", "-1.5em")
								   .attr("text-anchor", "right")
								   .text(function(d) {return d + " min"});
					
		if(callback) callback(objectReturn);

		return objectReturn;
	};

	var buildTextVertical = function(d3Object, callback){
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
		url: "/relatorios/tempo_de_espera_por_cliente",
		dataType: 'json',
		data: param,
		success: function(data){
			new WaitingTimeByClientD3({element : "#graph", data : data});
		}
	});
});
