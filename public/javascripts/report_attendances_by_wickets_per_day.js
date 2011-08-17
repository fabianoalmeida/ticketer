function renderProtovis(hash) {

  if(hash == null){
    alert('Nenhum registro encontrado para as datas selecionadas');
    return
  }

  var keys = Array();
  var data = Array();
  var max  = 0;
  
  for (index in hash) {
    keys.push(hash[index].call_history.date_local);
    data.push(hash[index].call_history.count_id);
    if ( hash[index].call_history.count_id > max )
      max = hash[index].call_history.count_id ;
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
      .left(20)
      .right(10)
      .top(5)
      .canvas('center');

  /* The bars. */
  var bar = vis.add(pv.Panel)
      .data(data)
      .top(function() y(this.index))
      .height(y.range().band)
    .add(pv.Bar)
      .data(function(d) d)
      .top(function() this.index * y.range().band / m)
      .height(y.range().band / m)
      .left(0)
      .width(x)
      .fillStyle(pv.Colors.category20().by(pv.index));

  /* The value label. */
  bar.anchor("right").add(pv.Label)
      .textStyle("white")
      .text(function(d) d);

  /* The variable label. */
  bar.parent.anchor("left").add(pv.Label)
      .textAlign("right")
      .textMargin(5)
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
    url: "/relatorios/atendimentos_por_guiche_por_dia",
    dataType: 'json',
    data: param,
    success: function(data){
      renderProtovis(data);
    }
  });
});
