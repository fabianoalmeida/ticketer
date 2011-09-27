function renderProtovis(hash) {

  if(hash == "" || hash == null){
    return
  }

  var keys = Array();
  var data_array = Array();
  var max  = 0;

  for (index in hash) {
    keys.push(hash[index][0]);
    data_array.push(hash[index][1]);
  }

  /* Sizing and scales. */
  var w = 550,
      h = keys.length * 300,
      x = pv.Scale.linear(0, 40).range(0, w),
      y = pv.Scale.ordinal(pv.range(keys.length)).splitBanded(0, h, 0.9);

  /* The root panel. */
  var vis = new pv.Panel()
      .width(w)
      .height(h)
      .bottom(20)
      .left(70)
      .right(10)
      .top(5)
      .canvas('graph');

  /* The bars. */
  var bar = vis.add(pv.Panel)
      .data(data_array)
      .top(function() y(this.index))
      .height(y.range().band)
    .add(pv.Bar)
      .data(function(d) d.values)
      .top( function() this.index * y.range().band / data_array[this.parent.index].values.length)
      .height( function() y.range().band / data_array[this.parent.index].values.length )
      .left(0)
      .width(x)
      .text(function(d) data_array[this.parent.index].dates[this.index])
      .event("mouseover", pv.Behavior.tipsy({gravity: "w", fade: true}))
      .fillStyle(pv.Colors.category20().by(pv.index));

  /* The value label. */
  bar.anchor("right").add(pv.Label)
      .textStyle("white")
      .text(function(d) d);

  /* The variable label. */
  bar.parent.anchor("left").add(pv.Label)
      .textAlign("right")
      .textMargin(5)
      .text(function() keys[this.parent.index]);

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

$('a.medium').click( function() {
  var form = $('form');
  var param = form.serializeArray();
  $.ajax({
    url: "/relatorios/atendimentos_por_guiche_por_mes",
    dataType: 'json',
    data: param,
    success: function(data){
      renderProtovis(data);
    }
  });
});
