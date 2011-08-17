function renderProtovis(hash) {

  if(hash == null){
    alert('Nenhum registro encontrado para as datas selecionadas');
    return
  }
  var keys = Array();
  var data = Array();
  var max  = 0;
  for (index in hash) {
    keys.push(hash[index].ticket.date_local);
    data.push(hash[index].ticket.count_id);
    if ( hash[index].ticket.count_id > max )
      max = hash[index].ticket.count_id ;
  }

  /* Sizing and scales. */
  var w = 550,
      h = keys.length * 30,
      x = pv.Scale.linear(0, max).range(0, w),
      y = pv.Scale.ordinal(pv.range(keys.length)).splitBanded(0, h, 0.7);

  /* The root panel. */
  var vis = new pv.Panel()
      .width(w)
      .height(h)
      .bottom(20)
      .left(100)
      .right(10)
      .top(5)
      .canvas('center');

  /* The bars. */
  var bar = vis.add(pv.Bar)
      .data(data)
      .top(function() y(this.index))
      .height(y.range().band)
      .left(0)
      .width(x)
      .text(function(d) 'Dia ' + keys[this.index] + ' foi(ram) gerada(s) ' + d + ' senha(s)'  )
      .fillStyle('#C5E008')
      .event("mouseover", pv.Behavior.tipsy({gravity: "w", fade: true}));

  /* The value label. */
  bar.anchor("right").add(pv.Label)
      .textStyle("#402E16")
      .text(function(d) d);

  /* The variable label. */
  bar.anchor("left").add(pv.Label)
      .textMargin(5)
      .textAlign("right")
      .text(function() keys[this.index]);

  /* X-axis ticks. */
  vis.add(pv.Rule)
      .data(x.ticks(5))
      .left(x)
      .strokeStyle(function(d) d ? "rgba(255,255,255,.3)" : "#000")
    .add(pv.Rule)
      .bottom(0)
      .height(5)
      .strokeStyle("#000")
    .anchor("bottom").add(pv.Label)
      .text(x.tickFormat);

  vis.render();
}

$('a.medium' ).click( function() {
  var form = $('form');
  var param = form.serializeArray();
  $.ajax({
    url: "/relatorios/senhas_por_dia",
    dataType: 'json',
    data: param,
    success: function(data){
      renderProtovis(data);
    }
  });
});

