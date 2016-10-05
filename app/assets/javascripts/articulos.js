$('document').ready(function(){

    // instantiate the bloodhound suggestion engine
    var articulos = new Bloodhound({
      datumTokenizer: Bloodhound.tokenizers.obj.whitespace('codigo', 'descripcion'),
      queryTokenizer: Bloodhound.tokenizers.whitespace,
          remote: {
            url: '../articulos/resultado_articulos/%QUERY.json',
            wildcard: '%QUERY'
        }
    });

    // initialize the bloodhound suggestion engine
    articulos.initialize();
    var source = $("#articulos-script").html();
    var template = Handlebars.compile(source);

    // instantiate the typeahead UI
    $('#search').typeahead(null, {
      displayKey: 'articulos',
      source: articulos.ttAdapter(),
      templates: {
           empty: [
          '<div class="empty-message">',
            'No se pudo encontrar lo buscado',
          '</div>'
        ].join('\n'),        
            suggestion: Handlebars.compile(template)         
      }
    });

    // function actualizarResultados() {
    //   $.get('/articulos/resultado_articulos', { search: $('#search').val() })
    //   .success(function(response){
    //     $('#resultado').html(response);
    //   });
    // }

    // $("#search").keyup(function(event){
    // if (event.which === 13) {
    //    actualizarResultados();
    //   }
    // });

    // $("#botonBusqueda").click(actualizarResultados());

    // $('#proveedor').change(function() {
    //   actualizarResultados();
    // });

    // actualizarResultados();
    // $('#search').keyup(function() {
    //   actualizarResultados();
    // });    
});