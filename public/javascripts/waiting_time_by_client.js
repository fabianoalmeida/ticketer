function WaitingTimeByClientD3(params){
	
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
		settings.keys = extract.keys;
		settings.data = extract.data;		
		settings.y    = d3.scale.linear().domain([0, d3.max(settings.data)]).range([0 + settings.margin, settings.h - settings.margin]),
		settings.x    = d3.time.scale().domain([d3.min(settings.keys), d3.max(settings.keys)]).range([0 + settings.margin, settings.w - settings.margin]);
		$.extend(this,settings);
		buildGraph();
	}
	
	
	/*
		Private methods 
	*/
	
	var extractDataAndKey = function(hash) {
		var keys = new Array(),
			data = new Array();
			
		for (var index = hash.length - 1; index >= 0; index--){
			keys.push(settings.format.parse(hash[index].call_history.data));
			data.push(hash[index].call_history.time);
		};
		
		return{ keys : keys, data : data};
	}
	
	var buildGraph = function(){
		var vis            = buildVisualization(), 
		    rule           = buildRule(vis), 
		    lineHorizontal = buildLineHorizontal(rule),
		    lineVertical   = buildLineVertical(rule), 
			textVertical   = buildTextVertical(rule),
			textHorizontal = buildTextHorizontal(rule),
			pathLine       = drawGraph(vis);
	}
	
	var drawGraph = function(d3Object, callback){
		var line		 =  d3.svg.line(map)
							.x(function(d) { return x(format.parse(d.call_history.data)); })
							.y(function(d) { return -1 * y(d.call_history.time); }),
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
	
	
	var buildRule = function(d3Object, callback){
		var objectReturn = d3Object.selectAll("g.rule")
								.data(x.ticks(d3.time.days, 1))
								.enter()
								.append("svg:g")
								.attr("class", "rule");
					
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
								   .attr("x2", x(d3.max(keys)) - margin)
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
		url: "/relatorios/tempo_de_espera_por_cliente",
		dataType: 'json',
		data: param,
		success: function(data){
			new WaitingTimeByClientD3({element : "#center", data : data});
		}
	});
});